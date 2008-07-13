From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: Re: ! [PATCH/RFC] git-mailinfo: use strbuf's instead of fixed buffers
Date: Sun, 13 Jul 2008 20:17:41 +0200
Organization: Chalmers
Message-ID: <487A46C5.6000503@etek.chalmers.se>
References: <4876820D.4070806@etek.chalmers.se> <7vod55o0tx.fsf@gitster.siamese.dyndns.org> <48768F30.8070409@etek.chalmers.se> <7v3amhnwy9.fsf@gitster.siamese.dyndns.org> <48769E40.8030303@etek.chalmers.se> <48769E91.60205@etek.chalmers.se> <7vy747fx9x.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 20:18:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI69j-0003xT-7H
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 20:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbYGMSRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 14:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753433AbYGMSRo
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 14:17:44 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:33830 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbYGMSRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 14:17:43 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id 3EA2811CC2;
	Sun, 13 Jul 2008 20:17:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vy747fx9x.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88317>

Junio C Hamano wrote:
> Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:
>=20
>> -static char *sanity_check(char *name, char *email)
>> +static void sanity_check(struct strbuf *out, struct strbuf *name, s=
truct strbuf *email)
>>  {
>> -	int len =3D strlen(name);
>> -	if (len < 3 || len > 60)
>> -		return email;
>> -	if (strchr(name, '@') || strchr(name, '<') || strchr(name, '>'))
>> -		return email;
>> -	return name;
>> +	struct strbuf o =3D STRBUF_INIT;
>> +	if (name->len < 3 || name->len > 60)
>> +		strbuf_addbuf(&o, email);
>> +	if (strchr(name->buf, '@') || strchr(name->buf, '<') ||
>> +		strchr(name->buf, '>'))
>> +		strbuf_addbuf(&o, email);
>> +	strbuf_addbuf(&o, name);
>> +	strbuf_reset(out);
>> +	strbuf_addbuf(out, &o);
>> +	strbuf_release(&o);
>=20
> This does not look like a correct conversion.  When name is too short=
 or
> too long, we do not even look at name and return email straight.  Per=
haps
> this would be more faithful conversion:
>=20
> 	struct strbuf *src =3D name;
> 	if (name->len < 3 ||
>             60 < name->len ||
> 	    strchr(name->buf, '@') ||
> 	    strchr(name->buf, '<') ||
> 	    strchr(name->buf, '>'))
> 		src =3D email;
> 	else if (name =3D=3D out)
>         	return;
> 	strbuf_reset(out);
> 	strbuf_addbuf(out, src);
>=20
> It is not your fault, but sanity_check() is a grave misnomer for this
> function.  This does "get_sane_name" (i.e. we have name and email but=
 if
> name does not look right, use email instead).

Right. I changed the name and used your implementation.

>> -static int bogus_from(char *line)
>> +static int bogus_from(const struct strbuf *line)
>>  {

[ ... ]

>>  	return 1;
>>  }
>=20
> Conversion looks correct but its return value does not make much sens=
e
> (again, not your fault).  bogus_from() is given a bogus looking from =
line
> (it is not about checking if it is bogus), and returns 0 if we alread=
y
> have e-mail address, if the from line does not have bra-ket for grabb=
ing
> e-mail address for, but returns 1 if we managed to get name and email
> pairs.  The inconsistency does not matter only because its sole calle=
r
> handle_from() returns its return value, and its caller discards it.  =
We
> may be better off declaring this function and handle_from() as void.
>=20

Done.

>>  	/* The remainder is name.  It could be "John Doe <john.doe@xz>"
>>  	 * or "john.doe@xz (John Doe)", but we have whited out the
>>  	 * email part, so trim from both ends, possibly removing
>>  	 * the () pair at the end.
>>  	 */
>=20
> Now, it should read "but we have removed the email part", I think.

Done.
>> +	strbuf_trim(from);
>> +	if (*from->buf =3D=3D '(')
>> +		strbuf_remove(&name, 0, 1);
>> +	if (*(from->buf + from->len - 1) =3D=3D ')')
>=20
> Can from be empty at this point before this check?
>=20

Yes. Added a test for that.

>> +		strbuf_setlen(from, from->len - 1);
>> +
>> +	sanity_check(&name, from, &email);
>>  	return 1;
>>  }
>=20
> We used to copy the data from the argument (in_line) before munging i=
t in
> this function, but now we are modifying it in place (from).  Does thi=
s
> upset our caller, or the original code was just doing an extra unnece=
ssary
> copy?

No, it's ok with the current code, since when handle_from() is called, =
it's
the last time we look at the header[i] field. I changed it to copy its =
argument
anyway, for future-proofing.

>=20
>> -static int handle_header(char *line, char *data, int ofs)
>> +static void handle_header(struct strbuf **out, const struct strbuf =
*line)
>>  {
>> -	if (!line || !data)
>> -		return 1;
>> -
>> -	strcpy(data, line+ofs);
>> +	if (!*out) {
>> +		*out =3D xmalloc(sizeof(struct strbuf));
>> +		strbuf_init(*out, line->len);
>> +	} else
>> +		strbuf_reset(*out);
>> =20
>> -	return 0;
>> +	strbuf_addbuf(*out, (struct strbuf *)line); /* const warning */
>>  }
>=20
> I think its second parameter can safely become "const struct strbuf *=
";
> perhaps we should fix the definition of strbuf_addbuf() in your first
> patch?
>=20
Done.

>> @@ -173,180 +153,176 @@ static int slurp_attr(const char *line, cons=
t char *name, char *attr)
>>  	else
>>  		ends =3D "; \t";
>>  	sz =3D strcspn(ap, ends);
>> -	memcpy(attr, ap, sz);
>> -	attr[sz] =3D 0;
>> +	strbuf_add(attr, ap, sz);
>>  	return 1;
>>  }
>> =20
>>  struct content_type {
>> -	char *boundary;
>> -	int boundary_len;
>> +	struct strbuf *boundary;
>>  };
>> =20
>>  static struct content_type content[MAX_BOUNDARIES];
>=20
> Wouldn't it make more sense to get rid of "struct content_type" altog=
ether
> and use "struct strbuf *content[MAX_BOUNDARIES]" directly?

Sure.

I'll send a patch updated with your comments shortly.

/Lukas
