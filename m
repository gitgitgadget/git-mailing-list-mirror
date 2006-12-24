From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 7/7] Replace mmap with xmmap, better handling MAP_FAILED.
Date: Sun, 24 Dec 2006 15:34:48 -0500
Message-ID: <20061224203448.GB631@spearce.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org> <20061224054723.GG8146@spearce.org> <Pine.LNX.4.63.0612241410400.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 21:35:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gya3d-0000BF-Tt
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 21:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbWLXUez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 15:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbWLXUez
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 15:34:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54852 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbWLXUey (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 15:34:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gya3P-0006xu-Gg; Sun, 24 Dec 2006 15:34:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8E9BC20FB65; Sun, 24 Dec 2006 15:34:49 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612241410400.19693@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35373>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> All in all it is a good change -- for the builtin programs.
> 
> But it is less good for the libification. Maybe it is time for a 
> discussion about the possible strategies to avoid dying in libgit.a?

Well we have the same problem with xmalloc.  All I've done is move
the MAP_FAILED cases which tend to wind up die()'ing later anyway
into the same scope of area where the xmalloc issue is.

We die() all over the place.  ~1312 times according to 'git grep die'.
Git isn't a program for the living.  :-)

To properly libify we have a few issues:

  - we cannot just exit this process when we run into an error;

  - routines need to cleanup temporary resources (memory, file
    descriptors) when returning an error;

  - static variables like environment.c need to be reorganized to
    support multiple repositories in the same program;

  - objects need to be able to be deallocated, especially
    if the revision walking machinary has done rewriting

Though the die() is the largest issue.

-- 
Shawn.
