From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] config: add options to list only variable names
Date: Wed, 27 May 2015 17:04:38 -0400
Message-ID: <20150527210438.GB22815@peff.net>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 27 23:04:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxiVK-0008Sm-FB
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbbE0VEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 17:04:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:36884 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751648AbbE0VEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 17:04:41 -0400
Received: (qmail 14115 invoked by uid 102); 27 May 2015 21:04:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:04:41 -0500
Received: (qmail 10590 invoked by uid 107); 27 May 2015 21:04:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 17:04:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 17:04:38 -0400
Content-Disposition: inline
In-Reply-To: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270095>

On Wed, May 27, 2015 at 10:07:19PM +0200, SZEDER G=C3=A1bor wrote:

> Help the completion script by introducing the '--list-names' and
> '--get-names-regexp' options, the "names-only" equivalents of '--list=
' and
> '--get-regexp', so it doesn't have to separate variable names from th=
eir
> values anymore.

Thanks, this sounds like the best solution. It should be a tiny bit mor=
e
efficient, too, though I doubt it matters much in practice.

> -'git config' [<file-option>] [-z|--null] -l | --list
> +'git config' [<file-option>] [-z|--null] -l | --list | --list-name

s/list-name/&s/, to match the code (and your commit message).

> @@ -161,6 +166,9 @@ See also <<FILES>>.
>  --list::
>  	List all variables set in config file.
> =20
> +--list-name::
> +	List the names of all variables set in config file.

Ditto here. Also, now that we have two similar modes, perhaps the
"--list" description above should become:

  List all variables set in config file, along with their values.

> @@ -165,7 +170,14 @@ static int collect_config(const char *key_, cons=
t char *value_, void *cb)
> =20
>  	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
> =20
> -	return format_config(&values->items[values->nr++], key_, value_);
> +	if (show_only_keys) {
> +		struct strbuf *buf =3D &values->items[values->nr++];
> +		strbuf_init(buf, 0);
> +		strbuf_addstr(buf, key_);
> +		strbuf_addch(buf, term);
> +		return 0;
> +	} else
> +		return format_config(&values->items[values->nr++], key_, value_);
>  }

Might it flow a little better to always enter format_config, and then
just return early (before writing the value) when show_key_only is set?

>  cat > expect << EOF
> +beta.noindent
> +nextsection.nonewline
> +123456.a123
> +version.1.2.3eX.alpha
> +EOF
> +
> +test_expect_success 'working --list-names' '
> +	git config --list-names > output &&
> +	test_cmp expect output
> +'
> +
> +cat > expect << EOF

We usually avoid the extra space after redirection operators. But we
also usually match existing code. I'm not sure which is more evil in
this case. ;)

> +test_expect_success '--get-name-regexp' '
> +	git config --get-name-regexp in >output &&
> +	test_cmp expect output
> +'

This one is the odd man out if you are following existing style,
though.

The rest of the patch looks good to me.

-Peff
