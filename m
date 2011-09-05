From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Mon, 5 Sep 2011 11:15:26 -0700
Message-ID: <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org> <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net> <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org> <20110902162524.GC19690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 20:16:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0diV-0007Xt-M9
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 20:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab1IESPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 14:15:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46649 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab1IESPr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 14:15:47 -0400
Received: by ywf7 with SMTP id 7so3514332ywf.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 11:15:47 -0700 (PDT)
Received: by 10.42.149.199 with SMTP id x7mr938433icv.294.1315246547101; Mon,
 05 Sep 2011 11:15:47 -0700 (PDT)
Received: by 10.42.163.70 with HTTP; Mon, 5 Sep 2011 11:15:26 -0700 (PDT)
In-Reply-To: <20110902162524.GC19690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180752>

On Fri, Sep 2, 2011 at 09:25, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 02, 2011 at 09:14:15AM -0700, Junio C Hamano wrote:
>>
>> It coincides with my idea too, but it might be a very limited set. For
>> example, there may be a good "suggested by upstream" default for LHS of
>> fetch refspecs (e.g. somebody may have 47 topics published but majority of
>> people are expected to follow only his "master" branch), but it is up to
>> the user of that suggestion what the RHS would be.
...
> One possible solution is that the local config could dynamically depend
> on the remote config. E.g., the fetch refspec has something like a
> wildcard that matches only the branches that the remote provides to us
> via some "interesting branches" config key. Then it's OK for git to
> update the "interesting branches" key from the remote. Either the user
> is OK with respecting that (because they have left the wildcard in
> place), or not (because they have changed the refspec not to use that
> wildcard).
>
> I do worry that could quickly get complex, and people would start
> wanting a Turing-complete config language. :)

What are we trying to do here?

I had some thought that dropping the "+" might prevent a remote
repository from being fetched from if it was rewound by an evil
attacker that now controls it. Unfortunately that attack is a
pointless one. Which makes this change to remove the "+" from fetch
specs also pointless.

If the attacker knows Git clients always fetch rewinds, he might be
tempted to rewrite some part of history and serve his modified history
of events to clients. But the repository owner (if using a private
per-user repository model like the Linux kernel developers use) would
notice on their next push, and sound the alarm that her repository has
been damaged and should not be trusted.

If on the other hand Git clients never fetch rewinds, the attacker
would just add a new commit to the tip of the history, and serve that.
Again, the repository owner would notice on their next push, and
notify people the repository is not to be trusted.

Either way, the "+" in the fetch spec has no impact on the attack. The
default just changes the attacker's choices slightly.


Maybe instead of getting a project policy from the server, we observe
the server's behavior over time from the client's reflog. If every
update to "maint" that _I_ have observed has always been a
fast-forward, a rewind on that branch should be a lot more verbose in
the fetch output than "force update". That is pretty easy to observe
from the reflog too, its just a scan of the records and either
matching the message, or checking the merge status of the old-new
pairs listed in the record. We don't even need to read the entire log
on every fetch, we could cache this data.

The main reason to alert the user that a branch rewound is to give
them a chance to correct their client if they need to. If a branch
normally doesn't rewind (e.g. next) but then suddenly does (e.g.
release cycle), but I haven't used this client in 3 weeks, its nice to
give me more of a "HEY STUPID FIX YOUR TOPICS" warning than just the
little quiet "force update" we give.

-- 
Shawn.
