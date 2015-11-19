From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] ident.c: add support for IPv6
Date: Thu, 19 Nov 2015 09:46:32 -0500
Message-ID: <20151119144632.GD9353@sigill.intra.peff.net>
References: <1447941260-5395-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 15:46:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzQTw-0006HD-Bg
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 15:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758677AbbKSOqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 09:46:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:59736 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758665AbbKSOqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 09:46:35 -0500
Received: (qmail 18570 invoked by uid 102); 19 Nov 2015 14:46:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 08:46:35 -0600
Received: (qmail 17139 invoked by uid 107); 19 Nov 2015 14:47:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 09:47:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Nov 2015 09:46:32 -0500
Content-Disposition: inline
In-Reply-To: <1447941260-5395-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281479>

On Thu, Nov 19, 2015 at 02:54:20PM +0100, Elia Pinto wrote:

> Add IPv6 support by implementing name resolution with the
> protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
> code is still available when git is compiled with NO_IPV6.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> Helped-by: Jeff King <peff@peff.net> 
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> This is the second version of the patch ($gmane/280488)
> Changes from previous:
> 
> - Simplified the implementation, avoiding the duplication of 
> the function add_domainname (Jeff King) ($gmane/280512)
> 
> - Fixed a possible memory leak with getaddrinfo (Eric Sunshine)
>   ($gmane/280507)

Thanks, this looks much nicer than the last round. I still have a few
comments:

> diff --git a/ident.c b/ident.c
> index 5ff1aad..283e83f 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -73,7 +73,12 @@ static int add_mailname_host(struct strbuf *buf)
>  static void add_domainname(struct strbuf *out)
>  {
>  	char buf[1024];
> +#ifndef NO_IPV6
> +	struct addrinfo hints, *ai;
> +	int gai;
> +#else
>  	struct hostent *he;
> +#endif /* NO_IPV6 */

Can we bump these declarations closer to the point of use? I think that
makes it easier to read, as the matching bits are all together.

So this:

> +	else	{
> +#ifndef NO_IPV6
> +		memset (&hints, '\0', sizeof (hints));
> +		hints.ai_flags = AI_CANONNAME;
> +		if (!(gai = getaddrinfo(buf, NULL, &hints, &ai)) && ai && strchr(ai->ai_canonname, '.')) 
> +			strbuf_addstr(out, ai->ai_canonname);
> +#else
> +		if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
> +			strbuf_addstr(out, he->h_name);
> +#endif /* NO_IPV6 */

becomes:

      else {
  #ifndef NO_IPV6
	struct addrinfo hints, *ai;
	int gai;
	if (!(gai = getaddrinfo()...))
  #else
	struct hostent *he;
	if ((he = gethostbyname()....))
  #endif

> +		else
> +			strbuf_addf(out, "%s.(none)", buf);

This depends on both sides of the #if ending with a hanging "if" clause.
I guess that's OK in such a small function, but I do still wonder if we
can have a helper like:

  static void canonical_name(const char *host, struct strbuf *out)
  {
  #ifndef NO_IPV6
	struct addrinfo hints, *ai;
	int gai = getaddrinfo(host, NULL, &hints, &ai);
	if (!gai && ai && strchr(ai->ai_canonname, '.')) {
		strbuf_addstr(out, ai->ai_canonname);
		freeaddrinfo(ai);
	}
  #else
	struct hostent *he = gethostbyname(buf);
	if (he && strchr(he->h_name, '.'))
		strbuf_addstr(out, he->h_name);
  }

  ...
  canonical_name(buf, out);
  if (!out.len)
	strbuf_addf(out, "%s.(none)", buf);

(or possibly have an integer return value from canonical_name instead of
checking the strbuf length).

> +#ifndef NO_IPV6
> +		if (gai) freeaddrinfo(ai);
> +#endif /* NO_IPV6 */

Should this be "if (!gai)"?

-Peff
