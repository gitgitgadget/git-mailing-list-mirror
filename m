From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] Threaded grep
Date: Tue, 26 Jan 2010 08:44:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001260836520.3574@localhost.localdomain>
References: <20100125225139.GA3048@fredrik-laptop>  <alpine.LFD.2.00.1001251542100.3574@localhost.localdomain> <4c8ef71001260410l2afd2dbx17b6e216bd9e5d8@mail.gmail.com> <alpine.LFD.2.00.1001260728260.3574@localhost.localdomain>
 <4B5F1894.4070509@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 17:45:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZoXq-0002ls-Eh
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 17:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab0AZQpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 11:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498Ab0AZQpe
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 11:45:34 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40541 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754642Ab0AZQpe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 11:45:34 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0QGiCeX010343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jan 2010 08:44:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0QGiCKS005836;
	Tue, 26 Jan 2010 08:44:12 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4B5F1894.4070509@googlemail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.946 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138056>



On Tue, 26 Jan 2010, Benjamin Kramer wrote:
> 
> BSD and glibc have an "REG_STARTEND" flag to do that. I made a small
> PoC patch to use it if it's available but it didn't give any significant
> speedup on my system.

Goodie.  It's noticeable for me. This is what I reported earlier:

> > $ /usr/bin/time git grep void
> 
> Before:
> 
>         real    0m1.144s
>         user    0m0.988s
>         sys     0m0.148s
> 
> After:
>         real    0m0.290s
>         user    0m1.732s
>         sys     0m0.232s

and with your patch I get

	real	0m0.239s
	user	0m1.392s
	sys	0m0.276s

and the profile shows no strlen in it:

    57.12%      git  libc-2.11.1.so                 [.] re_search_internal
     5.59%      git  [kernel]                       [k] copy_user_generic_string
     4.09%      git  [kernel]                       [k] _raw_spin_lock
     2.57%      git  [kernel]                       [k] intel_pmu_enable_all
     2.46%      git  [kernel]                       [k] __d_lookup
     1.94%      git  libc-2.11.1.so                 [.] re_string_reconstruct
     1.87%      git  [kernel]                       [k] kmem_cache_alloc
     1.68%      git  libc-2.11.1.so                 [.] _int_free
     1.53%      git  [kernel]                       [k] find_get_page
     1.43%      git  [kernel]                       [k] update_curr
     1.27%      git  libc-2.11.1.so                 [.] __GI___libc_malloc
     1.17%      git  [kernel]                       [k] _atomic_dec_and_lock
     1.00%      git  libc-2.11.1.so                 [.] __GI_memcpy

Side note: the tailing end of the profiles aren't very stable, probably 
because the grep executes so quickly and in so many threads, so the 
functions in the one-percent range will move up and down the list 
depending on just exactly where we happened to get profile hits. 
Similarly, the raw_spin_lock numbers vary.

But the big picture is stable, and that 57% number (and the nonlock 
copy_user_generic_string) is consistent. And your patch definitely helped 
both actual performance and is visible in the profile: re_search_internal 
went from ~52% to ~57%.

So ack on that patch. Looks like a good thing to do, and with the #ifdef, 
it looks like it should just automatically DTRT based on regexec 
implementation.

		Linus
