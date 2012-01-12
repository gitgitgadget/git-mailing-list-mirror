From: Jeff King <peff@peff.net>
Subject: Re: thin packs ending up fat
Date: Thu, 12 Jan 2012 17:32:34 -0500
Message-ID: <20120112223234.GA4949@sigill.intra.peff.net>
References: <20120112221523.GA3663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 23:32:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlTCM-0004oC-Nn
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 23:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab2ALWci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 17:32:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36348
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab2ALWch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 17:32:37 -0500
Received: (qmail 4842 invoked by uid 107); 12 Jan 2012 22:39:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jan 2012 17:39:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jan 2012 17:32:34 -0500
Content-Disposition: inline
In-Reply-To: <20120112221523.GA3663@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188487>

On Thu, Jan 12, 2012 at 05:15:23PM -0500, Jeff King wrote:

> It turns out that when packing a subset of a fully packed repo (as we do
> for a bundle or for a fetch), we tend not to make thin packs at all.
> The culprit is this logic in try_delta:
> 
>         /*
>          * We do not bother to try a delta that we discarded
>          * on an earlier try, but only when reusing delta data.
>          */
>         if (reuse_delta && trg_entry->in_pack &&
>             trg_entry->in_pack == src_entry->in_pack &&
>             trg_entry->in_pack_type != OBJ_REF_DELTA &&
>             trg_entry->in_pack_type != OBJ_OFS_DELTA)
>                 return 0;
> [...]
> Maybe it is enough to simply turn off this optimization if the potential
> delta source is not being included in the pack (i.e., we are using
> --thin and it is a boundary object). Because if both objects are being
> sent, we will just end up reusing the delta that goes in the reverse
> direction anyway.

Hmm. It turns out this is really easy, because we have already marked
such objects as preferred bases.

So with this patch:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 96c1680..d05e228 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1439,6 +1439,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	 */
 	if (reuse_delta && trg_entry->in_pack &&
 	    trg_entry->in_pack == src_entry->in_pack &&
+	    !src_entry->preferred_base &&
 	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
 	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
 		return 0;

here are the numbers I get:

                  dataset
            | fetches | tags
---------------------------------
     before | 53358   | 2750977
size  after | 32398   | 2668479
     change |   -39%  |      -3%
---------------------------------
     before |  0.18   | 1.12
CPU   after |  0.18   | 1.15
     change |    +0%  |      +3%

So nearly all of the size benefit, but very little CPU change (even the
3% on the larger-pack case is close to the levels of run-to-run noise).
Obviously the size benefit in the larger-pack case isn't impressive, but
I think the "fetches" case is much more indicative of a real server
load.

-Peff
