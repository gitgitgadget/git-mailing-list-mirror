From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix up diffcore-rename scoring
Date: Sun, 12 Mar 2006 23:44:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603122316160.3618@g5.osdl.org>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
 <7vmzfusuyq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603122256550.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 13 08:44:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIhjY-0005Ue-VT
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 08:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWCMHou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 02:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWCMHou
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 02:44:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932324AbWCMHot (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 02:44:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D7ijDZ019593
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 23:44:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D7iigs031689;
	Sun, 12 Mar 2006 23:44:45 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0603122256550.3618@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17560>



On Sun, 12 Mar 2006, Linus Torvalds wrote:
> 
> Now, that said, they _both_ find some pretty funky renames. I think there 
> is probably some serious room for improvement, regardless (or at least 
> changing the default similarity cut-off to something better ;)

I'm afraid that _good_ rename detection really ends up wanting to take 
"longest possible sequence" into account, exactly like the full xdelta 
does. 

Instead of doing a fixed-chunk thing and saying that any copy is 
equivalent to any other copy. That's simply not true. It's _much_ better 
to have one 24-byte copy than it is to have three 8-byte copies, but the 
new faster diffcore-delta.c just can't see that.

So one big reason as to why it is fast in the first place is that it 
fundamentally just doesn't do a very good job ;(

It might be that the fast delta thing is a good way to ask "is this even 
worth considering", to cut down the O(m*n) rename/copy detection to 
something much smaller, and then use xdelta() to actually figure out what 
is a good rename and what isn't from a much smaller set of potential 
targets.

That would actually allow us to be even _less_ precise. Screw that big 
hash-table etc, don't even try to be exact. Just try to be fairly fast, 
and then pick the top entries from the similarity array for more precise 
diffing if there are multiple choices that look like they might be 
possible.

The appended alternate "diffcore-delta.c" doesn't do any of the caching 
(ie I wrote it so that it would be easy to change to make the _caller_ 
keeps "src" constant, and iterates over destination - or the other way 
around - and would do the hash setup just once per src).

Still, even with the existing setup, it's pretty fast for me (not much 
slower than your caching version even though it recalculates everything 
every time). And it's not that far off, which tells me that if it was used 
as a "first-pass filter", we could afford to do a better job on the things 
that it says are likely candidates.

Hmm? It really does bother me how the suggested rename detector finds 
stuff that clearly isn't. 

			Linus

----
#include "cache.h"
#include "diff.h"
#include "diffcore.h"

#define CHUNK (16)
#define SILLYSIZE (65537)
static int hashnr[SILLYSIZE];

static void setup_hash(void)
{
	memset(hashnr, 0, sizeof(hashnr));
}

static void insert_hash(unsigned int hashval)
{
	hashval = hashval % SILLYSIZE;
	hashnr[hashval]++;
}

static int find_hash(unsigned int hashval)
{
	hashval = hashval % SILLYSIZE;
	if (hashnr[hashval]) {
		hashnr[hashval]--;
		return 1;
	}
	return 0;
}

int diffcore_count_changes(void *src, unsigned long src_size,
			   void *dst, unsigned long dst_size,
			   void **src_count_p,
			   void **dst_count_p,
			   unsigned long delta_limit,
			   unsigned long *src_copied,
			   unsigned long *literal_added)
{
	unsigned long copied = 0;
	unsigned long literal = 0;

	setup_hash();
	while (src_size >= CHUNK) {
		unsigned int hashval = adler32(0, src, CHUNK);
		insert_hash(hashval);
		src += CHUNK;
		src_size -= CHUNK;
	}

	while (dst_size >= CHUNK) {
		unsigned int hashval = adler32(0, dst, CHUNK);
		if (find_hash(hashval)) {
			copied += CHUNK;
			dst += CHUNK;
			dst_size -= CHUNK;
			continue;
		}
		literal++;
		if (literal > delta_limit)
			return -1;
		dst++;
		dst_size--;
	}
	literal += dst_size;

	*src_copied = copied;
	*literal_added = literal;
	return 0;
}
