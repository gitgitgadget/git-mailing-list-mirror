From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 20/23] rebase -i: parse to-do list command line options
Date: Thu,  7 Aug 2014 01:59:27 +0200
Message-ID: <8d01ff53a49647906c9008620435a62f08a1f76f.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB90-0004eT-3P
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbaHGABA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:01:00 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:39343 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbaHGAA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:58 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so3310488qap.9
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OoeKRxWnpc7fvvchrmjVJhImPcmPJFN3gBjN4nrc6xM=;
        b=sVJXxkXzNSQMUnSc/5+OQs6nOtmF0Xg1XJJLECr2+mlBLNiugjhxHQF+U3Raoa8HmU
         qsX1pOPwoqFZbU7koX871s7jniRO78+3DTerB8iPsoxoTr1x5mhBn/JEj3kYaSPnQthX
         rv3amPO0r/N8AP3/PaqI2jVbIHwWn/cn6qK9E3ABaj/oVIr0AUrbh7U0ixXZr70rBTem
         swdmnjAnJ+QN36WjLcl7mXZFa7M+ooBQWKaD+UzZ79auSilDe1VGHOQQMamvgGI2feBR
         i5q4M6OxLYS2/hkVwPtNZpEMFVRvDPne7mcw1ECRIlbq9188Zh6rgo3F6po/JN+E+C06
         Ia3g==
X-Received: by 10.229.212.138 with SMTP id gs10mr21584994qcb.7.1407369657922;
        Wed, 06 Aug 2014 17:00:57 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254936>

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
index 6ecd4d7..da435cb 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -577,8 +577,26 @@ do_pick () {
 
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
@@ -675,7 +693,7 @@ do_replay () {
 
 do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
-	read -r command sha1 rest <"$todo"
+	read -r command args <"$todo"
 
 	case "$command" in
 	"$comment_char"*|''|noop)
@@ -720,7 +738,7 @@ do_next () {
 		fi
 		;;
 	*)
-		do_replay $command $sha1 "$rest"
+		do_replay $command $args
 		;;
 	esac
 	test -s "$todo" && return
@@ -800,19 +818,34 @@ skip_unnecessary_picks () {
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
