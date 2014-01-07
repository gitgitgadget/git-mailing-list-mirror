From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Tue, 7 Jan 2014 12:26:44 -0500
Message-ID: <20140107172644.GA19051@sigill.intra.peff.net>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
 <20140106145723.GA15489@sigill.intra.peff.net>
 <5CDDBDF2D36D9F43B9F5E99003F6A0D4466883DF@PRN-MBX02-1.TheFacebook.com>
 <20140106215713.GA7133@sigill.intra.peff.net>
 <5CDDBDF2D36D9F43B9F5E99003F6A0D4466885EE@PRN-MBX02-1.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ben Maurer <bmaurer@fb.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:26:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0aQU-0005Wp-HX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbaAGR0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:26:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:56553 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752220AbaAGR0q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:26:46 -0500
Received: (qmail 11879 invoked by uid 102); 7 Jan 2014 17:26:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 11:26:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 12:26:44 -0500
Content-Disposition: inline
In-Reply-To: <5CDDBDF2D36D9F43B9F5E99003F6A0D4466885EE@PRN-MBX02-1.TheFacebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240113>

On Mon, Jan 06, 2014 at 10:14:30PM +0000, Ben Maurer wrote:

> It looks like for my repo the size win wasn't as big (~10%). Is it
> possible that with the kernel test you got extremely lucky and there
> was some huge binary blob that thin packing turned into a tiny delta?

I don't think so. When I look at the reused-delta numbers, I see that we
reused ~3000 extra deltas (and the "compressing" progress meter drops by
the same amount. If I do a full clone (or just index-pack the result),
it claims ~3000 thin objects completed with local objects (versus 0 in
the normal case).

So I think we really are getting a lot of little savings adding up,
which makes sense. If there were thousands of changed files, a non-thin
pack has to have at least _one_ full version of each file. With thin
packs, we might literally have only deltas.

It was a 7-week period, which might make more difference. I'm going to
run some experiments with different time periods to see if that changes
anything.

It might also be the repo contents. I'm going to try my experiments on a
few different repositories. It may be that either the kernel or your
repo is unusual in some way.

Or maybe I was just lucky. :)

> When you get a chance, it'd be handy if you could push an updated
> version of your change out to your public github repo. I'd like to see
> if folks here are interested in testing this more, and it'd be good to
> make sure we're testing the diff that is targeted for upstream.

I've pushed it to:

  git://github.com/peff/git.git jk/bitmap-reuse-delta

I'll continue to rebase it forward as time goes on (until a cleaned-up
version gets merged upstream), but the tip of that branch should always
be in a working state.

-Peff
