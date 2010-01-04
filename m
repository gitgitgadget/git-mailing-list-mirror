From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 08:24:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001040817420.3630@localhost.localdomain>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com> <7v7hs09tpi.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com> <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com> <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain> <7v3a2mzzg4.fsf@alter.siamese.dyndns.org> <20100104053125.GA5083@coredump.intra.peff.net> <7vbphaquwl.fsf@alter.siamese.dyndns.org> <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:25:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpk6-0004MF-0o
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab0ADQZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753577Ab0ADQZN
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:25:13 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50483 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753523Ab0ADQZL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 11:25:11 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o04GOiBO006574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jan 2010 08:24:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o04GOhux004401;
	Mon, 4 Jan 2010 08:24:44 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.447 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136126>



On Mon, 4 Jan 2010, Linus Torvalds wrote:
> 
>  - external grep:
> 
> 	[torvalds@nehalem linux]$ time git grep qwerty
> 	...
> 	real	0m0.412s
> 	user	0m0.196s
> 	sys	0m0.132s
> 
>  - NO_EXTERNAL_GREP:
> 
> 	[torvalds@nehalem linux]$ time ~/git/git grep qwerty
> 	...
> 	real	0m1.006s
> 	user	0m0.900s
> 	sys	0m0.096s
> 
> so that's not even close.

Side note: at least for me, if we did some auto-parallelization, the 
internal grep would make up for all its other suckiness. Do four or eight 
greps in parallel, and buffer the results (you still need to show them in 
the right order).

That might be an acceptable way to "fix" it. Developers pretty much all 
have at least two cores these days, some of us have four+HT. We use 
threads in other places, maybe this could be one more of them.

(Start 'n' threads, do an initial per-thread regex and 'regcomp()' to make 
it thread-safer, and the only interesting issue would be serializing the 
output. Whenever you get a result, you'd need to make sure that all files 
before have been completed, but you could do that all under a specific 
lock that protects completion information).

		Linus
