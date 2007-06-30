From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-mergetool: add support for ediff
Date: Sat, 30 Jun 2007 20:56:19 +1200
Message-ID: <11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:57:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4YlO-0006AV-4s
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbXF3I4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbXF3I4o
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:44 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56655 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbXF3I40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:26 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykg-0008UH-LA; Sat, 30 Jun 2007 20:56:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 9B8AD5CE00; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51207>

There was emerge already but I much prefer this mode.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/config.txt        |    3 ++-
 Documentation/git-mergetool.txt |    3 ++-
 git-mergetool.sh                |   19 ++++++++++++++-----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 50503e8..4661e24 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -550,7 +550,8 @@ merge.summary::
 merge.tool::
 	Controls which merge resolution program is used by
 	gitlink:git-mergetool[l].  Valid values are: "kdiff3", "tkdiff",
-	"meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and "opendiff".
+	"meld", "xxdiff", "emerge", "ediff", "vimdiff", "gvimdiff", and
+	"opendiff".
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 6c32c6d..1efe6e4 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -25,7 +25,8 @@ OPTIONS
 -t or --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, and opendiff
+	kdiff3, tkdiff, meld, xxdiff, emerge, ediff, vimdiff, gvimdiff,
+	and opendiff
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable merge.tool.  If the
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 7b66309..6fda8af 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -258,6 +258,15 @@ merge_file () {
 	    status=$?
 	    save_backup
 	    ;;
+	ediff)
+	    if base_present ; then
+		emacs --eval "(ediff-merge-files-with-ancestor \"$LOCAL\" \"$REMOTE\" \"$BASE\" nil \"$path\")"
+	    else
+		emacs --eval "(ediff-merge-files \"$LOCAL\" \"$REMOTE\" nil \"$path\")"
+	    fi
+	    status=$?
+	    save_backup
+	    ;;
     esac
     if test "$status" -ne 0; then
 	echo "merge of $path failed" 1>&2
@@ -299,7 +308,7 @@ done
 if test -z "$merge_tool"; then
     merge_tool=`git-config merge.tool`
     case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | "")
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | ediff | vimdiff | gvimdiff | "")
 	    ;; # happy
 	*)
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
@@ -320,15 +329,15 @@ if test -z "$merge_tool" ; then
         fi
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates emerge"
+        merge_tool_candidates="$merge_tool_candidates emerge ediff"
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
         merge_tool_candidates="$merge_tool_candidates vimdiff"
     fi
-    merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
+    merge_tool_candidates="$merge_tool_candidates opendiff ediff emerge vimdiff"
     echo "merge tool candidates: $merge_tool_candidates"
     for i in $merge_tool_candidates; do
-        if test $i = emerge ; then
+        if test $i = emerge || test $i = ediff ; then
             cmd=emacs
         else
             cmd=$i
@@ -351,7 +360,7 @@ case "$merge_tool" in
 	    exit 1
 	fi
 	;;
-    emerge)
+    emerge|ediff)
 	if ! type "emacs" > /dev/null 2>&1; then
 	    echo "Emacs is not available"
 	    exit 1
-- 
1.5.2.1.1131.g3b90
