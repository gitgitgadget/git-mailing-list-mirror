From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Mon, 19 Mar 2007 23:29:47 -0400
Message-ID: <20070320032947.GA29145@spearce.org>
References: <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com> <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org> <alpine.LFD.0.83.0703172136440.18328@xanadu.home> <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org> <alpine.LFD.0.83.0703172200060.18328@xanadu.home> <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org> <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org> <Pine.LNX.4.63.0703200400230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 20 04:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTV3S-00062P-13
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 04:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153AbXCTDaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 23:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933147AbXCTDaF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 23:30:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34982 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075AbXCTDaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 23:30:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTV2X-0000gf-Vt; Mon, 19 Mar 2007 23:29:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0768520FBAE; Mon, 19 Mar 2007 23:29:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703200400230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42697>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 18 Mar 2007, Linus Torvalds wrote:
> 
> > All the top profiling hits are about generating the patches and 
> > assigning blame:
> > 
> > 	samples  %        image name               app name                 symbol name
> > 	470352   15.5813  git                      git                      xdl_hash_record
> 
> I felt a little left out in all that performance slashing, and so I 
> thought maybe, just maybe, a small change in xdl_hash_record() can do 
> wonders (since it _is_ really simple, but still takes almost a 6th of the 
> CPU time). I don't have a proper test case setup, so maybe you want to try 
> this:
> 
> -- snipsnap --
> [PATCH] xdiff/xutils.c(xdl_hash_record): factor out whitespace handling
> 
> Since in at least one use case, xdl_hash_record() takes over 15% of the
> CPU time, it makes sense to even micro-optimize it. For many cases, no
> whitespace special handling is needed, and in these cases we should not
> even bother to check for whitespace in _every_ iteration of the loop.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> ---
> 
> 	Please do not consider this patch _unless_ it is proven to enhance 
> 	the profile statistics substantially.

This is a massive difference for me.  I ran it on git-gui.sh in
the git-gui repository - this is a 6000 line file that has a lot of
revisions, and has been renamed a few times.  I applied the patch on
top of current 'master' (v1.5.1-rc1), so I was testing with Linus'
delta_base_cache.

# stock v1.5.1-rc1
$ for a in 1 2 3 4 5;do /usr/bin/time ../lt-blame blame --incremental HEAD git-gui.sh >/dev/null;done
        6.27 real         5.31 user         0.55 sys
        6.40 real         5.32 user         0.55 sys
        6.33 real         5.33 user         0.53 sys
        6.67 real         5.32 user         0.55 sys
        6.18 real         5.31 user         0.53 sys

# with the above patch
$ for a in 1 2 3 4 5;do /usr/bin/time ../js-blame blame --incremental HEAD git-gui.sh >/dev/null;done
        3.57 real         2.87 user         0.51 sys
        3.58 real         2.87 user         0.51 sys
        3.53 real         2.86 user         0.52 sys
        3.61 real         2.86 user         0.51 sys
        3.64 real         2.87 user         0.52 sys

For the record, both versions did produce identical output.

Given how small of a change it is, and how much of an improvement
it made, I say apply it.

-- 
Shawn.
