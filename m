From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Tue, 19 Jan 2016 20:53:10 -0500
Message-ID: <20160120015310.GB24541@sigill.intra.peff.net>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
 <20160119191234.GA17562@sigill.intra.peff.net>
 <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
 <20160120002606.GA9359@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, larsxschneider@gmail.com,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:53:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLhxa-0004tK-IW
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 02:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934313AbcATBxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 20:53:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:56642 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932981AbcATBxM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 20:53:12 -0500
Received: (qmail 28264 invoked by uid 102); 20 Jan 2016 01:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 20:53:12 -0500
Received: (qmail 28878 invoked by uid 107); 20 Jan 2016 01:53:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 20:53:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 20:53:10 -0500
Content-Disposition: inline
In-Reply-To: <20160120002606.GA9359@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284411>

On Wed, Jan 20, 2016 at 09:26:06AM +0900, Mike Hommey wrote:

> Having recently looked into this, the relevant travis-ci documentation
> is:
> https://docs.travis-ci.com/user/ci-environment/
> 
> which says all environments have 2 cores, so you won't get much from
> anything higher than -j3.

FWIW, I settled on "-j16" on my 8-core (well, hyperthreaded quad-core)
machine after experimenting. That's running the tests on a RAM-disk,
though. On a slower filesystem where fsync() actually does something,
you're going to get a lot more I/O stalls, and want a bigger CPU to
process multiplier.

Here are actual numbers from my machine:

  -j | time (user+sys)
  ---+------------------
   1 | 5m18s (41s+17s)
   2 | 2m24s (41s+14s)
   4 | 1m15s (46s+13s)
   8 | 0m56s (65s+18s)
  16 | 0m53s (76s+24s)
  32 | 0m57s (78s+25s)

Note that the CPU-second times will go up with more threads because of
the frequency scaling.

So yeah, -j3 might not be that unreasonable, depending on the filesystem
response times.

> The https://docs.travis-ci.com/user/ci-environment/ document says the
> default is "sudo: false" for repositories enabled in 2015 or later, which
> I assume is the case for the git repository. "sudo: required" is the
> default for repositories enabled before 2015.

Thanks. The document I saw used the word "recognized", and I didn't
quite know what they meant. We just enabled this a month or two ago, so
we should be running on the new format.

-Peff
