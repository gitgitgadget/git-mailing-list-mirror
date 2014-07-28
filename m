From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 16/19] rebase -i: parse to-do list command line options
Date: Tue, 29 Jul 2014 01:18:16 +0200
Message-ID: <28c12d31fe8aa13d6aa8f76318637f3b644a5b74.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEM-0006Li-UI
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbaG1XVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:21:07 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:51768 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbaG1XVA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:21:00 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so8129168wes.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qVAdITvTg3vuQpPHYONx1XvPEV8UH2VP3EjhzmpBqbM=;
        b=eMNkvarCZH20fNvP4upyr0ZXC+oZf7xCBWDW7EL7sr89EQ4DNnjRZq02Nz5rlf6rzg
         CPnuH6ZzHNqgfJsmods8zmBKas/CZqT1wr1zZ+lGKoENgLz0FBvkS6v2z4fzBfRfGcc1
         AdfbVOmoEHKkbllzZ15lk4vHF0Fu6GzdR6+M4rTDZvM2hhuKzecSF0E8GRkI129kKIW0
         uMe6d3Op711JePvDZ6qix4KiSs0X47Im1jVB1lUhHqTBqq4G/iHexuOKXG3CBrUHQK2L
         KPZhQHvs7y+Nnx7VJIQV9Y4R6GA3hSNedxW2H+A7XmscGfLtFaYDzh0P3ln7CBGoiQfJ
         SH2A==
X-Received: by 10.180.24.66 with SMTP id s2mr34984397wif.33.1406589659770;
        Mon, 28 Jul 2014 16:20:59 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254377>

Read in to-do list lines as

    command args

instead of

    command sha1 rest

so that to-do list command lines can specify additional arguments
apart from the commit hash and the log message title, which become
the non-options in `args`. Loop over `args`, put all options (an
argument beginning with a dash) in `opts`, stop the loop on the first
non-option and assign it to `sha1`. The loop does not know the
options it parses so that options that take an argument themselves
are not supported at the moment. Neither are options that contain
spaces because the shell expansion of `args` in `do_next` interprets
white space characters as argument separator, that is a command line
like

    pick --author "A U Thor" fa1afe1 Some change

is parsed as the pick command

    pick --author

and the commit hash

    "A

which obviously results in an unknown revision error. For the sake of
completeness, in the example above the message title variable `rest`
is assigned the string 'U Thor" fa1afe1 Some change' (without the
single quotes).

Print an error message for unknown or unsupported command line
options, which means an error for all specified options at the
moment. Cleanly break the `do_next` loop by assigning the special
value 'unknown' to the local variable `command`, which triggers the
unknown command case in `do_cmd`.

The to-do list is also parsed when the commit hashes are translated
between long and short format before and after the to-do list is
edited. Apply the same procedure as in `do_cmd` with the exception
that we only care about where the options stop and the commit hash
begins. Do not reject any options when transforming the commit
hashes.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 49 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8dde8e6..ff4ba7f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -590,8 +590,26 @@ do_pick () {
 
 do_replay () {
 	command=$1
-	sha1=$2
-	rest=$3
+	shift
+
+	opts=
+	while test $# -gt 0
+	do
+		case "$1" in
+		-*)
+			warn "Unknown option: $1"
+			command=unknown
+			;;
+		*)
+			break
+			;;
+		esac
+		opts="$opts $(git rev-parse --sq-quote "$1")"
+		shift
+	done
+	sha1=$1
+	shift
+	rest=$*
 
 	case "$command" in
 	pick|p)
@@ -674,7 +692,7 @@ do_replay () {
 
 do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
-	read -r command sha1 rest <"$todo"
+	read -r command args <"$todo"
 
 	case "$command" in
 	"$comment_char"*|''|noop)
@@ -719,7 +737,7 @@ do_next () {
 		fi
 		;;
 	*)
-		do_replay $command $sha1 "$rest"
+		do_replay $command $args
 		;;
 	esac
 	test -s "$todo" && return
@@ -799,19 +817,34 @@ skip_unnecessary_picks () {
 }
 
 transform_todo_ids () {
-	while read -r command rest
+	while read -r command args
 	do
 		case "$command" in
 		"$comment_char"* | exec)
 			# Be careful for oddball commands like 'exec'
 			# that do not have a SHA-1 at the beginning of $rest.
+			newargs=\ $args
 			;;
 		*)
-			sha1=$(git rev-parse --verify --quiet "$@" ${rest%% *}) &&
-			rest="$sha1 ${rest#* }"
+			newargs=
+			sha1=
+			for arg in $args
+			do
+				case "$arg" in
+				-*)
+					newargs="$newargs $arg"
+					;;
+				*)
+					test -z "$sha1" &&
+						sha1=$(git rev-parse --verify --quiet "$@" $arg) &&
+						arg=$sha1
+					newargs="$newargs $arg"
+					;;
+				esac
+			done
 			;;
 		esac
-		printf '%s\n' "$command${rest:+ }$rest"
+		printf '%s\n' "$command$newargs"
 	done <"$todo" >"$todo.new" &&
 	mv -f "$todo.new" "$todo"
 }
-- 
2.0.1
