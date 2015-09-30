From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: accept indented comments (fixes regression)
Date: Wed, 30 Sep 2015 12:18:19 -0700
Message-ID: <xmqqy4fn7m2s.fsf@gitster.mtv.corp.google.com>
References: <1443600661-19391-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqd1wz9402.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 30 21:18:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhMtc-0003J6-E5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 21:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933102AbbI3TSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 15:18:25 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35841 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932460AbbI3TSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 15:18:21 -0400
Received: by pablk4 with SMTP id lk4so48370231pab.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=MD4o2tVcgWhD5euuQFcWIzUF57xabDsvQMcs/Db/FiE=;
        b=RQJz4pipoDiZ48tFUSHzfwGu8xAXX8SvMugYW1cEIh0YAGVS/I74KwvWe3iEEwAZjZ
         Yw44/QP5sSKHrfRM0VTeAKXb0SZ7GGl+WaSqCR1QnSgqthoKv3RxiLumAIi4yxr6X71y
         KlwVcYOerE73AdRzL/hvhCDJPpz41phFZ+MXYzFgnwfg8AfcH7gUu34/VYNOMG/bp7sK
         4M+0iAy1ibfwhYgpogHY0jGGnh4yoBzp9V8WGv4g9s6wrZNdcmyiRN147AX0PKb2pN9Y
         iV1KUgeug9ARbDYucLZtxEkNBlx4DavasZHZcPjPX/durBFwPCA1dxXnAczprP1xKZ4c
         tdKQ==
X-Received: by 10.68.92.1 with SMTP id ci1mr6679882pbb.155.1443640700988;
        Wed, 30 Sep 2015 12:18:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id g5sm2156464pat.21.2015.09.30.12.18.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 12:18:20 -0700 (PDT)
In-Reply-To: <xmqqd1wz9402.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 30 Sep 2015 11:05:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278857>

Junio C Hamano <gitster@pobox.com> writes:

> I am actually tempted to say that we should revert 804098b, which is
> the simplest fix.
>
> If we want "check everything before doing a single thing" mode, the
> right way to do it would be to base the check on the same loop as
> transform_todo_ids (one way to do so would be to give a third mode
> to that helper function, but I do not think we mind a small code
> duplication).
> ...

So here is a reroll, which is now minimally tested.

-- >8 --
Subject: [PATCH] rebase-i: loosen over-eager check_bad_cmd check

804098bb (git rebase -i: add static check for commands and SHA-1,
2015-06-29) tried to check all insns before running any in the todo
list, but it did so by implementing its own parser that is a lot
stricter than necessary.  We used to allow lines that are indented
(including comment lines), and we used to allow a whitespace between
the insn and the commit object name to be HT, among other things,
that are flagged as an invalid line by mistake.

Fix this by using the same tokenizer that is used to parse the todo
list file in the new check.  A new test is by Matthieu Moy.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh    | 62 ++++++++++++++++++++-----------------------
 t/t3404-rebase-interactive.sh | 10 +++++++
 2 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dcc3401..ae1806a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -849,7 +849,8 @@ add_exec_commands () {
 # Check if the SHA-1 passed as an argument is a
 # correct one, if not then print $2 in "$todo".badsha
 # $1: the SHA-1 to test
-# $2: the line to display if incorrect SHA-1
+# $2: the line number of the input
+# $3: the input filename
 check_commit_sha () {
 	badsha=0
 	if test -z $1
@@ -865,9 +866,10 @@ check_commit_sha () {
 
 	if test $badsha -ne 0
 	then
+		line="$(sed -n -e "${2}p" "$3")"
 		warn "Warning: the SHA-1 is missing or isn't" \
 			"a commit in the following line:"
-		warn " - $2"
+		warn " - $line"
 		warn
 	fi
 
@@ -878,37 +880,31 @@ check_commit_sha () {
 # from the todolist in stdin
 check_bad_cmd_and_sha () {
 	retval=0
-	git stripspace --strip-comments |
-	(
-		while read -r line
-		do
-			IFS=' '
-			set -- $line
-			command=$1
-			sha1=$2
-
-			case $command in
-			''|noop|x|"exec")
-				# Doesn't expect a SHA-1
-				;;
-			pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
-				if ! check_commit_sha $sha1 "$line"
-				then
-					retval=1
-				fi
-				;;
-			*)
-				warn "Warning: the command isn't recognized" \
-					"in the following line:"
-				warn " - $line"
-				warn
+	lineno=0
+	while read -r command rest
+	do
+		lineno=$(( $lineno + 1 ))
+		case $command in
+		"$comment_char"*|''|noop|x|exec)
+			# Doesn't expect a SHA-1
+			;;
+		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
+			if ! check_commit_sha "${rest%% *}" "$lineno" "$1"
+			then
 				retval=1
-				;;
-			esac
-		done
-
-		return $retval
-	)
+			fi
+			;;
+		*)
+			line="$(sed -n -e "${lineno}p" "$1")"
+			warn "Warning: the command isn't recognized" \
+				"in the following line:"
+			warn " - $line"
+			warn
+			retval=1
+			;;
+		esac
+	done <"$1"
+	return $retval
 }
 
 # Print the list of the SHA-1 of the commits
@@ -1002,7 +998,7 @@ check_todo_list () {
 		;;
 	esac
 
-	if ! check_bad_cmd_and_sha <"$todo"
+	if ! check_bad_cmd_and_sha "$todo"
 	then
 		raise_error=t
 	fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ebdab4b..2437a3c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1206,6 +1206,16 @@ test_expect_success 'static check of bad command' '
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'indented comments are accepted' '
+	rebase_setup_and_clean indented-comment &&
+	write_script add-indent.sh <<-\EOF &&
+	printf "\n \t # comment\n" >>$1
+	EOF
+	test_set_editor "$(pwd)/add-indent.sh" &&
+	git rebase -i HEAD^ &&
+	test E = $(git cat-file commit HEAD | sed -ne \$p)
+'
+
 cat >expect <<EOF
 Warning: the SHA-1 is missing or isn't a commit in the following line:
  - edit XXXXXXX False commit
-- 
2.6.0-273-g484a0d0
