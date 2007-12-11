From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 11:17:08 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111055590.25032@woody.linux-foundation.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>  <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>  <alpine.LFD.0.99999.0712102231570.555@xanadu.home>  <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>   <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>  <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>  <alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org> <9e4733910712111043h6a361996x740f4dba3d742da5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,         gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: gcc-return-142919-gcc=m.gmane.org@gcc.gnu.org Tue Dec 11 20:18:00 2007
Return-path: <gcc-return-142919-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J2AcA-0000iR-7E
	for gcc@gmane.org; Tue, 11 Dec 2007 20:17:58 +0100
Received: (qmail 28609 invoked by alias); 11 Dec 2007 19:17:39 -0000
Received: (qmail 28601 invoked by uid 22791); 11 Dec 2007 19:17:38 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Dec 2007 19:17:28 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBJH97f023470 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Tue, 11 Dec 2007 11:17:10 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBJH8h8004777; 	Tue, 11 Dec 2007 11:17:08 -0800
In-Reply-To: <9e4733910712111043h6a361996x740f4dba3d742da5@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67911>



On Tue, 11 Dec 2007, Jon Smirl wrote:
> >
> > So if you want to use more threads, that _forces_ you to have a bigger
> > memory footprint, simply because you have more "live" objects that you
> > work on. Normally, that isn't much of a problem, since most source files
> > are small, but if you have a few deep delta chains on big files, both the
> > delta chain itself is going to use memory (you may have limited the size
> > of the cache, but it's still needed for the actual delta generation, so
> > it's not like the memory usage went away).
> 
> This makes sense. Those runs that blew up to 4.5GB were a combination
> of this effect and fragmentation in the gcc allocator. Google
> allocator appears to be much better at controlling fragmentation.

Yes. I think we do have some case where we simply keep a lot of objects 
around, and if we are talking reasonably large deltas, we'll have the 
whole delta-chain in memory just to unpack one single object.

The delta cache size limits kick in only when we explicitly cache old 
delta results (in case they will be re-used, which is rather common), it 
doesn't affect the normal "I'm using this data right now" case at all.

And then fragmentation makes it much much worse. Since the allocation 
patterns aren't nice (they are pretty random and depend on just the sizes 
of the objects), and the lifetimes aren't always nicely nested _either_ 
(they become more so when you disable the cache entirely, but that's just 
death for performance), I'm not surprised that there can be memory 
allocators that end up having some issues.

> Is there a reasonable scheme to force the chains to only be loaded
> once and then shared between worker threads? The memory blow up
> appears to be directly correlated with chain length.

The worker threads explicitly avoid touching the same objects, and no, you 
definitely don't want to explode the chains globally once, because the 
whole point is that we do fit 15 years worth of history into 300MB of 
pack-file thanks to having a very dense representation. The "loaded once" 
part is the mmap'ing of the pack-file into memory, but if you were to 
actually then try to expand the chains, you'd be talking about many *many* 
more gigabytes of memory than you already see used ;)

So what you actually want to do is to just re-use already packed delta 
chains directly, which is what we normally do. But you are explicitly 
looking at the "--no-reuse-delta" (aka "git repack -f") case, which is why 
it then blows up.

I'm sure we can find places to improve. But I would like to re-iterate the 
statement that you're kind of doing a "don't do that then" case which is 
really - by design - meant to be done once and never again, and is using 
resources - again, pretty much by design - wildly inappropriately just to 
get an initial packing done.

> That may account for the threaded version needing an extra 20 minutes
> CPU time.  An extra 12% of CPU seems like too much overhead for
> threading. Just letting a couple of those long chain compressions be
> done twice

Well, Nico pointed out that those things should all be thread-private 
data, so no, the race isn't there (unless there's some other bug there).

> I agree, this problem only occurs when people import giant
> repositories. But every time someone hits these problems they declare
> git to be screwed up and proceed to thrash it in their blogs.

Sure. I'd love to do global packing without paying the cost, but it really 
was a design decision. Thanks to doing off-line packing ("let it run 
overnight on some beefy machine") we can get better results. It's 
expensive, yes. But it was pretty much meant to be expensive. It's a very 
efficient compression algorithm, after all, and you're turning it up to 
eleven ;)

I also suspect that the gcc archive makes things more interesting thanks 
to having some rather large files. The ChangeLog is probably the worst 
case (large file with *lots* of edits), but I suspect the *.po files 
aren't wonderful either.

			Linus
