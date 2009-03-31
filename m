From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 22:50:17 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903302244580.4093@localhost.localdomain>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain> <7vk5668g55.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain> <alpine.LFD.2.00.0903302231370.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:54:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWvR-0001TF-Aj
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbZCaFwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbZCaFwq
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:52:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56156 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754838AbZCaFwp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:52:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V5oI1t005271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Mar 2009 22:50:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V5oHBo023672;
	Mon, 30 Mar 2009 22:50:17 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0903302231370.4093@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.441 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115220>



On Mon, 30 Mar 2009, Linus Torvalds wrote:
> 
> If I do
> 
> 	mark_reachable(cb.ref_commit, 0);

Ok, I think I got it.

You had

	mark_reachable(cb.ref_commit, cmd->expire_unreachable);

but we care about the commits that are younger than 'expire_total' (older 
than that, and they are pruned unconditionally), but older than 
'expire_unreachable' (younger than that and the date doesn't matter).

So making it do

	mark_reachable(cb.ref_commit, cmd->expire_total);

marks the right parts reachable. Not the whole tree, but also not just the 
commits we're not going to expire regardless.

With that change, it's all basically instantaneous. We don't need to 
traverse the whole kernel history, and with that change to your patch, I 
get

	[torvalds@nehalem linux]$ time ~/git/git reflog expire --all

	real	0m1.715s
	user	0m1.676s
	sys	0m0.040s

which is still slower than I'd wish for, but is a whole lot faster than 
over half a minute.

		Linus
