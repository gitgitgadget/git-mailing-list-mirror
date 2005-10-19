From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Errors from http-fetch
Date: Wed, 19 Oct 2005 15:37:08 -0700
Message-ID: <20051019223708.GC6160@reactrix.com>
References: <Pine.LNX.4.64.0510191536350.25300@iabervon.org> <20051019212644.GB6160@reactrix.com> <Pine.LNX.4.64.0510191755280.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 00:39:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESMYp-0006wN-Sf
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 00:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbVJSWhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 18:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbVJSWhQ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 18:37:16 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:59143 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751582AbVJSWhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 18:37:14 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9JMb8l8015604;
	Wed, 19 Oct 2005 15:37:08 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9JMb8Fo015602;
	Wed, 19 Oct 2005 15:37:08 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510191755280.25300@iabervon.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10320>

On Wed, Oct 19, 2005 at 06:10:52PM -0400, Daniel Barkalow wrote:

> I'm getting 404 for the object, which it reports. This was pulling from 
> kernel.org.

Something similar was reported yesterday, and when I investigated I
found that one of the kernel.org servers was returning a 404 for the
object in question and the other wasn't.  Vger bounced my reply because
it contained Content-type: headers...

> That is, it was a later object that prompted getting the pack, because 
> either the server decided to send that error message sooner, some packet 
> got dropped and retransmitted, the connection got a lower-numbered file 
> descriptor and they were ready at the same time, or something like that.

I could see that happen if the pack appeared on the repo after #1 404ed
and subsequently decided there were no packs, and before #2 404ed.  Or,
as was the case I saw yesterday, servers with the same DNS name aren't
in sync.  However, the pack download for #2 should never start in that
case because fetch() for #1 would fail and exit.

> Another thing I noticed was that it was in the middle of downloading the 
> pack when it suddenly exitted due to not being able to find the object; it 
> would probably be worth having a call to finish up the active transfers 
> after giving up on completing the whole thing, since we probably do 
> actually want to finish downloading a big pack if we've started.

I'm not sure how that could happen - once a pack download request
starts, it has to finish before any fetch() calls can fail.  However,
there could certainly be other object requests in process when one
fails, and it would be polite to let them finish.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
