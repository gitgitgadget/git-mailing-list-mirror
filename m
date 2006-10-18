From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 21:38:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610172021320.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
 <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
 <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <7vr6x6ip5d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 03:38:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0OV-0002Mw-QB
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWJRBiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWJRBiw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:38:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54616 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751237AbWJRBiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 21:38:51 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7B001355WQR710@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 21:38:51 -0400 (EDT)
In-reply-to: <7vr6x6ip5d.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29172>

On Tue, 17 Oct 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Tue, 17 Oct 2006, Nicolas Pitre wrote:
> >> On Tue, 17 Oct 2006, Sergey Vlasov wrote:
> >> > 
> >> > Yes, on x86_64 this is 24 because of 8-byte alignment for longs:
> >> 
> >> Ah bummer.  Then this is most likely the cause.  And here's a simple 
> >> fix (Junio please confirm):
> >
> > Why do you use "unsigned long" in the first place?
> >
> > For some structure like this, it sounds positively wrong. Pack-files 
> > should be architecture-neutral, which means that they shouldn't depend on 
> > word-size, and they should be in some neutral byte-order.
> 
> This is an in-core structure if I am not mistaken, and is never
> written out in the resulting pack file.  The program is reading
> from .pack and building .idx that corresponds to it.  I agree
> that it is ugly, but I do not hink using neutral byte-order in
> this part of the processing buys us anything in this particular
> case.

Exact.

> > In contrast, the new union introduced in "next" is just horrid. There's 
> > not even any way to know which member to use, except apparently that it 
> > expects that a SHA1 is never zero in the last 12 bytes. Which is probably 
> > true, but still - that's some ugly stuff.
> 
> Again I agree with the ugliness objection, and I raised the
> "expecting no collision" issue which Nico refuted later.  The
> code is probably safe (not just safe in practice but safe in
> theory as well), although that would not change the fact that it
> is ugly X-<.

The problem is that I just don't see what you find "ugly" in the thing.
Maybe it is just a matter of few missing comments?

Please let me walk you through bits of the code. I hope you'll 
understand better why it is like it is after that.

In parse_pack_objects() you can read this:

        /*
         * First pass:
         * - find locations of all objects;
         * - calculate SHA1 of all non-delta objects;
         * - remember base SHA1 for all deltas.
         */

So we reads through the whole pack to find where objects are located. 
This information is stored in the objects[] array for all objects.  
Entries for that array are:

struct object_entry
{
        unsigned long offset;
        enum object_type type;
        enum object_type real_type;
        unsigned char sha1[20];
};

ON that first pass only the offset and type can be determined for all 
objects.  The sha1 can be determined for non delta objects only.

There is a second array, deltas[], to record information about deltas as 
they are found:

struct delta_entry
{
        struct object_entry *obj;
        union delta_base base;
};

The "obj" member points to the entry in the objects[] array for given 
delta entry.  And the "base" member, as you may guess, is a reference to 
the base object for that delta.

So here we are with that dreaded union.

Now why isn't it a second struct object_entry pointer instead?  Because 
one kind of delta allows for its base object to appear later in the pack 
and all we've got for identifying that base object is a sha1 reference 
since we cannot predict where the base object will be.  With the other 
object type we _could_ find out about the location of the base object 
right away.  But that would mean adding a special case for those objects 
through a different code path unnecessarily.  Instead, the base offset 
is treated just like a very special sha1 value and the same array is 
used.  So maybe the comment that says "remember base SHA1 for all 
deltas" could be adjusted to mention "base sha1 or offset" to be exact.

Now what next:

        /* Sort deltas by base SHA1/offset for fast searching */
        qsort(deltas, nr_deltas, sizeof(struct delta_entry),
              compare_delta_entry);

This comment, though, is extremely accurate.  We sort delta entries "for 
fast searching".  There is no other use for the union blob.  To avoid 
the union there could have been two separate delta arrays: one for 
OBJ_REF_DELTA and another for OBJ_OFS_DELTA.  Then two 
compare_delta_entry functions whould have been needed instead of only 
one.  But because we only use the union blob for searching given another 
such union blob for target, we actually don't care if the union content 
is a sha1 or an offset, and we don't care if that offset is 32-bit, 
64-bit, little endian or big endian.  All that we care about is that the 
delta entries are sorted according to that union blob for fast binary 
search.  That is really all there is about it and therefore a single 
qsort() does the trick.

Next:

        /*
         * Second pass:
         * - for all non-delta objects, look if it is used as a base for
         *   deltas;
         * - if used as a base, uncompress the object and apply all deltas,
         *   recursively checking if the resulting object is used as a base
         *   for some more deltas.
         */

Here we want to fill out the blanks in the objects[] array for delta 
objects.  It is of course much more efficient to start from a given base 
object, inflate it, and use it successively on all delta objects that 
depend on it.  And let's do it recursively if the delta is also a 
base object itself while at it.

So how does the dreaded union comes into play?  It is simple.  For each 
non-delta objects, we create two union blobs.  One with the sha1 member, 
the other with the offset member.  Those blobs are used as the key to 
search for a range of deltas that have that non-delta object for base.  
This has the possibility to find two ranges: one for deltas with base as 
sha1, and the other range for deltas with offsets as sha1.  Once the 
delta ranges are known, the deltas are applied on that base object, the 
resulting object's sha1 is computed and 
the whole thing is repeated for those resulting objects as potential 
base objects for more deltas.

Junio mentioned the possibility for collision between a union value that 
should be treated as a sha1 and a union value that should be treated as 
a delta base offset.  Although such a collision is extremely improbable, 
it is still possible and if so the wrong delta type could be applied on 
top of the wrong base object.  To avoid this issue, a test is made on 
the delta type before it is replayed.  So if the search key 
was created using the sha1 union member, we make sure that it is used 
with OBJ_REF_DELTA objects only.  And ditto for the search key created 
with the offset union member.  This way there just can not be any 
mistake even if there happens to be a collision in the base object 
reference namespace.

Finally, the objects[] array is completely populated with objects sha1 
and offsets. The dreaded union is completely forgotten (the deltas array 
is actually freed).  And only then the pack index is written out to 
disk.

> Nico, could we have an un-uglied version please?

I'm really sorry to say that I don't know how I could make it less 
"ugly".  To me it is beautiful and efficient as is and I don't see why 
it needs to be done another way.  If you still think otherwise then your 
guidance would be highly appreciated.


Nicolas
