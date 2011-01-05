From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [BUG?] "git submodule foreach" when command is ssh
Date: Thu, 6 Jan 2011 12:22:17 +1300
Message-ID: <AANLkTikCUKbHUrvXjWVyzmrZMzUtgrLrCDr8wSeFVgsZ@mail.gmail.com>
References: <AANLkTi=x2i6NvDNRzbszhk-a-z5AYe46-iUBxQsxJJHC@mail.gmail.com>
	<AANLkTini=GaGSHDX4e1jhPVxKaSayUJoWa=w4u4Rz-+5@mail.gmail.com>
	<20110105230334.GB9774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 06 00:22:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PacgT-00075m-9w
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 00:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab1AEXWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 18:22:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33567 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab1AEXWT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 18:22:19 -0500
Received: by fxm20 with SMTP id 20so15557247fxm.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 15:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GDz3/TmYlWQ8AR0LafAKUcoiY3J4ghnIXTKfWGPGLnQ=;
        b=i0Ro52l6tl1Sksaiw68TAZEdsMDuZoTsr9aiJG+O+1plCbA+gL76lx2zNULvkzzCbG
         0//OtV05WUcLeKFrkHX60yJ/Wa+aA52dKZ1YILv91tgzKqiK1QJIG0wYmxAwhZiaAu9z
         IBCxH1rEYbGRmejj/3h+ET+Ot+20FkdN1QUmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T0MbuqNOb+zD2tXwwHBRgLRbGU4Hsuzr+MfYHVw4m6/kGhd/r9NeDtitQnTLf/FHM6
         ok7pKObeVhItxhFOSjy9I3Mv+qv+qrMVbvbx+BoUVeeM7ILad+Era4z+Psj96khWckK1
         fGeifv4bZNacCp70d9nY+BPIzb3jtYkvYaJ5Y=
Received: by 10.223.83.8 with SMTP id d8mr327770fal.94.1294269737972; Wed, 05
 Jan 2011 15:22:17 -0800 (PST)
Received: by 10.223.73.205 with HTTP; Wed, 5 Jan 2011 15:22:17 -0800 (PST)
In-Reply-To: <20110105230334.GB9774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164607>

On Thu, Jan 6, 2011 at 12:03 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 06, 2011 at 11:50:58AM +1300, Chris Packham wrote:
>
>> Actually this might be a ssh/bash bug (feature?). There is different
>> behaviour between
>>
>> =C2=A0 find . -maxdepth 1 -type d -a ! -name '\.*' | while read; do =
echo
>> $REPLY && ssh localhost ls /; done
>>
>> and
>>
>> =C2=A0 find . -maxdepth 1 -type d -a ! -name '\.*' | while read; do =
echo
>> $REPLY && ls /; done
>
> Ssh will opportunistically eat data on stdin to send to the other sid=
e,
> even though the command on the other side ("ls" in this case) will ne=
ver
> read it. Because of course ssh has no way of knowing that, and is try=
ing
> to be an interactive terminal. So it ends up eating some random amoun=
t
> of the data you expected to go to the "read" call.
>
> You can use the "-n" option to suppress it. For example:
>
> =C2=A0$ (echo foo; echo bar) |
> =C2=A0 =C2=A0while read line; do
> =C2=A0 =C2=A0 =C2=A0echo local $line
> =C2=A0 =C2=A0 =C2=A0ssh host "echo remote $line"
> =C2=A0 =C2=A0done
>
> produces:
>
> =C2=A0local foo
> =C2=A0remote foo
>
> but:
>
> =C2=A0$ (echo foo; echo bar) |
> =C2=A0 =C2=A0while read line; do
> =C2=A0 =C2=A0 =C2=A0echo local $line
> =C2=A0 =C2=A0 =C2=A0ssh -n host "echo remote $line"
> =C2=A0 =C2=A0done
>
> produces:
>
> =C2=A0local foo
> =C2=A0remote foo
> =C2=A0local bar
> =C2=A0remote bar
>
> which is what you want.
>
> -Peff

Thanks that makes sense and adding -n to my ssh invocations solves the =
problem.
