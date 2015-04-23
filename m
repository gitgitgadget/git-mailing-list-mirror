From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] connect: improve check for plink to reduce false
 positives
Date: Thu, 23 Apr 2015 11:53:04 -0400
Message-ID: <20150423155304.GA26018@peff.net>
References: <20150422232306.GA32705@peff.net>
 <1429747595-298095-1-git-send-email-sandals@crustytoothpaste.net>
 <1429747595-298095-2-git-send-email-sandals@crustytoothpaste.net>
 <b6b4da1f7735b834043375e3d8eaa331@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 23 17:53:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlJRL-00010W-5I
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 17:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbbDWPxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 11:53:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:49241 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965475AbbDWPxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 11:53:07 -0400
Received: (qmail 24569 invoked by uid 102); 23 Apr 2015 15:53:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 10:53:06 -0500
Received: (qmail 6446 invoked by uid 107); 23 Apr 2015 15:53:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 11:53:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2015 11:53:04 -0400
Content-Disposition: inline
In-Reply-To: <b6b4da1f7735b834043375e3d8eaa331@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267694>

On Thu, Apr 23, 2015 at 08:50:17AM +0200, Johannes Schindelin wrote:

> > +				tortoiseplink = tplink == ssh ||
> > +					(tplink && is_dir_sep(tplink[-1]));
> 
> Maybe have a helper function here? Something like
> `basename_matches(const char *path, const char *basename, int
> ignore_case)`? That would be easier to read (I have to admit that I
> had to wrap my head around the logic to ensure that tplink[-1] is
> valid; It is, but it requires more brain cycles to verify than I would
> like).

Yeah, I had a similar thought when reading the patch.

> Also, I am really hesitant to just test the start of the basename; I
> would rather have an entire basename match so that something  like
> "PLinKoeln" would not match. (And of course, for Windows I would want
> that hypothetical `basename_matches()` function to allow basenames to
> end in `.exe` automatically).

What about "plink-0.83" that was mentioned earlier in the thread? I
think that is the reason brian's patch stuck to matching the start and
not the end. But I have no idea if that is actually a real thing, or
just a hypothetical.

If I were writing from scratch, I would probably keep things as tight as
possible, like:

  const char *base = basename(ssh);
  plink = !strcasecmp(base, "plink") ||
          !strcasecmp(base, "plink.exe");
  tplink = !strcasecmp(base, "tortoiseplink") ||
           !strcasecmp(base, "tortoiseplink.exe"));

but maybe that is too tight at this point in time; we don't really know
what's out there and working (or maybe _we_ do, but _I_ do not :) ).

At any rate, brian's patch only looks for a dir-separator anywhere, not
the actual basename. So:

  /path/to/plink/ssh

would match, and I'm not sure if that's a good thing or not. So yet
another variant is to use basename(), and then just check that the
basename starts with "plink" (to catch "plink.exe", "plink-0.83", etc).
That avoids cruft in the intermediate path, and unless your actual
binary is named PlinKoeln, it will not false positive on the example you
gave.

-Peff
