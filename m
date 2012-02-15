From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] git-send-email: allow overriding smtp-encryption config
 to 'none'
Date: Wed, 15 Feb 2012 15:49:59 -0800
Message-ID: <CAN8TOE_BnkOcMQRTY-GWrHozYD0+0giWn2LtjB8AVnP_DzA+Sg@mail.gmail.com>
References: <1329342178-14540-1-git-send-email-computersforpeace@gmail.com>
	<20120215220629.GA17672@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 16 00:50:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxobu-0001sO-MA
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 00:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab2BOXuB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 18:50:01 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52334 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab2BOXuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 18:50:00 -0500
Received: by yenm8 with SMTP id m8so1015938yen.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 15:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bVTcT/+9W6VrIP0GX93E7ULqFJOqogKZ89rC8pMOBH0=;
        b=q4AjYvSsEWEMgbP1mL7FSGG1CjnIcXTulPoKa0O8sGlHyWgqu7qMeC5oreN2ktFZXC
         iIRHm/mj+sle+AGwu2UDsT8UyazFzB9IzjUudRyAqUCLPYreA2jmW2F2wrDuCsTAlh92
         yIlodpYKbbT5ObKw/6FlgTWYq5PiAfnSrTu+g=
Received: by 10.236.72.170 with SMTP id t30mr216757yhd.101.1329349799799; Wed,
 15 Feb 2012 15:49:59 -0800 (PST)
Received: by 10.236.25.5 with HTTP; Wed, 15 Feb 2012 15:49:59 -0800 (PST)
In-Reply-To: <20120215220629.GA17672@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190866>

On Wed, Feb 15, 2012 at 2:06 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 15, 2012 at 01:42:58PM -0800, Brian Norris wrote:
>
>> According to the manpage:
>>
>> =A0--smtp-encryption=3D<encryption>
>> =A0 =A0 =A0 =A0 Specify the encryption to use, either ssl or tls. An=
y other value
>> =A0 =A0 =A0 reverts to plain SMTP. =A0Default is the value of
>> =A0 =A0 =A0 =A0 sendemail.smtpencryption.
>>
>> However, if I have already set sendemail.smtpencryption but try to o=
verride
>> it with something like 'no', the authentication code block still tri=
es to ask
>> for a password (and fails).
>
> Sounds reasonable.

An error like
  Command unknown: 'AUTH' at /usr/local/libexec/git-core/git-send-email
is reasonable?

>> This patch forces $smtp_encryption to 'none' when a proper encryptio=
n type is
>> not provided, then checks $smtp_encryption before proceeding to auth=
entication.
>
> Defaulting everything except "ssl" or "tls" to "none" seems risky to =
me.
> If I am understanding your patch correctly, then doing this:
>
> =A0git send-email --smtp-encryption=3DSSL
>
> will silently treat that as "don't do encryption", which could have
> surprising security implications for the user. I chose all-caps as it=
 is
> an obvious mistake to make. We probably should treat it the same as
> lowercase "ssl", but the same argument applies to other typos like
> "tsl".

Well, git-send-email already doesn't handle typos or capitalization
correctly, AFAICT. So nothing new here.

> It seems like a much safer default would be to die() on an invalid
> encryption specifier.

=46ine. But then we need to define a behavior that means 'no
encryption.' Like 'none' instead of just saying 'anything but tls or
ssl.'

Now that I look at this again, I think part of the issue I have is
that there is no way to override *smtp-user* via command-line, in
order to do unencrypted, unauthenticated email. So the
*authentication* not the encryption is really my main problem...I'll
take another look and try a new patch.

Thanks,
Brian
