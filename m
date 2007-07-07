From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make attributes "-diff" and "diff" work as advertized
Date: Sat, 7 Jul 2007 17:53:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071749220.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 07 19:00:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7De4-00026G-O4
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 19:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbXGGRA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 13:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXGGRA3
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 13:00:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:45823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752040AbXGGRA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 13:00:28 -0400
Received: (qmail invoked by alias); 07 Jul 2007 17:00:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 07 Jul 2007 19:00:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QNhJQxjIQopEtbAoh0bZ723l0q2oxeAWd3EyPZ0
	IIMHyEimiIh7UJ
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51825>


In Documentation/gitattributes.txt, it says that you can suppress
diffs by setting the attribute "-diff", and you can override the
binary detection with the attribute "diff".

Make it work.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Evidently, this is on top of "next" + the funcname patches, since
	I realized it only when working on top of them.

	However, it should also apply cleanly to "master", and even 
	"maint". (The only reason I'm not doing it right now, is that I am 
	in the middle of preparing a patch pair, and doing this patch was 
	easy enough with rebase -i.)

 diff.c                   |   15 +++++++--------
 t/t4020-diff-external.sh |   12 ++++++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 21e61af..e92db5c 100644
--- a/diff.c
+++ b/diff.c
@@ -1170,13 +1170,19 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
 	one->is_binary = 0;
 	one->funcname_pattern_ident = NULL;
 
+	if (!one->data && DIFF_FILE_VALID(one))
+		diff_populate_filespec(one, 0);
+
+	if (one->data)
+		one->is_binary = buffer_is_binary(one->data, one->size);
+
 	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
 		const char *value;
 
 		/* binaryness */
 		value = attr_diff_check.value;
 		if (ATTR_TRUE(value))
-			;
+			one->is_binary = 0;
 		else if (ATTR_FALSE(value))
 			one->is_binary = 1;
 
@@ -1186,13 +1192,6 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
 		else
 			one->funcname_pattern_ident = value;
 	}
-
-	if (!one->data && DIFF_FILE_VALID(one))
-		diff_populate_filespec(one, 0);
-
-	if (one->data)
-		one->is_binary = buffer_is_binary(one->data, one->size);
-
 }
 
 int diff_filespec_is_binary(struct diff_filespec *one)
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index f0045cd..ed3bd5b 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -94,4 +94,16 @@ test_expect_success 'diff attribute should apply only to diff' '
 
 '
 
+test_expect_success 'no diff with -diff' '
+	echo >.gitattributes "file -diff" &&
+	git diff | grep Binary
+'
+
+echo NULZbetweenZwords | tr Z '\0' > file
+
+test_expect_success 'force diff with "diff"' '
+	echo >.gitattributes "file diff" &&
+	git diff | grep -a second
+'
+
 test_done
-- 
1.5.3.rc0.2712.g125b7f
