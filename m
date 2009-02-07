From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Offer to print changes while running git-mergetool
Date: Sat, 07 Feb 2009 00:11:06 -0800
Message-ID: <7vr62ay8dh.fsf@gitster.siamese.dyndns.org>
References: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Sat Feb 07 09:12:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LViIs-0003Ff-Vg
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 09:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbZBGILQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 03:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbZBGILP
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 03:11:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbZBGILO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 03:11:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A884E2A9CF;
	Sat,  7 Feb 2009 03:11:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 89C442A9CE; Sat, 
 7 Feb 2009 03:11:08 -0500 (EST)
In-Reply-To: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv> (Jonathan
 del Strother's message of "Fri, 6 Feb 2009 14:32:25 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E247E80C-F4EE-11DD-8F2F-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108829>

Jonathan del Strother <jon.delStrother@bestbefore.tv> writes:

> Add a "Show changes" option to each prompt in mergetool. This prints the
> conflicted changes on the current file, using 'git log -p --merge
> <file>'

I think the patch should look like this, given the recent conversation I
had with you.  It seems that the script thinks the unit of indentation is
4-places, and case arms are indented from case/esac (neither of which is
the standard git shell script convention), and I tried to match that style
used in the existing code.

No, I didn't test it.

Charles volunteered to take over mergetool, so he is on the Cc: list.

 git-mergetool.sh |   60 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 47 insertions(+), 13 deletions(-)

diff --git c/git-mergetool.sh w/git-mergetool.sh
index 87fa88a..b8604d6 100755
--- c/git-mergetool.sh
+++ w/git-mergetool.sh
@@ -14,6 +14,13 @@ OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
 
+if test -f "$GIT_DIR/MERGE_HEAD"
+then
+    in_merge=t show_changes=", (s)how changes"
+else
+    in_merge=f show_changes=
+fi
+
 # Returns true if the mode reflects a symlink
 is_symlink () {
     test "$1" = 120000
@@ -62,22 +69,28 @@ describe_file () {
 
 resolve_symlink_merge () {
     while true; do
-	printf "Use (l)ocal or (r)emote, or (a)bort? "
+	printf "Use (l)ocal or (r)emote$show_changes, or (a)bort? "
 	read ans
-	case "$ans" in
-	    [lL]*)
+	case "$in_merge,$ans" in
+	    ?,[lL]*)
 		git checkout-index -f --stage=2 -- "$MERGED"
 		git add -- "$MERGED"
 		cleanup_temp_files --save-backup
 		return 0
 		;;
-	    [rR]*)
+	    ?,[rR]*)
 		git checkout-index -f --stage=3 -- "$MERGED"
 		git add -- "$MERGED"
 		cleanup_temp_files --save-backup
 		return 0
 		;;
-	    [aA]*)
+	    t,[sS]*)
+		git log -p --merge "$MERGED"
+		printf "\n"
+		resolve_symlink_merge
+		return
+		;;
+	    ?,[aA]*)
 		return 1
 		;;
 	    esac
@@ -87,23 +100,29 @@ resolve_symlink_merge () {
 resolve_deleted_merge () {
     while true; do
 	if base_present; then
-	    printf "Use (m)odified or (d)eleted file, or (a)bort? "
+	    printf "Use (m)odified or (d)eleted file$show_changes, or (a)bort? "
 	else
-	    printf "Use (c)reated or (d)eleted file, or (a)bort? "
+	    printf "Use (c)reated or (d)eleted file$show changes, or (a)bort? "
 	fi
 	read ans
-	case "$ans" in
-	    [mMcC]*)
+	case "$in_merge,$ans" in
+	    ?,[mMcC]*)
 		git add -- "$MERGED"
 		cleanup_temp_files --save-backup
 		return 0
 		;;
-	    [dD]*)
+	    ?,[dD]*)
 		git rm -- "$MERGED" > /dev/null
 		cleanup_temp_files
 		return 0
 		;;
-	    [aA]*)
+	    t,[sS]*)
+		git log -p --merge "$MERGED"
+		printf "\n"
+		resolve_deleted_merge
+		return
+		;;
+	    ?,[aA]*)
 		return 1
 		;;
 	    esac
@@ -184,8 +203,23 @@ merge_file () {
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
     if "$prompt" = true; then
-	printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-	read ans
+	while true; do
+	    case $in_merge in
+		t)	msg_head="(S)how changes, or h" ;;
+		f)	msg_head="H" ;;
+	    esac
+	    print "${msg_head}it return to start merge resolution tool (%s): " "$merge_tool"
+	    read ans
+	    case "$in_merge,$ans" in
+	        t,[sS]*)
+		    git log -p --merge "$MERGED"
+		    printf "\n"
+		    ;;
+		?,*)
+		    break
+		    ;;
+	    esac
+        done
     fi
 
     case "$merge_tool" in
