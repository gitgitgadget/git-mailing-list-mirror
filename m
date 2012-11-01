From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with textconv filter
Date: Thu, 01 Nov 2012 19:19:28 +0000
Message-ID: <5092CB40.3090707@ramsay1.demon.co.uk>
References: <508C29E4.5000801@arcor.de> <20121028120104.GE11434@sigill.intra.peff.net> <508D8DF7.7040007@arcor.de> <20121029060524.GB4457@sigill.intra.peff.net> <508EE4E4.1080407@arcor.de> <20121029223521.GJ20513@sigill.intra.peff.net> <20121029224705.GA32148@sigill.intra.peff.net> <20121030121747.GA4231@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 20:21:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU0Kb-0003I6-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 20:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229Ab2KATVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 15:21:22 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:42795 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751933Ab2KATVV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 15:21:21 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 9F2AA6F830F;
	Thu,  1 Nov 2012 19:21:20 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 713336F8148;	Thu,  1 Nov 2012 19:21:19 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;	Thu,  1 Nov 2012 19:21:17 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121030121747.GA4231@sigill.intra.peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208885>

Jeff King wrote:
> Thinking on it more, my patch, hacky thought it seems, may not be the
> worst solution. Here are the options that I see:
> 
>   1. Use a regex library that does not require NUL termination. If we
>      are bound by the regular regexec interface, this is not feasible.
>      But the GNU implementation works on arbitrary-length buffers (you
>      just have to use a slightly different interface), and we already
>      carry it in compat. It would mean platforms which provide a working
>      but non-GNU regexec would have to start defining NO_REGEX.

I have thought about the possibility of doing this for unrelated reasons
in the past.

On cygwin, there have been two unexpected test passes since about v1.6.0
(I reported it to the list in passing), like so:

    [ ... ]
    All tests successful.

    Test Summary Report
    -------------------
    t0050-filesystem.sh                              (Wstat: 0 Tests: 9 Failed: 0)
      TODO passed:   5
    t7008-grep-binary.sh                             (Wstat: 0 Tests: 20 Failed: 0)
      TODO passed:   12
    Files=604, Tests=8439, 11190 wallclock secs ( 2.59 usr  1.59 sys + 7294.86 cusr
    3416.65 csys = 10715.70 CPU)
    Result: PASS

In particular, t7008.12 passes on cygwin because the regex library apparently
matches '.' to NUL. Indeed if you add a test_pause to the script and execute
"grep .fi a" (note grep *not* git-grep) then "Binary file a matches" on Linux,
cygwin and MinGW. (So I assume the test was added to document a difference in
behaviour to GNU grep).

So, if we use the GNU interface to the regex routines in compat, then we may
specify the "grep syntax" for use in git-grep. (Well that's the theory, I've
not actually tried to code it up, so take this with a pinch of salt! :-P ).

ATB,
Ramsay Jones
