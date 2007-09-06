From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/3] archive: specfile syntax change: "$Format:%PLCHLDR$"
 instead of just "%PLCHLDR"
Date: Thu, 06 Sep 2007 22:35:06 +0200
Message-ID: <46E0647A.10000@lsrfire.ath.cx>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se> <Pine.LNX.4.64.0709041139140.28586@racer.site> <46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org> <46E028B9.2090908@lsrfire.ath.cx> <Pine.LNX.4.64.0709061803590.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 22:35:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITO4P-0004Xk-MJ
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 22:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbXIFUfP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 16:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757533AbXIFUfO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 16:35:14 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:55504
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755682AbXIFUfN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 16:35:13 -0400
Received: from [10.0.1.201] (p508EE2E4.dip.t-dialin.net [80.142.226.228])
	by neapel230.server4you.de (Postfix) with ESMTP id ADC91873B5;
	Thu,  6 Sep 2007 22:35:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709061803590.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57927>

Johannes Schindelin schrieb:
>> +static void *format_specfile(const struct commit *commit, const cha=
r *format,
>> +                             unsigned long *sizep)
>=20
> Should this not be "char *buffer" instead of "const char *format"?  O=
r=20
> even better: a "struct strbuf *"?

const is correct, because the data in the buffer shouldn't be (and
isn't) modified.

"buffer" is a generic term; "format" on the other hand indicates the
meaning of the data within the buffer.

Input and output might indeed be passed along as struct strbuf, even
more so since the new API encourages its use as generic buffer (format
can contain NULs).

>> +{
>> +	unsigned long len =3D *sizep, result_len =3D 0;
>> +	const char *a =3D format;
>> +	char *result =3D NULL;
>> +
>> +	for (;;) {
>> +		const char *b, *c;
>> +		char *fmt, *formatted =3D NULL;
>> +		unsigned long a_len, fmt_len, formatted_len, allocated =3D 0;
>=20
> Maybe initialise formatted_len, just to be on the safe side?

I wish I could use C99 syntax and move its declaration down to its firs=
t
use, then it would be obvious that formatted_len is never used without
initialization.

>> +
>> +		b =3D memchr(a, '$', len);
>> +		if (!b || a + len < b + 9 || memcmp(b + 1, "Format:", 7))
>> +			break;
>=20
> Wouldn't memmem(buffer, len, "$Format:", 8) be better here?

Oh, that's a nice GNU extension, didn't know it before.  We might impor=
t
it to compat etc., but I think that's better left for a follow-up patch=
=2E

> A general comment: since you plan to output the result into a file an=
yway,=20
> it should be even easier to avoid realloc(), and do a=20
> print_formatted_specfile() instead of a format_specfile(), no?

Hmm, not sure what you mean.  At least archive-tar needs the expanded
contents in a buffer (not immediately written to stdout) because it
tries to mimic a real tar and always writes in blocks of 10k and
therefore needs to buffer the output.

Thanks!
Ren=C3=A9
