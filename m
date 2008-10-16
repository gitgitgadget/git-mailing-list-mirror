From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] reset --hard/read-tree --reset -u: remove unmerged new
	paths
Date: Thu, 16 Oct 2008 09:20:10 +0200
Message-ID: <20081016072010.GA19188@elte.hu>
References: <20081015115654.fb34438f.akpm@linux-foundation.org> <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm> <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm> <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org> <20081015124949.b657a8db.akpm@linux-foundation.org> <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org> <7v3aixqzrn.fsf@gitster.siamese.dyndns.org> <7vy70ppiq1.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, david@lang.hm,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 09:21:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqNAw-0007k8-FP
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 09:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbYJPHUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 03:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbYJPHUY
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 03:20:24 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36602 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbYJPHUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 03:20:23 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KqN9a-0007UM-7f
	from <mingo@elte.hu>; Thu, 16 Oct 2008 09:20:14 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 67C483E21A3; Thu, 16 Oct 2008 09:20:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy70ppiq1.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98350>


* Junio C Hamano <gitster@pobox.com> wrote:

> When aborting a failed merge that has brought in a new path using "git 
> reset --hard" or "git read-tree --reset -u", we used to first forget 
> about the new path (via read_cache_unmerged) and then matched the 
> working tree to what is recorded in the index, thus ending up leaving 
> the new path in the work tree.

i've met this problem in various variants in the past few months, and i 
always assumed that it's "as designed" - as Git's policy is to never 
lose information unless forced to do so. (which i find very nice in 
general, and which saved modification from getting lost a couple of 
times in the past)

the situations where i end up with a messed up working tree [using 
git-c427559 right now]:

 - doing a conflicted Octopus merge will leave the tree in some weird 
   half-merged state, with lots of untracked working tree files that not 
   even a hard reset will recover from. The routine thing i do to clean 
   up is:

      git reset --hard HEAD
      git checkout HEAD .
      git ls-files --others | xargs rm              # DANGEROUS

   doing git checkout -f alone is not enough, as there might be various 
   dangling files left around.

 - git auto-gc thinking that it needs to do another pass in the middle 
   of a random git operation, but i dont have 10 minutes to wait so i 
   decide to Ctrl-C it.

 - doing the wrong "git checkout" and then Ctlr-C-ing it can leave the
   working tree in limbo as well, needing fixups. If i'm stuck between
   two branches that rename/remove files it might need the full fixup
   sequence above.

 - if a testbox has a corrupted system clock, its git repo and the 
   kernel build can get confused. This is to be expected i think - but
   the full sequence above will recover the corrupted tree. Not much Git
   can do about this i guess.

Does your fix mean that all i have to do in the future is a hard reset 
back to HEAD, and that dangling files are not supposed to stay around?

	Ingo
