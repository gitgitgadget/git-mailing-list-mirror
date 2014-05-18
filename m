From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/4] rebase -i: add ack action
Date: Mon, 19 May 2014 00:17:47 +0300
Message-ID: <1400447743-18513-2-git-send-email-mst@redhat.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 23:19:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm8U1-00060j-Li
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 23:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbaERVSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 17:18:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28002 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbaERVSx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 17:18:53 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4ILIrVX017200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:18:53 -0400
Received: from redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s4ILIpBC022804
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:18:52 -0400
Content-Disposition: inline
In-Reply-To: <1400447743-18513-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249510>

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
 git-rebase--interactive.sh | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6ec9d3c..821872c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -140,6 +140,7 @@ Commands:
  r, reword = use commit, but edit the commit message
  e, edit = use commit, but stop for amending
  s, squash = use commit, but meld into previous commit
+ a, ack = like "squash", but append commit body only to previous commit
  f, fixup = like "squash", but discard this commit's log message
  x, exec = run command (the rest of the line) using shell
 
@@ -412,6 +413,15 @@ update_squash_messages () {
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
@@ -453,7 +463,7 @@ record_in_rewritten() {
 	echo "$oldsha1" >> "$rewritten_pending"
 
 	case "$(peek_next_command)" in
-	squash|s|fixup|f)
+	squash|s|fixup|f|ack|a)
 		;;
 	*)
 		flush_rewritten_pending
@@ -521,8 +531,11 @@ do_next () {
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
@@ -546,7 +559,7 @@ do_next () {
 			die_failed_squash $sha1 "$rest"
 		fi
 		case "$(peek_next_command)" in
-		squash|s|fixup|f)
+		squash|s|fixup|f|ack|a)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
 			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
@@ -557,7 +570,7 @@ do_next () {
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
+				do_with_author git commit --quiet --amend --no-verify -F "$fixup_msg" \
 					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			else
@@ -690,7 +703,7 @@ skip_unnecessary_picks () {
 	done <"$todo" >"$todo.new" 3>>"$done" &&
 	mv -f "$todo".new "$todo" &&
 	case "$(peek_next_command)" in
-	squash|s|fixup|f)
+	squash|s|fixup|f|ack|a)
 		record_in_rewritten "$onto"
 		;;
 	esac ||
@@ -732,7 +745,7 @@ rearrange_squash () {
 	while read -r pick sha1 message
 	do
 		case "$message" in
-		"squash! "*|"fixup! "*)
+		"squash! "*|"fixup! "*|"ack! "*)
 			action="${message%%!*}"
 			rest=$message
 			prefix=
@@ -740,7 +753,7 @@ rearrange_squash () {
 			while :
 			do
 				case "$rest" in
-				"squash! "*|"fixup! "*)
+				"squash! "*|"fixup! "* |"ack! "*)
 					prefix="$prefix${rest%%!*},"
 					rest="${rest#*! }"
 					;;
@@ -975,6 +988,13 @@ do
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
 		printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
-- 
MST
