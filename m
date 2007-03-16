From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 12:17:52 -0400
Message-ID: <20070316161752.GA3275@spearce.org>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de> <alpine.LFD.0.83.0703161145520.5518@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:18:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSF84-0006lD-9M
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965451AbXCPQSF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965461AbXCPQSF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:18:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51619 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965451AbXCPQSD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:18:03 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HSF7j-0007PF-W0; Fri, 16 Mar 2007 12:17:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7F8C020FBAE; Fri, 16 Mar 2007 12:17:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.83.0703161145520.5518@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42372>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 16 Mar 2007, Johannes Schindelin wrote:
> 
> > We already _have_ the data structures!
> 
> Well... Shawn and I are contemplating alternate data structures to 
> improve things dramatically.

Hang on.  Yes, Nico and I are contemplating alternate disk based
data structure, and in some cases, alternate memory based data
structures to improve things.

But these structures are not changing the basic Git data structures
that have been with us since way back when. ;-) Commits still
have the same fields, with the same data and the same meaning.
Trees still have the same fields, and same meaning... etc.

> With a fixed public API I doubt such improvements could be as effective.

They still can be, and without shooting ourselves in the foot in the
process.
 
> So... if any API is to be developed, I'd argue that it must be done 
> _above_ the existing code with a higher level of abstraction and a much 
> narrower scope.

Yes.  Today we have a frozen API for commit walking.  Its called
`git rev-list --pretty=raw A ^B`.  That output format is pretty
well set in stone, and we cannot change it.  Everyone knows what
each field means, and hopefully knows that additional fields can
be added.  ;-)

Instead of formatting out those fields as hex strings, or as decimal
integer dates, we can offer them in a struct.  E.g.:

	struct git_objid {
		const unsigned char *obj_name;
	};

	struct git_commit {
		struct git_objid tree;
		struct git_objid *parents;
		uint32_t nr_parent;
		const char *author;
		time_t author_date;
		int author_tz;
		const char *committer;
		time_t committer_date;
		int committer_tz;
		const char *message;
	};

With the rule that the pointers are to static memory buffers that
libgit is loaning out to the caller (the caller should *not* free
these buffers).  This lets us play cute tricks down in the lower
tiers by pointing directly into the packfile dictionary tables
(saves memcpys); or xstrdup/xmalloc everything we give out if we
want to be really paranoid.

Just tossing ideas out - don't think that what I wrote above is my
final suggestion on the matter.  It may change in another day or
two if I think about it more.  ;-)

-- 
Shawn.
