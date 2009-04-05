From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 3/3] git-mergetool: add new merge tool TortoiseMerge
Date: Sun, 5 Apr 2009 14:43:27 +0200
Message-ID: <200904051443.28462.markus.heidelberg@web.de>
References: <200904051440.33154.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 14:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqRig-0004h8-Eo
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 14:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbZDEMn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 08:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbZDEMn0
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 08:43:26 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:53359 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbZDEMnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 08:43:25 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id A2EB1F9FF1FE;
	Sun,  5 Apr 2009 14:43:23 +0200 (CEST)
Received: from [89.59.118.104] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqRh5-0001s7-00; Sun, 05 Apr 2009 14:43:23 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200904051440.33154.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19qDevpFNmZMNYX54q9RBuoGKhKSVeWHxYCdGvC
	TwCuYR+LF8r3fEkvGeVJaCPGb1b289295dmVH/puMVe8nXfqK5
	X7UYYL1K7uwJiC4Rtr6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115661>

TortoiseMerge comes with TortoiseSVN or TortoiseGit for Windows. It can
only be used as a merge tool with an existing base file. It cannot be
used without a base nor as a diff tool.

The documentation only mentions the slash '/' as command line option
prefix, which refused to work, but the parser also accepts the dash '-'

See http://code.google.com/p/msysgit/issues/detail?id=226

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-mergetool.txt |    3 ++-
 Documentation/merge-config.txt  |    2 +-
 git-mergetool.sh                |   16 +++++++++++++---
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 5d3c632..5edac4d 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -26,7 +26,8 @@ OPTIONS
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
+	tortoisemerge and opendiff
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 9c44af8..8c10f66 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -23,7 +23,7 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"ecmerge" and
+	"ecmerge", tortoisemerge and
 	"opendiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 6e611e9..be9717a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -265,6 +265,16 @@ merge_file () {
 	    fi
 	    status=$?
 	    ;;
+	tortoisemerge)
+	    if base_present ; then
+		touch "$BACKUP"
+		"$merge_tool_path" -base:"$BASE" -mine:"$LOCAL" -theirs:"$REMOTE" -merged:"$MERGED"
+		check_unchanged
+	    else
+		echo "TortoiseMerge cannot be used without a base" 1>&2
+		status=1
+	    fi
+	    ;;
 	*)
 	    if test -n "$merge_tool_cmd"; then
 		if test "$merge_tool_trust_exit_code" = "false"; then
@@ -345,7 +355,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | tortoisemerge)
 			;; # happy
 		*)
 			if ! valid_custom_tool "$1"; then
@@ -404,9 +414,9 @@ fi
 if test -z "$merge_tool" ; then
     if test -n "$DISPLAY"; then
         if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-            merge_tool_candidates="meld kdiff3 tkdiff xxdiff gvimdiff"
+            merge_tool_candidates="meld kdiff3 tkdiff xxdiff tortoisemerge gvimdiff"
         else
-            merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
+            merge_tool_candidates="kdiff3 tkdiff xxdiff meld tortoisemerge gvimdiff"
         fi
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-- 
1.6.2.2.460.g49e5c
