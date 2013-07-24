From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/4] config: add support for http.<url>.* settings
Date: Wed, 24 Jul 2013 03:12:26 -0400
Message-ID: <20130724071226.GD30074@sigill.intra.peff.net>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
 <30e562871d9632141d612876db3147e@f74d39fa044aa309eaea14b9f57fe79>
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
X-From: git-owner@vger.kernel.org Wed Jul 24 09:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1tFW-0004zj-Ma
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 09:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489Ab3GXHMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 03:12:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:36630 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab3GXHMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 03:12:30 -0400
Received: (qmail 20982 invoked by uid 102); 24 Jul 2013 07:12:30 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 02:12:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 03:12:26 -0400
Content-Disposition: inline
In-Reply-To: <30e562871d9632141d612876db3147e@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231081>

On Mon, Jul 22, 2013 at 05:56:41AM -0700, Kyle J. McKay wrote:

> +enum http_option_type {
> +	OPT_POST_BUFFER,
> +	OPT_MIN_SESSIONS,
> +	OPT_SSL_VERIFY,
> +	OPT_SSL_TRY,
> +	OPT_SSL_CERT,
> +	OPT_SSL_CAINFO,
> +	OPT_LOW_SPEED,
> +	OPT_LOW_TIME,
> +	OPT_NO_EPSV,
> +	OPT_HTTP_PROXY,
> +	OPT_COOKIE_FILE,
> +	OPT_USER_AGENT,
> +	OPT_PASSWD_REQ,
> +#ifdef USE_CURL_MULTI
> +	OPT_MAX_REQUESTS,
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x070903
> +	OPT_SSL_KEY,
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x070908
> +	OPT_SSL_CAPATH,
> +#endif
> +	OPT_MAX
> +};
> +
> +static size_t http_option_max_matched_len[OPT_MAX];

It's frustrating that we now have an extra spot to add new options to
(e.g., somebody else is adding http.savecookies in another thread, and
the merge will need to not just resolve the textual conflicts, but add
it to this other list).

Might it be simpler to just keep a dynamic list indexed by option name
(either a hash table, or a sorted string_list)? We only incur a lookup
when we find an actual config entry, so the number of lookups (and
entries) should be minuscule and not affect performance. And as a bonus,
it lets us handle arbitrary keys if we want to allow "git config" to
learn about url matching for user-specified keys.

-Peff
