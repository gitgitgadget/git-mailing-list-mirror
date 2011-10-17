From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: What should "git fetch origin +next" should do?
Date: Mon, 17 Oct 2011 18:02:10 -0400
Message-ID: <4E9CA5E2.2020701@xiplink.com>
References: <7v7h45s8rh.fsf@alter.siamese.dyndns.org> <20111017171041.GA12837@sigill.intra.peff.net> <7vipnnmppx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 00:02:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFvGI-0007ES-1a
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab1JQWCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:02:17 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:33453 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab1JQWCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 18:02:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp43.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 3DB9E2D04F6;
	Mon, 17 Oct 2011 18:02:16 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp43.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0B7EB2D04FB;
	Mon, 17 Oct 2011 18:02:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vipnnmppx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183828>

On 11-10-17 02:34 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I think the exact same confusion exists. I told git to update 'next'
>> from origin, but it didn't touch refs/remotes/origin/next.
> 
> Except that you didn't tell git to *update* the remote tracking branch for
> 'next'; you merely told it to fetch 'next' at the remote.
> 
>> ...  But I suspect that is not how many git users think of it.
> 
> I am inclined to agree that it might be the case; see my other message in
> this thread.

Indeed.  Apologies for missing that subtlety.

So now I think option (2) is the best choice.  To support one-off fetches,
teach fetch to accept "foo:" refspecs as "fetch ref foo from the remote and
only update FETCH_HEAD" -- maybe allow "foo:FETCH_HEAD" too, for folks who
like to be explicit and can't remember the shorthand syntax.

The rest of this post explains my reasoning, which I think pretty much just
rehashes what Junio said more efficiently in his initial message.

Overall I'd expect "git fetch origin next" to be a subset of "git fetch
origin".  That is, since the default fetch refspec is
	+refs/heads/*:refs/remotes/origin/*
normally "git fetch origin" gets all of origin's updated refs (ff or not) and
puts them under the local remotes/origin/ space.  So I would expect "git
fetch origin next" to only fetch the "next" ref from origin and update the
local remotes/origin/next ref.

Given the default fetch refspec, I'd expect "git fetch origin +next" to do
the exact same thing.  The + on the command line is basically redundant.

But removing the + from the fetch refspec changes things.  Now I'd expect
plain "git fetch origin" to fail if there are any non-ff updates, and "git
fetch origin next" should also fail if origin's next ref is non-ff.  But "git
fetch origin +next" would succeed.

In all cases if the command-line refspec has no RHS then git should try to
figure out which local ref to update from the config, and it should die if it
can't figure out a local ref to create or update.  (As I said above, maybe
allow "git fetch origin foo:" to let the user put the tip of origin's foo ref
into FETCH_HEAD.)

All this gets a bit more complicated if the user has currently checked out
the a ref that should be updated (regardless of the presence of a LHS +).
But really only old-style git gurus should run in to that problem.

		M.
