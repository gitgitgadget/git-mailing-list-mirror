From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Thu, 12 Aug 2010 15:02:48 -0600
Message-ID: <AANLkTinqW4h-SG21ZEAvhKEPJ46WfBRyYboUsfXjy7Zn@mail.gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
	<1281592569-740-3-git-send-email-newren@gmail.com>
	<AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
	<AANLkTikLhe9+6ovLT99qG9wwDjXVmT8_81xuN8P31eve@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 23:03:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojevc-0003t5-9v
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 23:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934002Ab0HLVCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 17:02:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60108 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933999Ab0HLVCu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 17:02:50 -0400
Received: by fxm13 with SMTP id 13so1003917fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5HrYWRDBYHdOEOgIhulJ+RG/4Zsc3qQvndfvRfcAsx0=;
        b=mMyFCeFSlr897LRO6jLEsH7qQXCjHRCMRM+S6bg6i6KiOvB93IIAEC4FItsnPqoL/h
         bs/Lleg+DsPaMXpU8XpMlFv47SOSWLf/3xSV9ppNaoIgcMVGwEAK0HNHvZ6BeDv4+UV5
         zZt9XQjE6+DDKtDfexSgRwSaop4Rq8Cyy2eg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NUnArCMl0/lQ6HK0mM49Bd59YASDjMilmYl44/XPrP5zTnDXz8IdlIf681xOnq/keM
         mXLqV1Opf1Ad4U8qNzkeeg8/DoLLlXMYkodQSbSElbkvH4kZAs5WWdPQTMXpIPDQDFT6
         HkpgSVQfAlimnS4qPSQJf0ZwzRZ9p0py4FkfA=
Received: by 10.223.104.15 with SMTP id m15mr765556fao.103.1281646968077; Thu,
 12 Aug 2010 14:02:48 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Thu, 12 Aug 2010 14:02:48 -0700 (PDT)
In-Reply-To: <AANLkTikLhe9+6ovLT99qG9wwDjXVmT8_81xuN8P31eve@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153417>

Hi,

On Thu, Aug 12, 2010 at 8:37 AM, Santi B=C3=A9jar <santi@agolina.net> w=
rote:
> diff --git c/git-pull.sh w/git-pull.sh
> index a09a44e..c1617d5 100755
> --- c/git-pull.sh
> +++ w/git-pull.sh
> @@ -214,7 +214,10 @@ test true =3D "$rebase" && {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test "$refl=
og" =3D "$(git merge-base $reflog $curr_branch)"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 oldremoteref=3D"$reflog"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if test "$reflog" !=3D $(git merge-base $reflog
> $remoteref)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 oldremoteref=3D"$reflog"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi

How does this help?  I've been trying to scratch my head trying to
figure out a case where it could affect the outcome, and am struggling
to come up with one.

> @@ -273,6 +276,14 @@ then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit
> =C2=A0fi
>
> +if test true =3D "$rebase"
> +then
> + =C2=A0 =C2=A0 =C2=A0 if test "$oldremoteref" =3D $(git merge-base $=
oldremoteref $merge_head)
> + =C2=A0 =C2=A0 =C2=A0 then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset oldremoteref
> + =C2=A0 =C2=A0 =C2=A0 fi
> +fi
> +

This was indeed my original patch, then I just (incorrectly, as you
pointed out) moved other bits of code to be with this so that the
determination of oldremoteref was all in one place.
