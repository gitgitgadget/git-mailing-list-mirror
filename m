From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch-pack should not ask for a ref which is already
 there
Date: Thu, 29 Sep 2005 11:30:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509291129220.29969@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vll1gl4ms.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509291034450.20717@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vhdc4grrf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 11:31:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKukR-0006Ud-CC
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 11:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVI2JaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 05:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVI2JaV
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 05:30:21 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63925 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751297AbVI2JaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 05:30:20 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2F59413E5B0; Thu, 29 Sep 2005 11:30:19 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 168199DB20; Thu, 29 Sep 2005 11:30:19 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E7CC399C95; Thu, 29 Sep 2005 11:30:18 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C941513E5B0; Thu, 29 Sep 2005 11:30:18 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdc4grrf.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9481>

Hi,

On Thu, 29 Sep 2005, Junio C Hamano wrote:

> I suspect it would be cleaner to return (struct ref *) from
> fetch_pack (ideally use NULL to signal failure but there is no
> need -- it just dies) and print the refs from main() only after
> seeing the last close and finish_connect succeed.

Here's my next try:

[PATCH] fetch-pack should not ask for a ref which is already there
From: Johannes Schindelin <gene099@localhost>
Date: 1127950437 +0200

With this patch, instead of blindly asking for every remote ref, fetch-pack
first looks in the local repository if that ref is already there.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 fetch-pack.c |   56 ++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 20 deletions(-)

210c4c6fe4a353d59e4ca2871d7f2a3c1b9b1238
diff --git a/fetch-pack.c b/fetch-pack.c
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -16,20 +16,27 @@ static int find_common(int fd[2], unsign
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
+		if(!has_sha1_file(remote)) {
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
@@ -74,7 +81,7 @@ static int find_common(int fd[2], unsign
 	return retval;
 }
 
-static int fetch_pack(int fd[2], int nr_match, char **match)
+static struct ref *fetch_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *ref;
 	unsigned char sha1[20];
@@ -86,7 +93,10 @@ static int fetch_pack(int fd[2], int nr_
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
@@ -109,12 +119,7 @@ static int fetch_pack(int fd[2], int nr_
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
@@ -125,10 +130,11 @@ static int fetch_pack(int fd[2], int nr_
 
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
@@ -160,9 +166,19 @@ int main(int argc, char **argv)
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
