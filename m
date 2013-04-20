From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] grep: allow to use textconv filters
Date: Sat, 20 Apr 2013 00:31:22 -0400
Message-ID: <20130420043122.GF24970@sigill.intra.peff.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
 <2e4b789c1578660b8b62eabd9e0418a3edbc8f6a.1366389739.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 06:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTPSX-0000iU-8u
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 06:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab3DTEb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 00:31:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:44597 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab3DTEb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 00:31:26 -0400
Received: (qmail 8237 invoked by uid 102); 20 Apr 2013 04:31:30 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 23:31:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Apr 2013 00:31:22 -0400
Content-Disposition: inline
In-Reply-To: <2e4b789c1578660b8b62eabd9e0418a3edbc8f6a.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221837>

On Fri, Apr 19, 2013 at 06:44:48PM +0200, Michael J Gruber wrote:

> From: Jeff King <peff@peff.net>
> 
> Recently and not so recently, we made sure that log/grep type operations
> use textconv filters when a userfacing diff would do the same:
> 
> ef90ab6 (pickaxe: use textconv for -S counting, 2012-10-28)
> b1c2f57 (diff_grep: use textconv buffers for add/deleted files, 2012-10-28)
> 0508fe5 (combine-diff: respect textconv attributes, 2011-05-23)
> 
> "git grep" currently does not use textconv filters at all, that is
> neither for displaying the match and context nor for the actual grepping.
> 
> Introduce an option "--textconv" which makes git grep use any configured
> textconv filters for grepping and output purposes. It is off by default.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/grep.c         |   2 +
>  grep.c                 | 100 ++++++++++++++++++++++++++++++++++++++++++-------
>  grep.h                 |   1 +
>  t/t7008-grep-binary.sh |  18 +++++++++
>  4 files changed, 107 insertions(+), 14 deletions(-)

This patch, of course, is flawless. :)

Feel free to add:

  Signed-off-by: Jeff King <peff@peff.net>

> +	/*
> +	 * We know the result of a textconv is text, so we only have to care
> +	 * about binary handling if we are not using it.
> +	 */
> +	if (!textconv) {
> +		switch (opt->binary) {
> +		case GREP_BINARY_DEFAULT:
> +			if (grep_source_is_binary(gs))
> +				binary_match_only = 1;
> +			break;
> +		case GREP_BINARY_NOMATCH:
> +			if (grep_source_is_binary(gs))
> +				return 0; /* Assume unmatch */
> +			break;
> +		case GREP_BINARY_TEXT:
> +			break;
> +		default:
> +			die("bug: unknown binary handling mode");
> +		}
>  	}

Junio mentioned checking the textconv output for binary-ness. Doing that
would involve removing the outer conditional here. But it's not quite so
simple, as we don't load the textconv results until later, and
grep_source_is_binary will lazily load the contents. I think it would be
sufficient to fill_textconv_grep() right before, and then
grep_source_is_binary would rely on the cached buffer.

-Peff
