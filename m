From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: Re: [PATCH] Makefile: fix compilation of test programs under MinGW 
	environment
Date: Sun, 28 Feb 2010 02:03:35 +0300
Message-ID: <63cde7731002271503oac53237ubed6d318b46042e9@mail.gmail.com>
References: <1267304969-1924-1-git-send-email-michael.lukashov@gmail.com>
	 <7vy6ietlf7.fsf@alter.siamese.dyndns.org>
	 <7vmxyupbpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 00:03:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlVhH-0004MT-BJ
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 00:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030885Ab0B0XDh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 18:03:37 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50410 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965997Ab0B0XDg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2010 18:03:36 -0500
Received: by wya21 with SMTP id 21so695301wya.19
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 15:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ypgB8K5endnVP8GLQLmRGHeL+A+YYrLY1JlUe+Arl4U=;
        b=WwXdc43m+DVjXziZGU5Fp0O15dJjlhbaas6Mm8ib9vaVC3DMntfilsFo5+EPG7DITz
         vWfkjoetsjR1DbniAe+bcMRK7naIfqFpuBWUbFFrwrVUxOUwT5mD1041QniZqAtYrBjt
         0NMs7NpvqnQBhJnwJ3sCjjS0NmtzkU7i95Kg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nsvBulZ7Q7tGQua9Gq7NLwgSNP/WYaKeO1SmWO93QiRz3XBpbmcbcz1iSHfZP4khR6
         oWDjfHQdkmk5694NqhqV1ApvOfiuJn2XJxe3dwc6u0i2MwZ4JTKkC8Aa5h5RClJZZie+
         e/8tvpgOL7duEx4TmbzSDncXpVTq0Uj7H4wtw=
Received: by 10.216.89.84 with SMTP id b62mr1649624wef.226.1267311815178; Sat, 
	27 Feb 2010 15:03:35 -0800 (PST)
In-Reply-To: <7vmxyupbpa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141237>

Hi,

On Sun, Feb 28, 2010 at 1:15 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Michael Lukashov <michael.lukashov@gmail.com> writes:
>>
>>> Commit 225f78c8 (Merge branch 'master' of git://repo.or.cz/alt-git
>>> into jn/autodep, 2010-01-26) changed Makefile in such a way that
>>> the following error occurs when trying to compile Git under MinGW e=
nvironment:
>>>
>>> =C2=A0 make: *** No rule to make target `test-chmtime', needed by `=
all'. =C2=A0Stop.
>>>
>>> Under Linux it seems there's no difference between two variants.
>>
>>> -TEST_PROGRAMS :=3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
>>> +TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
>>
>> If the difference were on the RHS of this definition, which does inv=
olve
>> $X that is different between the two platforms, I would understand, =
but
>> your patch looks like it is addressing difference between :=3D vs =3D=
, and
>> that is more like a difference of other parts of the Makefile than
>> difference between Linux and mingw compilation environment.
>
> Ok, I think I know what happend.
>
> We used to have the definition of TEST_PROGRAMS way later than where =
we
> currently have it, and it was for a reason. =C2=A0X is to be defined =
to be .exe
> in the platform specific section for MinGW (and probably Cygwin as we=
ll).
>
> But because the definition of TEST_PROGRAMS was moved way up, it need=
s to
> be recursively expanded.
>
> TEST_OBJS also uses $X in simple expansion (i.e. sets with :=3D not w=
ith =3D),
> so I expect that it has the same issue. =C2=A0Can you check and verif=
y?
>
>

It seems there's no difference between

TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))

and

TEST_OBJS =3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))

Both variants seem to work under mingw.
