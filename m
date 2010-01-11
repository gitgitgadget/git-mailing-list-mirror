From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 11 Jan 2010 12:07:25 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001111159270.17145@localhost.localdomain>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>  <20100104053125.GA5083@coredump.intra.peff.net>  <7vbphaquwl.fsf@alter.siamese.dyndns.org>  <20100104064408.GA7785@coredump.intra.peff.net>  <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain> 
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>  <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>  <7vvdf9402f.fsf@alter.siamese.dyndns.org>  <4c8ef71001111119p253170f8q37bcd3708d894a62@mail.gmail.com> 
 <alpine.LFD.2.00.1001111124480.17145@localhost.localdomain> <4c8ef71001111140j7e7d0081o7718d956104a2451@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 21:08:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUQYh-00013M-Rc
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 21:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab0AKUIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 15:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979Ab0AKUIJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 15:08:09 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54545 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754024Ab0AKUII (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 15:08:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0BK7QYK014308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jan 2010 12:07:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0BK7PFh024848;
	Mon, 11 Jan 2010 12:07:25 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4c8ef71001111140j7e7d0081o7718d956104a2451@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.449 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136662>



On Mon, 11 Jan 2010, Fredrik Kuivinen wrote:
> >
> > Try a complex pattern ("qwerty.*as" finds the same line), and see if that
> > too is slower than before. If that is faster than it used to be (with
> > --no-ext-grep, of course), then it's strstr() that is badly implemented.
> 
> Ah, yes, that's it. With the pattern "qwerty.*as" I get 2.5s with the
> patch and 6s without.

Ok, so on your machine, regcomp() is basically twice as fast as strstr().

Which is not entirely unexpected: I was actually surprised by strstr() 
being apparently so good on my machine. I do not generally expect things 
like that to be at all optimized for bigger working sets. Most common uses 
of strstr() are in short strings - not "strings" that are many kilobytes 
in size (the whole file).

In fact, I suspect it works so well for me because in my version of glibc 
it's not just SSE-optimized: judging by the naming it's SSE4.2 optimized - 
so the case I see on my machine will _only_ happen on Nehalem-based cores 
(ie the new "Core i[357]" cpu's).

It is entirely possible that strstr in general is a disaster.

		Linus
