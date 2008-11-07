From: Ingo Molnar <mingo@elte.hu>
Subject: [minor usability suggestion] git rebase <upstream> --onto
	<newbase> ?
Date: Fri, 7 Nov 2008 10:20:35 +0100
Message-ID: <20081107092035.GA1339@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 10:22:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyNY0-00064P-LN
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 10:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbYKGJUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 04:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754374AbYKGJUs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 04:20:48 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:44832 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238AbYKGJUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 04:20:45 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KyNW9-00009c-NY
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Fri, 07 Nov 2008 10:20:43 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 86CCC3E21A5; Fri,  7 Nov 2008 10:20:37 +0100 (CET)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100297>


I use git rebase rarely, but i just had one of those exceptions where 
it's OK to use it: wanted to zap an unsafe commit [685aebb below] from 
a short-lifetime topic branch. With that i had this small usability 
incident:

 earth4:~/tip> tc
 tip/core/urgent 82d4e6e: xen: make sure stray alias mappings are gone

 earth4:~/tip> git rebase 685aebb --onto linus
 Current branch core/urgent is up to date.

 earth4:~/tip> glll
 82d4e6e: xen: make sure stray alias mappings are gone before pinning
 f6ab176: vmap: cope with vm_unmap_aliases before vmalloc_init()
 685aebb: kernel/cpu.c: section mismatch warning fix

 earth4:~/tip> git rebase --onto linus 685aebb
 First, rewinding head to replay your work on top of it...
 Applying: vmap: cope with vm_unmap_aliases before vmalloc_init()
 Applying: xen: make sure stray alias mappings are gone before pinning

 earth4:~/tip> glll
 d05fdf3: xen: make sure stray alias mappings are gone before pinning
 9b46333: vmap: cope with vm_unmap_aliases before vmalloc_init()

 earth4:~/tip> tc
 tip/core/urgent d05fdf3: xen: make sure stray alias mappings are gone 

 earth4:~/tip> git version
 git version 1.6.0.2.GIT

What i tried to achieve was to zap a single commit that was applied 
first, and preserve the other two commits - without having to go via 
the longer "git rebase -i" path.

It took me some time to figure out that while the principle i applied 
was correct, the first rebase command didnt work because i mistakenly 
flipped around the "--onto <newbase> <upstream>" arguments to 
"<upstream> --onto <newbase>".

Unless the reverse order is meaningful and important, it might make 
sense to flip it back implicitly and thus accept that order as well 
transparently.

For example "git log" is exemplary in this area as it accepts just 
about any permutation of parameters thrown at it, and i love that 
aspect of Git commands in general, it's a really nice property.

Or at least we should print some sort of warning/error? The "Current 
branch core/urgent is up to date." message definitely did not help me 
in noticing my mistake.

	Ingo
