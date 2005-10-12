From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Strangely broken git repo
Date: Tue, 11 Oct 2005 20:26:46 -0700
Message-ID: <20051012032646.GA14819@reactrix.com>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com> <46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com> <4349ED5D.6020703@catalyst.net.nz> <7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 05:28:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPXHL-0005z6-PE
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 05:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVJLD1j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 23:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVJLD1j
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 23:27:39 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:41011 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932385AbVJLD1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 23:27:38 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9C3QlI0007387;
	Tue, 11 Oct 2005 20:26:47 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9C3QkFA007385;
	Tue, 11 Oct 2005 20:26:46 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10002>

On Mon, Oct 10, 2005 at 02:00:06AM -0700, Junio C Hamano wrote:

> The fetch_alternates() function was supposed to be call-once and
> we have a static variable got_alternates that becomes 1 when it
> runs for the first time.  However, there are other 'return 0's
> introduced that does not set got_alternates to 1.

Oops, thanks for catching that - I'll fix it.

> I am wondering if the semantics has changed that now we chain
> the alternates?  Initially, if we are cloning/fetching from
> repository A, which borrows from repository B (i.e. alternates
> we retrieve from A would name B), and if B in turn borrows from
> C, then we assumed that A's alternates would also name C, and
> that was the reason why fetch_alternates() was call-once
> function.  I do not mind if we change it to chain the alternates
> file, but if that is the case we should move the got_alternates
> variable into "struct alt_base", and pass the struct, not just
> alt->base, to fetch_alternates(), like this (untested, of
> course):

I'd thought about chaining the alternates, but wasn't sure whether it's
safe to consider all alternates in the chain equivalent.  I would want to
implement fetching the chain such that it could happen parallel to other
request and not block the pull.  I think it would also be useful to track
the network performance of each alternate and prefer faster sources as
new requests are started.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
