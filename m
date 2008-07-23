From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 17:06:21 +0200
Message-ID: <20080723150621.GA8499@elte.hu>
References: <20080723130518.GA17462@elte.hu> <20080723131736.GA9100@elte.hu> <20080723134926.GA12888@elte.hu> <76718490807230747w5d0350b8v6feba00fb8837617@mail.gmail.com> <20080723145622.GA23440@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 17:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfwa-0007OH-49
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 17:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbYGWPGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 11:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbYGWPGp
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 11:06:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41307 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832AbYGWPGg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 11:06:36 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KLfv5-0001qz-PF
	from <mingo@elte.hu>; Wed, 23 Jul 2008 17:06:34 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id CEA373E21AB; Wed, 23 Jul 2008 17:06:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723145622.GA23440@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89684>


* Ingo Molnar <mingo@elte.hu> wrote:

> > Shouldn't this be:
> > 
> > [ -f "$CACHE" -a "$CACHE" -nt .git/refs/heads/$BRANCH ] && {
> > 
> > ?
> 
> yeah, i just figured it out too ... the hard way :)
> 
> Updated script below. This works fine across resets in the master 
> branch.
> 
> While it's fast in the empty-merge case, it's not as fast as i'd like 
> it to be in the almost-empty-merge case.

When i update a topic branch, i first get a relatively fast run:

  earth4:~/tip> time todo-merge-all
  merging all branches ...
  Auto-merged arch/x86/kernel/genx2apic_uv_x.c
  Merge made by recursive.
   arch/x86/kernel/genx2apic_uv_x.c |    1 -
   1 files changed, 0 insertions(+), 1 deletions(-)
  ... merge done.

  real    0m6.625s
  user    0m3.740s
  sys     0m2.563s

Then on the next run it's slower:

  earth4:~/tip> time todo-merge-all
  merging all branches ...
  ... merge done.

  real    0m30.823s
  user    0m23.403s
  sys     0m7.545s

that's unfortunate. The freshly updated topic branch was at the end of 
the run, now all other topic branches will have to run slow at least 
once until they become cached again.

Perhaps the cache should update all other current topics to the new 
sha1, to establish the fact that they were not merged this time. (and 
that they are still not to be merged)

(It's still much faster than completely uncached though, because of the 
overlap in sha1's.)

Third (empty) run is fast again, because it's fully cached:

  earth4:~/tip> time todo-merge-all
  merging all branches ...
  ... merge done.

  real    0m3.036s
  user    0m1.360s
  sys     0m1.782s

But it would be nice if the cache worked more intelligently in the 
one-topic-updated-only case as well.

	Ingo
