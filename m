From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 11 Jan 2010 13:24:57 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001111315470.17145@localhost.localdomain>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>  <20100104064408.GA7785@coredump.intra.peff.net>  <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>  <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>  <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
  <7vvdf9402f.fsf@alter.siamese.dyndns.org>  <4c8ef71001111119p253170f8q37bcd3708d894a62@mail.gmail.com>  <alpine.LFD.2.00.1001111124480.17145@localhost.localdomain>  <4c8ef71001111140j7e7d0081o7718d956104a2451@mail.gmail.com> 
 <alpine.LFD.2.00.1001111159270.17145@localhost.localdomain> <4c8ef71001111307q6679039ajbef22f2e1748df56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:25:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NURlj-0002Z4-LX
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 22:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab0AKVZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 16:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317Ab0AKVZn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 16:25:43 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45234 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751133Ab0AKVZm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 16:25:42 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0BLOvS5021866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jan 2010 13:24:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0BLOvF3028828;
	Mon, 11 Jan 2010 13:24:57 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4c8ef71001111307q6679039ajbef22f2e1748df56@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.45 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136667>



On Mon, 11 Jan 2010, Fredrik Kuivinen wrote:
> 
> Another option is to use memmem instead. As we know the length of the
> buffer already it should be a slight improvement over strstr for
> everyone. memmem may cause some portability problems though as it is a
> GNU extension.

I'd almost prefer to just drop the strstr entirely.

It's not actually all *that* big a win, even on my machine. I get

 - strstr:

        real    0m0.309s
        user    0m0.168s
        sys     0m0.136s

 - regexec:

	real	0m0.410s
	user	0m0.220s
	sys	0m0.116s

so yeah, it's slower, but not by a huge degree. With strstr, "git grep" 
actually beats the external grep for me, but I don't really care. It's 
already way better than it used to be - and clearly strstr has a lot of 
potential problems.

Sure memmem() might be better for you than strstr, but on the other hand, 
it might easily be worse than strstr for others - and not just from a 
portability standpoint. Is memmem() optimized to take advantage of SSE4.2? 
I suspect it is not, exactly _because_ it's a GNU extension, so Intel 
hasn't published optimized sample code for people to use.

So I would argue against even bothering to try memmem. Especially since	in 
your case, regexec() is apparently faster than memmem _anyway_. I expect 
that it is for me too, but I'm too lazy to check.

			Linus
