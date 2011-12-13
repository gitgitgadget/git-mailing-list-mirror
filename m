From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] fetch-pack: match refs exactly
Date: Mon, 12 Dec 2011 19:54:29 -0500
Message-ID: <20111213005429.GA3812@sigill.intra.peff.net>
References: <20111213003925.GA28403@sigill.intra.peff.net>
 <20111213004808.GC3699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Sawicki <kevin@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 01:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGdg-00073s-Fv
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab1LMAyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:54:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48436
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab1LMAyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:54:31 -0500
Received: (qmail 8462 invoked by uid 107); 13 Dec 2011 01:01:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 20:01:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 19:54:29 -0500
Content-Disposition: inline
In-Reply-To: <20111213004808.GC3699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186994>

On Mon, Dec 12, 2011 at 07:48:08PM -0500, Jeff King wrote:

> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 46688dc..6207ecd 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -556,11 +556,16 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>  			continue;
>  		}
>  		else {
> -			int order = path_match(ref->name, nr_match, match);
> -			if (order) {
> -				return_refs[order-1] = ref;
> -				continue; /* we will link it later */
> +			int i;
> +			for (i = 0; i < nr_match; i++) {
> +				if (!strcmp(ref->name, match[i])) {
> +					match[i][0] = '\0';
> +					return_refs[i] = ref;
> +					break;
> +				}
>  			}
> +			if (i < nr_match)
> +				continue; /* we will link it later */

Astute readers may notice that our matching scheme is now something
like:

  for ref in refs
    for match in matches
      strcmp(ref, match)

If you are fetching everything, that's O(n^2) strcmps (where n is the
number of remote refs). If we sorted the match list (the refs list is
already sorted), we could turn it into an O(n lg n) sort+merge.  This is
an optimization we couldn't do with the old suffix-matching rule.

I doubt it matters in any practical case. Even for our crazy 100K ref
cases at GitHub, we don't tend to actually fetch all of those at one
time. So it is more like O(n * m), where m is probably in the dozens at
most.

-Peff
