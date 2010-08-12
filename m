From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Fri, 13 Aug 2010 00:51:59 +0200
Message-ID: <AANLkTinJK3YZ0sojnpiH0KZvFFC38X8LFr3U1ZrU_UXG@mail.gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
 <1281592569-740-3-git-send-email-newren@gmail.com> <AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
 <AANLkTikLhe9+6ovLT99qG9wwDjXVmT8_81xuN8P31eve@mail.gmail.com> <AANLkTinqW4h-SG21ZEAvhKEPJ46WfBRyYboUsfXjy7Zn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjgdO-0001Yi-8Z
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761046Ab0HLWwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 18:52:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54424 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761021Ab0HLWwU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 18:52:20 -0400
Received: by gwb20 with SMTP id 20so637739gwb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:52:19 -0700 (PDT)
Received: by 10.231.39.195 with SMTP id h3mr699856ibe.88.1281653539136; Thu,
 12 Aug 2010 15:52:19 -0700 (PDT)
Received: by 10.231.16.196 with HTTP; Thu, 12 Aug 2010 15:51:59 -0700 (PDT)
In-Reply-To: <AANLkTinqW4h-SG21ZEAvhKEPJ46WfBRyYboUsfXjy7Zn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153439>

On Thu, Aug 12, 2010 at 11:02 PM, Elijah Newren <newren@gmail.com> wrot=
e:
> Hi,
>
> On Thu, Aug 12, 2010 at 8:37 AM, Santi B=E9jar <santi@agolina.net> wr=
ote:
>> diff --git c/git-pull.sh w/git-pull.sh
>> index a09a44e..c1617d5 100755
>> --- c/git-pull.sh
>> +++ w/git-pull.sh
>> @@ -214,7 +214,10 @@ test true =3D "$rebase" && {
>> =A0 =A0 =A0 =A0do
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if test "$reflog" =3D "$(git merge-ba=
se $reflog $curr_branch)"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0then
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldremoteref=3D"$reflo=
g"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$reflog" !=3D=
 $(git merge-base $reflog
>> $remoteref)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldrem=
oteref=3D"$reflog"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
>
> How does this help? =A0I've been trying to scratch my head trying to
> figure out a case where it could affect the outcome, and am strugglin=
g
> to come up with one.

Me too :)

The only case where it makes a difference, it is wrong. I was trying
to be extra cautious, but ... too much in this case.

>
>> @@ -273,6 +276,14 @@ then
>> =A0 =A0 =A0 =A0exit
>> =A0fi
>>
>> +if test true =3D "$rebase"
>> +then
>> + =A0 =A0 =A0 if test "$oldremoteref" =3D $(git merge-base $oldremot=
eref $merge_head)
>> + =A0 =A0 =A0 then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unset oldremoteref
>> + =A0 =A0 =A0 fi
>> +fi
>> +
>
> This was indeed my original patch, then I just (incorrectly, as you
> pointed out) moved other bits of code to be with this so that the
> determination of oldremoteref was all in one place.

OK. Then for your original patch:

Acked-by: Santi B=E9jar <santi@agolina.net>

Thanks,
Santi
