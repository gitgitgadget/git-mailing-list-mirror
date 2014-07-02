From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 16/19] rebase -i: Parse to-do list command line options
Date: Wed,  2 Jul 2014 19:48:08 +0200
Message-ID: <e6e472630dd3dd08316ab0b07eb488da437c6c7c.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OgJ-0007RX-1N
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbaGBRuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:50 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:39646 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbaGBRuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:50:07 -0400
Received: by mail-we0-f174.google.com with SMTP id u57so11426136wes.5
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q0mlEtqqrySLr++UqXCOolRLExHn3UDGxA6bYIq8qJQ=;
        b=GEeUFWBNbzotSToUs8mkd9itU1IQ8J138KzUH0yxJ/go1m3WTJ5An80UCYsBvOBb46
         E80YYw5SxLxyfqUGkbsHZHD24ZzTySgglRaCHdn/a7S/9vZYIEFmvXe6O4jOw09Hw46s
         b/EgXzJwvIN6QOn8CBOVHQWOlOwPjqPTz4KaT2BdwrGS0WsCZSmVjIq8yWuO6kAiii9g
         SvkLlSbztvnui5O/Dw6fkkRw/Jb6TngUZ2jFzEmuTnqKO+3+Uo7iOGGMgq1biWOLkgQq
         dwPJBKdcUgiivLyJK9wxCEaRdh9VJkosGp7MSZJD6QJZJAr09QZPDbPD3fV2pJpIGisw
         X2iw==
X-Received: by 10.194.7.36 with SMTP id g4mr61305293wja.37.1404323406488;
        Wed, 02 Jul 2014 10:50:06 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.50.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:50:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252819>

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
index 9de7441..2119d00 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -587,8 +587,26 @@ do_pick () {
 
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
@@ -671,7 +689,7 @@ do_replay () {
 
 do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
-	read -r command sha1 rest <"$todo"
+	read -r command args <"$todo"
 
 	case "$command" in
 	"$comment_char"*|''|noop)
@@ -716,7 +734,7 @@ do_next () {
 		fi
 		;;
 	*)
-		do_replay $command $sha1 "$rest"
+		do_replay $command $args
 		;;
 	esac
 	test -s "$todo" && return
@@ -796,19 +814,34 @@ skip_unnecessary_picks () {
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
2.0.0
