From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] status: show commit sha1 in "You are currently
 cherry-picking" message
Date: Fri, 11 Oct 2013 20:14:49 +0200
Message-ID: <CAN0XMOKXYBnuEceAwzzmi0PUy6BgWLOxsBjLoEzHpNynR5+b_A@mail.gmail.com>
References: <1381507117-11519-1-git-send-email-ralf.thielow@gmail.com>
	<20131011174210.GS9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu.Moy@imag.fr,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 20:14:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUhEm-0006TT-JO
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 20:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab3JKSOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 14:14:51 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:61408 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab3JKSOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 14:14:50 -0400
Received: by mail-wg0-f42.google.com with SMTP id m15so1294129wgh.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=icJzj3Qxct8g5kzjEw6573qAybmmKQszoh+BQoFZusY=;
        b=MMwRW5UhuY5Z26ejNN1tXfIWmX7eevCMRF+9VJeryvOF6tVHjj7YbXiQmUk/2GMBmg
         2xADMYH9EICkQLEO/6JGmr//HT2r4AW3PG4GdjlhSxCZvBrCCtC10OL+tF8pqCwPwjL6
         7wgTg+FvjmQFuQynbbqAQGIwjmbsB/Od73blW5CGq8ByqPlMTevuIC/7E4Cma8Ia1ByK
         A/p8dbczia8gKj9r5y7d0oty6/iE494O8erCibd443Xk7MLE8KHpqChIF2GkQf/AgYKt
         ZnQOREEjgpHD1umb9djydtJxIQqCjvU51Cw5ZPCspV1EAyS7ZHxk11JyZDTFtIuW06Ay
         g42A==
X-Received: by 10.180.187.2 with SMTP id fo2mr4182101wic.65.1381515289353;
 Fri, 11 Oct 2013 11:14:49 -0700 (PDT)
Received: by 10.194.165.163 with HTTP; Fri, 11 Oct 2013 11:14:49 -0700 (PDT)
In-Reply-To: <20131011174210.GS9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235916>

On Fri, Oct 11, 2013 at 7:42 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ralf Thielow wrote:
>
>> Especially helpful when cherry-picking multiple commits.
>
> Neat, thanks.
>
> [...]
>> --- a/t/t7512-status-help.sh
>> +++ b/t/t7512-status-help.sh
>> @@ -626,9 +626,10 @@ test_expect_success 'prepare for cherry-pick conflicts' '
>>  test_expect_success 'status when cherry-picking before resolving conflicts' '
>>       test_when_finished "git cherry-pick --abort" &&
>>       test_must_fail git cherry-pick cherry_branch_second &&
>> +     TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
>> -     cat >expected <<\EOF &&
>> +     cat >expected <<EOF
>
> Did you mean to drop the '&&'?
>

No. The important thing was actually the "\" character. Sry

> [...]
>> @@ -648,11 +649,12 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
>>       git reset --hard cherry_branch &&
>>       test_when_finished "git cherry-pick --abort" &&
>>       test_must_fail git cherry-pick cherry_branch_second &&
>> +     TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
>>       echo end >main.txt &&
>>       git add main.txt &&
>> -     cat >expected <<\EOF &&
>> +     cat >expected <<EOF
>
> Likewise.
>
> [...]
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -996,7 +996,8 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
>>                                       struct wt_status_state *state,
>>                                       const char *color)
>>  {
>> -     status_printf_ln(s, color, _("You are currently cherry-picking."));
>> +     status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
>> +                     find_unique_abbrev(state->cherry_pick_head_sha1, DEFAULT_ABBREV));
>
> This function is only called when ->cherry_pick_in_progress is true, so
> we know cherry_pick_head_sha1 is initialized.  Good.
>
> I would be tempted to check anyway, so that if we ever regress in this,
> the cause will be clear and users know to report a bug:
>
>         if (is_null_sha1(state->cherry_pick_head_sha1))
>                 die("BUG: cherry-pick in progress but no valid CHERRY_PICK_HEAD?");
>         status_printf_ln(s, color, _("You are ...
>
> I dunno.
>
> Applied with the && fixes mentioned above on top of the following.
>

Thanks

> -- >8 --
> Subject: status test: add missing && to <<EOF blocks
>
> When a test forgets to include && after each command, it is possible
> for an early command to succeed but the test to fail, which can hide
> bugs.
>
> Checked using the following patch to the test harness:
>
>         --- a/t/test-lib.sh
>         +++ b/t/test-lib.sh
>         @@ -425,7 +425,17 @@ test_eval_ () {
>                 eval </dev/null >&3 2>&4 "$*"
>          }
>
>         +check_command_chaining_ () {
>         +       eval >&3 2>&4 "(exit 189) && $*"
>         +       eval_chain_ret=$?
>         +       if test "$eval_chain_ret" != 189
>         +       then
>         +               error 'bug in test script: missing "&&" in test commands'
>         +       fi
>         +}
>         +
>          test_run_ () {
>         +       check_command_chaining_ "$1"
>                 test_cleanup=:
>                 expecting_failure=$2
>                 setup_malloc_check
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  t/t7512-status-help.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 0688d58..9905d43 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -669,7 +669,7 @@ EOF
>  test_expect_success 'status showing detached at and from a tag' '
>         test_commit atag tagging &&
>         git checkout atag &&
> -       cat >expected <<\EOF
> +       cat >expected <<\EOF &&
>  HEAD detached at atag
>  nothing to commit (use -u to show untracked files)
>  EOF
> @@ -677,7 +677,7 @@ EOF
>         test_i18ncmp expected actual &&
>
>         git reset --hard HEAD^ &&
> -       cat >expected <<\EOF
> +       cat >expected <<\EOF &&
>  HEAD detached from atag
>  nothing to commit (use -u to show untracked files)
>  EOF
> @@ -695,7 +695,7 @@ test_expect_success 'status while reverting commit (conflicts)' '
>         test_commit new to-revert.txt &&
>         TO_REVERT=$(git rev-parse --short HEAD^) &&
>         test_must_fail git revert $TO_REVERT &&
> -       cat >expected <<EOF
> +       cat >expected <<EOF &&
>  On branch master
>  You are currently reverting commit $TO_REVERT.
>    (fix conflicts and run "git revert --continue")
> @@ -716,7 +716,7 @@ EOF
>  test_expect_success 'status while reverting commit (conflicts resolved)' '
>         echo reverted >to-revert.txt &&
>         git add to-revert.txt &&
> -       cat >expected <<EOF
> +       cat >expected <<EOF &&
>  On branch master
>  You are currently reverting commit $TO_REVERT.
>    (all conflicts fixed: run "git revert --continue")
> @@ -735,7 +735,7 @@ EOF
>
>  test_expect_success 'status after reverting commit' '
>         git revert --continue &&
> -       cat >expected <<\EOF
> +       cat >expected <<\EOF &&
>  On branch master
>  nothing to commit (use -u to show untracked files)
>  EOF
> --
> 1.8.4-50-g437ce60
>
