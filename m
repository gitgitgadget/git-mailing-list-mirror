From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 22:56:40 -0400
Message-ID: <20070906025640.GL18160@spearce.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <20070906024555.GJ18160@spearce.org> <46DF6AA8.60804@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Nix <nix@esperi.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT7YD-0003o8-Bd
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbXIFC44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbXIFC44
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:56:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36502 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297AbXIFC44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:56:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT7Xi-00075h-Av; Wed, 05 Sep 2007 22:56:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9B81320FBAE; Wed,  5 Sep 2007 22:56:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46DF6AA8.60804@midwinter.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57809>

Steven Grimm <koreth@midwinter.com> wrote:
> Shawn O. Pearce wrote:
> >But this suffers from the same fate if the user sets gc.auto too
> >small and doesn't realize that the reason Git is always repacking
> >is because over the last 6 months they have been unlucky enough to
> >stage the magic number of unreachable blobs into the 17 directory
> >and they have *never* run `git gc --prune` because the auto thing
> >is working just fine for them and they don't realize they need to
> >prune every once in a blue moon.
> 
> Check the modification times on those files and don't count ones that 
> are older than the last git-gc run, maybe? That'd take care of the problem.

Eh, that could mean a bunch of stat calls that it would be nice
to avoid.  The counter Junio (and git-gui) implements just does
a readdir().  Reasonably cheap.

Maybe just save a ".git/gc_last_auto" with the last object count
of .git/objects/17, after repacking.  If the count is over the
gc.auto limit *and* is still over the limit after subtracting the
".git/gc_last_auto" value then consider that auto is required.

This way the file is only consulted if we are really thinking
about running a repack, and its only written to if we actually do
the repack.  So we only take the extra penalty if we are going to
be taking a *really* big extra penalty by repacking.

-- 
Shawn.
