From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Speeding up a null fetch
Date: Sun, 11 Feb 2007 18:52:18 -0500
Message-ID: <20070211235218.GH31488@spearce.org>
References: <200702112332.14698.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:52:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOUb-0002ZX-HE
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbXBKXwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932932AbXBKXwW
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:52:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53332 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbXBKXwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:52:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGOUM-0007Vv-8C; Sun, 11 Feb 2007 18:52:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ADC7020FBAE; Sun, 11 Feb 2007 18:52:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702112332.14698.julian@quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39337>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> Investigation showed that the main culprit seemed to be show-ref
> having to build a sorted list of all refs for every ref that was being
> checked.  So I used the patch below to reduce this to a single call to
> show-ref (unless the ref had been updated).  With this patch the fetch
> timed dropped to just under 1m - obviously quite a lot faster (better
> than I expected in fact).

Have a look at the `pu` branch in git.git.  Junio has done some
work in this area to handle 1000 refs better:

  ...
  commit 58fef67cb067b6dee8f94b7b0e0c1a2d324e3505
  Author: Junio C Hamano <junkio@cox.net>
  Date:   Tue Jan 16 02:31:36 2007 -0800

    git-fetch: rewrite another shell loop in C
    
    Move another shell loop that canonicalizes the list of refs for
    underlying git-fetch-pack and fetch-native-store into C.
    
    This seems to shave the runtime for the same 1000 branch
    repository from 30 seconds down to 15 seconds (it used to be 2
    and half minutes with the original version).
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

  commit 3fc3729cd08e9d40dad54ccdd4db53900eca197b
  Author: Junio C Hamano <junkio@cox.net>
  Date:   Tue Jan 16 01:53:29 2007 -0800

    git-fetch: move more code into C.
    
    This adds "native-store" subcommand to git-fetch--tool to
    move a huge loop implemented in shell into C.  This shaves about
    70% of the runtime to fetch and update 1000 tracking branches
    with a single fetch.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>
  ...

> However, this seems more band-aid than fix, and I wondered if someone
> more familiar with the git internals could point me in the right
> direction for a better fix, e.g. should I look at rewriting fetch in C?

Rewriting fetch in C is a lot of work, not just in developing it,
but in testing that all existing functionality is preserved and no
new bugs are introduced.  Rewriting some of the performance critical
parts perhaps makes sense.  Rewriting them in Python doesn't, as
we no longer have any Python dependency, and would like to keep it
that way (actuallly, some folks are also trying to remove the Perl
dependency from some of our critical tools).

-- 
Shawn.
