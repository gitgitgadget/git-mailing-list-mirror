From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fix object re-hashing
Date: Mon, 13 Feb 2006 00:55:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602130007320.9507@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602121006360.3691@g5.osdl.org> <7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602121037460.3691@g5.osdl.org> <Pine.LNX.4.64.0602121101040.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 00:55:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8R4N-0000If-Uq
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 00:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWBLXzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 18:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWBLXzv
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 18:55:51 -0500
Received: from mail.gmx.net ([213.165.64.21]:30093 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751494AbWBLXzv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 18:55:51 -0500
Received: (qmail invoked by alias); 12 Feb 2006 23:55:44 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp036) with SMTP; 13 Feb 2006 00:55:44 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602121101040.3691@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16028>

Hi,

On Sun, 12 Feb 2006, Linus Torvalds wrote:

> [something about the overflow in another mail]

Thank you for thinking it through! I was soooo stuck with my original 
idea: Ideally (i.e. if there are no collisions), if the hashtable is 
doubled in size, then each offset should either stay the same, or be just 
incremented by the original size (since the index is the hash modulo the 
hashtable size).

So I wanted to be clever about resizing, and just increment the offset if 
necessary. As it turns out, it's more complicated than that. You have to 
make sure that those entries which collided  with another entry, but do no 
longer, are adjusted appropriately.

And the overflow problem eluded my attention entirely. (I feel quite silly 
about it, because I fixed so many buffer-overflow problems myself, and 
the cause of the problem is the same there.)

> On Sun, 12 Feb 2006, Linus Torvalds wrote:
> > 
> >  - the "overflow of the overflow": when the linear probing itself 
> >    overflows the size of the hash queue, it will "change direction" by 
> >    overflowing back to index zero.
> > 
> >    Happily, the re-hashing does not need to care about this case, because 
> >    the new hash is bigger: the rule we have when doing the re-hashing is 
> >    that as we re-hash, the "i" entries we have already re-hashed are all 
> >    valid in the new hash, so even if overflow occurs, it will occur the 
> >    right way (and if it overflows all the way past the current "i", we'll 
> >    re-hash the already re-hashed entry anyway).
> 
> Btw, this is only always true if the new hash is at least twice the size 
> of the old hash, I think. Otherwise a re-hash can fill up the new entries 
> and overflow entirely before we've actually even re-hashed all the old 
> entries, and then we'd need to re-hash even the overflowed entries (which 
> are now below "i").

After thinking long and hard about it, I tend to agree.

Note: I chose the factor 2 because hashtables tend to have *awful* 
performance when space becomes scarce. So, 2 is not only a wise choice for 
rehashing, but for the operation in general.

> Anyway, if all this makes you nervous, the conceptually much simpler way 
> to do the re-sizing is to not do the in-place re-hashing. Instead of doing 
> the xrealloc(), just do a "xmalloc()" of the new area, do the re-hashing 
> (which now _must_ re-hash in just the "0..oldcount-1" old area) into the 
> new area, and then free the old area after rehashing.
> 
> That would make things more obviously correct, and perhaps simpler.
> 
> Johannes, do you want to try that?

I do not particularly like it, since doubling the hashtable size is not 
particularly space efficient, and this makes it worse. Anyway, see below.

> Btw, as it currently stands, I worry a tiny tiny bit about the
> 
> 	obj_allocs = (obj_allocs < 32 ? 32 : 2 * obj_allocs)
> 
> thing, because I think that second "32" needs to be a "64" to be really 
> safe (ie guarantee that the new obj_allocs value is always at least twice 
> the old one).

As Junio already pointed out: obj_allocs is initially set to 0. But you're 
right, it is conceptually wrong.

> Anyway, I'm pretty sure people smarter than me have already codified 
> exactly what needs to be done for a in-place rehash of a linear probe hash 
> overflow algorithm. This must all be in some "hashing 101" book. I had to 
> think it through from first principles rather than "knowing" what the 
> right answer was (which probably means that I slept through some 
> fundamental algorithms class in University ;)

Well, it seems like a long time, doesn't it? But I always liked the 
Fibonacci numbers, and therefore the Fibonacci heap.

---

Make hashtable resizing more robust AKA do not resize in-place

diff --git a/object.c b/object.c
index c9ca481..94f0f5d 100644
--- a/object.c
+++ b/object.c
@@ -56,18 +56,14 @@ void created_object(const unsigned char 
 
 	if (obj_allocs - 1 <= nr_objs * 2) {
 		int i, count = obj_allocs;
-		obj_allocs = (obj_allocs < 32 ? 32 : 2 * obj_allocs);
-		objs = xrealloc(objs, obj_allocs * sizeof(struct object *));
-		memset(objs + count, 0, (obj_allocs - count)
-				* sizeof(struct object *));
-		for (i = 0; i < obj_allocs; i++)
-			if (objs[i]) {
-				int j = find_object(objs[i]->sha1);
-				if (j != i) {
-					j = -1 - j;
-					objs[j] = objs[i];
-					objs[i] = NULL;
-				}
+		struct object** old_objs = objs;
+		obj_allocs = (obj_allocs < 32 ? 64 : 2 * obj_allocs);
+		objs = xcalloc(obj_allocs, sizeof(struct object *));
+		for (i = 0; i < count; i++)
+			if (old_objs[i]) {
+				/* it is guaranteed to be new */
+				int j = -1 - find_object(old_objs[i]->sha1);
+				objs[j] = old_objs[i];
 			}
 	}
 
