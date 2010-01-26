From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] Threaded grep
Date: Tue, 26 Jan 2010 08:56:50 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001260846330.3574@localhost.localdomain>
References: <20100125225139.GA3048@fredrik-laptop>  <alpine.LFD.2.00.1001251542100.3574@localhost.localdomain> <4c8ef71001260410l2afd2dbx17b6e216bd9e5d8@mail.gmail.com> <alpine.LFD.2.00.1001260728260.3574@localhost.localdomain> <4B5F1894.4070509@googlemail.com>
 <alpine.LFD.2.00.1001260836520.3574@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 17:59:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZokn-0000U5-CU
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 17:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab0AZQ65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 11:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107Ab0AZQ65
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 11:58:57 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48709 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753829Ab0AZQ64 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 11:58:56 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0QGuphA012135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jan 2010 08:56:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0QGuoEt006603;
	Tue, 26 Jan 2010 08:56:50 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001260836520.3574@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.946 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138057>



On Tue, 26 Jan 2010, Linus Torvalds wrote:
>
> Goodie.  It's noticeable for me. This is what I reported earlier:
> 
> > > $ /usr/bin/time git grep void
> > 
> > Before:
> > 
> >         real    0m1.144s
> > 
> > After:
> >         real    0m0.290s
> 
> and with your patch I get
> 
> 	real	0m0.239s

Btw, I have to also say that this whole performance reduction _feels_ 
good. It's very noticeable in normal use. "git grep" was always fast (it's 
been getting a bit slower as the kernel has grown, though), but it used to 
be still a noticeable pause.

Now it just -feels- very immediate. That quarter second is short enough 
that I can see the pause, but I don't feel it. It's like the results just 
"are there" rather than get searched for.

But perhaps even more importantly, it's also noticeable for me in the 
cold-cache case. IOW, after I do

	echo 3 > /proc/sys/vm/drop_caches

the threaded grep is able to do much better at reading the disk:

Before threading:

	[torvalds@nehalem linux]$ time git grep void > /dev/null 

	real	0m11.745s
	user	0m2.380s
	sys	0m1.200s

After:

	[torvalds@nehalem linux]$ time ~/git/git grep void > /dev/null 

	real	0m3.710s
	user	0m2.564s
	sys	0m2.076s

although it is worth noting that that machine has an Intel SSD, which is 
why it gets sped up so much by parallel IO (there's no seek penalty, and 
it is able to read multiple channels in parallel, so this gives much 
better IO patterns for it - with rotational media the numbers might be 
very different).

IOW, the whole threaded grep thing is a 4x performance improvement in 
hot-cache, and a 3x improvement in cold-cache.

Major good mojo.

		Linus
