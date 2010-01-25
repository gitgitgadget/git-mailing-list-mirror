From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] Threaded grep
Date: Mon, 25 Jan 2010 15:59:56 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001251542100.3574@localhost.localdomain>
References: <20100125225139.GA3048@fredrik-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 01:00:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZYr3-0002DH-5R
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 01:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab0AZAAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 19:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042Ab0AZAAT
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 19:00:19 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52867 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750758Ab0AZAAS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 19:00:18 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0PNxvu0018425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jan 2010 15:59:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0PNxuFU018746;
	Mon, 25 Jan 2010 15:59:56 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20100125225139.GA3048@fredrik-laptop>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.947 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138008>



On Mon, 25 Jan 2010, Fredrik Kuivinen wrote:
> 
> The results below are best of five runs in the Linux repository (on a
> box with two cores).
> 
> git grep qwerty

Before:

	real	0m0.531s
	user	0m0.412s
	sys	0m0.112s

After:

	real	0m0.151s
	user	0m0.720s
	sys	0m0.272s


> $ /usr/bin/time git grep void

Before:

	real	0m1.144s
	user	0m0.988s
	sys	0m0.148s

After:
	real	0m0.290s
	user	0m1.732s
	sys	0m0.232s

So it's helping a lot (~3.5x and ~3.9x) on this 4-core HT setup. 

I don't seem to ever get more than a 4x speedup, so my guess is that HT 
simply isn't able to do much of anything with this load. 

The profile for the threaded case says:

    51.73%      git  libc-2.11.1.so                 [.] re_search_internal
    11.47%      git  [kernel]                       [k] copy_user_generic_string
     2.90%      git  libc-2.11.1.so                 [.] __strlen_sse2
     2.66%      git  [kernel]                       [k] link_path_walk
     2.55%      git  [kernel]                       [k] intel_pmu_enable_all
     2.40%      git  [kernel]                       [k] __d_lookup
     1.71%      git  libc-2.11.1.so                 [.] __GI___libc_malloc
     1.55%      git  [kernel]                       [k] _raw_spin_lock
     1.43%      git  [kernel]                       [k] sys_futex
     1.30%      git  libc-2.11.1.so                 [.] __cfree
     1.28%      git  [kernel]                       [k] intel_pmu_disable_all
     1.25%      git  libc-2.11.1.so                 [.] __GI_memchr
     1.14%      git  libc-2.11.1.so                 [.] _int_malloc
     1.02%      git  [kernel]                       [k] effective_load

and the only thing that makes me go "eh?" there is the strlen(). Why is 
that so hot?  But locking doesn't seem to be the biggest issue, and in 
general I think this is all pretty good. The 'effective_load' thing is the 
scheduler, so there's certainly some context switching going on, probably 
still due to excessive synchronization, but it's equally clear that that 
is certainly not a dominant factor.

One potentially interesting data point is that if I make NR_THREADS be 16, 
performance goes down, and I get more locking overhead. So NR_THREADS of 8 
works well on this machine.

So ack from me. The patch looks reasonably clean too, at least for 
something as complex as a multi-threaded grep.

One worry is, of course, whether all regex() implementations are 
thread-safe. Maybe there are broken libraries that have hidden global 
state in them?

			Linus
