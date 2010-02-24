From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4 6/6] is_submodule_modified(): clear environment properly
Date: Wed, 24 Feb 2010 09:55:14 +0100
Message-ID: <cb7bb73a1002240055v58953dcfh3be7c4589523b14b@mail.gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1266996196-25978-7-git-send-email-giuseppe.bilotta@gmail.com> 
	<4B84DDE9.8000301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 09:55:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkD1z-0000ve-QW
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 09:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab0BXIzh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 03:55:37 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:53647 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab0BXIzg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 03:55:36 -0500
Received: by ewy4 with SMTP id 4so728770ewy.28
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 00:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6pPfM57pQFDYF9eHmJ/AEt7rN/UR+J8Ue3l0Hq4AfXo=;
        b=p6ZuPFJYBnzxKArfOnRU6Pzv7SGWV1KgQjuADa1T7d4+xp4jdxr16c0K+igQpWCuq2
         Bl7Q9QzBCtaFqy5/TTVkquRq3kyAKgzzRk2ukG7At14gAfDhRAdE20XP270BI9YQBBLc
         tS0a6u1n3uPz9OiKy38dnvzMigPleUCuUUuts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fNhpXYGwic9wTGR12eXPOuhBKC+khl9Uu6W9Dy+N+MQTrRPxJOUxNJbvJotD/VxFoM
         z5SZsHKXmkIsIhK3fIn4V/d67JrDJmZ9tIXb+MjydaZtWlUjJQozWo+xrwdx86JX7H9Q
         CTZXc1oEO0Gq3wlm+N8SbAAdomeoYh861wzrg=
Received: by 10.213.75.134 with SMTP id y6mr1643454ebj.48.1267001734974; Wed, 
	24 Feb 2010 00:55:34 -0800 (PST)
In-Reply-To: <4B84DDE9.8000301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140920>

On Wed, Feb 24, 2010 at 9:06 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Giuseppe Bilotta schrieb:
>> + =A0 =A0 const char *env[local_repo_env_size+2];
>
> Variable sized arrays are prohibited.

Ah, sorry. Is alloca() allowed? I don't see it being used anywhere
else in the code, and malloc would be a little too much for this case.

>> =A0 =A0 =A0 struct strbuf buf =3D STRBUF_INIT;
>>
>> + =A0 =A0 /* Copy local_repo_env to env, letting i
>> + =A0 =A0 =A0 =A0rest at the last NULL */
>> + =A0 =A0 while (env[i] =3D local_repo_env[i])
>> + =A0 =A0 =A0 =A0 =A0 =A0 ++i; /* do nothing */
>> +
>
> This looks very inconsistent: At the one hand, you use l_r_e_size to
> allocate the space, but then you iterate over it assuming that the li=
st is
> (also) NULL-terminated. But this is only a minor nit.

Well, if you consider that using l-r-e-size is just a way to spare a
double-walk, the inconsistency is tolerable. OTOH, in this particular
case NULL-walking the list doesn't give the usual benefit of sparing a
counter, so I could rework the patch to use a standard for loop. (I
also notice that I forgot to remove the /* do nothing */ comment from
the while(env[i] =3D local_repo_env[i++]) ; --i approach I was going
with at first)

--=20
Giuseppe "Oblomov" Bilotta
