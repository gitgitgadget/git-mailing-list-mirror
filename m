From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 11:39:49 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712061118050.13796@woody.linux-foundation.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <20071205.202047.58135920.davem@davemloft.net>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net>   <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>  <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> <1196968371.18340.30.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Berlin <dberlin@dberlin.org>, David Miller <davem@davemloft.net>,         ismail@pardus.org.tr, gcc@gcc.gnu.org, Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: gcc-return-142766-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 20:41:01 2007
Return-path: <gcc-return-142766-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0MaO-0000nU-DM
	for gcc@gmane.org; Thu, 06 Dec 2007 20:40:41 +0100
Received: (qmail 21099 invoked by alias); 6 Dec 2007 19:40:22 -0000
Received: (qmail 21089 invoked by uid 22791); 6 Dec 2007 19:40:21 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 19:40:15 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6JdpWB025893 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Thu, 6 Dec 2007 11:39:52 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6Jdn9E008421; 	Thu, 6 Dec 2007 11:39:50 -0800
In-Reply-To: <1196968371.18340.30.camel@ld0161-tx32>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67329>



On Thu, 6 Dec 2007, Jon Loeliger wrote:
>
> On Thu, 2007-12-06 at 00:09, Linus Torvalds wrote:
> > Git also does delta-chains, but it does them a lot more "loosely". There 
> > is no fixed entity. Delta's are generated against any random other version 
> > that git deems to be a good delta candidate (with various fairly 
> > successful heursitics), and there are absolutely no hard grouping rules.
> 
> I'd like to learn more about that.  Can someone point me to
> either more documentation on it?  In the absence of that,
> perhaps a pointer to the source code that implements it?

Well, in a very real sense, what the delta code does is:
 - just list every single object in the whole repository
 - walk over each object, trying to find another object that it can be 
   written as a delta against
 - write out the result as a pack-file

That's simplified: we may not walk _all_ objects, for example: only a 
global repack does that (and most pack creations are actually for pushign 
and pulling between two repositories, so we only walk the objects that are 
in the source but not the destination repository).

The interesting phase is the "walk each object, try to find a delta" part. 
In particular, you don't want to try to find a delta by comparing each 
object to every other object out there (that would be O(n^2) in objects, 
and with a fairly high constant cost too!). So what it does is to sort the 
objects by a few heuristics (type of object, base name that object was 
found as when traversing a tree and size, and how recently it was found in 
the history).

And then over that sorted list, it tries to find deltas between entries 
that are "close" to each other (and that's where the "--window=xyz" thing 
comes in - it says how big the window is for objects being close. A 
smaller window generates somewhat less good deltas, but takes a lot less 
effort to generate).

The source is in git/builtin-pack-objects.c, with the core of it being

 - try_delta() - try to generate a *single* delta when given an object 
   pair.

 - find_deltas() - do the actual list traversal

 - prepare_pack() and type_size_sort() - create the delta sort list from 
   the list of objects.

but that whole file is probably some of the more opaque parts of git.

> I guess one question I posit is, would it be more accurate
> to think of this as a "delta net" in a weighted graph rather
> than a "delta chain"?

It's certainly not a simple chain, it's more of a set of acyclic directed 
graphs in the object list. And yes, it's weigted by the size of the delta 
between objects, and the optimization problem is kind of akin to finding 
the smallest spanning tree (well, forest - since you do *not* want to 
create one large graph, you also want to make the individual trees shallow 
enough that you don't have excessive delta depth).

There are good algorithms for finding minimum spanning trees, but this one 
is complicated by the fact that the biggest cost (by far!) is the 
calculation of the weights itself. So rather than really worry about 
finding the minimal tree/forest, the code needs to worry about not having 
to even calculate all the weights!

(That, btw, is a common theme. A lot of git is about traversing graphs, 
like the revision graph. And most of the trivial graph problems all assume 
that you have the whole graph, but since the "whole graph" is the whole 
history of the repository, those algorithms are totally worthless, since 
they are fundamentally much too expensive - if we have to generate the 
whole history, we're already screwed for a big project. So things like 
revision graph calculation, the main performance issue is to avoid having 
to even *look* at parts of the graph that we don't need to see!)

			Linus
