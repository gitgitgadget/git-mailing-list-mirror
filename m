From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Threaded grep
Date: Tue, 19 Jan 2010 07:41:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001190728300.13231@localhost.localdomain>
References: <20100118103334.GA17361@fredrik-laptop> <alpine.LFD.2.00.1001180947140.13231@localhost.localdomain> <20100119073454.GA15575@fredrik-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 16:44:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXGFL-0003Sr-TV
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 16:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab0ASPn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 10:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659Ab0ASPn4
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 10:43:56 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54503 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153Ab0ASPnz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2010 10:43:55 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0JFfhEr001298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Jan 2010 07:41:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0JFfhDN019700;
	Tue, 19 Jan 2010 07:41:43 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20100119073454.GA15575@fredrik-laptop>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.949 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137467>



On Tue, 19 Jan 2010, Fredrik Kuivinen wrote:
> > 
> >  - git grep --no-ext-grep function
> > 
> > 	real	0m0.241s
> > 	user	0m1.436s
> > 	sys	0m0.216s
> 
> I haven't seen this overhead during my tests. But I'm _guessing_ that
> the problem is that the mutex grep_lock is held while the result is
> written to stdout. So when we are writing, no significant amount of
> work can be done by any thread. Here is a patch to fix this (applies
> on to of v3).

No, I get basically the same timings with this patch:

	real	0m0.239s
	user	0m1.372s
	sys	0m0.280s

(that _may_ be a slight real improvement, but it's more likely that the 
changing in user/sys time is just noise).

But I do think that you're right that there's a difference in my timings, 
and I am comparing to the one that uses strstr(). Your patches didn't have 
a "disable threads" option that I could see, so I just compared against my 
old numbers. 

So I guess a better example is to use a "complex" grep pattern like 
'function.*a' which also gets a lot of hits, and the threaded case does 
look much better in comparison. Pre-threaded:

	real	0m0.921s
	user	0m0.728s
	sys	0m0.184s

so it's less than 2x the CPU time, and a 3.85x real-time improvement. And 
that "less than 2x the CPU time" is the factor I'd expect from HT.

It's also worth noting that at least _some_ versions of glibc would 
actually use different versions of subroutines for the threaded vs 
non-threaded case, ie they'd avoid locking overhead when they know they 
aren't running with threads. So things like stdio actually got slower when 
you did any pthreads things, because suddenly glibc knew that it needed to 
do locking around the functions.

			Linus
