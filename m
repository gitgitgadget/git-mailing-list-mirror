From: Jeff King <peff@github.com>
Subject: [RFC/PATCH 0/7] user-configurable git-archive output formats
Date: Wed, 15 Jun 2011 18:30:30 -0400
Message-ID: <20110615223030.GA16110@sigill.intra.peff.net>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
 <4DF7B90B.9050802@lsrfire.ath.cx>
 <20110614201433.GB1567@sigill.intra.peff.net>
 <20110614204521.GA12776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:30:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWybe-0006Yp-91
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab1FOWad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 18:30:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55152
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab1FOWac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:30:32 -0400
Received: (qmail 7335 invoked by uid 107); 15 Jun 2011 22:30:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 18:30:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 18:30:30 -0400
Content-Disposition: inline
In-Reply-To: <20110614204521.GA12776@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175856>

On Tue, Jun 14, 2011 at 04:45:21PM -0400, Jeff King wrote:

> The gzip path is not configurable at all. Probably it should read the
> path and arguments from the config file. In fact, we could even allow
> arbitrary config like:
> 
>   [tarfilter "tgz"]
>     command = gzip -c
>     extension = tgz
>     extension = tar.gz

Here's a series implementing that. You can configure whatever you want,
and it includes builtin gzip configuration by default. You can override
to turn it off, or even switch it to run something like pigz instead.

My biggest reservation with the patches as-is is that they are very
tar-centric and not orthogonal. Specifically, they won't handle:

  1. Other streamable archive formats you would want to pipe through
     compressors. Do any of these actually exist? I guess we could offer
     "pax" as a format eventually, and it might be like tar with
     different defaults? I dunno.

     Fixing this would not be too hard. Instead of these being
     "tarfilters", they would be "archive filters", and they would chain
     to some format, defaulting to "tar".  Since there is no other
     format right now, we could even punt on writing most of the code
     until somebody adds one. But we would want to get the naming of the
     config options right, since those are user-facing. Maybe
     "archivefilter" (unfortunately the more readable archive.filter is
     a little awkward with the way we parse config files)?

  2. In theory you might want to plug in external helpers that are not
     just stream filters, but actually their own container formats (like
     zip). I think people who want 7zip would want this.

     But how does git-archive interact with the helper? By definition
     the data it wants is the set of files, not a single stream. So
     either:

       a. We give the helper a temporary exported checkout, and it
          generates the stream from that.

       b. We use tar as the lingua franca of streaming file containers,
          and let the helper deal with converting to its preferred
          output format.

      Option (a) seems horribly inefficient on disk I/O. And if we did
      want to do that, I think it's largely unrelated to this patch
      series.

      You can actually do option (b) with this series. In its worst
      case, you can do the same as (a): just untar into a temporary
      directory and compress from there. But a well-written helper could
      convert tar into the output format on the fly.

The patches are:

  [1/7]: archive: reorder option parsing and config reading
  [2/7]: archive: add user-configurable tar-filter infrastructure
  [3/7]: archive: support user tar-filters via --format
  [4/7]: archive: advertise user tar-filters in --list
  [5/7]: archive: refactor format-guessing from filename
  [6/7]: archive: match extensions from user-configured formats
  [7/7]: archive: provide builtin .tar.gz filter

-Peff
