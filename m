From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: working out where git-rebase is up to?
Date: Mon, 22 Feb 2010 11:49:32 +0100
Message-ID: <201002221149.32504.trast@student.ethz.ch>
References: <2cfc40321002220209pe1942ecucb3716f60bf05d32@mail.gmail.com> <201002221126.47372.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 13:13:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVr9-0003PQ-LH
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab0BVKtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 05:49:35 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:7449 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab0BVKte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:49:34 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 11:49:34 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 11:49:32 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <201002221126.47372.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140671>

On Monday 22 February 2010 11:26:47 Thomas Rast wrote:
> On Monday 22 February 2010 11:09:18 Jon Seymour wrote:
> > For my funky "compensating rebases" I need to know where an automated
> > rebase has stopped. In particular, I need to know the sha1 of the
> > commit that caused the rebase to stop.
> > 
> > No doubt rebase is tracking this info, but is there a supported way to
> > discover it?
> 
> It's in .git/rebase-merge/done (and .git/rebase-merge/git-rebase-todo
> for the remaining TODO file).  Maybe we should add a 'git rebase
> --whydiditstop' command ;-)

Here's a lightly tested draft patch.  I should stop stealing work time
for this, but you're welcome to fill in docs and tests and submit it.

diff --git i/git-rebase--interactive.sh w/git-rebase--interactive.sh
index 415ae72..d34c057 100755
--- i/git-rebase--interactive.sh
+++ w/git-rebase--interactive.sh
@@ -13,7 +13,7 @@
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git-rebase [-i] [options] [--] <upstream> [<branch>]
-git-rebase [-i] (--continue | --abort | --skip)
+git-rebase [-i] (--continue | --abort | --skip | --status)
 --
  Available options are
 v,verbose          display a diffstat of what changed upstream
@@ -26,6 +26,7 @@ i,interactive      always used (no-op)
 continue           continue rebasing process
 abort              abort rebasing process and restore original branch
 skip               skip current patch and continue rebasing process
+status	           show where the rebasing process stopped
 no-verify          override pre-rebase hook from stopping the operation
 root               rebase all reachable commmits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -i
@@ -103,6 +104,10 @@ AMEND="$DOTEST"/amend
 REWRITTEN_LIST="$DOTEST"/rewritten-list
 REWRITTEN_PENDING="$DOTEST"/rewritten-pending
 
+# This file holds the status message that we showed to the user when
+# stopping, so that it can be retrieved by 'git rebase --status'.
+STATUS="$DOTEST"/status
+
 PRESERVE_MERGES=
 STRATEGY=
 ONTO=
@@ -204,11 +209,16 @@ make_patch () {
 		get_author_ident_from_commit "$1" > "$AUTHOR_SCRIPT"
 }
 
+status_message () {
+	cat >> "$STATUS"
+	"$1" "$(cat "$STATUS")"
+}
+
 die_with_patch () {
 	echo "$1" > "$DOTEST"/stopped-sha
 	make_patch "$1"
 	git rerere
-	die "$2"
+	status_message die "$2"
 }
 
 die_abort () {
@@ -429,8 +439,10 @@ die_failed_squash() {
 	mv "$SQUASH_MSG" "$MSG" || exit
 	rm -f "$FIXUP_MSG"
 	cp "$MSG" "$GIT_DIR"/MERGE_MSG || exit
-	warn
-	warn "Could not apply $1... $2"
+	status_message warn <<EOF
+
+Could not apply $1... $2
+EOF
 	die_with_patch $1 ""
 }
 
@@ -455,7 +467,7 @@ record_in_rewritten() {
 }
 
 do_next () {
-	rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" || exit
+	rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" "$STATUS" || exit
 	read command sha1 rest < "$TODO"
 	case "$command" in
 	'#'*|''|noop)
@@ -487,15 +499,17 @@ do_next () {
 		echo "$1" > "$DOTEST"/stopped-sha
 		make_patch $sha1
 		git rev-parse --verify HEAD > "$AMEND"
-		warn "Stopped at $sha1... $rest"
-		warn "You can amend the commit now, with"
-		warn
-		warn "	git commit --amend"
-		warn
-		warn "Once you are satisfied with your changes, run"
-		warn
-		warn "	git rebase --continue"
-		warn
+		status_message warn <<EOF
+Stopped at $sha1... $rest
+You can amend the commit now, with
+
+	git commit --amend
+
+Once you are satisfied with your changes, run
+
+	git rebase --continue
+
+EOF
 		exit 0
 		;;
 	squash|s|fixup|f)
@@ -767,6 +781,24 @@ first and then run 'git rebase --continue' again."
 
 		output git reset --hard && do_rest
 		;;
+	--status)
+		is_standalone "$@" || usage
+		warn "Your rebase stopped at the following action:"
+		warn
+		warn "    $(tail -1 "$DOTEST"/done)"
+		warn
+		next="$(sed -n -e "/^#/d" -e '/^$/d' -e "/ /p" -e "q" < "$TODO")"
+		if test -n "$next"; then
+			warn "The next action will be:"
+			warn
+			warn "    $next"
+		else
+			warn "There are no more actions left after this one."
+		fi
+		warn
+		cat "$STATUS" >&2
+		exit
+		;;
 	-s)
 		case "$#,$1" in
 		*,*=*)


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
