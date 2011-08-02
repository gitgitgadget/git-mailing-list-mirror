From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v13 4/8] bisect: introduce support for --no-checkout option.
Date: Wed, 3 Aug 2011 07:24:27 +1000
Message-ID: <CAH3Anrrf5aZMEH8KmKtvdaRf=D9fb6OVRJN+VjGM8Cd2wV6rnA@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<1312284545-2426-5-git-send-email-jon.seymour@gmail.com>
	<7vr553elsd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 23:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoMUI-0006TT-IK
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 23:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab1HBV0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 17:26:50 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46071 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab1HBV0t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 17:26:49 -0400
Received: by ewy4 with SMTP id 4so115738ewy.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=m3tiP51+ntL2cI8cYAS9HRcM1VcAfB3wkW/tkXB5k9g=;
        b=Io1YT/GoLMq586KRWNHz0U6grGoESkTi5+QL6Lt8IU2zlZS5wHN/bGG3SddDXpoHy4
         A9ft0afj1wSupw66k4FoMFw4OaQKIW3QQout1DaXlIpTXBUgQD5UUFmtONwO74ahu7gI
         9epMeeCzGYkyBrmTLMLqadAAK11nlqLvPGv6Y=
Received: by 10.14.41.8 with SMTP id g8mr1975051eeb.58.1312320267390; Tue, 02
 Aug 2011 14:24:27 -0700 (PDT)
Received: by 10.14.28.6 with HTTP; Tue, 2 Aug 2011 14:24:27 -0700 (PDT)
In-Reply-To: <7vr553elsd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178510>

On Wed, Aug 3, 2011 at 4:00 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> If --no-checkout is specified, then the bisection process uses:
>>
>> =C2=A0 =C2=A0 =C2=A0 git update-ref --no-deref HEAD <trial>
>>
>> at each trial instead of:
>>
>> =C2=A0 =C2=A0 =C2=A0 git checkout <trial>
>> ...
>
> Ok.
>
>> =C2=A0int cmd_bisect__helper(int argc, const char **argv, const char=
 *prefix)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int next_all =3D 0;
>> + =C2=A0 =C2=A0 int no_checkout =3D 0;
>> + =C2=A0 =C2=A0 char *bisect_mode=3DNULL;
>> =C2=A0 =C2=A0 =C2=A0 struct option options[] =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN(0, "nex=
t-all", &next_all,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "perform 'git bisect next'"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_STRING(0, "bisect-mo=
de", &bisect_mode, "mode",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "the bisection mode either checkout or update-ref. de=
faults to checkout."),
>
> I think this is a regression from naming perspective from the previou=
s
> round. You would be either the normal (checkout) mode or no-checkout =
mode,
> and honestly, --no-checkout would be understood by anybody while upda=
te-ref
> would be understood only by Gitz.
>

Is it relevant here that --bisect-mode here is on bisect--helper which
is really part of the plumbing and unlikely to be used by anything
other than git's own porcelain?

I did leave the porcelain option as --no-checkout.

I personally think the git-bisect.sh implementation which uses
BISECT_MODE internally is slightly simpler than the one that uses
BISECT_NO_CHECKOUT.

Are you ok if I keep roughly the v13 git-bisect.sh implementation, but
revert the bisect--helper.c to v11 (adjusting git-bisect.sh to
compensate)?

jon,
