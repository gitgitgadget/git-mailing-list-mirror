From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: 2.6.0: Comment in rebase instruction has become too rigid
Date: Tue, 29 Sep 2015 20:31:40 +0200
Message-ID: <CAN0XMOJDUMHX5WwVYoJVSuYKPHpf=+0Os=U34_zRDt1XPwPtQQ@mail.gmail.com>
References: <CAEY4ZpN0C96jU4Tgvqt-hWEviR-sapDoyAv88H+opPSr-cs=mg@mail.gmail.com>
	<vpqr3lhb719.fsf@grenoble-inp.fr>
	<vpqzj0588i2.fsf@grenoble-inp.fr>
	<xmqqk2r99jjp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nazri Ramliy <ayiehere@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 20:32:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgzh0-0008AY-S2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 20:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965393AbbI2Sbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 14:31:50 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:34073 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965052AbbI2Sbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 14:31:42 -0400
Received: by labzv5 with SMTP id zv5so19406350lab.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2015 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D0/Uh+0sSez0H36TwOHWbua8Okzet893I/sEJd7Lidg=;
        b=lUvmM/7hzQhQq9T8itBjK/bA3YPMw8NCvqihtvi3DK6Z7wt/i+NUCB8DoJ9YHJ6tKW
         2BbOoc9eOMed1lk1eOWx3dMgt4nvlKFGK5L9ft7YFrW6/DiKo+wligRCDlmMhko9sFmg
         lI0jKx2oAvkpSOLD+x7f4ERQWI3gUi85fPJHWOXev4QNMoZgi9SGJbSoujkz1gmRTyqK
         0JmPtXtOz3PP5RG4lXPo+ANrhm33NzhEEuoT/uDuyvysZt3N9nfS5lUmERTue8dPKQuX
         lWtd2w9OtsLy8X1+kp+vj8LiM7JTn05dMiUXChJ0I0ifmPxhLvGPnbQN7WUqMi0F4ATu
         6+3w==
X-Received: by 10.112.77.197 with SMTP id u5mr6196173lbw.120.1443551500215;
 Tue, 29 Sep 2015 11:31:40 -0700 (PDT)
Received: by 10.25.201.211 with HTTP; Tue, 29 Sep 2015 11:31:40 -0700 (PDT)
In-Reply-To: <xmqqk2r99jjp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278833>

2015-09-29 20:17 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> Confirmed: Git 2.1.4 accepts this, 2.6 doesn't:
>>>
>>> Warning: the command isn't recognized in the following line:
>>>  - # pick dbafac11052a0075233bdcf0b71f54d1503aa82d test
>>>
>>> You can fix this with 'git rebase --edit-todo'.
>>> Or you can abort the rebase with 'git rebase --abort'.
>>>
>>> I didn't bisect, but I guess this was introduced in the series
>>> introducing this check on the todolist before starting the bisection.
>>
>> Indeed:
>>
>> 804098bb30a5339cccb0be981a3e876245aa0ae5 is the first bad commit
>
> Yup, before that series, expand_todo_ids -> transfom_todo_ids ended
> up reading each line with "while read -r command rest" loop and the
> we did not honor the usual "# at the beginning line is the comment"
> convention, which I think was a bug.  With that commit, a separate
> step in check_bad_cmd_and_sha1 uses a similar looking "while read"
> loop but forgets to take '#' into account.
>
> I know you alluded to preprocess what is fed to stripspace, but I
> wonder if we can remove the misguided call to stripspace in the
> first place and do something like the attached instead.
>
>  git-rebase--interactive.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f01637b..a64f77a 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -886,7 +886,6 @@ check_commit_sha () {
>  # from the todolist in stdin
>  check_bad_cmd_and_sha () {
>         retval=0
> -       git stripspace --strip-comments |
>         (
>                 while read -r line
>                 do
> @@ -896,7 +895,7 @@ check_bad_cmd_and_sha () {
>                         sha1=$2
>
>                         case $command in
> -                       ''|noop|x|"exec")
> +                       '#'*|''|noop|x|"exec")

If so, I think we should use "$comment_char"* here.

>                                 # Doesn't expect a SHA-1
>                                 ;;
>                         pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
