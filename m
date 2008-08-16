From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: Casting and dereferencing of pointer
Date: Sat, 16 Aug 2008 21:24:08 +0300
Message-ID: <87y72w95tj.fsf@Astalo.kon.iki.fi>
References: <loom.20080816T093019-717@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Keywords: alignment,__alignof__
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 20:56:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUQwm-0001fn-OV
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 20:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbYHPSzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 14:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbYHPSzM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 14:55:12 -0400
Received: from 85-23-33-52-Rajakyla-TR1.suomi.net ([85.23.33.52]:56902 "EHLO
	Astalo.kon.iki.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750794AbYHPSzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 14:55:11 -0400
X-Greylist: delayed 2028 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Aug 2008 14:55:10 EDT
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1KUQRc-0001r1-Vc; Sat, 16 Aug 2008 21:24:08 +0300
In-Reply-To: <loom.20080816T093019-717@post.gmane.org> (sed's message of "Sat,
	16 Aug 2008 09:33:30 +0000 (UTC)")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92552>

sed <sed.nivo@gmail.com> writes:

> static void _parseItems(const unsigned char *pBuffer)
> {
>   unsigned int itemSize;
>   itemSize = *((unsigned int*)pBuffer); // this give system fault
>   memcpy(&itemSize, pBuffer, sizeof(unsigned int)); // this works well
>   .......
> }

On some processors, you get an exception or just wrong results
if you try to read a value from an address that is not properly
aligned for the type.  For example, a processor can require that
the address of any (signed or unsigned) int is divisible by 4.
Intel 8086 compatibles have historically allowed any alignment,
although even with them the code works faster if the alignment
is right.  GCC has an __alignof__ operator with which you can
check the alignment expected for a given type.

So, the *((unsigned int*)pBuffer) expression works portably only
if the correct alignment is somehow ensured.  The memcpy() call
works regardless of the alignment of the pBuffer pointer.

> static unsigned int hash_obj(struct object *obj, unsigned int n)
> {
> 	unsigned int hash = *(unsigned int *)obj->sha1;
> 	return hash % n;
> }

object.h defines struct object as:

| struct object {
| 	unsigned parsed : 1;
| 	unsigned used : 1;
| 	unsigned type : TYPE_BITS;
| 	unsigned flags : FLAG_BITS;
| 	unsigned char sha1[20];
| };

The structure has first an unsigned int that is split into
bitfields, and then unsigned char sha1[20].  If the compiler
works sensibly, then __alignof__(struct object) is the same as
__alignof__(unsigned int), and offsetof(struct object, sha1) is
sizeof(unsigned int); so if obj points to a correctly aligned
struct object, then obj->sha1 should also be correctly aligned
to be accessed as an unsigned int.

It seems somewhat brittle though: if someone adds a member
between flags and sha1, then the alignment may become wrong.
I think it would be good to add a comment in struct object
about the alignment requirement, or change hash_obj to use
memcpy (which might be slower).

> static int hashtable_index(const unsigned char *sha1)
> {
> 	unsigned int i;
> 	memcpy(&i, sha1, sizeof(unsigned int));
> 	return (int)(i % obj_hash_size);
> }

Here, the sha1 argument does not come from struct object and
might not be sufficiently aligned for unsigned int, so the
memcpy is necessary.  If you look with git blame, you'll find
the commit where the memcpy was added for just this reason.
