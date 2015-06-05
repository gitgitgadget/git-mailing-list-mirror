From: Jeff King <peff@peff.net>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Fri, 5 Jun 2015 08:18:17 -0400
Message-ID: <20150605121817.GA22125@peff.net>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net>
 <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C55197764FE@C111KXTEMBX51.ERF.thomson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pclouds@gmail.com, git@vger.kernel.org
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Fri Jun 05 14:18:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0qZu-0006xc-Tl
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 14:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbbFEMSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 08:18:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:41588 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751240AbbFEMSU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 08:18:20 -0400
Received: (qmail 30782 invoked by uid 102); 5 Jun 2015 12:18:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 07:18:19 -0500
Received: (qmail 8557 invoked by uid 107); 5 Jun 2015 12:18:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 08:18:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jun 2015 08:18:17 -0400
Content-Disposition: inline
In-Reply-To: <7FAE15F0A93C0144AD8B5FBD584E1C55197764FE@C111KXTEMBX51.ERF.thomson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270828>

On Fri, Jun 05, 2015 at 12:01:16PM +0000, steve.norman@thomsonreuters.com wrote:

> On Sunday, May 24, 2015 @ 10:01 AM Duy Nguyen [mailto:pclouds@gmail.com] did scribble:
> 
> > In case you want to back away from option 2 because it starts to leak
> > raciness, which your old commit tried to fix in the first place. I
> > think the only other place that tests for lots of non-existent loose
> > objects is write_sha1_file (e.g. "tar -xf bigtarball.tar.gz; cd
> > bigtarball; git init; git add ."). But the number of calls should be
> > much smaller compared to index-pack and it does not use has_sha1_file,
> > it uses check_and_freshen_file() instead.
> > 
> > There are other places where has_sha1_file() may return 0, but I think
> > the number of calls is even smaller to bother (shallow.c,
> > fetch-pack.c, apply.c, buik-checkin.c)
> 
> Any updates / further thoughts on this?

Sorry, I haven't had a chance to look at it further. It still on my todo
list. My plan is:

  1. Devise some torture to tests to see whether my patch series is in
     fact racy on Linux.

  2. Assuming it is, scrap it and make a has_sha1_file_quick() which
     might sometimes return a false negative (if somebody else is
     repacking). Use that in index-pack (and possibly other places, but
     we can start with index-pack).

If we skip step 1 out of pessimism (which I think is a reasonable thing
to do), then step 2 should not be all that much work. I'm going to be
offline for a few days, though, so I won't get to it until next week at
the earliest. If you (or someone else) wants to take a stab at it,
please feel free.

-Peff
