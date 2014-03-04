From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rev-parse: support OPT_NUMBER_CALLBACK in --parseopt
Date: Tue, 04 Mar 2014 10:28:22 -0800
Message-ID: <xmqqiortlsxl.fsf@gitster.dls.corp.google.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, philipoakley@iee.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 19:28:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKu4u-000194-7M
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 19:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbaCDS21 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 13:28:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbaCDS20 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 13:28:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E70D6F773;
	Tue,  4 Mar 2014 13:28:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T2h4EwTc4RDP
	xqdyZ63gSwhAGEQ=; b=hRZS02ZsmZQgwuwisRmBL9N0/lyZFIneJcmlgZn8TyAp
	JWZ6i4DzNz7l/tMGITw1n5A7BBtOfXPFDtKsCOUshoqGn499LNNz0teM8LqY70m/
	IZra+FPfHjieOh+CF43u6rHqzK3L5yUNK9Hgq6UBbaNP/PzBkpsOy9MIdl1JiJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Er2QnB
	vEiN1HACR6N2TtYSnWrWdE5Uv8mwSpRI0logBPNnbUQOsN96RtLNBTp1QP7IF5/5
	TmaOqdqZFCwxycD1vlLb2Xprw7do+z5+dTOdXGQUJ98fcTS3JHAKYkcPe1Kyk0P6
	To8bufsURWJ5h9VsiMP0yB4ZUaLNQeNootLQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3604D6F772;
	Tue,  4 Mar 2014 13:28:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 370806F76D;
	Tue,  4 Mar 2014 13:28:25 -0500 (EST)
In-Reply-To: <1393728794-29566-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 2 Mar
 2014 09:53:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C607A82C-A3CA-11E3-A931-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243366>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If the option spec is
>
> -NUM Help string
>
> then rev-parse will accept and parse -([0-9]+) and return "-NUM $1"

Even though the hardcoded "NUM" token initially gave me a knee-jerk
"Yuck" reaction, that literal option name is very unlikely to be
desired by scripts/commands for their real option names, and being
in all uppercase it is very clear that it is magic convention
between the parsing mechanism and the script it uses.

It however felt funny to me without a matching (possibly hidden)
mechanism to allow parse-options machinery to consume such an output
as its input.  In a script that uses this mechanism to parse out the
numeric option "-NUM 3" out of "git script -3" and uses that "three"
to drive an underlying command (e.g. "git grep -3"), wouldn't it be
more natural if that underlying command can be told to accept the
same notation (i.e. "git grep -NUM 3")?  For that to be consistent
with the rest of the system, "-NUM" would not be a good token; being
it multi-character, it must be "--NUM" or something with double-dash
prefix.

I kind of like the basic idea, the capability it tries to give
scripted Porcelain implementations.  But my impression is that
"rebase -i -4", which this mechanism was invented for, is not
progressing, so perhaps we should wait until the real user of this
feature appears.

Thanks.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/rev-parse.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 45901df..b37676f 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -331,6 +331,8 @@ static int parseopt_dump(const struct option *o, =
const char *arg, int unset)
>  	struct strbuf *parsed =3D o->value;
>  	if (unset)
>  		strbuf_addf(parsed, " --no-%s", o->long_name);
> +	else if (o->type =3D=3D OPTION_NUMBER)
> +		strbuf_addf(parsed, " -NUM");
>  	else if (o->short_name && (o->long_name =3D=3D NULL || !stuck_long)=
)
>  		strbuf_addf(parsed, " -%c", o->short_name);
>  	else
> @@ -338,7 +340,7 @@ static int parseopt_dump(const struct option *o, =
const char *arg, int unset)
>  	if (arg) {
>  		if (!stuck_long)
>  			strbuf_addch(parsed, ' ');
> -		else if (o->long_name)
> +		else if (o->long_name || o->type =3D=3D OPTION_NUMBER)
>  			strbuf_addch(parsed, '=3D');
>  		sq_quote_buf(parsed, arg);
>  	}
> @@ -439,7 +441,10 @@ static int cmd_parseopt(int argc, const char **a=
rgv, const char *prefix)
> =20
>  		if (s - sb.buf =3D=3D 1) /* short option only */
>  			o->short_name =3D *sb.buf;
> -		else if (sb.buf[1] !=3D ',') /* long option only */
> +		else if (s - sb.buf =3D=3D 4 && !strncmp(sb.buf, "-NUM", 4)) {
> +			o->type =3D OPTION_NUMBER;
> +			o->flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG;
> +		} else if (sb.buf[1] !=3D ',') /* long option only */
>  			o->long_name =3D xmemdupz(sb.buf, s - sb.buf);
>  		else {
>  			o->short_name =3D *sb.buf;
