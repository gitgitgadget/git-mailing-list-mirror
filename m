From: Junio C Hamano <gitster@pobox.com>
Subject: Re:! [PATCH/RFC] git-mailinfo: use strbuf's instead of fixed buffers
Date: Fri, 11 Jul 2008 23:10:18 -0700
Message-ID: <7vy747fx9x.fsf_-_@gitster.siamese.dyndns.org>
References: <4876820D.4070806@etek.chalmers.se>
 <7vod55o0tx.fsf@gitster.siamese.dyndns.org>
 <48768F30.8070409@etek.chalmers.se>
 <7v3amhnwy9.fsf@gitster.siamese.dyndns.org>
 <48769E40.8030303@etek.chalmers.se> <48769E91.60205@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Sat Jul 12 08:11:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHYKL-0007QG-7a
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 08:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbYGLGK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jul 2008 02:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbYGLGK1
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 02:10:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbYGLGK0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jul 2008 02:10:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 21ED91CAFC;
	Sat, 12 Jul 2008 02:10:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DC9961CAFB; Sat, 12 Jul 2008 02:10:21 -0400 (EDT)
In-Reply-To: <48769E91.60205@etek.chalmers.se> (Lukas =?utf-8?Q?Sandstr?=
 =?utf-8?Q?=C3=B6m's?= message of "Fri, 11 Jul 2008 01:43:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37A8405A-4FD9-11DD-9093-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88221>

Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:

> -static char *sanity_check(char *name, char *email)
> +static void sanity_check(struct strbuf *out, struct strbuf *name, st=
ruct strbuf *email)
>  {
> -	int len =3D strlen(name);
> -	if (len < 3 || len > 60)
> -		return email;
> -	if (strchr(name, '@') || strchr(name, '<') || strchr(name, '>'))
> -		return email;
> -	return name;
> +	struct strbuf o =3D STRBUF_INIT;
> +	if (name->len < 3 || name->len > 60)
> +		strbuf_addbuf(&o, email);
> +	if (strchr(name->buf, '@') || strchr(name->buf, '<') ||
> +		strchr(name->buf, '>'))
> +		strbuf_addbuf(&o, email);
> +	strbuf_addbuf(&o, name);
> +	strbuf_reset(out);
> +	strbuf_addbuf(out, &o);
> +	strbuf_release(&o);

This does not look like a correct conversion.  When name is too short o=
r
too long, we do not even look at name and return email straight.  Perha=
ps
this would be more faithful conversion:

	struct strbuf *src =3D name;
	if (name->len < 3 ||
            60 < name->len ||
	    strchr(name->buf, '@') ||
	    strchr(name->buf, '<') ||
	    strchr(name->buf, '>'))
		src =3D email;
	else if (name =3D=3D out)
        	return;
	strbuf_reset(out);
	strbuf_addbuf(out, src);

It is not your fault, but sanity_check() is a grave misnomer for this
function.  This does "get_sane_name" (i.e. we have name and email but i=
f
name does not look right, use email instead).

> -static int bogus_from(char *line)
> +static int bogus_from(const struct strbuf *line)
>  {
>  	/* John Doe <johndoe> */
> -	char *bra, *ket, *dst, *cp;
> =20
> +	char *bra, *ket;
>  	/* This is fallback, so do not bother if we already have an
>  	 * e-mail address.
>  	 */
> -	if (*email)
> +	if (email.len)
>  		return 0;
> =20
> -	bra =3D strchr(line, '<');
> +	bra =3D strchr(line->buf, '<');
>  	if (!bra)
>  		return 0;
>  	ket =3D strchr(bra, '>');
>  	if (!ket)
>  		return 0;
> =20
> -	for (dst =3D email, cp =3D bra+1; cp < ket; )
> -		*dst++ =3D *cp++;
> -	*dst =3D 0;
> -	for (cp =3D line; isspace(*cp); cp++)
> -		;
> -	for (bra--; isspace(*bra); bra--)
> -		*bra =3D 0;
> -	cp =3D sanity_check(cp, email);
> -	strcpy(name, cp);
> +	strbuf_reset(&email);
> +	strbuf_add(&email, bra + 1, ket - bra - 1);
> +
> +	strbuf_reset(&name);
> +	strbuf_add(&name, line->buf, bra - line->buf);
> +	strbuf_trim(&name);
> +	sanity_check(&name, &name, &email);
>  	return 1;
>  }

Conversion looks correct but its return value does not make much sense
(again, not your fault).  bogus_from() is given a bogus looking from li=
ne
(it is not about checking if it is bogus), and returns 0 if we already
have e-mail address, if the from line does not have bra-ket for grabbin=
g
e-mail address for, but returns 1 if we managed to get name and email
pairs.  The inconsistency does not matter only because its sole caller
handle_from() returns its return value, and its caller discards it.  We
may be better off declaring this function and handle_from() as void.

> -static int handle_from(char *in_line)
> +static int handle_from(struct strbuf *from)
> ...
> +	el =3D strcspn(at, " \n\t\r\v\f>");
> +	strbuf_reset(&email);
> +	strbuf_add(&email, at, el);
> +	strbuf_remove(from, at - from->buf, el + 1);
>  	/* The remainder is name.  It could be "John Doe <john.doe@xz>"
>  	 * or "john.doe@xz (John Doe)", but we have whited out the
>  	 * email part, so trim from both ends, possibly removing
>  	 * the () pair at the end.
>  	 */

Now, it should read "but we have removed the email part", I think.

> +	strbuf_trim(from);
> +	if (*from->buf =3D=3D '(')
> +		strbuf_remove(&name, 0, 1);
> +	if (*(from->buf + from->len - 1) =3D=3D ')')

Can from be empty at this point before this check?

> +		strbuf_setlen(from, from->len - 1);
> +
> +	sanity_check(&name, from, &email);
>  	return 1;
>  }

We used to copy the data from the argument (in_line) before munging it =
in
this function, but now we are modifying it in place (from).  Does this
upset our caller, or the original code was just doing an extra unnecess=
ary
copy?

> -static int handle_header(char *line, char *data, int ofs)
> +static void handle_header(struct strbuf **out, const struct strbuf *=
line)
>  {
> -	if (!line || !data)
> -		return 1;
> -
> -	strcpy(data, line+ofs);
> +	if (!*out) {
> +		*out =3D xmalloc(sizeof(struct strbuf));
> +		strbuf_init(*out, line->len);
> +	} else
> +		strbuf_reset(*out);
> =20
> -	return 0;
> +	strbuf_addbuf(*out, (struct strbuf *)line); /* const warning */
>  }

I think its second parameter can safely become "const struct strbuf *";
perhaps we should fix the definition of strbuf_addbuf() in your first
patch?

> @@ -173,180 +153,176 @@ static int slurp_attr(const char *line, const=
 char *name, char *attr)
>  	else
>  		ends =3D "; \t";
>  	sz =3D strcspn(ap, ends);
> -	memcpy(attr, ap, sz);
> -	attr[sz] =3D 0;
> +	strbuf_add(attr, ap, sz);
>  	return 1;
>  }
> =20
>  struct content_type {
> -	char *boundary;
> -	int boundary_len;
> +	struct strbuf *boundary;
>  };
> =20
>  static struct content_type content[MAX_BOUNDARIES];

Wouldn't it make more sense to get rid of "struct content_type" altoget=
her
and use "struct strbuf *content[MAX_BOUNDARIES]" directly?

I'll review from handle_content_type() til the rest of the file
separately, as my concentration is wearing out..
