From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] submodule: Port resolve_relative_url from shell to C
Date: Thu, 17 Dec 2015 22:27:08 -0500
Message-ID: <20151218032708.GA8530@sigill.intra.peff.net>
References: <1450311999-3992-1-git-send-email-sbeller@google.com>
 <1450311999-3992-2-git-send-email-sbeller@google.com>
 <5673052F.7050000@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	gitster@pobox.com, jens.lehmann@web.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 18 04:27:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9lht-0004Tr-Dt
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 04:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbbLRD1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 22:27:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:44100 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751257AbbLRD1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 22:27:11 -0500
Received: (qmail 11780 invoked by uid 102); 18 Dec 2015 03:27:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 21:27:11 -0600
Received: (qmail 20820 invoked by uid 107); 18 Dec 2015 03:27:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 22:27:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 22:27:08 -0500
Content-Disposition: inline
In-Reply-To: <5673052F.7050000@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282696>

On Thu, Dec 17, 2015 at 07:55:43PM +0100, Johannes Sixt wrote:

> -static int has_same_dir_prefix(const char *str, const char **out)
> +static int starts_with_dot_slash(const char *str)
>  {
> -#ifdef GIT_WINDOWS_NATIVE
> -	return skip_prefix(str, "./", out)
> -		|| skip_prefix(str, ".\\", out);
> -#else
> -	return skip_prefix(str, "./", out);
> -#endif
> +	return str[0] == '.' && is_dir_sep(str[1]);
>  }
>  
> -static int has_upper_dir_prefix(const char *str, const char **out)
> +static int starts_with_dot_dot_slash(const char *str)
>  {
> -#ifdef GIT_WINDOWS_NATIVE
> -	return skip_prefix(str, "../", out)
> -		|| skip_prefix(str, "..\\", out);
> -#else
> -	return skip_prefix(str, "../", out);
> -#endif
> +	return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
>  }

As the set of prefixes you are looking is probably bounded, it may not
be worth generalizing this. But I wondered if something like:

  /*
   * Like skip_prefix, but consider any "/" in the prefix as a
   * directory separator for the platform.
   */
  int skip_prefix_fs(const char *str, const char *prefix, const char **out)
  {
	while (1) {
		if (!*prefix) {
			*out = str;
			return 1;
		} else if (*prefix == '/') {
			if (!is_dir_sep(*str))
				return 0;
		} else {
			if (*str != *prefix)
				return 0;
		}
		str++;
		prefix++;
	}
  }

  ...
  /* works on all platforms! */
  if (skip_prefix_fs(foo, "./", &out))
	...

would be helpful. I don't know if there are other opportunities in the
code base that could make use of this. If it's just these two sites,
it's probably not worth it.

-Peff
