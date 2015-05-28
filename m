From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] t750*: make tests for commit messages more pedantic
Date: Thu, 28 May 2015 09:34:14 -0400
Message-ID: <CAPig+cRHB3Qzm-e1_KROu2RQoW2rftLH=uKrWQBsnW0EYkcLPw@mail.gmail.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
	<1432620908-16071-2-git-send-email-patryk.obara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Patryk Obara <patryk.obara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 15:34:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxxx3-0006Wr-T8
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 15:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbbE1NeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 09:34:16 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35100 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbE1NeP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 09:34:15 -0400
Received: by igbyr2 with SMTP id yr2so112122054igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rXsRv7rGNmUWGX+FSxdeSWyBfOYO6l1DaQu5gmEo9CA=;
        b=eSlv9eITYTiAU6006JEj+hNptbf0G87UuKwHoqf9aYWeGNVAzHn/9kDjaFiMtDqrns
         up+vZ2Nv+zb77/TYT5OoGHW5Jd14LiAa4M8ahJliHlr6AY9xOwWoq+6rjeLmV+FKk0wR
         FsR5ozkYHacKfdBnDnYa92XJnVSxUTKvTDcpMe/Oofe3fm4vapJaTrmB4Ezo1thyMb9R
         667OPk1Gq330ncfU9ro1l6L6A5KbL238DYt6eae5yO+QJhvyP8+2CEiso7CE9Iix0Aie
         VxNyZc0ksl5V5IpfWunuujtZQ3gxoeaLGtsHyGZatAeRP3ecz1YIoO+LaQNYOCIbq0OO
         QcAw==
X-Received: by 10.107.151.75 with SMTP id z72mr3444182iod.46.1432820054614;
 Thu, 28 May 2015 06:34:14 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 28 May 2015 06:34:14 -0700 (PDT)
In-Reply-To: <1432620908-16071-2-git-send-email-patryk.obara@gmail.com>
X-Google-Sender-Auth: 0mpfXnVp3Sx1bySjn-vT4iuN-mQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270149>

On Tue, May 26, 2015 at 2:15 AM, Patryk Obara <patryk.obara@gmail.com> wrote:
> Currently messages are compared with --pretty=format:%s%b which does
> not retain raw format of commit message. In result it's not clear what
> part of expected commit msg is subject and what part is body. Also, it's
> impossible to test if messages with multiple lines are handled
> correctly, which may be significant when using nondefault --cleanup.

Makes sense.

> Change "commit_msg_is" function to use raw message format in log and
> interpret escaped sequences in expected message. This way it's possible
> to test exactly what commit message text was saved.

These changes would be less daunting to review if split into multiple
patches; one per logical change. So, for instance, patch 1 would make
this change and adjust tests accordingly.

> Add test to verify, that no additional content is appended to template
> message, which uncovers tiny "bug" in --status handling - new line is
> always appended before status message. If template file ended with
> newline (which is default for many popular text editors, e.g. vim)
> then blank line appears before status (which is very annoying when
> template ends with line starting with '#'). On the other hand, this
> newline needs to be appended if template file didn't end with newline
> (which is default for e.g. emacs) - otherwise first line of status
> message may be not cleaned up.

This could be patch 2.

> Add explicit test to verify if \n is kept unexpanded in commit message -
> this used to be part of unrelated template test.

And patch 3, and so on...

> Modify add-content-and-comment fake editor to include both comments and
> whitespace, so --cleanup=whitespace is now actually tested.
>
> Modify expected value of test "cleanup commit messages" (t7502), which
> shouldn't be passing, because template and logfiles are unnecessarily
> stripped before placing them into editor.

Your cover letter correctly states that with this patch is applied, a
number of tests fail. Tests which are expected to fail should be
declared test_expect_failure rather than test_expect_success. The
patch which fixes the failures should flip them to
test_expect_success.

> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>

More below...

> ---
> diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
> index 116885a..fd1bf71 100755
> --- a/t/t7500-commit.sh
> +++ b/t/t7500-commit.sh
> @@ -13,8 +13,8 @@ commit_msg_is () {
>         expect=commit_msg_is.expect
>         actual=commit_msg_is.actual
>
> -       printf "%s" "$(git log --pretty=format:%s%b -1)" >"$actual" &&
> -       printf "%s" "$1" >"$expect" &&
> +       git log --pretty=format:%B -1 >"$actual" &&
> +       printf "%b" "$1" >"$expect" &&
>         test_i18ncmp "$expect" "$actual"
>  }
>
> @@ -329,4 +329,47 @@ test_expect_success 'invalid message options when using --fixup' '
>         test_must_fail git commit --fixup HEAD~1 -F log
>  '
>
> +test_expect_success 'no blank lines appended after template with --status' '
> +       echo "template line" > "$TEMPLATE" &&

Style: Modern code omits the space after the redirection operator
(>"$TEMPLATE"), however, it's also important to match existing style.
Unfortunately, this file has an equal mixture of both '>blap' and '>
blap', so it's difficult to know which style to match. As this is new
code, it'd probably be best to omit the space.

> +       echo changes >>foo &&
> +       git add foo &&
> +       test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
> +       git commit -e -t "$TEMPLATE" --status &&
> +       commit_msg_is "template line\ncommit message\n"
> +'
> +
> +test_expect_success 'template without newline before eof should work with --status' '

It's not clear what "should work" means. I suppose you mean that the
end result should have exactly one newline after the template. Perhaps
the test title could indicate the intent more clearly.

> +       printf "%s" "template line" > "$TEMPLATE" &&
> +       echo changes >>foo &&
> +       git add foo &&
> +       test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
> +       git commit -e -t "$TEMPLATE" --status &&
> +       commit_msg_is "template line\ncommit message\n"
> +'
> +
> +test_expect_success 'logfile without newline before eof should work with --status' '

Ditto: Unclear "should work"

> +       printf "%s" "log line" >log-file &&
> +       echo changes >>foo &&
> +       git add foo &&
> +       test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
> +       git commit -e -F log-file --status &&
> +       commit_msg_is "log line\ncommit message\n"
> +'
>  test_done
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index 051489e..d2203ed 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -8,11 +8,12 @@ commit_msg_is () {
>         expect=commit_msg_is.expect
>         actual=commit_msg_is.actual
>
> -       printf "%s" "$(git log --pretty=format:%s%b -1)" >$actual &&
> -       printf "%s" "$1" >$expect &&
> -       test_i18ncmp $expect $actual
> +       git log --pretty=format:%B -1 >"$actual" &&
> +       printf "%b" "$1" >"$expect" &&
> +       test_i18ncmp "$expect" "$actual"
>  }
>
> +

Sneaking in unnecessary whitespace change.

>  # Arguments: [<prefix] [<commit message>] [<commit options>]
>  check_summary_oneline() {
>         test_tick &&
