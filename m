From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 09:01:04 -0700
Message-ID: <20130328160104.GC16034@leaf>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
 <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
 <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
 <20130327231819.GL28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:01:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFGo-0003yF-OV
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab3C1QBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:01:13 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41995 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab3C1QBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:01:12 -0400
Received: from mfilter19-d.gandi.net (mfilter19-d.gandi.net [217.70.178.147])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id F146B172094;
	Thu, 28 Mar 2013 17:01:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter19-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter19-d.gandi.net (mfilter19-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id mMHn7F7t8tr1; Thu, 28 Mar 2013 17:01:08 +0100 (CET)
X-Originating-IP: 50.43.39.152
Received: from leaf (static-50-43-39-152.bvtn.or.frontiernet.net [50.43.39.152])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 358361720AD;
	Thu, 28 Mar 2013 17:01:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130327231819.GL28148@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219417>

On Wed, Mar 27, 2013 at 04:18:19PM -0700, Jonathan Nieder wrote:
> Josh Triplett wrote:
> 
> >                       I have a .gitconfig in my git-managed home
> > directory which sets pushInsteadOf so that I can clone via git:// and
> > immediately have working push.  I work with a number of systems that
> > don't have inbound access to each other but do have outbound access to
> > the network; on some of these "satellite" boxes, I can't push changes
> > directly to the server pushInsteadOf points to, so I can explicitly set
> > pushurl in .git/config for that repository, which overrides the
> > pushInsteadOf.  This change would break that configuration.
> 
> Would it?  As long as your pushurl does not start with git://, I think
> your configuration would still work fine.

I had to think about it for a while, but I think you're right; I
inferred a behavior that the patch didn't actually add or have anything
to do with, namely having the result of applying pushInsteadOf to the
non-push URL override the pushUrl.

OK, I take it back.  I *can* imagine configurations that this change
would break, since it does change intentional and documented behavior,
but I don't have any such configuration.  The only such configuration I
can imagine involves directly counting on the non-rewriting of pushUrl,
by using pushInsteadOf to rewrite urls and then sometimes using pushUrl
to override that and point back at the un-rewritten URL.  And while
supported, that does seem *odd*.

Objection withdrawn; if nobody can come up with a sensible configuration
that relies on the documented behavior, I don't particularly care if it
changes.

> After this patch, neither pushInsteadOf nor pushUrl overrides the
> other one.  The rule is:
> 
> 	1. First, get the URL from the remote's configuration, based
> 	   on whether you are fetching or pushing.
> 
> 	   (At this step, in your setup git chooses the URL specified
> 	   with pushurl in your .git/config.)
> 	
> 	2. Next, apply the most appropriate url.*.insteadOf or
> 	   url.*.pushInsteadOf rule, based on whether you are fetching
> 	   or pushing.
> 
> 	   (At this step, no rewrite rules apply, so the URL is used
> 	   as is.)
