From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Something is broken in repack
Date: Wed, 12 Dec 2007 08:54:28 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712120848130.25032@woody.linux-foundation.org>
References: <alpine.LFD.0.99999.0712112057390.555@xanadu.home> <alpine.LFD.0.99999.0712120743040.555@xanadu.home> <alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org> <20071212.084212.02518392.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: nico@cam.org, jonsmirl@gmail.com, gitster@pobox.com, gcc@gcc.gnu.org,         git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: gcc-return-142939-gcc=m.gmane.org@gcc.gnu.org Wed Dec 12 17:55:32 2007
Return-path: <gcc-return-142939-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J2Ure-00017q-3P
	for gcc@gmane.org; Wed, 12 Dec 2007 17:55:18 +0100
Received: (qmail 21271 invoked by alias); 12 Dec 2007 16:54:58 -0000
Received: (qmail 21263 invoked by uid 22791); 12 Dec 2007 16:54:57 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Dec 2007 16:54:47 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBCGsTHj022871 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Wed, 12 Dec 2007 08:54:30 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBCGsSUs019776; 	Wed, 12 Dec 2007 08:54:28 -0800
In-Reply-To: <20071212.084212.02518392.davem@davemloft.net>
X-MIMEDefang-Filter: lf$Revision: 1.188 $
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68074>



On Wed, 12 Dec 2007, David Miller wrote:
> 
> I personally don't think it's unreasonable for GIT to have it's
> own customized allocator at least for certain object types.

Well, we actually already *do* have a customized allocator, but currently 
only for the actual core "object descriptor" that really just has the SHA1 
and object flags in it (and a few extra words depending on object type).

Those are critical for certain loads, and small too (so using the standard 
allocator wasted a _lot_ of memory). In addition, they're fixed-size and 
never free'd, so a specialized allocator really can do a lot better than 
any general-purpose memory allocator ever could.

But the actual object *contents* are currently all allocated with whatever 
the standard libc malloc/free allocator is that you compile for (or load 
dynamically). Havign a specialized allocator for them is a much more 
involved issue, exactly because we do have interesting allocation patterns 
etc.

That said, at least those object allocations are all single-threaded (for 
right now, at least), so even when git does multi-threaded stuff, the core 
sha1_file.c stuff is always run under a single lock, and a simpler 
allocator that doesn't care about threads is likely to be much better than 
one that tries to have thread-local heaps etc.

I suspect that is what the google allocator does. It probably doesn't have 
per-thread heaps, it just uses locking (and quite possibly things like 
per-*size* heaps, which is much more memory-efficient and helps avoid some 
of the fragmentation problems). 

Locking is much slower than per-thread accesses, but it doesn't have the 
issues with per-thread-fragmentation and all the problems with one thread 
allocating and another one freeing.

			Linus
