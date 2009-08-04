From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] Let mailsplit and mailinfo handle mails with CRLF 
	line-endings
Date: Tue, 4 Aug 2009 23:58:13 +0200
Message-ID: <81b0412b0908041458w7e76854bn96c4cb71a5e91e74@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com>
	 <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
	 <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
	 <20090804172638.GA15136@blimp.localdomain>
	 <20090804210327.GA23747@blimp.localdomain>
	 <H9KDJzU0XgndJHC8J4OETn7kxYhGP3gl0YJPR0low0hfIHjZOUsoxw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:59:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYS29-0008Jo-Rs
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133AbZHDV6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 17:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933130AbZHDV6P
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:58:15 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33631 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111AbZHDV6O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 17:58:14 -0400
Received: by bwz19 with SMTP id 19so3349532bwz.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ceKSeLgFAoCacjTU3x2qLg/MXqXjF6Mue9Ltg6TjLEw=;
        b=jM3bsremhksr4AipEHj/uoU+QwNwSYkIJoHBbqUVoU4gOD+zpL5wDH2rtg4BCRirSb
         awWWcT8mWAo9UINRKHCcRHs07XNX6YcGo2PujCFb2tmvTSCIyPqew8VaLUWm7sYlwYRV
         Su7NtW0gES/OGf+jo9sQKlvYbJKQ4hfgKif3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nQS7cicbYeO9D0iYXoDkSWKg0hDm/f2QBk38IWDrQ+iO9kTl2ay9xUXJbkR/mlvbb2
         z4dqlTJznXTeYjdhV7SwahHXQRbMJ0PzSTxlV91OND/oiMn7CaJ2NGzYBLXiMe/Ai8fZ
         m0GPAUDCyfQNs7Bu+kCspZiIJFQW6Y5UhHWR8=
Received: by 10.204.59.76 with SMTP id k12mr145671bkh.136.1249423093493; Tue, 
	04 Aug 2009 14:58:13 -0700 (PDT)
In-Reply-To: <H9KDJzU0XgndJHC8J4OETn7kxYhGP3gl0YJPR0low0hfIHjZOUsoxw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124822>

On Tue, Aug 4, 2009 at 23:29, Brandon
Casey<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> Alex Riesen wrote:
>> + =C2=A0 =C2=A0 if (c =3D=3D '\n' && len > 1 && buf[len - 2] =3D=3D =
'\r')
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[--len - 1] =3D '\n';
>> =C2=A0 =C2=A0 =C2=A0 buf[len] =3D '\0';
>>
>> =C2=A0 =C2=A0 =C2=A0 return len;
>
> What if \r lands at character 99 and \n is at character 100? =C2=A0If=
 buf has
> exactly 100 characters available for writing. ...

Ah, yes. You're right.

I have strong dislike towards unget, though. How about this, instead:

int read_line_with_nul(char *buf, int size, FILE *in)
{
	int len =3D 0, c;

	while (len < size) {
		c =3D getc(in);
		if (c =3D=3D EOF)
			break;
		buf[len++] =3D c;
		if (c =3D=3D '\n')
			break;
		else if (len =3D=3D size)
			c =3D 0;
	}
	if (c =3D=3D '\n' && len > 1 && buf[len - 2] =3D=3D '\r')
		buf[--len - 1] =3D '\n';
	buf[len] =3D '\0';

	return len;
}
