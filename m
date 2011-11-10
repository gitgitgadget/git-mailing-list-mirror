From: Eric Raible <raible@nextest.com>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Wed, 9 Nov 2011 23:48:58 -0800
Message-ID: <4EBB81EA.6060303@nextest.com>
References: <4EB9C7D1.30201@nextest.com> <20111109220128.GA31535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 08:49:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPNk-0002lD-39
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757452Ab1KJHtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:49:03 -0500
Received: from exchange.domain1.nextest.com ([12.96.234.114]:47637 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752684Ab1KJHtC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2011 02:49:02 -0500
Received: from [131.101.151.102] (131.101.151.102) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Wed, 9 Nov 2011 23:49:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111109220128.GA31535@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185201>

On 11/9/2011 2:01 PM, Jeff King wrote:
> On Tue, Nov 08, 2011 at 04:22:41PM -0800, Eric Raible wrote:
> 
> [explanation how --since is used to limits traversal omitted]

Yes, all that is as expected, and makes sense.

> Now let's look at reflog walking. It's kind of bolted on to the side
> of the revision traversal machinery. We walk through the reflog
> backwards and pretend that entry N's parent is entry N-1 (you can see
> this if you do "git log -g -p", for example; you see the patch versus
> the last reflog entry, not the patch against the commit's true parent).
> 
> In the case of rewound history (like the reset you showed above), this
> means that the history graph will appear to have bad clock skew. The
> timestamp of HEAD@{0} is going to be much earlier than its pretend
> parent, HEAD@{1}. And the "--since" optimization is going to cut off
> traversal, even though there are more interesting commits to be shown.
> 
> So in that sense, I think it's a bug, and we should probably disable the
> exit-early-from-traversal optimization when we're walking reflogs.

Indeed.  Seems like a case of an optimization leading to an incorrect result.

> But it may also be a misfeature, because it's not clear what you're
> actually trying to limit by. We have commit timestamps, of course, but
> when we are walking reflogs, we also have reflog timestamps. Did you
> actually want to say "show me all commits in the reflog, in reverse
> reflog order, omitting commits that happened before time t"? Or did you
> really mean "show me the reflog entries that happened before time t,
> regardless of their commit timestamp"?

I meant "show me the reflog entries that happened *since* time t,
regardless of their commit timestamp.

> In the latter case, we would either need a new specifier (like
> "--reflog-since"), or to rewrite the commit timestamp when we rewrite
> the parent pointers.
> 
> The latter has a certain elegance to it (we are making a pretend linear
> history graph out of the reflog, so faking the timestamps to be sensible
> and in order is a logical thing to do) but I worry about lying too much
> in the output. Something like "git log -g --format=%cd" would now have
> the fake timestamp in the output. But then, we already show the fake
> parents in the output, so I don't know that this is any worse.

Since -g is asking specifying for the reflog, and since the reflog has
its own timestamps, I would expect that those timestamps be used.
