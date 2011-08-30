From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-for-each-ref: move GPG sigs off %(body) to %(signature).
Date: Tue, 30 Aug 2011 11:43:44 +0200
Message-ID: <4E5CB0D0.7000905@drmicha.warpmail.net>
References: <20110829213757.GB14299@sigill.intra.peff.net> <1314694641-24148-1-git-send-email-mgorny@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 11:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyKrK-0000Ad-Hg
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 11:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab1H3Jns convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 05:43:48 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59407 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752434Ab1H3Jnr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 05:43:47 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C09C820B35;
	Tue, 30 Aug 2011 05:43:46 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 30 Aug 2011 05:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=1O2+KT4wLIm00ZXDiqC4PC
	H8InM=; b=ZVHjH8XpH/26yPw0AAeWJ95h7DJDKQ27rYjXOwgDnrKvOfPWFzvZ51
	7cYClX1Zu684BcGEDYRkKx4c0gLi4+luM2wAxTBbeBvxfG1NdBF5ZuCU1cjYAykU
	26R065Vhnp1dUXxxGY6JzmXPChN9FhbSt0yOnqsXci2rbbK+CGCMs=
X-Sasl-enc: tGOrF1MNto6wCDkHTSduCNcMlKJ/6ItcKw9yIeS2E3JA 1314697426
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07F06403637;
	Tue, 30 Aug 2011 05:43:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <1314694641-24148-1-git-send-email-mgorny@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180398>

Micha=C5=82 G=C3=B3rny venit, vidit, dixit 30.08.2011 10:57:

Welcome to yet another MG (and a fresh spelling of Michael) on the list=
 ;)

> When grabbing a %(body) or %(contents) off a tag, one doesn't really
> expect to get the GPG signature as well (as it's basically useless
> without the complete signed text). Thus, strip it off those two tags,
> and make available via %(signature) if anyone needs it.

No, please do not change %(contents). It is the complete content which
(together with the header) enters into the sha1 calculation.

You will probably also face opposition as regards to %(body), changing
existing behaviour.

In fact, I wish we didn't have %(body) but %(contents:body) just like
other modifiers such as :short.

I think I'd go for

%(contents:signature)

and implement

%(contents:subject) the same as %(subject)
%(contents:body) as contents minus subject minus signature

and slowly deprecate %(subject) and %(body) (simply un-document for now=
).

Jeff will have more to say about this. Please see below for the sig
detection:

> Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
> ---
>  Documentation/git-for-each-ref.txt |    3 ++-
>  builtin/for-each-ref.c             |   35 ++++++++++++++++++++++++++=
+++------
>  2 files changed, 31 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-f=
or-each-ref.txt
> index 152e695..7145c46 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -103,7 +103,8 @@ and `date` to extract the named component.
> =20
>  The first line of the message in a commit and tag object is
>  `subject`, the remaining lines are `body`.  The whole message
> -is `contents`.
> +is `contents`.  If the message is GPG-signed, the signature is
> +`signature`.
> =20
>  For sorting purposes, fields with numeric values sort in numeric
>  order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 89e75c6..fa5c292 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -10,6 +10,9 @@
>  #include "parse-options.h"
>  #include "remote.h"
> =20
> +/* Used to strip signature off body */
> +#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----\n"
> +
>  /* Quoting styles */
>  #define QUOTE_NONE 0
>  #define QUOTE_SHELL 1
> @@ -69,6 +72,7 @@ static struct {
>  	{ "subject" },
>  	{ "body" },
>  	{ "contents" },
> +	{ "signature" },
>  	{ "upstream" },
>  	{ "symref" },
>  	{ "flag" },
> @@ -458,7 +462,7 @@ static void grab_person(const char *who, struct a=
tom_value *val, int deref, stru
>  	}
>  }
> =20
> -static void find_subpos(const char *buf, unsigned long sz, const cha=
r **sub, const char **body)
> +static void find_subpos(const char *buf, unsigned long sz, const cha=
r **sub, const char **body, const char **sig)
>  {
>  	while (*buf) {
>  		const char *eol =3D strchr(buf, '\n');
> @@ -478,18 +482,34 @@ static void find_subpos(const char *buf, unsign=
ed long sz, const char **sub, con
>  	buf =3D strchr(buf, '\n');
>  	if (!buf) {
>  		*body =3D "";
> +		*sig =3D *body;
>  		return; /* no body */
>  	}
>  	while (*buf =3D=3D '\n')
>  		buf++; /* skip blank between subject and body */
>  	*body =3D buf;
> +	*sig =3D *body;
> +
> +	/* look for GPG signature */

Again I have to say no. Please look at

3d5854e (tag: recognize rfc1991 signatures, 2010-11-10)

which uses the factored out signature detection as introduced in the
previous commits. Thanks!

> +	while (*buf) {
> +		const char *eol =3D strchr(buf, '\n');
> +		if (!eol) {
> +			*sig =3D buf + strlen(buf);
> +			return;
> +		}
> +		if (!strncmp(eol + 1, PGP_SIGNATURE, ARRAY_SIZE(PGP_SIGNATURE)-1))=
 {
> +			*sig =3D eol + 1;
> +			break; /* found end of body */
> +		}
> +		buf =3D eol + 1;
> +	}
>  }
> =20
>  /* See grab_values */
>  static void grab_sub_body_contents(struct atom_value *val, int deref=
, struct object *obj, void *buf, unsigned long sz)
>  {
>  	int i;
> -	const char *subpos =3D NULL, *bodypos =3D NULL;
> +	const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NULL;
> =20
>  	for (i =3D 0; i < used_atom_cnt; i++) {
>  		const char *name =3D used_atom[i];
> @@ -500,19 +520,22 @@ static void grab_sub_body_contents(struct atom_=
value *val, int deref, struct obj
>  			name++;
>  		if (strcmp(name, "subject") &&
>  		    strcmp(name, "body") &&
> -		    strcmp(name, "contents"))
> +		    strcmp(name, "contents") &&
> +		    strcmp(name, "signature"))
>  			continue;
>  		if (!subpos)
> -			find_subpos(buf, sz, &subpos, &bodypos);
> +			find_subpos(buf, sz, &subpos, &bodypos, &sigpos);
>  		if (!subpos)
>  			return;
> =20
>  		if (!strcmp(name, "subject"))
>  			v->s =3D copy_line(subpos);
>  		else if (!strcmp(name, "body"))
> -			v->s =3D xstrdup(bodypos);
> +			v->s =3D xstrndup(bodypos, sigpos - bodypos);
>  		else if (!strcmp(name, "contents"))
> -			v->s =3D xstrdup(subpos);
> +			v->s =3D xstrndup(subpos, sigpos - subpos);
> +		else if (!strcmp(name, "signature"))
> +			v->s =3D xstrdup(sigpos);
>  	}
>  }
> =20
