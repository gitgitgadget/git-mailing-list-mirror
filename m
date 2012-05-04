From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] http: try http_proxy env var when http.proxy config
 option is not set
Date: Fri, 4 May 2012 03:08:02 -0400
Message-ID: <20120504070802.GA21895@sigill.intra.peff.net>
References: <4FA2B4D3.90809@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 04 09:08:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQCcf-0005bw-UX
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab2EDHIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:08:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57591
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab2EDHIG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 03:08:06 -0400
Received: (qmail 15959 invoked by uid 107); 4 May 2012 07:08:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 03:08:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 03:08:02 -0400
Content-Disposition: inline
In-Reply-To: <4FA2B4D3.90809@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196996>

On Thu, May 03, 2012 at 06:39:47PM +0200, Nelson Benitez Leon wrote:

> +static const char *read_prot_proxy_env(const char *protocol)
> +{
> +	const char *env_proxy;
> +	struct strbuf var = STRBUF_INIT;
> +
> +	strbuf_addf(&var, "%s_proxy", protocol);
> +	env_proxy = getenv(var.buf);
> +	if (!env_proxy && strcmp("http_proxy", var.buf)) {
> +		char *p;
> +		for (p = var.buf; *p; p++)
> +			*p = toupper(*p);
> +		env_proxy = getenv(var.buf);
> +	}
> +	strbuf_release(&var);
> +	
> +	return env_proxy;
> +}

Thanks, this is way more readable than the previous iteration.

> +static int host_allowed_by_noproxy_env (const char *host)
> +{
> +	const char *no_proxy = getenv("no_proxy");
> +	if (!no_proxy)
> +		no_proxy = getenv("NO_PROXY");
> +	if (!no_proxy ||
> +	    (strcmp("*", no_proxy) &&
> +	     !strstr(no_proxy, host)))
> +		return 1;
> +	
> +	return 0;
> +}

This simplified parsing misses a lot of corner cases. Three I can see
right off the bat:

  1. If your NO_PROXY is "no-proxy.com", and your host is
     "proxy.com", your code will consider that a match, but curl does
     not.

  2. If your NO_PROXY contains "no-proxy.com", but your host is
     "www.no-proxy.com", curl will consider that a match, but your code
     does not.

  3. If your NO_PROXY contains "no-proxy.com", but your host is
     "no-proxy.com:80", curl will consider that a match, but your code
     does not.

I don't see any way around it besides implementing curl's full
tokenizing and matching algorithm, which is about a page of code. I'd
really prefer not to re-implement bits of curl (especially because they
may change later), but AFAIK there is no way to ask curl "is there a
proxy configured, and if so, what is it?".

The rest of this patch looks OK to me, though.

-Peff
