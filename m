From: Jeff King <peff@peff.net>
Subject: Re: Why does send-pack call pack-objects for all remote refs?
Date: Mon, 14 Dec 2015 16:04:29 -0500
Message-ID: <20151214210429.GC14788@sigill.intra.peff.net>
References: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com>
 <20151207225714.GA3785@sigill.intra.peff.net>
 <8712f730fb4c414ebc2b1168ca7948b8@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <20151210041941.GA4056@sigill.intra.peff.net>
 <d0a39b03e49d41e685cf61398c0d1102@EXCHANGE2U.uunet.arlington.PredictiveTechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Nasser Grainawi <nasser@codeaurora.org>
To: Daniel Koverman <dkoverman@predictiveTechnologies.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:14:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8aS1-00088Y-AF
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbbLNVEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:04:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:41494 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932148AbbLNVEc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:04:32 -0500
Received: (qmail 17903 invoked by uid 102); 14 Dec 2015 21:04:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 15:04:32 -0600
Received: (qmail 31621 invoked by uid 107); 14 Dec 2015 21:04:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 16:04:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 16:04:29 -0500
Content-Disposition: inline
In-Reply-To: <d0a39b03e49d41e685cf61398c0d1102@EXCHANGE2U.uunet.arlington.PredictiveTechnologies.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282418>

On Mon, Dec 14, 2015 at 01:47:39PM +0000, Daniel Koverman wrote:

> > You might also try repacking with "git repack -adb", which will
> > build reachability bitmaps. Pack-objects can use them to compute
> > the set of required objects much faster.
> 
> Running "git repack -adb" caused my push time to incease by about 5x.
> I made some fresh clones and tried other options with repack, and
> consistently anything I tried with -b caused the push time to
> increase about 5x.
> 
> I don't know much about reachability bitmaps, but perhaps it is
> important to note that I timed the pushes after repacking on Git for
> Windows. My earlier timings were done on both Linux and Windows and I
> did not see a significant difference.

Hmm. I guess that makes sense. The bitmap we want is the set difference
between the objects we are sending, and the tips the other side has. If
we have a bitmap at each ref tip, that's very fast. But if you have a
very large number of refs, we don't make one for each ref, and it has to
fallback to walking to the nearest one (and it ends up worse than a
regular walk, because it's filling in the bitmap for each tree, rather
than just doing the "good enough" commit walk that we usually do).

I suspect there's room for improvement in the way we select commits to
store bitmaps for (so that the average walk is smaller). But it's rather
tricky; there's not a single constant to change to make it work better.

Thanks for trying out my suggestion.

-Peff
