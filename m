From: Jeff King <peff@peff.net>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Wed, 27 Jul 2011 02:03:04 -0600
Message-ID: <20110727080303.GA8105@sigill.intra.peff.net>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net>
 <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
 <20110726051411.GB25046@sigill.intra.peff.net>
 <CACsJy8Ay1wPXAx61_rGymHDJ=YGywAy=9epiXRfJ9e68np8x6g@mail.gmail.com>
 <20110726060903.GA29486@sigill.intra.peff.net>
 <CACsJy8Birqg2Ldp1Mt4NWOq1aT0oigTcFA8S=RWcK5y+zstwDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 10:03:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlz5I-0004bL-Qy
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 10:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab1G0IDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 04:03:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42537
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615Ab1G0IDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 04:03:08 -0400
Received: (qmail 28299 invoked by uid 107); 27 Jul 2011 08:03:38 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jul 2011 04:03:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2011 02:03:04 -0600
Content-Disposition: inline
In-Reply-To: <CACsJy8Birqg2Ldp1Mt4NWOq1aT0oigTcFA8S=RWcK5y+zstwDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177938>

On Tue, Jul 26, 2011 at 07:44:06PM +0700, Nguyen Thai Ngoc Duy wrote:

> > I don't think there's a way to do --no-match style negation in the
> > regex itself, though.
> 
> Your coding skills are needed :)

OK. Patches to follow. :)

> Speaking of names, I'm usually bad at naming, but here goes. How about
> --hunks=regex, --no-hunks=regex and --split-hunks? We may have
> --[no-]case-hunks later on but that does sound bad.
> 
> <over-engineering>maybe we should support multiple --hunks (or
> --no-hunks, but not a mix of them), all must be matched, because there
> are many lines in a hunk and people may want set patterns across
> lines</over-engineering>

My series lets you do multiple --hunks, and a hunk just needs to match
any of them.

Having "--no-hunks" implies that you can negate just some of the
filters. Like:

  git add -p --hunks=foo --no-hunks=bar

My series doesn't support that, though it would not be that big a deal
to do so (the tricky part is defining the OR-ing and AND-ing sensibly).
Something like:

  git add -p --negate-hunks --hunks=foo --hunks=bar

makes it clear that you are either selecting or de-selecting with your
filter.

Technically somebody could also want:

  git add -p --hunk=foo --and --hunk=bar

but I didn't want to get into parsing arbitrary boolean expressions.

An easy flexible thing would be to just eval perl code like:

  git add -p --hunk-filter='/foo/ && !/bar/'

but I don't think we want to tie ourselves to the implementation being
in perl forever.

Anyway, the series is:

  [1/5]: add--interactive: refactor patch mode argument processing
  [2/5]: add--interactive: factor out regex error handling
  [3/5]: add--interactive: allow hunk filtering on command line
  [4/5]: add--interactive: allow negatation of hunk filters
  [5/5]: add--interactive: add option to autosplit hunks

Lightly tested by me. You can either build on top, or just squash them
into your commits as appropriate.

-Peff
