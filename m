From: =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>
Subject: Re: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 14:18:22 -0300
Message-ID: <CAHCkQtPmJdFBk7G-EP70FwtkRk11Utp+rppjNrEZFtZgOVrObA@mail.gmail.com>
References: <1343664610-479-1-git-send-email-dangra@gmail.com>
	<7v6295rxmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:18:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svtbw-0001Ed-Kk
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484Ab2G3RSY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 13:18:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42228 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab2G3RSX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 13:18:23 -0400
Received: by yhmm54 with SMTP id m54so5067888yhm.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ND6EPft1qJa4SfHkP+57QDrlM3jzpqcjxC/6ZWXIQmU=;
        b=vlKmAxoT1idHD/jsTnsmBY8iNFyUs/iV8iDqNwLocnZeNf0UDPslF6N6HzwKTijJqJ
         rvX9RUO/XjuZwT/pjFOXqt4iYXdLIE0I5MmuFnQ54jUOZdwlt6vHTtrG7nQUfRKHhAPA
         BNpHHEh/K4UVaBwD+yq8sHM+usNdLqyl1RuvqDkhPOmiOHBkDVngzRpAe+m7AzOXH6/l
         wOJ8IBYnjT+nxSi8kUSctBKSllOFfoNWGAQCzdj3hFJ+gChEQtcc+SJuZHRMMh1tW7ee
         iHkdWLf16jS69tPnTFZ1g6+Y/ANpNMt0DAqvTHkkXt8367iJFv1QpZ/ScVkztTFrdJOB
         Er1A==
Received: by 10.66.84.67 with SMTP id w3mr25930192pay.83.1343668702330; Mon,
 30 Jul 2012 10:18:22 -0700 (PDT)
Received: by 10.68.62.226 with HTTP; Mon, 30 Jul 2012 10:18:22 -0700 (PDT)
In-Reply-To: <7v6295rxmb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202586>

On Mon, Jul 30, 2012 at 2:02 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Daniel Gra=C3=B1a <dangra@gmail.com> writes:
>
>> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
>> ---
>>  t/t7409-submodule-detached-worktree.sh |   31 +++++++++++++++++++++=
+++-------
>>  1 files changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submod=
ule-detached-worktree.sh
>> index db75642..d88f400 100755
>> --- a/t/t7409-submodule-detached-worktree.sh
>> +++ b/t/t7409-submodule-detached-worktree.sh
>> @@ -15,7 +15,11 @@ TEST_NO_CREATE_REPO=3D1
>>  test_expect_success 'submodule on detached working tree' '
>>       git init --bare remote &&
>>       test_create_repo bundle1 &&
>> -     (cd bundle1 && test_commit "shoot") &&
>> +     (
>> +             cd bundle1 &&
>> +             test_commit "shoot" &&
>> +             git rev-list --max-count=3D1 HEAD > "$TRASH_DIRECTORY/=
expect"
>
> Better written as
>
>         git rev-parse --verify HEAD >../expect
>
> methinks.

You rule here,

is it still better than "git rev-parse --max-count=3D1 HEAD" seen in
t7406-submodule.update.sh?

>
>> +     ) &&
>>       mkdir home &&
>>       (
>>               cd home &&
>> @@ -23,14 +27,27 @@ test_expect_success 'submodule on detached worki=
ng tree' '
>>               git clone --bare ../remote .dotfiles &&
>>               git submodule add ../bundle1 .vim/bundle/sogood &&
>>               test_commit "sogood" &&
>> +             (
>> +                     unset GIT_WORK_TREE GIT_DIR &&
>> +                     cd .vim/bundle/sogood &&
>> +                     git rev-list --max-count=3D1 HEAD > actual &&
>> +                     test_cmp actual "$TRASH_DIRECTORY/expect"
>
> Likewise.
>
>         git rev-parse --verify HEAD >actual &&
>         test_cmp ../expect actual

I tried to avoid the too many ".." usage, in that case it'd be:

    test_cmp ../../../../expect actual

>
> As test_cmp turns into "diff -u", comparing expect against actual
> (instead of the other way around) shows the deviation in a more
> readable way when your test fails.

must agree, thanks.


>
>> +             ) &&
>>               git push origin master
>> -     ) &&
>> +     )
>>       mkdir home2 &&
>>       (
>>               cd home2 &&
>> -             export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dot=
files" &&
>>               git clone --bare ../remote .dotfiles &&
>> -             git submodule update --init
>> +             export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dot=
files" &&
>
> So you used to clone with the two environment variables in effect to
> create the .otfiles, but now you don't use them while cloning.  That
> makes more sense to me, especially the .otfiles is created "bare".
>
>> +             git checkout master &&
>
> So you populate the newly created home2 working tree out of the .otfi=
les
> repository in it.

right, before it wasn't creating ~/.gitmodules and "git subodule
update --init" wasn't taking effect.

>
>> +             git submodule update --init &&
>> +             (
>> +                     unset GIT_WORK_TREE GIT_DIR &&
>> +                     cd .vim/bundle/sogood &&
>> +                     git rev-list --max-count=3D1 HEAD > actual &&
>> +                     test_cmp actual "$TRASH_DIRECTORY/expect"
>
> Likewise.
>
>> +             )
>>       )
>>  '
>>
>> @@ -42,6 +59,7 @@ test_expect_success 'submodule on detached working=
 pointed by core.worktree' '
>>               git clone --bare ../remote "$GIT_DIR" &&
>>               git config core.bare false &&
>>               git config core.worktree .. &&
>> +             git checkout master &&
>>               git submodule add ../bundle1 .vim/bundle/dupe &&
>>               test_commit "dupe" &&
>>               git push origin master
>> @@ -52,9 +70,8 @@ test_expect_success 'submodule on detached working=
 pointed by core.worktree' '
>>               git config core.bare false &&
>>               git config core.worktree .. &&
>>               git pull &&
>> -             git submodule update &&
>> -             git submodule status &&
>> -             test -d .vim/bundle/dupe
>> +             git submodule update --init &&
>> +             test -e .vim/bundle/dupe/shoot.t
>
> Is the "existence" the only thing you care about?  That's not all
> that different from the old test that only checked the existence of
> the directory dupe, no?

Except the submodule wasn't updating but the directory still existed
so test passed, now it check for a file that exists only if the
submodule update works.
I check for file existence as a shortcut for checking for submodule
revision and because I am not sure what else too check honestly.

the real purpose of this test is the use or "core.worktree" instead of
GIT_WORK_TREE.
