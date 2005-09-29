From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch-pack should not ask for a ref which is already
 there
Date: Thu, 29 Sep 2005 21:08:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509292058020.8413@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509291120170.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 21:10:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL3lu-0005LK-Nf
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 21:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVI2TI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 15:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVI2TI0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 15:08:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45525 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932215AbVI2TIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 15:08:25 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6BD5C13E626; Thu, 29 Sep 2005 21:08:24 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 53697B3D42; Thu, 29 Sep 2005 21:08:24 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2F01BB3D33; Thu, 29 Sep 2005 21:08:24 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A871B13E626; Thu, 29 Sep 2005 21:08:23 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509291120170.3308@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9497>

Hi,

On Thu, 29 Sep 2005, Linus Torvalds wrote:

> On Thu, 29 Sep 2005, Johannes Schindelin wrote:
> >
> > With this patch, instead of blindly asking for every remote ref, fetch-pack
> > first looks in the local repository if that ref is already there.
> 
> No. This is WRONG.

Actually, this is not wrong. The patch is wrong. Here's why:

> The "fetch" semantics are simple: we only write out new refs _after_ we've 
> fetched all the objects that point to them. That means that while we 
> cannot trust a "oh, I already have this commit, let's skip it", we _can_ 
> trust "oh, I already have these refs, let's skip them".

What the commit message should suggest was: if a local ref is identical to 
the remote ref, do not "want" it. But of course, I got it all wrong. BTW 
this patch is not to annoy you, but to ease the burden on the server for 
git-daemon. (Many a developer begins the day by fetching the latest and 
greatest).

The correct way to go about it would be to check that

$(git-rev-list <remote_ref> $(git-rev-parse --all | sed "s/^/^/"))

is empty. However, I am lazy, and in most cases, it is sufficient to check 
if the remote ref is identical to a local ref. So here goes another try:

[PATCH] fetch-pack should not ask for a ref which is already there

With this patch, instead of blindly asking for every remote ref, fetch-pack
first looks in the local repository if that ref is already a local ref.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 fetch-pack.c |   72 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 52 insertions(+), 20 deletions(-)

edfbae3927434270c35dfcad417e7d202e509e90
diff --git a/fetch-pack.c b/fetch-pack.c
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -9,6 +9,22 @@ static const char fetch_pack_usage[] =
 "git-fetch-pack [-q] [-v] [--exec=upload-pack] [host:]directory <refs>...";
 static const char *exec = "git-upload-pack";
 
+static int has_ref_flag;
+static const unsigned char *has_ref_sha1;
+
+static int has_ref_helper(const char *path, const unsigned char *sha1) {
+	if(!memcmp(sha1, has_ref_sha1, 20))
+		has_ref_flag = 1;
+	return has_ref_flag;
+}
+
+static int has_ref(const unsigned char *sha1) {
+	has_ref_sha1 = sha1;
+	has_ref_flag = 0;
+	for_each_ref(has_ref_helper);
+	return has_ref_flag;
+}
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
@@ -16,20 +32,27 @@ static int find_common(int fd[2], unsign
 	int count = 0, flushes = 0, retval;
 	FILE *revs;
 
-	revs = popen("git-rev-list $(git-rev-parse --all)", "r");
-	if (!revs)
-		die("unable to run 'git-rev-list'");
-
 	while (refs) {
 		unsigned char *remote = refs->old_sha1;
-		if (verbose)
-			fprintf(stderr,
-				"want %s (%s)\n", sha1_to_hex(remote),
-				refs->name);
-		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+		if(!has_ref(remote)) {
+			if (verbose)
+				fprintf(stderr,
+					"want %s (%s)\n", sha1_to_hex(remote),
+					refs->name);
+			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+			count++;
+		}
 		refs = refs->next;
 	}
 	packet_flush(fd[1]);
+
+	if(count==0)
+		return 1;
+
+	revs = popen("git-rev-list $(git-rev-parse --all)", "r");
+	if (!revs)
+		die("unable to run 'git-rev-list'");
+
 	flushes = 1;
 	retval = -1;
 	while (fgets(line, sizeof(line), revs) != NULL) {
@@ -74,7 +97,7 @@ static int find_common(int fd[2], unsign
 	return retval;
 }
 
-static int fetch_pack(int fd[2], int nr_match, char **match)
+static struct ref *fetch_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *ref;
 	unsigned char sha1[20];
@@ -86,7 +109,10 @@ static int fetch_pack(int fd[2], int nr_
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	if (find_common(fd, sha1, ref) < 0)
+	status = find_common(fd, sha1, ref);
+	if(status > 0)
+		return ref;
+	if(status < 0)
 		fprintf(stderr, "warning: no common commits\n");
 	pid = fork();
 	if (pid < 0)
@@ -109,12 +135,7 @@ static int fetch_pack(int fd[2], int nr_
 		int code = WEXITSTATUS(status);
 		if (code)
 			die("git-unpack-objects died with error code %d", code);
-		while (ref) {
-			printf("%s %s\n",
-			       sha1_to_hex(ref->old_sha1), ref->name);
-			ref = ref->next;
-		}
-		return 0;
+		return ref;
 	}
 	if (WIFSIGNALED(status)) {
 		int sig = WTERMSIG(status);
@@ -125,10 +146,11 @@ static int fetch_pack(int fd[2], int nr_
 
 int main(int argc, char **argv)
 {
-	int i, ret, nr_heads;
+	int i, nr_heads;
 	char *dest = NULL, **heads;
 	int fd[2];
 	pid_t pid;
+	struct ref *ref;
 
 	nr_heads = 0;
 	heads = NULL;
@@ -160,9 +182,19 @@ int main(int argc, char **argv)
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
 		return 1;
-	ret = fetch_pack(fd, nr_heads, heads);
+	ref = fetch_pack(fd, nr_heads, heads);
+	if(!ref)
+		return 1;
+
+	while (ref) {
+		printf("%s %s\n",
+		       sha1_to_hex(ref->old_sha1), ref->name);
+		ref = ref->next;
+	}
+
 	close(fd[0]);
 	close(fd[1]);
 	finish_connect(pid);
-	return ret;
+
+	return 0;
 }
