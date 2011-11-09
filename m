From: Jeff King <peff@peff.net>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Wed, 9 Nov 2011 17:01:28 -0500
Message-ID: <20111109220128.GA31535@sigill.intra.peff.net>
References: <4EB9C7D1.30201@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 23:01:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROGD9-0003P3-PD
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 23:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab1KIWBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 17:01:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38790
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009Ab1KIWBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 17:01:30 -0500
Received: (qmail 18889 invoked by uid 107); 9 Nov 2011 22:01:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Nov 2011 17:01:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2011 17:01:28 -0500
Content-Disposition: inline
In-Reply-To: <4EB9C7D1.30201@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185171>

On Tue, Nov 08, 2011 at 04:22:41PM -0800, Eric Raible wrote:

>     # It's reported correctly here:
>     git log -g --oneline --since=$add_b
> 
>     # But after a reset no history isn't shown.
>     git reset --hard HEAD^
>     git log -g --oneline --since=$add_b
> 
> Is this a bug?  Of course everything is reported when --since isn't used,
> but not so when limited with --since.

It's sort of a bug. And sort of a missing feature.

In the normal revision walking case, git walks the history graph
backwards, hitting the parent of each commit (and when there are
multiple lines of history, we traverse them in commit timestamp order).

So "--since" works not just by omitting non-matching commits from the
output, but also by stopping the traversal when we go too far back in
time. In a sense, this is purely an optimization, as it shouldn't change
the output. But it's an important one, because it makes looking back in
time O(how far back) instead of O(size of all history).

This optimization breaks down badly, of course, in the face of clock
skew (i.e., a commit whose timestamp is further back than its parent).
There are a few tricks we do to avoid small runs of moderate skew, and
in practice it works well.

Now let's look at reflog walking. It's kind of bolted on to the side
of the revision traversal machinery. We walk through the reflog
backwards and pretend that entry N's parent is entry N-1 (you can see
this if you do "git log -g -p", for example; you see the patch versus
the last reflog entry, not the patch against the commit's true parent).

In the case of rewound history (like the reset you showed above), this
means that the history graph will appear to have bad clock skew. The
timestamp of HEAD@{0} is going to be much earlier than its pretend
parent, HEAD@{1}. And the "--since" optimization is going to cut off
traversal, even though there are more interesting commits to be shown.

So in that sense, I think it's a bug, and we should probably disable the
exit-early-from-traversal optimization when we're walking reflogs.

But it may also be a misfeature, because it's not clear what you're
actually trying to limit by. We have commit timestamps, of course, but
when we are walking reflogs, we also have reflog timestamps. Did you
actually want to say "show me all commits in the reflog, in reverse
reflog order, omitting commits that happened before time t"? Or did you
really mean "show me the reflog entries that happened before time t,
regardless of their commit timestamp"?

In the latter case, we would either need a new specifier (like
"--reflog-since"), or to rewrite the commit timestamp when we rewrite
the parent pointers.

The latter has a certain elegance to it (we are making a pretend linear
history graph out of the reflog, so faking the timestamps to be sensible
and in order is a logical thing to do) but I worry about lying too much
in the output. Something like "git log -g --format=%cd" would now have
the fake timestamp in the output. But then, we already show the fake
parents in the output, so I don't know that this is any worse.

-Peff
