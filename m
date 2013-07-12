From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Fri, 12 Jul 2013 05:59:23 -0400
Message-ID: <20130712095923.GA4695@sigill.intra.peff.net>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 11:59:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxa8V-0004wW-BN
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 11:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251Ab3GLJ7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 05:59:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:37949 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146Ab3GLJ72 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 05:59:28 -0400
Received: (qmail 27817 invoked by uid 102); 12 Jul 2013 10:00:46 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 05:00:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 05:59:23 -0400
Content-Disposition: inline
In-Reply-To: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230190>

On Thu, Jul 11, 2013 at 02:50:03PM -0700, Kyle J. McKay wrote:

> The <url> value is considered a match to a url if the <url> value
> is either an exact match or a prefix of the url which ends on a
> path component boundary ('/').  So "https://example.com/test" will
> match "https://example.com/test" and "https://example.com/test/too"
> but not "https://example.com/testextra".
> 
> Longer matches take precedence over shorter matches with
> environment variable settings taking precedence over all.
> 
> With this configuration:
> 
> [http]
>         useragent = other-agent
>         noEPSV = true
> [http "https://example.com"]
>         useragent = example-agent
>         sslVerify = false
> [http "https://example.com/path"]
>         useragent = path-agent

I like the general direction you are going, and especially the path
prefix matching is something I had always meant to implement for the
credential code.

A few comments on the implementation:

> +enum http_option_type {
> +	opt_post_buffer = 0,
> +	opt_min_sessions,
> +#ifdef USE_CURL_MULTI
> +	opt_max_requests,
> +#endif
> +	opt_ssl_verify,
> +	opt_ssl_try,
> +	opt_ssl_cert,
> +#if LIBCURL_VERSION_NUM >= 0x070903
> +	opt_ssl_key,
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x070908
> +	opt_ssl_capath,
> +#endif
> +	opt_ssl_cainfo,
> +	opt_low_speed,
> +	opt_low_time,
> +	opt_no_epsv,
> +	opt_http_proxy,
> +	opt_cookie_file,
> +	opt_user_agent,
> +	opt_passwd_req,
> +	opt_max
> +};

We usually put enum fields in ALL_CAPS to mark them as constants (though
you can find few exceptions in the code).

> +static size_t http_options_url_match_prefix(const char *url,
> +					    const char *url_prefix,
> +					    size_t url_prefix_len)
> +{

It looks like you're matching the URLs as raw strings, and I don't see
any canonicalization going on. What happens if I have
"https://example.com/foo+bar" in my config, but then I visit
"https://example.comfoo%20bar"?

Or what about optional components? If I have "https://example.com" in my
config, but I am visiting "https://peff@example.com/", shouldn't it
match? The config spec is more general than my specific URL; you would
not want it to match in the opposite direction, though.

I think you would want to break down the URL into fields, canonicalize
each field by undoing any encoding, and then compare the broken-down
URLs, as credential_match does (adding in your prefix/boundary matching to
the path instead of a straight string comparison).

I think you could mostly reuse the code there by doing:

  1. Create a "struct url" that contains the broken-down form; "struct
     credential" would contain a url.

  2. Pull out credential_from_url into "int url_parse(struct url *,
     const char *)".

  3. Pull out credential_match into "int url_match(struct url *, struct
     url *)".

  4. Parse and compare URLs from "http.$URL.*" during the config read
     (similar to credential_config_callback).

That does make your by-length ordering impossible, but I don't think you
can do it in the general case. If I have:

  [http "http://peff@example.com"] foo = 1
  [http "http://example.com:8080"] foo = 2

and I visit "http://peff@example.com:8080", which one is the winner? I
don't think there is an unambiguous definition. I'd suggest instead just
using the usual "last one wins" strategy that our config uses. It has
the unfortunate case that:

  [http "http://example.com"]
     foo = 1
  [http]
     foo = 2

will always choose http.foo=2, but I don't think that is a big problem
in practice. You often only set one or the other, and in the cases where
you want to have a non-standard default and then override it with
another host-specific case, the "last one wins" rule makes it simple to
explain that you need to specify keys in most-general to most-specific
order.

>  static int http_options(const char *var, const char *value, void *cb)
>  {
> -	if (!strcmp("http.sslverify", var)) {
> +	const char *url = (const char *)cb;

No need to cast from void, this isn't C++. :)

The rest of the http_options() changes look like what I'd expect.

> @@ -344,7 +479,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  
>  	http_is_verbose = 0;
>  
> -	git_config(http_options, NULL);
> +	git_config(http_options, (void *)url);

No need to cast again. :)

So this is the URL that we got on the command line. Which means that if
we get a redirect, we will not re-examine the options. I think that's
OK; we do not even _see_ the redirect, as it happens internally within
curl. The credential code has the same problem, but it is not a security
issue because curl clears the credentials on redirect.

However, it may be worth mentioning in the documentation that the config
options operate on the URL you give git, _not_ necessarily on the actual
URL you are hitting at any given moment (the gitcredentials(7) page
should probably make the same distinction).

-Peff
