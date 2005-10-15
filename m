From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Sat, 15 Oct 2005 14:21:54 -0700
Message-ID: <20051015212154.GB5509@reactrix.com>
References: <867jciz18w.fsf@blue.stonehenge.com> <864q7kqsa4.fsf@blue.stonehenge.com> <7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net> <86achcoyvz.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510141543030.23242@iabervon.org> <863bn3lypn.fsf@blue.stonehenge.com> <7vd5m6py11.fsf@assigned-by-dhcp.cox.net> <7v1x2mpx6m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 23:22:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQtTp-0001lD-4V
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 23:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVJOVWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 17:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVJOVWH
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 17:22:07 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:50554 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751221AbVJOVWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 17:22:05 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9FLLtJT012734;
	Sat, 15 Oct 2005 14:21:55 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9FLLsgM012731;
	Sat, 15 Oct 2005 14:21:54 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x2mpx6m.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10146>

On Sat, Oct 15, 2005 at 09:22:25AM -0700, Junio C Hamano wrote:

> More interesting is this "error:" without error message.
> "Getting pack list" is a signal that we fell back to
> fetch_pack(), so this is coming from fetch_object().

I've seen that happen before fetch_pack used the active queue; open object
requests in the active queue would not be processed while fetch_pack was
transferring the pack, and in some cases a server had timed out a connection
from one of these requests by the time the active queue started processing 
again.  I worked around this at one point by detecting an empty server
response and retrying the request.

Changing all requests to run through the active queue seemed to fix the
problem, but it's possible that something is still holding up processing
long enough to cause a server timeout.

> BTW, I do not think this is related to git.git repository
> problem, but I wonder why we do not do fetch_object() against
> each altbase in http-fetch.c::fetch(); nobody said you cannot
> borrow unpacked object from your neighbour.

It doesn't look like there are any alternates defined in the git.git
repository.  I've seen alternates used during testing when I deliberately
removed objects and packs from the primary repository.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
