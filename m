From: Jeff King <peff@peff.net>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Tue, 18 May 2010 15:19:33 -0400
Message-ID: <20100518191933.GB2383@coredump.intra.peff.net>
References: <4BEAF941.6040609@puckerupgames.com>
 <20100514051049.GF6075@coredump.intra.peff.net>
 <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <4BF2E168.2020706@puckerupgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John <john@puckerupgames.com>
X-From: git-owner@vger.kernel.org Tue May 18 21:19:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OESKM-0003sF-VR
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 21:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757663Ab0ERTTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 15:19:37 -0400
Received: from peff.net ([208.65.91.99]:34422 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab0ERTTh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 15:19:37 -0400
Received: (qmail 19544 invoked by uid 107); 18 May 2010 19:20:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 May 2010 15:20:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 May 2010 15:19:33 -0400
Content-Disposition: inline
In-Reply-To: <4BF2E168.2020706@puckerupgames.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147299>

On Tue, May 18, 2010 at 02:50:16PM -0400, John wrote:

> I just compiled the latest git. It got worse!!

I think Sverre is right that this is simply that --aggressive got more
so in the last few versions. But do note that aggressive implies that we
should pack from scratch, not reusing previously found deltas (or
accepting that we didn't find deltas previously).

So you might want "git gc --aggressive" the _first_ time you pack, or
possibly even very occasionally. But if you are packing every day, you
should just use "git gc", which will run much more quickly (and would
probably have acceptable behavior even without the -delta attribute, as
it would only have to look at _new_ objects).

It will have to write the whole 200M packfile out each time, though.
From your timings that looks to take about 50 seconds or so (just
looking at the difference between wall clock time and CPU time, which is
presumably spent in I/O).

Packing nightly won't hurt, but is perhaps excessive. It sounds like you
actually have a fairly normal workload.

> >How big is your packed repo? Given the pattern you describe below, I am
> [...]
> The packed .git dir is 203 MB. Yes, we make frequent changes to these
> files, and push/pull frequently as well. Just a normal development
> pattern, though. It's all manually done -- i.e., there's no automated
> bot doing excessive git operations.

OK, that is not very big. Once packed, you really should not see
performance issues.

> culprit. Yes, network bandwidth is always a factor, but I guess my
> expectation is that git shouldn't transfer too much more info than
> the amount of recent changes. For example, if we change 10 files for
> a total of 10MB, then my admittedly naive expectation is that git
> will send that 10MB of changes, plus some small constant amount of
> meta info... not the whole repo every time. No?

Your assumption is correct. Git should transmit at _worst_ 10MB in such
a scenario (i.e., often much less because of delta compression, but in
your case of apparently-random media files, probably about 10MB).

I wasn't clear from your message: you indicated the changes you made,
but are you still having performance problems, or are you still waiting
to get data?

-Peff
