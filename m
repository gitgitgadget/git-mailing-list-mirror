From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: print progress
Date: Wed, 2 Nov 2011 23:33:25 -0400
Message-ID: <20111103033325.GA10230@sigill.intra.peff.net>
References: <CACsJy8DN74QWYA_NzBCGgp_VdQpV5PqGMgAFUKYbOecVqw6HYQ@mail.gmail.com>
 <1320290513-8878-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 04:33:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLo3i-0003FM-Ty
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 04:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab1KCDda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 23:33:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60656
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422Ab1KCDd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 23:33:29 -0400
Received: (qmail 19908 invoked by uid 107); 3 Nov 2011 03:39:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 23:39:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 23:33:25 -0400
Content-Disposition: inline
In-Reply-To: <1320290513-8878-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184702>

On Thu, Nov 03, 2011 at 10:21:53AM +0700, Nguyen Thai Ngoc Duy wrote:

> fsck is usually a long process and it would be nice if it prints
> progress from time to time.

The output looks good to me. Code looks sane overall, with one comment:

> +		for (i = 1, p = packed_git; p; p = p->next, i++) {
> +			if (show_progress) {
> +				char buf[32];
> +				snprintf(buf, sizeof(buf), "Verifying pack %d/%d",
> +					 i, nr_packs);
> +				if (open_pack_index(p))
> +					continue;
> +				progress = start_progress(buf, p->num_objects);
> +			}
>  			/* verify gives error messages itself */
> -			verify_pack(p);
> +			verify_pack(p, progress);
> +
> +			/*
> +			 * we do not stop progress here, let the next
> +			 * progress line overwrite the current one for
> +			 * the next pack.
> +			 */
> +		}
> +		stop_progress(&progress);

We're actually leaking some memory here, since stop_progress will also
free() the progress object and any associated resources. It's not a lot,
but it's kind of ugly.

Perhaps there should be a special version of stop_progress that handles
this better? Or perhaps we could even come up with a total object count
before starting.  I guess it would involve mapping each pack index
simultaneously, though by my reading of the code, I think we do that
anyway (the opened index is cached in the pack object).

-Peff
