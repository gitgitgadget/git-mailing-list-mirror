From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: Make use of the strip_suffix() helper method
Date: Thu, 9 Jul 2015 13:00:54 -0400
Message-ID: <20150709170054.GA15820@peff.net>
References: <0000014e73738297-cce3a38b-a85d-40be-b501-354686c25eee-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 19:01:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDFC3-0001yx-5N
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 19:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbbGIRA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 13:00:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:58160 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751866AbbGIRA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 13:00:57 -0400
Received: (qmail 20025 invoked by uid 102); 9 Jul 2015 17:00:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jul 2015 12:00:57 -0500
Received: (qmail 32427 invoked by uid 107); 9 Jul 2015 17:00:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jul 2015 13:00:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jul 2015 13:00:54 -0400
Content-Disposition: inline
In-Reply-To: <0000014e73738297-cce3a38b-a85d-40be-b501-354686c25eee-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273759>

On Thu, Jul 09, 2015 at 03:33:46PM +0000, Sebastian Schuberth wrote:

> @@ -174,19 +175,17 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
>  	 * Strip .{bundle,git}.
>  	 */
>  	if (is_bundle) {
> -		if (end - start > 7 && !strncmp(end - 7, ".bundle", 7))
> -			end -= 7;
> +		strip_suffix(start, ".bundle", &len);
>  	} else {
> -		if (end - start > 4 && !strncmp(end - 4, ".git", 4))
> -			end -= 4;
> +		strip_suffix(start, ".git", &len);
>  	}

Yay, always glad to see complicated string handling like this go away.
As the resulting conditional blocks are one-liners, I think you can drop
the curly braces, which will match our usual style:

  if (is_bundle)
	strip_suffix(start, ".bundle", &len);
  else
	strip_suffix(start, ".git", &len);

If you wanted to get really fancy, I think you could put a ternary
operator in the middle of the strip_suffix call. That makes it clear
that "len" is set in all code paths, but I think some people find
ternary operators unreadable. :)

>  	if (is_bare) {
>  		struct strbuf result = STRBUF_INIT;
> -		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
> +		strbuf_addf(&result, "%.*s.git", len, start);
>  		dir = strbuf_detach(&result, NULL);

This one can also be simplified using xstrfmt to:

  if (is_bare)
	dir = xstrfmt("%.*s.git", len, start);

Do we still need to cast "len" to an int to use it with "%.*" (it is
defined by the standard as an int, not a size_t)?

-Peff
