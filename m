From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-fast-import: note 1M limit of mark number
Date: Wed, 16 Apr 2008 02:54:26 -0400
Message-ID: <20080416065425.GC29771@spearce.org>
References: <20080415125222.C55C121CE8F@mail.utsl.gen.nz> <4804CECE.2040205@alum.mit.edu> <48051882.8000201@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 08:56:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm1Y4-0003MF-Kj
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 08:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbYDPGya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 02:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbYDPGya
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 02:54:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58202 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbYDPGya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 02:54:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jm1XH-0003b4-2S; Wed, 16 Apr 2008 02:54:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3632520FBAE; Wed, 16 Apr 2008 02:54:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48051882.8000201@vilain.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79681>

Sam Vilain <sam@vilain.net> wrote:
> Michael Haggerty wrote:
> >> ++
> >> +Note that due to current internal limitations, you may not make marks
> >> +with a higher number than 1048575 (2^20-1).
> >>  
> >>  * A complete 40 byte or abbreviated commit SHA-1 in hex.
> > 
> > Oh.  Um.  That is an awkwardly small number nowadays.
> > 
> > cvs2svn has been used for repositories with O(2^20) distinct file
> > revisions (KDE, Mozilla, NetBSD, ...).  So this limit will likely be too
> > small for some users.
> 
> Right.  But, if you're not making the importer you write for a
> conversion of that size restartable, you're insane.  So, marking more
> than 1Mi *marks* in a single gfi session might not be so vital.
> 
> It only tripped me up because I was using a database sequence to
> generate the marks, which meant I hit the ceiling.

Uhm.  Wow.  gfi has a bug then; mark numbers are supposed to
be whatever uintmax_t is on your platform; for any systems that
support a 64 bit off_t (and most do these days) that should be a
64 bit integer value, which we all know easily exceeds 2^20-1.

I'd rather see the bug fixed than a documentation patch.  But I'm
too whacked out from heavy travel in the past two days flying
coast-to-coast and back to attempt debugging gfi and writing such
a fix patch tonight.  Maybe someone else will find it before I
can look at it later.  ;-)
 
> > While I'm at it, let me also renew my suggestion that git-fast-import
> > use separate namespaces ("markspaces", so to speak) for file content
> > marks and for commit marks.  There is no reason for these distinct types
> > of marks to be located in a shared space of integers.
> 
> There is a reason, it's because they're both just object IDs.  Is it
> really that much of a drag?  I know what you mean though, it meant for
> my code I had to keep track of which type each mark was.

Yea.  I think I had pointed out the same point to Michael earlier
when he asked about it.  I didn't want create two different tables
of marks because then we either need to extend the language to say
which table, or we have to infer it based on position.  But either
way its just object IDs.

-- 
Shawn.
