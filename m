From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 15:31:20 -0500
Message-ID: <20070107203120.GA4970@spearce.org>
References: <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <m3odpazxit.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 21:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3egp-0002m1-KS
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 21:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbXAGUcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 15:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbXAGUcI
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 15:32:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44839 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965102AbXAGUcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 15:32:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H3eg4-0004EN-FQ; Sun, 07 Jan 2007 15:31:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A598220FB65; Sun,  7 Jan 2007 15:31:20 -0500 (EST)
To: Krzysztof Halasa <khc@pm.waw.pl>
Content-Disposition: inline
In-Reply-To: <m3odpazxit.fsf@defiant.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36195>

Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Hmm... Perhaps it should be possible to push git updates as a pack
> file only? I mean, the pack file would stay packed = never individual
> files and never 256 directories?

Latest Git does this.  If the server is later than 1.4.3.3 then
the receive-pack process can actually store the pack file rather
than unpacking it into loose objects.  The downside is that it will
copy any missing base objects onto the end of a thin pack to make
it not-thin.

There's actually a limit that controls when to keep the pack and when
not to (receive.unpackLimit).  In 1.4.3.3 this defaulted to 5000
objects, which meant all but the largest pushes will be exploded
into loose objects.  In 1.5.0-rc0 that limit changed from 5000 to
100, though Nico did a lot of study and discovered that the optimum
is likely 3.  But that tends to create too many pack files so 100
was arbitrarily chosen.

So if the user pushes <100 objects to a 1.5.0-rc0 server we unpack
to loose; >= 100 we keep the pack file.  Perhaps this would help
kernel.org.
 
-- 
Shawn.
