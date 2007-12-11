From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 08:33:21 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>  <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>  <alpine.LFD.0.99999.0712102231570.555@xanadu.home>  <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>   <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com> <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,         gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: gcc-return-142911-gcc=m.gmane.org@gcc.gnu.org Tue Dec 11 17:35:02 2007
Return-path: <gcc-return-142911-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J284A-0005Y5-9t
	for gcc@gmane.org; Tue, 11 Dec 2007 17:34:42 +0100
Received: (qmail 4321 invoked by alias); 11 Dec 2007 16:34:23 -0000
Received: (qmail 4308 invoked by uid 22791); 11 Dec 2007 16:34:22 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Dec 2007 16:34:10 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBGXM1r017779 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Tue, 11 Dec 2007 08:33:23 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBGXLI1031101; 	Tue, 11 Dec 2007 08:33:21 -0800
In-Reply-To: <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67883>



On Tue, 11 Dec 2007, Jon Smirl wrote:
> 
> So why does our threaded code take 20 CPU minutes longer (12%) to run
> than the same code with a single thread?

Threaded code *always* takes more CPU time. The only thing you can hope 
for is a wall-clock reduction. You're seeing probably a combination of 
 (a) more cache misses
 (b) bigger dataset active at a time
and a probably fairly miniscule
 (c) threading itself tends to have some overheads.

> Q6600 is just two E6600s in the same package, the caches are not shared.

Sure they are shared. They're just not *entirely* shared. But they are 
shared between each two cores, so each thread essentially has only half 
the cache they had with the non-threaded version.

Threading is *not* a magic solution to all problems. It gives you 
potentially twice the CPU power, but there are real downsides that you 
should keep in mind.

> Why does the threaded code need 2.24GB (google allocator, 2.85GB gcc)
> with 4 threads? But only need 950MB with one thread? Where's the extra
> gigabyte going?

I suspect that it's really simple: you have a few rather big files in the 
gcc history, with deep delta chains. And what happens when you have four 
threads running at the same time is that they all need to keep all those 
objects that they are working on - and their hash state - in memory at the 
same time!

So if you want to use more threads, that _forces_ you to have a bigger 
memory footprint, simply because you have more "live" objects that you 
work on. Normally, that isn't much of a problem, since most source files 
are small, but if you have a few deep delta chains on big files, both the 
delta chain itself is going to use memory (you may have limited the size 
of the cache, but it's still needed for the actual delta generation, so 
it's not like the memory usage went away).

That said, I suspect there are a few things fighting you:

 - threading is hard. I haven't looked a lot at the changes Nico did to do 
   a threaded object packer, but what I've seen does not convince me it is 
   correct. The "trg_entry" accesses are *mostly* protected with 
   "cache_lock", but nothing else really seems to be, so quite frankly, I 
   wouldn't trust the threaded version very much. It's off by default, and 
   for a good reason, I think.

   For example: the packing code does this:

	if (!src->data) {
		read_lock();
		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
		read_unlock();
		...

   and that's racy. If two threads come in at roughly the same time and 
   see a NULL src->data, theÿ́'ll both get the lock, and they'll both 
   (serially) try to fill it in. It will all *work*, but one of them will 
   have done unnecessary work, and one of them will have their result 
   thrown away and leaked.

   Are you hitting issues like this? I dunno. The object sorting means 
   that different threads normally shouldn't look at the same objects (not 
   even the sources), so probably not, but basically, I wouldn't trust the 
   threading 100%. It needs work, and it needs to stay off by default.

 - you're working on a problem that isn't really even worth optimizing 
   that much. The *normal* case is to re-use old deltas, which makes all 
   of the issues you are fighting basically go away (because you only have 
   a few _incremental_ objects that need deltaing). 

   In other words: the _real_ optimizations have already been done, and 
   are done elsewhere, and are much smarter (the best way to optimize X is 
   not to make X run fast, but to avoid doing X in the first place!). The 
   thing you are trying to work with is the one-time-only case where you 
   explicitly disable that big and important optimization, and then you 
   complain about the end result being slow!

   It's like saying that you're compiling with extreme debugging and no
   optimizations, and then complaining that the end result doesn't run as 
   fast as if you used -O2. Except this is a hundred times worse, because 
   you literally asked git to do the really expensive thing that it really 
   really doesn't want to do ;)

> Is there another allocator to try? One that combines Google's
> efficiency with gcc's speed?

See above: I'd look around at threading-related bugs and check the way we 
lock (or don't) accesses.

		Linus
