From: David Kastrup <dak@gnu.org>
Subject: [Untested! proposal] git-mergetool.sh: introduce ediff option
Date: Sun, 29 Jul 2007 15:51:34 +0200
Organization: Organization?!?
Message-ID: <85hcnnwblu.fsf@lola.goethe.zz>
References: <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net> <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
 <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
 <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com> <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
 <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> <7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net>
 <85zm1g3nze.fsf@lola.goethe.zz> <85bqdw27mb.fsf@lola.goethe.zz>
 <20070729031612.GB17204@thunk.org> <Pine.LNX.4.64.0707291224460.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 16:04:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF9OA-0004b7-Gn
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 16:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763441AbXG2OEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 10:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762834AbXG2OEU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 10:04:20 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:50270 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762864AbXG2OEQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 10:04:16 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 3F10B17FC8B;
	Sun, 29 Jul 2007 16:04:14 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 25FD5345C06;
	Sun, 29 Jul 2007 16:04:14 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 744508C46C;
	Sun, 29 Jul 2007 16:04:06 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 046421CFF95E; Sun, 29 Jul 2007 16:03:41 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3804/Sun Jul 29 06:09:31 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54116>


This is not yet tested (still have to do that): it's a base for
discussion and something which I think reasonable.  It does not touch
the old behavior of "emerge" apart from calling Emacs with option -q
foregoing user-specific initializations, and preselects "ediff" only
where EDITOR/VISUAL suggest Emacs being used as a normal editor.

Here goes:

Most actual Emacs users prefer ediff to emerge concerning the
consolidation of versions.  In general, people habitually using Emacs
will have this preference reflected in the EDITOR/VISUAL environment
variables.

If such a preference can be found there, ediff will be used/offered in
preference of emerge (which retains its previous behavior).

In ediff mode, success or failure of the merge will be discerned by
Emacs either having written or not written the merge buffer; no
attempt of interpreting the exit code is made.

This is much closer to the working habits of Emacs users than the
emerge behavior which uses Emacs as a one-shot session editor.

In order to bypass things like desktop files being loaded, emerge mode
now passes the "-q" option to Emacs.  This will make it work in more
situations likely to occur, at the price of excluding possibly
harmless user customizations with the rest.
---
 git-mergetool.sh |   50 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 47a8055..8ed3ed4 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -251,13 +251,27 @@ merge_file () {
 	    ;;
 	emerge)
 	    if base_present ; then
-		emacs -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$path"
+		emacs -q -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$path"
 	    else
-		emacs -f emerge-files-command "$LOCAL" "$REMOTE" "$path"
+		emacs -q -f emerge-files-command "$LOCAL" "$REMOTE" "$path"
 	    fi
 	    status=$?
 	    save_backup
 	    ;;
+	ediff)
+	    case "${EDITOR:-${VISUAL:-emacs}}" in
+		*/emacs*|*/gnuclient*|*/xemacs*)
+		    emacs_candidate="${EDITOR:-${VISUAL:-emacs}}";;
+		*)
+		    emacs_candidate=emacs;;
+	    esac
+	    if base_present ; then
+		${emacs_candidate} --eval "(ediff-merge-files-with-ancestor (pop command-line-args-left) (pop command-line-args-left) (pop command-line-args-left) nil (pop-command-line-args-left))" "$LOCAL" "$REMOTE" "$BASE" "$path"
+	    else
+		${emacs_candidate} --eval "(ediff-merge-files (pop command-line-args-left) (pop command-line-args-left) nil (pop-command-line-args-left))" "$LOCAL" "$REMOTE" "$path"
+	    fi
+	    check_unchanged
+	    save_backup
     esac
     if test "$status" -ne 0; then
 	echo "merge of $path failed" 1>&2
@@ -299,7 +313,7 @@ done
 if test -z "$merge_tool"; then
     merge_tool=`git config merge.tool`
     case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | "")
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | ediff | vimdiff | gvimdiff | "")
 	    ;; # happy
 	*)
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
@@ -319,23 +333,26 @@ if test -z "$merge_tool" ; then
             merge_tool_candidates="kdiff3 $merge_tool_candidates"
         fi
     fi
-    if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates emerge"
-    fi
+    case "${EDITOR:-${VISUAL}}" in
+	*/emacs*|*/gnuclient*|*/xemacs*)
+            merge_tool_candidates="$merge_tool_candidates ediff"
+    esac
     if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
         merge_tool_candidates="$merge_tool_candidates vimdiff"
     fi
     merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
     echo "merge tool candidates: $merge_tool_candidates"
     for i in $merge_tool_candidates; do
-        if test $i = emerge ; then
-            cmd=emacs
-        else
-            cmd=$i
-        fi
-        if type $cmd > /dev/null 2>&1; then
-            merge_tool=$i
-            break
+	case $i in emerge)
+		cmd=emacs;;
+	    ediff)
+		merge_tool=$i
+		break;;
+	    *) cmd=$i
+	    esac
+	if type $cmd > /dev/null 2>&1; then
+	    merge_tool=$i
+	    break
         fi
     done
     if test -z "$merge_tool" ; then
@@ -357,6 +374,11 @@ case "$merge_tool" in
 	    exit 1
 	fi
 	;;
+    ediff)
+	if ! (set ${EDITOR:-${VISUAL:-emacs}}; type "$1" > /dev/null 2>&1); then
+	    echo "${EDITOR:-${VISUAL:-emacs}} is not available"
+	    exit 1
+	fi
     *)
 	echo "Unknown merge tool: $merge_tool"
 	exit 1
-- 
1.5.2.3
