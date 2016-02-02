From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/6] convert.c: Remove input_crlf_action()
Date: Tue, 02 Feb 2016 13:44:46 -0800
Message-ID: <xmqqbn7yrdm9.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1454431992-2019-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Feb 02 22:45:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQikt-0003nD-5c
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 22:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608AbcBBVow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2016 16:44:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756536AbcBBVou convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 16:44:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 189CB4183D;
	Tue,  2 Feb 2016 16:44:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XcbgE7Ip+C9p
	IxVqZbJqznN/qsM=; b=wR1A1a6La/qXQ00GVKa1XoqdbHVH1eNnRyA6XaL00a+T
	bXHLjAmLZzl1tQgWU229xFS3N+GbKOKOW8Yb3EG+nrpsByPTfi3xtBBlCB13QWLK
	clNzvPM1h1yKaXw8TsiB5+BQ8XhQYE3aXwfLFiD+F1C3/gwHHQmqRxys9X3WVnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IdPe+K
	Ak4fUrLutwcImUoF9LH8YyD6S6CCM+5KpX6Up/a7bFBtS02gzsq9hTw/YYfEniMO
	oYezY0LwOuicPBgRBat4GdPwDQeKy3cb8aBfZrzG+8EeIfZ/FoJVgdgPWmWSD4ND
	NnlNYUH0o1ur74EvyqGzT7Mayd/JWYlXDGJo0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0DBD84183C;
	Tue,  2 Feb 2016 16:44:49 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2B57A4183A;
	Tue,  2 Feb 2016 16:44:48 -0500 (EST)
In-Reply-To: <1454431992-2019-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Tue, 2 Feb 2016 17:53:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E615EEC-C9F6-11E5-9AC6-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285311>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Integrate the code of input_crlf_action() into convert_attrs(),
> so that ca.crlf_action is aleays valid after calling convert_attrs().

s/aleays/always/

> Keep a copy of crlf_action in attr_action, this is needed for
> get_convert_attr_ascii().
>
> Remove eol_attr from struct conv_attrs, as it is now used temporally.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  convert.c | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index a24c2a2..bca3d0c 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -746,21 +746,10 @@ static int git_path_check_ident(struct git_attr=
_check *check)
>  	return !!ATTR_TRUE(value);
>  }
> =20
> -static enum crlf_action input_crlf_action(enum crlf_action text_attr=
, enum eol eol_attr)
> -{
> -	if (text_attr =3D=3D CRLF_BINARY)
> -		return CRLF_BINARY;
> -	if (eol_attr =3D=3D EOL_LF)
> -		return CRLF_INPUT;
> -	if (eol_attr =3D=3D EOL_CRLF)
> -		return CRLF_CRLF;
> -	return text_attr;
> -}
> -
>  struct conv_attrs {
>  	struct convert_driver *drv;
> -	enum crlf_action crlf_action;
> -	enum eol eol_attr;
> +	enum crlf_action attr_action; /* What attr says */
> +	enum crlf_action crlf_action; /* When no attr is set, use core.auto=
crlf */
>  	int ident;
>  };
> =20
> @@ -782,16 +771,23 @@ static void convert_attrs(struct conv_attrs *ca=
, const char *path)
>  	}
> =20
>  	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
> +		enum eol eol_attr;
>  		ca->crlf_action =3D git_path_check_crlf( ccheck + 4);

I guess this extra SP after opening paren was a misconversion from
the previous step...

>  		if (ca->crlf_action =3D=3D CRLF_GUESS)
>  			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
> +		ca->attr_action =3D ca->crlf_action;
>  		ca->ident =3D git_path_check_ident(ccheck + 1);
>  		ca->drv =3D git_path_check_convert(ccheck + 2);
> -		ca->eol_attr =3D git_path_check_eol(ccheck + 3);
> +		if (ca->crlf_action =3D=3D CRLF_BINARY)
> +			return;
> +		eol_attr =3D git_path_check_eol(ccheck + 3);
> +		if (eol_attr =3D=3D EOL_LF)
> +			ca->crlf_action =3D CRLF_INPUT;
> +		else if (eol_attr =3D=3D EOL_CRLF)
> +			ca->crlf_action =3D CRLF_CRLF;
>  	} else {
>  		ca->drv =3D NULL;
>  		ca->crlf_action =3D CRLF_GUESS;
> -		ca->eol_attr =3D EOL_UNSET;
>  		ca->ident =3D 0;
>  	}
>  }
> @@ -818,11 +814,9 @@ int would_convert_to_git_filter_fd(const char *p=
ath)
>  const char *get_convert_attr_ascii(const char *path)
>  {
>  	struct conv_attrs ca;
> -	enum crlf_action crlf_action;
> =20
>  	convert_attrs(&ca, path);
> -	crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
> -	switch (crlf_action) {
> +	switch (ca.attr_action) {
>  	case CRLF_GUESS:
>  		return "";
>  	case CRLF_BINARY:
> @@ -861,7 +855,6 @@ int convert_to_git(const char *path, const char *=
src, size_t len,
>  		src =3D dst->buf;
>  		len =3D dst->len;
>  	}
> -	ca.crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
>  	ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe=
);
>  	if (ret && dst) {
>  		src =3D dst->buf;
> @@ -882,7 +875,6 @@ void convert_to_git_filter_fd(const char *path, i=
nt fd, struct strbuf *dst,
>  	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);
> =20
> -	ca.crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
>  	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksaf=
e);
>  	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
>  }
> @@ -912,7 +904,6 @@ static int convert_to_working_tree_internal(const=
 char *path, const char *src,
>  	 * is a smudge filter.  The filter might expect CRLFs.
>  	 */
>  	if (filter || !normalizing) {
> -		ca.crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
>  		ret |=3D crlf_to_worktree(path, src, len, dst, ca.crlf_action);
>  		if (ret) {
>  			src =3D dst->buf;
> @@ -1381,7 +1372,7 @@ struct stream_filter *get_stream_filter(const c=
har *path, const unsigned char *s
>  	if (ca.ident)
>  		filter =3D ident_filter(sha1);
> =20
> -	crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
> +	crlf_action =3D ca.crlf_action;
> =20
>  	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_IN=
PUT) ||
>  	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FA=
LSE))

So the idea is that the code before this prepared eol_attr and
crlf_action fields in convert_attrs() and consumers of these fields
called input_crlf_action() with them as parameters to choose one of
CRLF_X, but with this change, that is precomputed and left in the
new field crlf_action.

I didn't find a code where ca.eol_attr is redefined after
convert_attrs() returned, and all the codepaths that redefine
ca.crlf_action do so by assigning the result of the call to
input_crlf_action(), _and_ they do not use the value before doing
so.  So it appears that this should not change any behaviour.

OK.
