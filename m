From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-mv: special case destination "."
Date: Fri, 18 Aug 2006 12:42:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608181241200.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060818072328.GA5255@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 12:42:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE1oT-0004on-HM
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 12:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWHRKmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 06:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWHRKmm
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 06:42:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:28607 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751360AbWHRKml (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 06:42:41 -0400
Received: (qmail invoked by alias); 18 Aug 2006 10:42:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 18 Aug 2006 12:42:40 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060818072328.GA5255@c165.ib.student.liu.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25647>


Since the normalized basename of "." is "", the check for directory
failed erroneously.

Noticed by Fredrik Kuivinen.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

	> Subject: Re: Another git-mv bug

	... and another fix.

	On Fri, 18 Aug 2006, Fredrik Kuivinen wrote:

	> In a Git repository:
	> 
	>     $ git mv templates/info--exclude .
	>     fatal: renaming templates/info--exclude failed: No such file or directory

 builtin-mv.c  |    5 ++++-
 t/t7001-mv.sh |    4 ++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index c0c8764..b2ecc26 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -114,7 +114,10 @@ int cmd_mv(int argc, const char **argv, 
 	modes = xcalloc(count, sizeof(enum update_mode));
 	dest_path = copy_pathspec(prefix, argv + argc - 1, 1, 0);
 
-	if (!lstat(dest_path[0], &st) &&
+	if (dest_path[0][0] == '\0')
+		/* special case: "." was normalized to "" */
+		destination = copy_pathspec(dest_path[0], argv + i, count, 1);
+	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
 		dest_path[0] = add_slash(dest_path[0]);
 		destination = copy_pathspec(dest_path[0], argv + i, count, 1);
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e5e0bb9..b7fcdb3 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -82,4 +82,8 @@ test_expect_failure \
     'do not move directory over existing directory' \
     'mkdir path0 && mkdir path0/path2 && git-mv path2 path0'
 
+test_expect_success \
+    'move into "."' \
+    'git-mv path1/path2/ .'
+
 test_done
-- 
1.4.2.ge0502-dirty
