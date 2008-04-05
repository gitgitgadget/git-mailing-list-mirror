From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Fri, 4 Apr 2008 23:24:45 -0400
Message-ID: <20080405032445.GS10274@spearce.org>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com> <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org> <m3tziita2y.fsf@localhost.localdomain> <alpine.LFD.1.00.0804040844470.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Roman Shaposhnik <rvs@Sun.COM>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 05:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhz27-00085J-6O
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 05:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbYDEDYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 23:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbYDEDYw
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 23:24:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44710 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYDEDYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 23:24:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jhz18-0004Ox-DD; Fri, 04 Apr 2008 23:24:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 61FCF20FBAE; Fri,  4 Apr 2008 23:24:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0804040844470.2947@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78835>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 3 Apr 2008, Jakub Narebski wrote:
> 
> > One of bigger hindrances, as I understand it, in developing pack v4
> > was the fact that it didn't offer that much of improvement in typical
> > cases for the work needed... but perhaps "your" repository would be
> > good showcase for pack v4.
> 
> The biggest hindrance for pack v4 is actually the lack of a native 
> runtime tree walking, and having both tree object formats properly and 
> optimally abstracted has not been looked at yet.
> 
> Speed is the primary goal for pack v4.  The fact that it also provides a 
> 10% pack reduction is only consequential.  But without native tree 
> walking we must recreate the legacy tree format on the fly each time a 
> tree object is loaded which dwarfs any improvements pack v4 is aiming 
> for (yes it is still a little bit faster than pack v3 nevertheless, but 
> not yet significantly enough to overcome the incompatibility costs).

Even though we don't have native tree walking, I think the right
way to do this is to put in pack v4 with "canonical tree, canonical
commit" mode, where it inflates its native tree/commit encoding
into the canonical forms, then come back later with native walking.

Canonical mode is still faster than pack v2 inflate is for these
types, so it does (slightly) boost rev-list performance.  It might
chop a solid 30% off the CPU time jgit spends in its equivilant of
revision.c, and that's without teaching jgit to use the native pack
v4 encoding directly.

Once we have it in we can experiment with the necessary abstractions
to handle the two different available encodings, and allowing
higher level code to switch back and forth between them as objects
come from loose or pack v2, and from pack v4.  One of the things we
wanted to do was boost path limiter performance by matching on tree
name ids when walking a pack v4 native tree, but fall back to the
string based memcmp when walking a canonical tree.  That won't be
easy to design without the two different encodings being available
at the lower level in sha1_file.c.

Just my rapidly declining .02 bush peso.

> Nicolas (who wishes he was still a student with plenty of hacking time)

Don't we all.  :-)

-- 
Shawn.
