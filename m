From: =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>
Subject: Re: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 15:15:45 -0300
Message-ID: <CAHCkQtNUKHkK8DYT-cBD3pbaqXPFJ-cNBsKqkAHdEUs9rxVa7A@mail.gmail.com>
References: <7vsjc9qh33.fsf@alter.siamese.dyndns.org>
	<1343670719-3635-1-git-send-email-dangra@gmail.com>
	<7vfw89qfx2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 20:16:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvuVX-0004rm-BE
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 20:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab2G3SPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 14:15:47 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53899 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab2G3SPq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 14:15:46 -0400
Received: by pbbrp8 with SMTP id rp8so10204683pbb.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KSfI1rj09Q+Ik3kHQqHfCAaS7X3wVr1fm/J5YqqdSxA=;
        b=GGSPwEbf54qgONCg2Au/tm5nX0JoeOqyPgNiTp+LGYzmrq20ZKOp5QEWeu2YbD0F5D
         IQdgoj2Cl4tXJHtxPtjhbpvq/CeXi1NavUA0AR4NbnCYr6Bh4mqjUWuMcZlxfdwQuqnC
         lhBXOLKYg5vG6KIg+7vaYrYZ241ADOJWsCTCY+4LT4XkWg6PH1jA7rEN1UeiA6isyj/O
         zsgKVb30fMPxUKuH6QHIOk2hNhsJff+tgdnZOR+MGc8k6tAb1pJ6Hg3P2hOH8cYbvt6s
         Zv2P2o4+hFGJBDwKAfmyYH/MSxXCvEb8VkEL57qnZGn26OA7DSW/J7V3zJC3r+LjQ41K
         6cNA==
Received: by 10.68.231.132 with SMTP id tg4mr37540245pbc.159.1343672145296;
 Mon, 30 Jul 2012 11:15:45 -0700 (PDT)
Received: by 10.68.62.226 with HTTP; Mon, 30 Jul 2012 11:15:45 -0700 (PDT)
In-Reply-To: <7vfw89qfx2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202600>

On Mon, Jul 30, 2012 at 3:09 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Daniel Gra=C3=B1a <dangra@gmail.com> writes:
>
>> * Check submodule is correctly initialized and updated after cloning=
 .dotfiles
>>
>> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
>> ---
>
> Thanks.
>
>> @@ -23,14 +27,27 @@ test_expect_success 'submodule on detached worki=
ng tree' '
>>               git clone --bare ../remote .dotfiles &&
>>               git submodule add ../bundle1 .vim/bundle/sogood &&
>>               test_commit "sogood" &&
>> +             (
>> +                     unset GIT_WORK_TREE GIT_DIR &&
>> +                     cd .vim/bundle/sogood &&
>> +                     git rev-parse --verify HEAD >actual &&
>> +                     test_cmp ../../../../expect actual
>> +             ) &&
>>               git push origin master
>> -     ) &&
>> +     )
>
> I do not think you meant to break the && chain here on purpose.
> I'll queue with a minor fix-up here.

great, thanks.

>
>>       mkdir home2 &&
>>       (
>>               cd home2 &&
>> -             export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dot=
files" &&
>>               git clone --bare ../remote .dotfiles &&
>> -             git submodule update --init
>> +             export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dot=
files" &&
>> +             git checkout master &&
>> +             git submodule update --init &&
>> +             (
>> +                     unset GIT_WORK_TREE GIT_DIR &&
>> +                     cd .vim/bundle/sogood &&
>> +                     git rev-parse --verify HEAD >actual &&
>> +                     test_cmp ../../../../expect actual
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
>>       )
>>  '
