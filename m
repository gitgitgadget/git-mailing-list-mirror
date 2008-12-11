From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: epic fsck SIGSEGV!
Date: Thu, 11 Dec 2008 12:18:18 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812111212510.3340@localhost.localdomain>
References: <1228867861.14165.19.camel@starfruit.local> <7vd4g051ax.fsf@gitster.siamese.dyndns.org> <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net> <1228949523.27061.20.camel@starfruit.local> <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812102031440.14328@xanadu.home> <alpine.LFD.2.00.0812101854230.3340@localhost.localdomain> <alpine.LFD.2.00.0812101930590.3340@localhost.localdomain> <7v63lrupxk.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0812110928060.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAs1R-0002Rs-9J
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 21:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676AbYLKUS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 15:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756674AbYLKUS6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 15:18:58 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52184 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756622AbYLKUS5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 15:18:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBBKIKNh019033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Dec 2008 12:18:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBBKII1l017942;
	Thu, 11 Dec 2008 12:18:19 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812110928060.3340@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.426 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102814>



On Thu, 11 Dec 2008, Linus Torvalds wrote:
> 
> But obviously the true test for fsck is some complex corruption, and I 
> didn't test that. I can't imagine that it introduces any new problems 
> though - but the bugs you can't imagine are always the worst ones ;)

Btw, even if it doesn't introduce any bugs, it _does_ change the order 
that we traverse things in. It shouldn't matter, of course, but because it 
always picks the last entry from the object array (it really treats the 
array as a stack), it ends up traversing parents of commits (and the 
entries in trees) by looking at the last parent (or entry) first.

The whole two-phase thing also means that rather traverse the references 
as we find them, we'll end up traversing things later in one group. Again, 
access ordering will change.

Absolutely nothing should care about this from a correctness angle, of 
course, but I thought I'd point it out because I think it will change the 
order that we print out errors in.

So if somebody has some test-case, and you get different output 
before-and-after, it's not necessarily any indication of a problem, just 
an effect of doing object traversal in slightly different order.

		Linus
