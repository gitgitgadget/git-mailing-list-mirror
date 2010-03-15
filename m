From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] checkout --conflict=diff3: add a label for
 ancestor
Date: Mon, 15 Mar 2010 03:32:38 -0500
Message-ID: <20100315083238.GA10068@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
 <20100315075509.GD8824@progeny.tock>
 <7vvdcy0zf3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 09:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5j9-0006MW-OP
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759795Ab0COIcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 04:32:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54386 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367Ab0COIch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:32:37 -0400
Received: by gwb11 with SMTP id 11so869332gwb.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=I2xsk+KOJ/OtFb5AM2lQqrGzt7v6prSPt7ShSaL2C1M=;
        b=oS4OvYd5RPmb6vMVVGE3/1+cAjtijfkuYDDnsOU0CbKAkaBkaDe66kCVg2MABelOtB
         fOxtpZR3vUuj/9Fz2BLso+KL0o/ewvoI/G138ZsTtYNQKTYZ29lrBC+b79UsITde8QZ6
         XOkZ4dXFKDHuWH6Uz8Ytki5bRspoMVSuUbNX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=a5geM8kfgP7Sr/+inhnWeSZWIXNkN0dyzcvmpbOoG+Sv9TlAXPNC3Dn9uwp5n2wFUx
         XuImW/BtwWgjhMs9IaM1E2/HKEz5Y1Fwm00zMIrVDz65nnl35w4EfW2rqfu/7R6R60jW
         CMST+3ed9E4xEn3/kjL1hMyiaFEheDORMNzZY=
Received: by 10.90.14.14 with SMTP id 14mr2131619agn.34.1268641956954;
        Mon, 15 Mar 2010 01:32:36 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4070638iwn.9.2010.03.15.01.32.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 01:32:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvdcy0zf3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142191>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> git rerere will not have trouble parsing this output, since instead =
of
>> looking for a newline, it looks for whitespace after the |||||||
>> marker.
>
> Missing:
>=20
>     "... and adding the extra label will not affect the computed the =
conflict
>     identifier, so existing rerere database will not be invalidated w=
ith this
>     change either".
>=20
> I didn't verified the above claim, but if it does not hold true, then=
 we
> need to think the transition strategy.  I don't expect a problem, tho=
ugh.

It holds.  handle_path() in rerere.c actually recreates the conflict hu=
nk
after parsing it:

	rerere_io_putconflict('<', marker_size, io);
	rerere_io_putmem(one.buf, one.len, io);
	rerere_io_putconflict('=3D', marker_size, io);
	rerere_io_putmem(two.buf, two.len, io);
	rerere_io_putconflict('>', marker_size, io);

This is a piece of defensive programing by Dscho that has lasted since
rerere was first made builtin.  It shelters rerere from changes in the
format of the conflict markers.

>> Reported-by: Stefan Monnier <monnier@iro.umontreal.ca>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> This "Reported" feels very odd for a feature enhancement ("Requested"
> would be more appropriate) not a bugfix.

Makes sense, thanks.

>> ---
>> Since =E2=80=9Coriginal=E2=80=9D a good name for the common ancestor=
?  I also
>> considered =E2=80=9Cbase=E2=80=9D and =E2=80=9Cancestor=E2=80=9D; th=
e latter is too jargon-y for my
>> taste, but =E2=80=9Cbase=E2=80=9D seems all right.
>
> Yeah, base sounds good.  Even though at the lowest level, a merge is =
a
> merge between two equals, people tend to think of the contents of the=
ir
> own side "original" (vs the merge outcome "result").

Sound good.  =E2=80=9Cbase=E2=80=9D it is, then.

Thanks,
Jonathan
