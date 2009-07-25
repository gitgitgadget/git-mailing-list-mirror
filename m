From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Add support for external programs for handling native
 fetches
Date: Sat, 25 Jul 2009 12:09:23 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907251151270.3960@localhost.localdomain>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org> <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 21:10:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmdB-0007b0-2G
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 21:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbZGYTJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 15:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZGYTJ6
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 15:09:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37122 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751696AbZGYTJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 15:09:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PJ9N56010245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Jul 2009 12:09:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PJ9NWH021252;
	Sat, 25 Jul 2009 12:09:23 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.959 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124058>



On Sat, 25 Jul 2009, Linus Torvalds wrote:
> 
> Btw, some real timing numbers for 'time make -j64 test':
> 
>  - before:
> 	real	1m16.070s
> 	user	2m47.046s
> 	sys	2m34.698s
> 
>  - after:
> 	real	0m58.851s
> 	user	1m57.087s
> 	sys	1m44.671s
> 
> so that's actually a real-world example of the whole 'scripting 
> performance'. Not an insignificant speedup on my machine (with an 
> obligatory "nyaah, nyaah, I can do the git test-suite under a minute" just 
> to rub peoples noses in the fact that my desktop computer is disgustingly 
> fast).
> 
> That's an almost 30% performance improvement, despite the fact that parts 
> of the test suite didn't actually change (shell costs are the same, the 
> svn tests are quite perl-intensive etc).

Just in case people wonder _why_, here is a profile from before and after. 
Note how big a deal the page faulting, unmapping (TLB flushes etc), and 
fork() is (copy_page_range()).

And notice how the biggest user space cost - even after the change - is 
do_lookup_x() in the dynamic loader. But before the change it was the very 
top entry, and you had things like strcmp and _dl_relocate_object pretty 
high too. Not to mention that you got just a lot _more_ munmap's and page 
faults:

 - before:

     4.51%               git  /lib64/ld-2.10.1.so        [.] do_lookup_x
     3.17%               git  [kernel]                   [k] unmap_vmas
     2.75%               git  [kernel]                   [k] page_fault
     1.48%               git  [kernel]                   [k] copy_page_c
     1.43%               git  /lib64/ld-2.10.1.so        [.] strcmp
     1.30%               git  [kernel]                   [k] _spin_lock
     1.12%               git  /lib64/ld-2.10.1.so        [.] _dl_relocate_object
     0.99%           git-svn  [kernel]                   [k] copy_page_range
     0.99%               git  [kernel]                   [k] kmem_cache_alloc
     0.97%               git  [kernel]                   [k] get_page_from_freelist
     0.92%               git  [kernel]                   [k] copy_page_range
     0.88%               git  [kernel]                   [k] clear_page_c
     0.80%               git  [kernel]                   [k] find_vma
     0.79%               git  /lib64/ld-2.10.1.so        [.] _dl_lookup_symbol_x
     0.68%               git  [kernel]                   [k] handle_mm_fault
     0.68%               git  /lib64/libc-2.10.1.so      [.] _int_malloc
     0.63%               git  /bin/bash                  0x00000000046e96
     0.57%               git  /lib64/libc-2.10.1.so      [.] __GI__dl_addr
     0.51%               git  [kernel]                   [k] release_pages

 - after:

     3.02%               git  [kernel]                   [k] unmap_vmas
     2.74%               git  [kernel]                   [k] page_fault
     1.32%               git  [kernel]                   [k] copy_page_c
     1.23%               git  [kernel]                   [k] _spin_lock
     1.17%           git-svn  [kernel]                   [k] copy_page_range
     1.06%               git  [kernel]                   [k] copy_page_range
     0.99%               git  /lib64/ld-2.10.1.so        [.] do_lookup_x
     0.95%               git  /lib64/libc-2.10.1.so      [.] _int_malloc
     0.83%               git  [kernel]                   [k] get_page_from_freelist
     0.83%               git  /lib64/libc-2.10.1.so      [.] __GI__dl_addr
     0.82%               git  [kernel]                   [k] clear_page_c
     0.70%               git  [kernel]                   [k] kmem_cache_alloc
     0.65%               git  [kernel]                   [k] handle_mm_fault
     0.62%               git  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so  [.] Perl_yyparse
     0.60%           git-svn  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so  [.] Perl_yyparse
     0.59%               git  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so  [.] Perl_yylex
     0.58%               git  [kernel]                   [k] release_pages
     0.58%               git  [kernel]                   [k] page_remove_rmap
     0.57%               git  /bin/bash                  0x0000000004c2df
     0.55%           git-svn  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so  [.] Perl_yylex
     0.52%               git  [kernel]                   [k] find_vma
     0.52%               git  [kernel]                   [k] strnlen_user
     0.52%           git-svn  /lib64/libc-2.10.1.so      [.] _int_malloc

Interesting to see how after the change, perl is now looking like a fairly 
big part.

The big picture (not per-function, but per-program split by code segment: 
kernel, executable, library) shows the same thing. git does have a high 
kernel component in general, but something like "make test" makes it even 
bigger, since most of the costs are really forking a _lot_ of git 
programs:

- before:

    33.23%               git  [kernel]                 
    11.93%               git  /lib64/ld-2.10.1.so      
     7.55%           git-svn  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so
     6.82%               git  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so
     4.83%               git  /lib64/libc-2.10.1.so    
     3.28%           git-svn  [kernel]                 
     1.82%                sh  [kernel]                 
     1.57%               git  /bin/bash                
     1.52%              perl  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so
     1.37%           git-svn  /lib64/libc-2.10.1.so    
     1.28%              tput  [kernel]                 
     1.26%   git-filter-bran  [kernel]                 
     0.98%                rm  [kernel]                 
     0.97%               sed  [kernel]                 
     0.82%   git-rebase--int  [kernel]                 
     0.71%        git-bisect  [kernel]                 
     0.64%               git  ./git                    
     0.62%              grep  [kernel]                 
     0.55%               cat  [kernel]                 

 - after:

    30.30%               git  [kernel]                 
    10.62%           git-svn  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so
     9.77%               git  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so
     6.31%               git  /lib64/libc-2.10.1.so    
     4.31%           git-svn  [kernel]                 
     3.49%               git  /lib64/ld-2.10.1.so      
     2.17%               git  /bin/bash                
     2.10%              perl  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so
     1.93%           git-svn  /lib64/libc-2.10.1.so    
     1.90%                sh  [kernel]                 
     1.40%   git-filter-bran  [kernel]                 
     1.24%              tput  [kernel]                 
     0.95%               sed  [kernel]                 
     0.91%                rm  [kernel]                 
     0.89%               git  ./git                    
     0.84%   git-rebase--int  [kernel]                 
     0.82%   git-filter-bran  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so
     0.75%                sh  /usr/lib64/perl5/5.10.0/x86_64-linux-thread-multi/CORE/libperl.so
     0.59%                sh  /lib64/libc-2.10.1.so    
     0.57%              grep  [kernel]                 
     0.57%        git-bisect  [kernel]                 
     0.55%               cat  [kernel]                 

Note how the biggest user-space component used to be the dynamic loader. 
Now it's down there way below the perl overhead.

And notice how while the dynamic loader was "just" 11% of all overhead 
(and is still 3.5% after the fix), the reason performance has improved by 
30% is that the dynamic loader has a _huge_ kernel overhead due to the 
whole mmap/munmap/mprotect/page-fault-to-COW/etc code. 

		Linus
