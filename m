From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: print progress
Date: Thu, 3 Nov 2011 15:51:47 -0400
Message-ID: <20111103195147.GA21318@sigill.intra.peff.net>
References: <20111103033325.GA10230@sigill.intra.peff.net>
 <1320310234-11243-1-git-send-email-pclouds@gmail.com>
 <20111103193826.GB19483@sigill.intra.peff.net>
 <7vd3d9f0u8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 20:51:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM3KP-0000RJ-45
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 20:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865Ab1KCTvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 15:51:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32991
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab1KCTvv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 15:51:51 -0400
Received: (qmail 27646 invoked by uid 107); 3 Nov 2011 19:57:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Nov 2011 15:57:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2011 15:51:47 -0400
Content-Disposition: inline
In-Reply-To: <7vd3d9f0u8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184744>

On Thu, Nov 03, 2011 at 12:43:59PM -0700, Junio C Hamano wrote:

> > But I almost wonder if it is worth factoring out the concept of a
> > "progress group", where you would call it like:
> >
> >   progress = progress_group_start("Checking objects in pack", nr_packs);
> >   for (p = packed_git; p; p = p->next) {
> >           progress_group_next(progress, p->num_objects);
> >           for (j = 0; j < num; j++) {
> >                   fsck_sha1(p, j);
> >                   display_progress(progress, j+1);
> >           }
> >   }
> >   stop_progress(&progress);
> 
> Hmm, once you do this kind of thing I would expect two (or more) progress
> bars to be shown, something like:
> 
> 	$ git fsck --progress
> 	checking packs: 3 of 7 (42% done)
>         checking objects in pack: 12405 of 332340 (4% done)

I don't think we can do multiple lines portably, though, because the
progress code just uses "\r" to return to the beginning of the line.

However, I do think it's a nice design even if the output is the same
right now, because the calling code is specifying more clearly to the
progress code what it actually means. Which means it is easier to
tweak the progress code later to make a prettier representation of that
meaning.

One downside (as with all abstractions :) ), is that it's hard to
deviate from the defaults. With the above, how would you specify if it
was a group of throughput measurements, not counts? Or that you wanted
to use start_progress_delay instead of start_progress on each one?

Or hey, if you really want to get crazy, why can't we check each pack in
parallel on a different CPU, and have all of the progress meters
displayed and moving simultaneously? :)

The last one is obviously a bit tongue in cheek. But it does raise an
interesting point: is seeing the per-pack meter actually useful (whether
parallel or not)? The user just wants to know that progress is being
made, and when it is done. And maybe that argues for just summing the
size of each pack and showing a single progress meter per task.

-Peff
