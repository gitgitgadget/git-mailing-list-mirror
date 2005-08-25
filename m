From: James Ketrenos <jketreno@linux.intel.com>
Subject: [PATCH] cogito -- add -c $commit support
Date: Thu, 25 Aug 2005 13:19:55 -0500
Message-ID: <430E0BCB.5010402@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020900000007010504050305"
X-From: git-owner@vger.kernel.org Thu Aug 25 20:22:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8MKW-0008VR-OQ
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 20:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVHYST6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 14:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVHYST6
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 14:19:58 -0400
Received: from fmr19.intel.com ([134.134.136.18]:21944 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751400AbVHYST5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 14:19:57 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7PIJvrI005872
	for <git@vger.kernel.org>; Thu, 25 Aug 2005 18:19:57 GMT
Received: from [192.168.1.154] (logicsbox.jf.intel.com [134.134.16.142])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j7PIJtpD007109
	for <git@vger.kernel.org>; Thu, 25 Aug 2005 18:19:56 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050816
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7755>

This is a multi-part message in MIME format.
--------------020900000007010504050305
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Add -c parameter to cg-commit to set commit data based on prior commit.

This will then commit any changes using the author and message from the commit
specified.  The actual logic for parsing the old commit values was taken from
git-commit-script.

git-commit-script supports this option via -C, which was already used in cg-commit
for something else.

Signed-off-by: James Ketrenos <jketreno@linux.intel.com>
---

 cg-commit |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

b07037397659763271e946fc15c0b3c61a8fcdfa
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -3,6 +3,8 @@
 # Commit into a GIT repository.
 # Copyright (c) Petr Baudis, 2005
 # Based on an example script fragment sent to LKML by Linus Torvalds.
+# 
+# -c commit based on code in git-commit-script by Linus Torvalds
 #
 # Commits changes to a GIT repository. Accepts the commit message from
 # `stdin`. If the commit message is not modified the commit will be
@@ -45,6 +47,12 @@
 #	might not actually _have_ any object database. This option is
 #	normally not interesting.
 #
+# -c::
+#	Specifify the commit SHA to inherit the GIT_AUTHOR_* variables and
+#	commit message from.  The GIT_COMMITTER_* variables will not be
+#	inherited from the specified commit.  This option is typically used
+#	when replaying commits from one lineage or repository to another.
+#	
 # FILES
 # -----
 # $GIT_DIR/author::
@@ -112,6 +120,7 @@ ignorecache=
 infoonly=
 commitalways=
 missingok=
+use_commit=
 msgs=()
 while optparse; do
 	if optparse -C; then
@@ -128,6 +137,8 @@ while optparse; do
 		force=1
 	elif optparse -m=; then
 		msgs[${#msgs[@]}]="$OPTARG"
+	elif optparse -c=; then
+	    use_commit="$OPTARG"
 	else
 		optfail
 	fi
@@ -196,6 +207,39 @@ for msg in "${msgs[@]}"; do
 	echo "$msg" | fmt -s >>$LOGMSG
 	written=1
 done
+
+if [ "$use_commit" ]; then
+	pick_author_script='
+		/^author /{
+			h
+			s/^author \([^<]*\) <[^>]*> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/GIT_AUTHOR_NAME='\''&'\''/p
+
+			g
+			s/^author [^<]* <\([^>]*\)> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
+
+			g
+			s/^author [^<]* <[^>]*> \(.*\)$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/GIT_AUTHOR_DATE='\''&'\''/p
+
+			q
+		}
+		'
+	set_author_env=`git-cat-file commit "$use_commit" |
+	sed -ne "$pick_author_script"`
+	eval "$set_author_env"
+	export GIT_AUTHOR_NAME
+	export GIT_AUTHOR_EMAIL
+	export GIT_AUTHOR_DATE
+	git-cat-file commit "$use_commit" |
+	sed -e '1,/^$/d'
+        written=1
+fi >> $LOGMSG
+
 # Always have at least one blank line, to ease the editing for
 # the poor people whose text editor has no 'O' command.
 [ "$written" ] || echo >>$LOGMSG
@@ -239,7 +283,7 @@ echo "CG: vim: textwidth=75" >>$LOGMSG
 
 cp $LOGMSG $LOGMSG2
 if tty -s; then
-	if ! [ "$msgs" ] || [ "$forceeditor" ]; then
+	if ! ([ "$use_commit" ] || [ "$msgs" ]) || [ "$forceeditor" ]; then
 		${EDITOR:-vi} $LOGMSG2
 		if ! [ "$commitalways" ] && ! [ $LOGMSG2 -nt $LOGMSG ]; then
 			echo "Log message unchanged or not specified" >&2



--------------020900000007010504050305
Content-Type: text/plain;
 name="0001-Add-c-parameter-to-cg-commit-to-set-commit-data-based-on-prior-commit.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Add-c-parameter-to-cg-commit-to-set-commit-data-based-on-prior-commit.txt"

[PATCH] Add -c parameter to cg-commit to set commit data based on prior commit.

This will then commit any changes using the author and message from the commit
specified.  The actual logic for parsing the old commit values was taken from
git-commit-script.

git-commit-script supports this option via -C, which was already used in cg-commit
for something else.

Signed-off-by: James Ketrenos <jketreno@linux.intel.com>
---

 cg-commit |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

b07037397659763271e946fc15c0b3c61a8fcdfa
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -3,6 +3,8 @@
 # Commit into a GIT repository.
 # Copyright (c) Petr Baudis, 2005
 # Based on an example script fragment sent to LKML by Linus Torvalds.
+# 
+# -c commit based on code in git-commit-script by Linus Torvalds
 #
 # Commits changes to a GIT repository. Accepts the commit message from
 # `stdin`. If the commit message is not modified the commit will be
@@ -45,6 +47,12 @@
 #	might not actually _have_ any object database. This option is
 #	normally not interesting.
 #
+# -c::
+#	Specifify the commit SHA to inherit the GIT_AUTHOR_* variables and
+#	commit message from.  The GIT_COMMITTER_* variables will not be
+#	inherited from the specified commit.  This option is typically used
+#	when replaying commits from one lineage or repository to another.
+#	
 # FILES
 # -----
 # $GIT_DIR/author::
@@ -112,6 +120,7 @@ ignorecache=
 infoonly=
 commitalways=
 missingok=
+use_commit=
 msgs=()
 while optparse; do
 	if optparse -C; then
@@ -128,6 +137,8 @@ while optparse; do
 		force=1
 	elif optparse -m=; then
 		msgs[${#msgs[@]}]="$OPTARG"
+	elif optparse -c=; then
+	    use_commit="$OPTARG"
 	else
 		optfail
 	fi
@@ -196,6 +207,39 @@ for msg in "${msgs[@]}"; do
 	echo "$msg" | fmt -s >>$LOGMSG
 	written=1
 done
+
+if [ "$use_commit" ]; then
+	pick_author_script='
+		/^author /{
+			h
+			s/^author \([^<]*\) <[^>]*> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/GIT_AUTHOR_NAME='\''&'\''/p
+
+			g
+			s/^author [^<]* <\([^>]*\)> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
+
+			g
+			s/^author [^<]* <[^>]*> \(.*\)$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/GIT_AUTHOR_DATE='\''&'\''/p
+
+			q
+		}
+		'
+	set_author_env=`git-cat-file commit "$use_commit" |
+	sed -ne "$pick_author_script"`
+	eval "$set_author_env"
+	export GIT_AUTHOR_NAME
+	export GIT_AUTHOR_EMAIL
+	export GIT_AUTHOR_DATE
+	git-cat-file commit "$use_commit" |
+	sed -e '1,/^$/d'
+        written=1
+fi >> $LOGMSG
+
 # Always have at least one blank line, to ease the editing for
 # the poor people whose text editor has no 'O' command.
 [ "$written" ] || echo >>$LOGMSG
@@ -239,7 +283,7 @@ echo "CG: vim: textwidth=75" >>$LOGMSG
 
 cp $LOGMSG $LOGMSG2
 if tty -s; then
-	if ! [ "$msgs" ] || [ "$forceeditor" ]; then
+	if ! ([ "$use_commit" ] || [ "$msgs" ]) || [ "$forceeditor" ]; then
 		${EDITOR:-vi} $LOGMSG2
 		if ! [ "$commitalways" ] && ! [ $LOGMSG2 -nt $LOGMSG ]; then
 			echo "Log message unchanged or not specified" >&2

--------------020900000007010504050305--
