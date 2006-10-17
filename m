From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 17:21:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610171706260.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
 <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
 <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sergey Vlasov <vsu@altlinux.ru>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 23:22:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZwOI-0006e5-MZ
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 23:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWJQVWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 17:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWJQVWA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 17:22:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:4087 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750984AbWJQVV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 17:21:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7A00MWKU03QQQ1@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 17:21:40 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29116>

On Tue, 17 Oct 2006, Linus Torvalds wrote:

> 
> 
> On Tue, 17 Oct 2006, Nicolas Pitre wrote:
> > On Tue, 17 Oct 2006, Sergey Vlasov wrote:
> > > 
> > > Yes, on x86_64 this is 24 because of 8-byte alignment for longs:
> > 
> > Ah bummer.  Then this is most likely the cause.  And here's a simple 
> > fix (Junio please confirm):
> 
> Why do you use "unsigned long" in the first place?

Because offsets into packs are expressed as unsigned long everywhere 
else (except in the current pack index on-disk format).

> For some structure like this, it sounds positively wrong. Pack-files 
> should be architecture-neutral, which means that they shouldn't depend on 
> word-size, and they should be in some neutral byte-order.

But they do.  Please consider this code:

	case OBJ_OFS_DELTA:
		memset(delta_base, 0, sizeof(*delta_base));
		c = pack_base[pos++];
		base_offset = c & 127;
		while (c & 128) {
			base_offset += 1;
			if (!base_offset || base_offset & ~(~0UL >> 7))
				bad_object(offset, "offset value overflow for delta base object");
			if (pos >= pack_limit)
				bad_object(offset, "object extends past end of pack");
			c = pack_base[pos++];
			base_offset = (base_offset << 7) + (c & 127);
		}
		delta_base->offset = offset - base_offset;
		if (delta_base->offset >= offset)
			bad_object(offset, "delta base offset is out of bound");
		break;

Do you see anything inerently wrong in this code?  The above is already 
64-bit ready such that it'll just work on 64-bit archs and will display 
a sensible message if a 32-bit arch encounter a pack larger than 4GB.  
But the on-disk pack format has no limitation what so ever.

> Quite frankly, this all makes me go "Eww..". The original pack-file (well, 
> v2) format was well-defined and had none of these issues. In contrast, the 
> new code in 'next' is just _ugly_.

I beg to differ.  Please reconsider in light of the above.

> And maybe it's just me, but I consider unions to be bug-prone on their 
> own. The "master" branch has exactly two unions: the "grep_expr" structure 
> contains one (where the union member is clearly defined by the node type 
> in that structure), and object.c has a "union any_object" that _literally_ 
> exists as purely an allocation size issue (ie it is used _only_ to 
> allocate the maximum size of any of the possible structures).
> 
> In contrast, the new union introduced in "next" is just horrid. There's 
> not even any way to know which member to use, except apparently that it 
> expects that a SHA1 is never zero in the last 12 bytes. Which is probably 
> true, but still - that's some ugly stuff.

This union should be looked at just like a sortable hash pointing to a 
base object so that deltas with the same base object can be sorted 
together.  And the field to use is well defined of course: deltas with 
sha1 to base use the sha1 member, deltas with offset to base use the 
offset member.  This hash, together with the delta type, constitute a 
tuple guaranteed to be unique so there can't be any confusion.

> Is this something you want to bet a big project on?

I don't see why not.


Nicolas
