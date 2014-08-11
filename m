From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v2 20/23] rebase -i: parse to-do list command line options
Date: Mon, 11 Aug 2014 22:56:29 +0200
Message-ID: <53E92DFD.2050601@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1407368621.git.bafain@gmail.com>	<8d01ff53a49647906c9008620435a62f08a1f76f.1407368621.git.bafain@gmail.com> <87vbq2ajcc.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:56:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGwdz-00057s-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 22:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbaHKU4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 16:56:34 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:40280 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbaHKU4d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 16:56:33 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so9165704wes.15
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 13:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DaYS58FnJs3JsAOZKwA2TXcZeERag4nEv+CkYzpXdNI=;
        b=nrHhyCzNnlmyZ7eEjUGsICG8DqEKAQmeBh1sKiyJctNnJxZH7IInn1g+ejng0y2SMz
         KpSQzLuCLqKD/6qvjtltPLko7wxrv+FbMAUtPul+XpctqfEYrq6o56HEln16skP41bga
         WGUUVcLxEi1Ky9hADGJoYSrse9M1U8hSWio48ZLIq14xm4GORuinjB4vBlvCHHG//n6B
         c1IL6folDLJcCG6LpUDn8FcxNBKKWnyCLUJbKAPRuVRs8TLS6bgi1TY1Aq00wVISRsZ5
         Q1DABQOP0GA3s/j3ZfUkBpoymOpnHmux2UMCPya6D4rTmOXCx7VxxZJZtOtSThrO4xfH
         Xezg==
X-Received: by 10.194.187.4 with SMTP id fo4mr266602wjc.35.1407790592175;
        Mon, 11 Aug 2014 13:56:32 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id u10sm47933580wix.14.2014.08.11.13.56.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 13:56:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <87vbq2ajcc.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255139>

Hi Thomas,

an updated patch is attached below.

Thomas Rast writes:> Fabian Ruch <bafain@gmail.com> writes:
> [...]
>> are not supported at the moment. Neither are options that contain
>> spaces because the shell expansion of `args` in `do_next` interprets
>> white space characters as argument separator, that is a command line
>> like
>>
>>     pick --author "A U Thor" fa1afe1 Some change
>>
>> is parsed as the pick command
>>
>>     pick --author
>>
>> and the commit hash
>>
>>     "A
>>
>> which obviously results in an unknown revision error. For the sake of
>> completeness, in the example above the message title variable `rest`
>> is assigned the string 'U Thor" fa1afe1 Some change' (without the
>> single quotes).
> 
> You could probably trim down the non-example a bit and instead give an
> example :-)

Done. The example "reword --signoff" is substituted for the
non-example and used for an error message example as well. I hope
that is not confusing.

>> Print an error message for unknown or unsupported command line
>> options, which means an error for all specified options at the
>> moment.
> 
> Can you add a test that verifies we catch an obvious unknown option
> (such as --unknown-option)?

Done. The test checks that git-rebase--interactive fails to execute
'pick --unknown-option' and that the rebase can be resumed after
removing the --unknown-option part.

>> Cleanly break the `do_next` loop by assigning the special
>> value 'unknown' to the local variable `command`, which triggers the
>> unknown command case in `do_cmd`.
> [...]
>>  do_replay () {
>>  	command=$1
>> -	sha1=$2
>> -	rest=$3
>> +	shift
>> +
>> +	opts=
>> +	while test $# -gt 0
>> +	do
>> +		case "$1" in
>> +		-*)
>> +			warn "Unknown option: $1"
>> +			command=unknown
>> +			;;
>> +		*)
>> +			break
>> +			;;
> 
> This seems a rather hacky solution to me.  Doesn't this now print
> 
>   warning: Unknown option: --unknown-option
>   warning: Unknown command: pick --unknown-option
> 
> ?
> 
> It shouldn't claim the command is unknown if the command itself was
> valid.

OK. "do_replay" now first checks for unknown commands and exits
immediately if that is the case, ignoring any options specified.

> Also, you speak of do_cmd above, but the unknown command handling seems
> to be part of do_replay?

Fixed.

   Fabian

-- >8 --
Subject: rebase -i: parse to-do list command line options

Read in to-do list lines as

    command args

instead of

    command sha1 rest

so that to-do list command lines can specify additional arguments
apart from the commit hash and the log message title, which become
the non-options in `args`. Loop over `args`, put all options (an
argument beginning with a dash) in `opts`, stop the loop on the first
non-option and assign it to `sha1`. For instance, the to-do list

    reword --signoff fa1afe1 Some change

is parsed as `command=reword`, `opts= '--signoff'` (including the
single quotes and the space for evaluation and concatenation of
options), `sha1=fa1afel` and `rest=Some change`. The loop does not
know the options it parses so that options that take an argument
themselves are not supported at the moment. Neither are options that
contain spaces because the shell expansion of `args` in `do_next`
interprets white space characters as argument separator.

Print an error message for unknown or unsupported command line
options, which means an error for all specified options at the
moment. Cleanly break the `do_next` loop by assigning a reason to the
local variable `malformed`, which triggers the unknown command code
in `do_replay`. Move the error code to the beginning of `do_replay`
so that unknown commands are reported before bad options are as only
the first error we come across is reported. For instance, the to-do
list from above produces the error

    Unknown 'reword' option: --signoff
    Please fix this using 'git rebase --edit-todo'.

The to-do list is also parsed when the commit hashes are translated
between long and short format before and after the to-do list is
edited. Apply the same procedure as in `do_replay` with the exception
that we only care about where the options stop and the commit hash
begins. Do not reject any options when transforming the commit
hashes.

Enable the specification of to-do list command line options in
`FAKE_LINES` the same way this is accomplished for command lines
passed to `exec`. Define a new `fake_editor.sh` that edits a static
to-do list instead of the one passed as argument when invoked by
git-rebase. Add a test case that checks that unknown options are
refused and can be corrected using `--edit-todo`.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh     | 80 ++++++++++++++++++++++++++++++++----------
 t/lib-rebase.sh                | 20 +++++++++--
 t/t3427-rebase-line-options.sh | 26 ++++++++++++++
 3 files changed, 105 insertions(+), 21 deletions(-)
 create mode 100755 t/t3427-rebase-line-options.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 344d2cc..20636da 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -576,9 +576,47 @@ do_pick () {
 }
 
 do_replay () {
+	malformed=
 	command=$1
-	sha1=$2
-	rest=$3
+	shift
+	case "$command" in
+	pick|reword|edit|squash|fixup)
+		;;
+	*)
+		read -r command <"$todo"
+		malformed="Unknown command: $command"
+		;;
+	esac
+
+	opts=
+	while test $# -gt 0 && test -z "$malformed"
+	do
+		case "$1" in
+		-*)
+			malformed="Unknown '$command' option: $1"
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
+
+	if test -n "$malformed"
+	then
+		warn "$malformed"
+		fixtodo="Please fix this using 'git rebase --edit-todo'."
+		if git rev-parse --verify -q "$sha1" >/dev/null
+		then
+			die_with_patch $sha1 "$fixtodo"
+		else
+			die "$fixtodo"
+		fi
+	fi
 
 	case "$command" in
 	pick|p)
@@ -659,23 +697,12 @@ do_replay () {
 		esac
 		record_in_rewritten $sha1
 		;;
-	*)
-		read -r command <"$todo"
-		warn "Unknown command: $command"
-		fixtodo="Please fix this using 'git rebase --edit-todo'."
-		if git rev-parse --verify -q "$sha1" >/dev/null
-		then
-			die_with_patch $sha1 "$fixtodo"
-		else
-			die "$fixtodo"
-		fi
-		;;
 	esac
 }
 
 do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
-	read -r command sha1 rest <"$todo"
+	read -r command args <"$todo"
 
 	case "$command" in
 	"$comment_char"*|''|noop)
@@ -720,7 +747,7 @@ do_next () {
 		fi
 		;;
 	*)
-		do_replay $command $sha1 "$rest"
+		do_replay $command $args
 		;;
 	esac
 	test -s "$todo" && return
@@ -800,19 +827,34 @@ skip_unnecessary_picks () {
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
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 0cd1193..104f5bd 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -46,8 +46,8 @@ set_fake_editor () {
 	action=pick
 	for line in $FAKE_LINES; do
 		case $line in
-		squash|fixup|edit|reword)
-			action="$line";;
+		pick*|squash*|fixup*|edit*|reword*)
+			action=$(echo "$line" | sed 's/_/ /g');;
 		exec*)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
 		"#")
@@ -80,6 +80,22 @@ set_cat_todo_editor () {
 	test_set_editor "$(pwd)/fake-editor.sh"
 }
 
+# set_fixed_todo_editor takes a file path as argument and installs an
+# editor script that, firstly, overwrites the file path argument with
+# the one specified during installation and, secondly, calls
+# fake-editor.sh for changing the contents as usual. This comes in
+# handy if it is easier to change some fixed file instead of the one
+# that will be passed when the editor is being invoked.
+
+set_fixed_todo_editor () {
+	set_fake_editor
+	write_script fake-editor-wrapper.sh <<-EOF
+	cp "$1" "\$1"
+	"$(pwd)"/fake-editor.sh "\$1"
+	EOF
+	test_set_editor "$(pwd)/fake-editor-wrapper.sh"
+}
+
 # checks that the revisions in "$2" represent a linear range with the
 # subjects in "$1"
 test_linear_range () {
diff --git a/t/t3427-rebase-line-options.sh b/t/t3427-rebase-line-options.sh
new file mode 100755
index 0000000..5881162
--- /dev/null
+++ b/t/t3427-rebase-line-options.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='git rebase -i with line options'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'Set up repository' '
+	test_commit Initial &&
+	test_commit Commit1 &&
+	test_commit Commit2
+'
+
+test_expect_success 'Unknown option' '
+	git checkout -b unknown-option master &&
+	set_cat_todo_editor &&
+	test_must_fail git rebase -i HEAD^ >todo &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 pick_--unknown-option 2" git rebase -i HEAD~2 &&
+	set_fixed_todo_editor "$(pwd)"/todo &&
+	git rebase --edit-todo &&
+	git rebase --continue
+'
+
+test_done
-- 
2.0.1
