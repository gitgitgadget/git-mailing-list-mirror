From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch-pack should not ask for a ref which is already
 there
Date: Thu, 29 Sep 2005 10:42:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509291034450.20717@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vll1gl4ms.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 10:45:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKu0g-0000EQ-0c
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 10:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVI2Ime (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 04:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVI2Ime
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 04:42:34 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47268 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751170AbVI2Imd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 04:42:33 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AA73813EA33; Thu, 29 Sep 2005 10:42:32 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 89000B3975; Thu, 29 Sep 2005 10:42:32 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 62A5EA885D; Thu, 29 Sep 2005 10:42:32 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 478A613EA35; Thu, 29 Sep 2005 10:42:32 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll1gl4ms.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9476>

Hi,

On Thu, 29 Sep 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > With this patch, instead of blindly asking for every remote ref, fetch-pack
> > first looks in the local repository if that ref is already there.
> 
> This patch breaks things.  git-fetch-pack is supposed to report
> the resulting SHA1 and refs on its standard output.  If you are
> up to date with this patch you would lose that.

Yeah, sorry. I did not test that one. Maybe an automated test for 
git-fetch-pack would be useful after all...

How about the following? (I avoided an ugly goto, but had to duplicate 
code :-( )

---

[PATCH] fetch-pack should not ask for a ref which is already there

With this patch, instead of blindly asking for every remote ref, fetch-pack
first looks in the local repository if that ref is already there.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 fetch-pack.c |   36 ++++++++++++++++++++++++++----------
 1 files changed, 26 insertions(+), 10 deletions(-)

fbef982e4c5c4591b8d5517ef1694ab71e29c9e5
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
@@ -86,7 +93,16 @@ static int fetch_pack(int fd[2], int nr_
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	if (find_common(fd, sha1, ref) < 0)
+	status = find_common(fd, sha1, ref);
+	if(status > 0) {
+		while (ref) {
+			printf("%s %s\n",
+			       sha1_to_hex(ref->old_sha1), ref->name);
+			ref = ref->next;
+		}
+		return 0;
+	}
+	if(status < 0)
 		fprintf(stderr, "warning: no common commits\n");
 	pid = fork();
 	if (pid < 0)
