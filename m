From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] diff: round down similarity index
Date: Mon, 25 Jun 2007 12:34:24 +0200
Message-ID: <467F9A30.7040201@lsrfire.ath.cx>
References: <467EEEE6.3090100@lsrfire.ath.cx>	<7vir9co8ue.fsf@assigned-by-dhcp.cox.net> <86k5tsh761.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 12:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2luF-0000ho-Qp
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 12:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbXFYKer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Jun 2007 06:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbXFYKer
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 06:34:47 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:36315
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751144AbXFYKeq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 06:34:46 -0400
Received: from [10.0.1.201] (p508E4C4D.dip.t-dialin.net [80.142.76.77])
	by neapel230.server4you.de (Postfix) with ESMTP id D26AE900D;
	Mon, 25 Jun 2007 12:34:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <86k5tsh761.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50887>

David Kastrup schrieb:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>
>>> +static int similarity_index(struct diff_filepair *p)
>>> +{
>>> +	int result =3D p->score * 100.0 / MAX_SCORE;
>>> +
>>> +	/* Paranoia: guard against floating point rounding errors. */
>>> +	if (p->score =3D=3D MAX_SCORE)
>>> +		result =3D 100;
>>> +	else if (result =3D=3D 100)
>>> +		result =3D 99;
>>> +
>>> +	return result;
>>> +}
>> Why not simply do this?
>>
>>         static int similarity_index(struct diff_filepair *p)
>>         {
>>                 if (p->score =3D=3D MAX_SCORE)
>>                         return 100;
>>                 return p->score * 100 / MAX_SCORE;
>>         }
>>
>> MAX_SCORE and p->score run up to 60000 and we assume int is at
>> least 32-bit, so I do not think there is no risk of overflowing.

Good idea!  *smacks himself against the forehead*

I just copied the old code (sans the addition of 0.5) and then tried
to work around it's rounding problem (which I'm not even certain
exists and matters).  Look out for an updated patch..

> You bet me to it on the way to work.  Anyway, when working with
> integers, the first two lines are definitely not required (I am
> assuming that p->score is integer as well but have not checked).

Right.

> What probably requires more thought is the calculation of p->score
> itself: if one has large numbers as a ratio (original vs changes
> lines), multiplying by 60000 before dividing by the second large
> numbers might exceed the size of the integers.

MAX_SCORE is defined as 60000.0, which makes it a double.  AFAICS all
the multiplications with MAX_SCORE are done using floating point
arithmetic for that reason.

Ren=E9
