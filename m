From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] read_loose_refs(): treat NULL_SHA1 loose
 references as broken
Date: Wed, 3 Jun 2015 10:08:04 -0400
Message-ID: <20150603140803.GA23901@peff.net>
References: <cover.1433339279.git.mhagger@alum.mit.edu>
 <eb79f7d96ec74445f7adf62757119273280e09c9.1433339279.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 03 16:08:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z09L2-0000C6-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 16:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbbFCOII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 10:08:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:40426 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755206AbbFCOIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 10:08:06 -0400
Received: (qmail 30011 invoked by uid 102); 3 Jun 2015 14:08:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 09:08:06 -0500
Received: (qmail 20256 invoked by uid 107); 3 Jun 2015 14:08:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 10:08:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 10:08:04 -0400
Content-Disposition: inline
In-Reply-To: <eb79f7d96ec74445f7adf62757119273280e09c9.1433339279.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270688>

On Wed, Jun 03, 2015 at 03:51:59PM +0200, Michael Haggerty wrote:

> NULL_SHA1 is used to indicate of "invalid SHA-1" throughout our code

s/of/an/ ?

> (and the code of other git implementations), so it is vastly more
> likely that a reference was set to this value due to a software bug
> than that NULL_SHA1 is the legitimate SHA-1 of an actual object.
> Therefore, if a loose reference has the value NULL_SHA1, consider it
> to be broken.
> 
> Amusingly, each of the other 2^160-1 possible SHA-1 values is exactly
> as unlikely as NULL_SHA1 to be the SHA-1 of an actual object. The
> difference is that most of those other values are also very unlikely
> to be written to a loose reference file by accident, whereas
> accidentally writing NULL_SHA1 to a loose reference file would be an
> easy mistake to make.

FWIW, I think this justification (and the comment below) reads better
than what you had before.

> diff --git a/refs.c b/refs.c
> index 6736424..83af13d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1324,6 +1324,16 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
>  			if (!read_ok) {
>  				hashclr(sha1);
>  				flag |= REF_ISBROKEN;
> +			} else if (is_null_sha1(sha1)) {
> +				/*
> +				 * It is so astronomically unlikely
> +				 * that NULL_SHA1 is the SHA-1 of an
> +				 * actual object that we consider its
> +				 * appearance in a loose reference
> +				 * file to be repo corruption
> +				 * (probably due to a software bug).
> +				 */
> +				flag |= REF_ISBROKEN;

Nice. After reading the other thread, I did not think we needed to
bother with more refactoring here, but I agree this end result flows
nicely.

-Peff
