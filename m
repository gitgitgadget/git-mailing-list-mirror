From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] replace: parse revision argument for -d
Date: Fri, 9 Nov 2012 11:48:08 -0500
Message-ID: <20121109164808.GE19725@sigill.intra.peff.net>
References: <508E55B2.6060502@drmicha.warpmail.net>
 <24b0f81315ddab8cc37133d5b3bec8aec90ed652.1351516888.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:48:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWrkr-0004H8-BK
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 17:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab2KIQsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 11:48:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40173 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754661Ab2KIQsN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 11:48:13 -0500
Received: (qmail 8389 invoked by uid 107); 9 Nov 2012 16:49:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 11:49:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 11:48:08 -0500
Content-Disposition: inline
In-Reply-To: <24b0f81315ddab8cc37133d5b3bec8aec90ed652.1351516888.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209232>

On Mon, Oct 29, 2012 at 02:23:27PM +0100, Michael J Gruber wrote:

> 'git replace' parses the revision arguments when it creates replacements
> (so that a sha1 can be abbreviated, e.g.) but not when deleting
> replacements.
> 
> Make it parse the arguments to 'replace -d' in the same way.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> v2 has the simplified error check as per Jeff, and a reworded message.
> Comes with a free test case, too.

I noticed this today in my pile of "to look at" patches. Sorry for being
slow.

>  	for (p = argv; *p; p++) {
> -		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
> -					>= sizeof(ref)) {
> -			error("replace ref name too long: %.*s...", 50, *p);
> +		q = *p;
> +		if (get_sha1(q, sha1)) {
> +			error("Failed to resolve '%s' as a valid ref.", q);
>  			had_error = 1;
>  			continue;
>  		}

Looks reasonable.

> +		q = sha1_to_hex(sha1);
> +		snprintf(ref, sizeof(ref), "refs/replace/%s", q);
>  		if (read_ref(ref, sha1)) {
> -			error("replace ref '%s' not found.", *p);
> +			error("replace ref '%s' not found.", q);

I worry a little about assuming that "q", which points to a static
internal buffer of sha1_to_hex, is still valid after calling read_ref.
We'll end up in resolve_ref, which might need to do considerable work
(e.g., loading the whole packed refs file). Just grepping for
sha1_to_hex, I don't think it is a problem currently, but it might be
worth copying the value (you could even point into the "ref" buffer to
avoid dealing with an extra allocation).

Other than that, it looks good to me.

-Peff
