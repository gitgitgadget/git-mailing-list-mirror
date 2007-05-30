From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] rev-parse: Identify short sha1 sums correctly.
Date: Tue, 29 May 2007 21:58:43 -0400
Message-ID: <20070530015843.GH7044@spearce.org>
References: <1180478596243-git-send-email-jbowes@dangerouslyinc.com> <7vabvn5hca.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Bowes <jbowes@dangerouslyinc.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 03:58:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtDSl-0006yh-07
	for gcvg-git@gmane.org; Wed, 30 May 2007 03:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbXE3B6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 21:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbXE3B6t
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 21:58:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41384 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbXE3B6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 21:58:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtDSM-0002gr-Kh; Tue, 29 May 2007 21:58:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C499420FBAE; Tue, 29 May 2007 21:58:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vabvn5hca.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48720>

Junio C Hamano <junkio@cox.net> wrote:
> James Bowes <jbowes@dangerouslyinc.com> writes:
> 
> > find_short_packed_object was not loading the pack index files.
> > Teach it to do so.
> >
> > Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
> 
> I think this is the proper fix of the problem I was unhappy
> about with 'next', rather than reverting the lazy index
> loading.  But I wonder how many _other_ places like this there
> are that we might be missing...
> 
> Shawn, an Ack, and any ideas for futureproofing?

Ack, though late.  ;-)

I actually found this exact same bug today.  At first I thought it
was related to alternates, but when I dug into the code I came up
with basically the same patch as James did.  His was sent in first
and is logically identical, so I'm not going to send my version.

With regards to future proofing this, I have no idea.  I'm going to
write up a test case that catches this and submit that, to avoid a
future regression here, but otherwise I'm not sure what we can do.
I had thought I had visited every callsite and checked them, but
apparently that wasn't true.

What would probably help is to change the name of the structure
member in the .h file when its initialization time changes (or its
meaning changes in a subtle way) and then go through and manually
update every mention of the old name to the new name, then flip it
back with a global search and replace when done.

E.g. I should have done:

	* in cache.h rename num_objects to num_objects_SHAWNCHANGEHERE;
	* manually update every num_objects usage to my private name;
	* finally globally search-replace back to the standard name.

It would have forced me to more carefully visit every damn callsite.

I'll go back through the code tonight and double check my work,
because this bug was completely my fault.  I'm hoping this was the
only bug however.

-- 
Shawn.
