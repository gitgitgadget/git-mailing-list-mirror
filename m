From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/4] rebase -i: add ack action
Date: Sun, 10 Apr 2016 16:54:45 +0300
Message-ID: <1460296343-17304-2-git-send-email-mst@redhat.com>
References: <1460296343-17304-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bafain@gmail.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:54:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFpE-00054Y-Mm
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbcDJNyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58840 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbcDJNys (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:54:48 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A7DD3E3;
	Sun, 10 Apr 2016 13:54:47 +0000 (UTC)
Received: from redhat.com (vpn1-4-6.ams2.redhat.com [10.36.4.6])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3ADsjwr024714;
	Sun, 10 Apr 2016 09:54:46 -0400
Content-Disposition: inline
In-Reply-To: <1460296343-17304-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291171>

This implements a new ack! action for git rebase -i
It is essentially a middle ground between fixup! and squash!:
- commits are squashed silently without editor being started
- commit logs are concatenated (with action line being discarded)
- because of the above, empty commits aren't discarded,
  their log is also included.

I am using it as follows:
	git am -s < mailbox #creates first commit
	hack ...
	get mail with Ack
	git commit --allow-empty -m `cat <<-EOF
	ack! first

	Acked-by: maintainer
	EOF`
	repeat cycle
	git rebase --autosquash -i origin/master
	before public branch push

The "cat" command above is actually a script that
parses the Ack mail to create the empty commit -
to be submitted separately.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-rebase--interactive.sh | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4cde685..6a766ca 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -150,6 +150,7 @@ Commands:
  r, reword = use commit, but edit the commit message
  e, edit = use commit, but stop for amending
  s, squash = use commit, but meld into previous commit
+ a, ack = like "squash", but append commit body only to previous commit
  f, fixup = like "squash", but discard this commit's log message
  x, exec = run command (the rest of the line) using shell
  d, drop = remove commit
@@ -438,6 +439,15 @@ update_squash_messages () {
 		echo
 		commit_message $2
 		;;
+	ack)
+		if test -f "$fixup_msg"
+		then
+			commit_message $2 | git stripspace --strip-comments | sed -e '1,2d' >> "$fixup_msg"
+		fi
+		printf '%s\n' "$comment_char This is the $(nth_string $count) commit message:"
+		echo
+		commit_message $2
+		;;
 	fixup)
 		echo
 		printf '%s\n' "$comment_char The $(nth_string $count) commit message will be skipped:"
@@ -479,7 +489,7 @@ record_in_rewritten() {
 	echo "$oldsha1" >> "$rewritten_pending"
 
 	case "$(peek_next_command)" in
-	squash|s|fixup|f)
+	squash|s|fixup|f|ack|a)
 		;;
 	*)
 		flush_rewritten_pending
@@ -551,8 +561,11 @@ do_next () {
 		warn "Stopped at $sha1... $rest"
 		exit_with_patch $sha1 0
 		;;
-	squash|s|fixup|f)
+	squash|s|fixup|f|ack|a)
 		case "$command" in
+		ack|a)
+			squash_style=ack
+			;;
 		squash|s)
 			squash_style=squash
 			;;
@@ -576,7 +589,7 @@ do_next () {
 			die_failed_squash $sha1 "$rest"
 		fi
 		case "$(peek_next_command)" in
-		squash|s|fixup|f)
+		squash|s|fixup|f|ack|a)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
 			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
@@ -587,7 +600,7 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
+				do_with_author git commit --quiet --amend --no-verify -F "$fixup_msg" \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			else
@@ -717,7 +730,7 @@ skip_unnecessary_picks () {
 	done <"$todo" >"$todo.new" 3>>"$done" &&
 	mv -f "$todo".new "$todo" &&
 	case "$(peek_next_command)" in
-	squash|s|fixup|f)
+	squash|s|fixup|f|ack|a)
 		record_in_rewritten "$onto"
 		;;
 	esac ||
@@ -764,7 +777,7 @@ rearrange_squash () {
 	do
 		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
 		case "$message" in
-		"squash! "*|"fixup! "*)
+		"squash! "*|"fixup! "*|"ack! "*)
 			action="${message%%!*}"
 			rest=$message
 			prefix=
@@ -772,7 +785,7 @@ rearrange_squash () {
 			while :
 			do
 				case "$rest" in
-				"squash! "*|"fixup! "*)
+				"squash! "*|"fixup! "* |"ack! "*)
 					prefix="$prefix${rest%%!*},"
 					rest="${rest#*! }"
 					;;
@@ -904,7 +917,7 @@ check_bad_cmd_and_sha () {
 			# Work around CR left by "read" (e.g. with Git for
 			# Windows' Bash).
 			;;
-		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
+		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f|ack|a)
 			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"
 			then
 				retval=1
@@ -1196,6 +1209,13 @@ do
 		comment_out=
 	fi
 
+	# keep empty ack! commits around: useful to add text to commit log
+	case "$rest" in
+	"ack! "*)
+		comment_out=
+		;;
+	esac
+
 	if test t != "$preserve_merges"
 	then
 		printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
-- 
MST
