From: =?UTF-8?B?IkphbiBILiBTY2jDtm5oZXJyIg==?= <schnhrr@cs.tu-berlin.de>
Subject: Re: [PATCH 2/5] format-patch: do not wrap rfc2047 encoded headers
 too late
Date: Wed, 10 Oct 2012 11:31:59 +0200
Message-ID: <5075408F.8050502@cs.tu-berlin.de>
References: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de> <1349717609-4770-3-git-send-email-schnhrr@cs.tu-berlin.de> <7v7gqzfnpj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 11:32:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLseT-0000BZ-Js
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 11:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab2JJJcS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 05:32:18 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:60036 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab2JJJcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 05:32:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 609B75FEB
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 11:32:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id kOBa3wkCRpBO 22803-18;
	Wed, 10 Oct 2012 11:31:59 +0200 (CEST) 13694
Received: from [130.149.91.59] (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Wed, 10 Oct 2012 11:31:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120919 Thunderbird/10.0.7
In-Reply-To: <7v7gqzfnpj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207382>

Am 09.10.2012 21:30, schrieb Junio C Hamano:
> Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de> writes:
=2E..
>>  static int is_rfc2047_special(char ch)
>>  {
>> +	/*
>> +	 * We encode ' ' using '=3D20' even though rfc2047
>> +	 * allows using '_' for readability.  Unfortunately,
>> +	 * many programs do not understand this and just
>> +	 * leave the underscore in place.
>> +	 */
>=20
> The sentence break made me read the above three times to understand
> what it is trying to say.  "Unfortunately" refers to what happens if
> we were to use '_', but it initially appeared to be describing some
> bug due to our encoding ' ' as '=3D20'.  Perhaps like this?
>=20
> 	/*
> 	 * rfc2047 allows '_' to encode ' ' for readability, but
> 	 * many programs do not understand ...; encode ' ' using
> 	 * '=3D20' instead to avoid the problem.
> 	 */

I was just moving that comment (and the following check) around,
but I'll update the comment in the next version.

>> +	if (ch =3D=3D ' ' || ch =3D=3D '\n')
>> +		return 1;
>=20
> The comment justifies why this "if (ch =3D=3D ' ')", which could be p=
art
> of the "return" below, separately is done, but nothing explains why
> you add '\n' (and not other controls, e.g. '\t') to the mix.

The check for '\n' was introduced in commit c22e7de3
("format-patch: rfc2047-encode newlines in headers").

The commit log was:

    These should generally never happen, as we already
    concatenate multiples in subjects into a single line. But
    let's be defensive, since not encoding them means we will
    output malformed headers.

Having again a look at RFC 2047, I see that we should be
even more strict and not allow any non-printable character to
be passed through unencoded. I guess that adds another patch to
the series. Hmm... Maybe I can split patch 4 into two patches,
one that mostly fixes is_rfc2047_special() and one that
avoids 822 quoting when doing 2047 encoding.

>=20
>>  	return (non_ascii(ch) || (ch =3D=3D '=3D') || (ch =3D=3D '?') || (=
ch =3D=3D '_'));
>>  }
>> =20
>>  static void add_rfc2047(struct strbuf *sb, const char *line, int le=
n,
>>  		       const char *encoding)
>>  {
>> -	static const int max_length =3D 78; /* per rfc2822 */
>> +	static const int max_length =3D 76; /* per rfc2047 */
>>  	int i;
>>  	int line_len;
>> =20
>> @@ -286,7 +295,7 @@ static void add_rfc2047(struct strbuf *sb, const=
 char *line, int len,
>>  		if ((i + 1 < len) && (ch =3D=3D '=3D' && line[i+1] =3D=3D '?'))
>>  			goto needquote;
>>  	}
>> -	strbuf_add_wrapped_bytes(sb, line, len, -line_len, 1, max_length+1=
);
>> +	strbuf_add_wrapped_bytes(sb, line, len, -line_len, 1, 78+1);
>>  	return;
>=20
> Yuck.  If you do want to retain 78 for non-quoted output for
> backward compatibility, that is OK, but if that is the case, please
> introduce a new constant "max_quoted_length" or something to stand
> for 76 and use it in the "needquote:" part below.

Will do.

Regards
Jan
