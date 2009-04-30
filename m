From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
	dscms and a "whole product" approach)
Date: Thu, 30 Apr 2009 11:43:19 -0700
Message-ID: <20090430184319.GP23604@spearce.org>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3ocugod96.fsf@localhost.localdomain> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:44:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzbEH-0002H5-2G
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 20:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762279AbZD3SnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 14:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbZD3SnU
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 14:43:20 -0400
Received: from george.spearce.org ([209.20.77.23]:60534 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbZD3SnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 14:43:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 90FC33806F; Thu, 30 Apr 2009 18:43:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118034>

Michael Witten <mfwitten@gmail.com> wrote:
> On Thu, Apr 30, 2009 at 07:17, Jakub Narebski <jnareb@gmail.com> wrote:
> > I hope that JGit developers can
> > tell us whether using higher level language affects performance, how
> > much, and what features of higher-level language are causing decrease
> > in performance.
> 
> Java is definitely higher than C, but you can do some pretty low-level
> operations on bits and bytes and the like, not to mention the presence
> of a JIT.

But its still costly compared to C.
 
> My point: I don't think that Java can tell us anything special in this regard.

Sure it can.

Peff I think made a good point here, that we rely on a lot of small
tweaks in the C git code to get *really* good performance.  5% here,
10% there, and suddenly you are 60% faster than you were before.
Nico, Linus, Junio, they have all spent some time over the past
3 or 4 years trying to tune various parts of Git to just flat out
run fast.

Higher level languages hide enough of the machine that we can't
make all of these optimizations.

JGit struggles with not having mmap(), or when you do use Java NIO
MappedByteBuffer, we still have to copy to a temporary byte[] in
order to do any real processing.  C Git avoids that copy.  Sure,
other higher level langauges may offer a better mmap facility,
but they also tend to offer garbage collection and most try to tie
the mmap management into the GC "for safety and ease of use".

JGit struggles with not having unsigned types in Java.  There are
many locations in JGit where we really need "unsigned int32_t" or
"unsigned long" (largest machine word available) or "unsigned char"
but these types just don't exist in Java.  Converting a byte up to
an int just to treat it as an unsigned requires an extra " & 0xFF"
operation to remove the sign extension.

JGit struggles with not having an efficient way to represent a SHA-1.
C can just say "unsigned char[20]" and have it inline into the
container's memory allocation.  A byte[20] in Java will cost an
*additional* 16 bytes of memory, and be slower to access because
the bytes themselves are in a different area of memory from the
container object.  We try to work around it by converting from a
byte[20] to 5 ints, but that costs us machine instructions.

C Git takes for granted that memcpy(a, b, 20) is dirt cheap when
doing a copy from an inflated tree into a struct object.  JGit has
to pay a huge penalty to copy that 20 byte region out into 5 ints,
because later on, those 5 ints are cheaper.

Other higher level languages also lack the ability to mark a
type unsigned.  Or face similiar penalties with storing a 20 byte
binary region.

Native Java collection types have been a snare for us in JGit.
We've used java.util.* types when they seem to be handy and already
solve the data structure problem at hand, but they tend to preform
a lot worse than writing a specialized data structure.

For example, we have ObjectIdSubclassMap for what should be
Map<ObjectId,Object>.  Only it requires that the Object type you
use as the "value" entry in the map extend from ObjectId, as the
instance serves as both key *and* value.  But it screams when
compared to HashMap<ObjectId,Object>.  (For those who don't know,
ObjectId is JGit's "unsigned char[20]" for a SHA-1.)

Just a day or so ago I wrote LongMap, a faster HashMap<Long,Object>,
for hashing objects by indexes in a pack file.  Again, the boxing
costs in Java to convert a "long" (largest integer type) into an
Object that the standard HashMap type would accept was rather high.

Right now, JGit is still paying dearly when it comes to ripping
apart a commit or a tree object to follow the object links.  Or when
invoking inflate().  We spend a lot more time doing this sort of work
than C git does, and yet we're trying to be as close to the machine
as we can go by using byte[] whenever possible, by avoiding copying
whenever possible, and avoiding memory allocation when possible.

Notably, `rev-list --objects --all` takes about 2x as long in
JGit as it does in C Git on a project like the linux kernel, and
`index-pack` for the full ~270M pack file takes about 2x as long.

Both parts of JGit are about as good as I know how to make them,
but we're really at the mercy of the JIT, and changes in the JIT
can cause us to perform worse (or better) than before.  Unlike in
C Git where Linus has done assembler dumps of sections of code and
tried to determine better approaches.  :-)

So. Yes, its practical to build Git in a higher level language, but
you just can't get the same performance, or tight memory utilization,
that C Git gets.  That's what that higher level language abstraction
costs you.  But, JGit performs reasonably well; well enough that
we use internally at Google as a git server.

-- 
Shawn.
