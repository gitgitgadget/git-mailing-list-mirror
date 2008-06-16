From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 21:09:11 +0200
Message-ID: <20080616190911.GA7047@elte.hu>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8K5p-0005kP-Q8
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 21:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYFPTJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 15:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbYFPTJX
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 15:09:23 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59260 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbYFPTJW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 15:09:22 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1K8K4o-0007Xy-6Y
	from <mingo@elte.hu>; Mon, 16 Jun 2008 21:09:20 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 918F43E21DD; Mon, 16 Jun 2008 21:09:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vej6xb4lr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85217>


* Junio C Hamano <gitster@pobox.com> wrote:

> >  - Automation: would be nice to have a git-rerere modus operandi where
> >    it would auto-commit things if and only if all conflicting files were 
> >    resolved.
> 
> I am not sure how safe this is.  rerere as originally designed does 
> not even update the index with merge results so that the application 
> of earlier resolution can be manually inspected, and this is exactly 
> because I consider a blind textual reapplication of previous 
> resolution always iffy, even though I invented the whole mechanism.

We use a 'safe, lazy integration' method in -tip, that basically has 
external checks against any integration bugs.

Basically, we integrate only about once a day, and we advance the topic 
branches but do not reintegrate on every topic merge. We merge commits 
_both_ to their target topic branches, and to the (previous) integration 
branch.

Then once a day (or every second day) we 'reintegrate': we propagate the 
topic branches to the linux-next auto-*-next branches [recreating them 
from scratch] and flush out the messy criss-cross merges from the 
integration tree.

But that is always an identity transformation as far as the integration 
result is concerned: the result of the integration run must be exactly 
the same content (obviously it results in a very different tree 
structure) as the previous one. We only run it on a perfectly tested 
tree so we know none of our previous merges were wrong, and we want the 
git-rerere result to be the same. We repeat the integration until the 
end result matches.

In fact sometimes git-rerere is able to pick up a conflict resolution 
from our 'messy' delta-merge into the integration tree, which is an 
added bonus. (this doesnt always work if the merge order differs from 
integration order)

Anyway, the gist is that in this workflow it does not hurt at all if 
git-rerere is "unsafe", and we'd love to have the integration as fast as 
possible. Right now most of my manual overhead is in making sure that 
git-rerere has not missed some file.

At a ~100 conflicting files tracked, that is rather error-prone, and i'd 
love to have further automation here besides a rather lame method of 
grepping for:

  "Resolved 'kernel/Makefile' using previous resolution."

type of patterns in git-merge output.

So i'd not mind if git-rerere was safe by default, but it would be nice 
to have some knob to turn it into something fast and automatic. For us 
it would be much _safer_, because right now most of our manual energy is 
spent on checking something that could be automated.

We could in theory avoid git-rerere altogether by creating separate 
conflict resolution branches, and automated their handling - but we 
thought git-rerere was pretty nice as well and kept the branch count 
down.

And while asking for an arm i'd also like to ask for a leg, if i may: 
i'd love it if a "slightly conflicting" octopus merge of 85 topic trees 
would not result in one huge conflict commit that merges together 1000 
commits into a single commit ;-)

So right now in our -tip scripts work around this issue: we 'serialize' 
the topic merges despite having very nice opportunities for higher-order 
octopus merges. The integration would be a lot faster if we could use 
octopus merges and automated git-rerere. (Octopus merges would look much 
nicer as well in graphical representation as well, which counts too :-) )

	Ingo
