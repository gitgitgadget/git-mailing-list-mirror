From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 3/4] tests: add new test for the url_normalize function
Date: Wed, 24 Jul 2013 02:59:33 -0400
Message-ID: <20130724065933.GC30074@sigill.intra.peff.net>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
 <60d85be89d27515d913ae15e10c332f@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 08:59:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1t30-0004r6-As
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 08:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab3GXG7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 02:59:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:36533 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab3GXG7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 02:59:37 -0400
Received: (qmail 20379 invoked by uid 102); 24 Jul 2013 06:59:37 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 01:59:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 02:59:33 -0400
Content-Disposition: inline
In-Reply-To: <60d85be89d27515d913ae15e10c332f@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231080>

On Mon, Jul 22, 2013 at 05:56:43AM -0700, Kyle J. McKay wrote:

> In order to perform sane URL matching for http.<url>.* options,
> http.c normalizes URLs before performing matches.
> 
> A new test-url-normalize test program is introduced along with
> a new t5200-url-normalize.sh script to run the tests.

While looking at test-url-normalize (and wanting to experiment some with
your series to see how it handled a few behaviors), I wondered if we
shouldn't be exposing this selection process to the user somehow via
git-config.

That is, would a shell script ever want to say "what is the value of
this config variable for url $X"? Certainly our test scripts want to,
and having a test-* program covers that, but might user scripts want to
do the same? Or even to introduce its own URL-matched config options?

How hard would it be to convert the "-c" option of test-url-normalize
into something like:

  git config --file=foo --url http noepsv $URL

which would look for http.$URL.noepsv matches.

If we want to go that route, we don't have to do it now (the test-*
interface is unpublished, and the git-config interface can simply come
later than the internal feature).  But it may be worth thinking about
now while it is in your head.

> diff --git a/test-url-normalize.c b/test-url-normalize.c
> new file mode 100644
> index 0000000..f18bd88
> --- /dev/null
> +++ b/test-url-normalize.c
> [...]
> +	if (!strcmp("sslverify", opt_lc.buf))
> +		printf("%s\n", curl_ssl_verify ? "true" : "false");
> +	else if (!strcmp("sslcert", opt_lc.buf))
> +		printf("%s\n", ssl_cert);
> +#if LIBCURL_VERSION_NUM >= 0x070903
> +	else if (!strcmp("sslkey", opt_lc.buf))
> +		printf("%s\n", ssl_key);
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x070908
> +	else if (!strcmp("sslcapath", opt_lc.buf))
> +		printf("%s\n", ssl_capath);
> +#endif
> [...]

Do we need to have the complete list of options here, including curl
version limitations? It seems like this will eventually get out of date
with the list of options. Would it be sufficient to test just one (or
even just handle a fake "http.$URL.foo" variable)?

> +#define url_normalize(u) http_options_url_normalize(u)

Does this macro do anything besides shorten the name? Is the extra
level of indirection to the reader worth it?

-Peff
