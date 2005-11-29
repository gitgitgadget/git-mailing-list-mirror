From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-commit: append sign off line when passed -s or --signoff
Date: Wed, 30 Nov 2005 00:58:51 +0100
Message-ID: <20051129235851.GB5365@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 01:00:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhFN9-0001i5-Uz
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 00:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVK2X6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 18:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVK2X6x
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 18:58:53 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:3071 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751408AbVK2X6w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 18:58:52 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 84D3C6DFF0F; Wed, 30 Nov 2005 00:58:07 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3CC6E6DFECF; Wed, 30 Nov 2005 00:58:07 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 491B961494; Wed, 30 Nov 2005 00:58:51 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12971>

No sign off line is appended if it already is signed off. By default the
identity reported by 'git-var GIT_AUTHOR_IDENT' is used for signing off.
Optionally, specify the name and email to sign off with by doing:

	cg-commit --signoff='Author Name <user@example.com>

If the commit message specified on the command line already contains
signed off lines no empty line is inserted between the message and the
sign off line.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit dd872816a04f6462686e282b00d3e1523e3ecf4c
tree a8487566085727636a5782e2edb270190b9f3916
parent c0a9b8feb79d72f7c02f37392da840dbad446dbd
author Jonas Fonseca <fonseca@diku.dk> Mon, 28 Nov 2005 04:42:05 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Mon, 28 Nov 2005 04:42:05 +0100

 TODO      |    2 --
 cg-commit |   17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/TODO b/TODO
index 5193d08..777c728 100644
--- a/TODO
+++ b/TODO
@@ -79,8 +79,6 @@ cg-*patch should be pre-1.0.)
 		  whitespace errors and stuff; hooks are good for this too,
 		  but I think it's good to have internal support for the
 		  basic stuff.
-		* -s,--signoff to automatically append a signoff line of
-		  yours to the patch.
 	-- post 1.0 --
 	* Patch-altering cg-commit
 		You can already alter the list of files to be committed,
diff --git a/cg-commit b/cg-commit
index d084c24..9f8d5d5 100755
--- a/cg-commit
+++ b/cg-commit
@@ -58,6 +58,11 @@
 #	Be quiet in case there's "nothing to commit", and silently exit
 #	returning success. In a sense, this is the opposite to '-f'.
 #
+# -s, --signoff:: Automatically append a sign off line
+#	Add Signed-off-by line at the end of the commit message.
+#	Optionally, specify the exact name and email to sign off with by
+#	passing: `--signoff="Author Name <user@example.com>"`.
+#
 # FILES
 # -----
 # $GIT_DIR/author::
@@ -119,7 +124,7 @@
 # EDITOR::
 #	The editor used for entering revision log information.
 
-USAGE="cg-commit [-m MESSAGE]... [-C] [-e | -E] [-c COMMIT_ID] [FILE]... [< MESSAGE]"
+USAGE="cg-commit [-m MESSAGE]... [-C] [-e | -E] [-s | --signoff] [-c COMMIT_ID] [FILE]... [< MESSAGE]"
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
@@ -148,6 +153,7 @@ ignorecache=
 infoonly=
 commitalways=
 missingok=
+signoff=
 copy_commit=
 msgs=()
 quiet=
@@ -166,6 +172,10 @@ while optparse; do
 		force=1
 	elif optparse -q; then
 		quiet=1
+	elif optparse -s || optparse --signoff; then
+		[ "$signoff" ] || signoff="$(git-var GIT_AUTHOR_IDENT | sed 's/> .*/>/')"
+	elif optparse --signoff=; then
+		signoff="$OPTARG"
 	elif optparse -m=; then
 		msgs[${#msgs[@]}]="$OPTARG"
 	elif optparse -c=; then
@@ -292,6 +302,11 @@ fi >> $LOGMSG
 # the poor people whose text editor has no 'O' command.
 [ "$written" ] || echo >>$LOGMSG
 
+if [ "$signoff" ] && ! grep -q -i "signed-off-by: $signoff" $LOGMSG; then
+	grep -q -i sign-off-by $LOGMSG || echo
+	echo "Signed-off-by: $signoff"
+fi >> $LOGMSG
+
 if [ -e "$_git/commit-template" ]; then
 	cat $_git/commit-template >>$LOGMSG
 else

-- 
Jonas Fonseca
