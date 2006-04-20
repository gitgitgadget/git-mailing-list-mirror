From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 15:35:27 -0700
Message-ID: <7vy7xzvpsg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
	<20060420150315.GB31198@spearce.org>
	<Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
	<20060420164351.GB31738@spearce.org>
	<Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
	<20060420175554.GH31738@spearce.org>
	<Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
	<7v8xq0yteb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604201630320.2215@localhost.localdomain>
	<7vfyk8vscl.fsf@assigned-by-dhcp.cox.net>
	<20060420220240.GB32748@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 00:35:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWhkL-0007uP-8y
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 00:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWDTWfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWDTWfa
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 18:35:30 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:474 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932093AbWDTWf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 18:35:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420223528.DWOH24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 18:35:28 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19005>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> The list is sorted by type then hash then size (type_size_sort),
>> so if you have t/Makefile that are big medium small too-small
>> and then doc/Makefile that are big medium, once you see the
>> too-small t/Makefile it would not consider the big doc/Makefile
>> as a candidate X-<.
>> 
>> This _might_ improve things:
>>... 
>
> Holy cow, it did:
>
>   Total 46391, written 46391 (delta 8391), reused 37774 (delta 0)
>    46M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
>
> That's the smallest packing I've seen yet.  And it doesn't have a
> negative affect on repacking GIT either.

Thanks for trying.  Mind trying one more?

I suspect the test patch makes pack-objects a lot more
expensive.

The code before the test patch said "if the size is very small
or size difference is too great, do not consider this, and do
not consider any more objects in the delta window, because we
know they are either even smaller of the same path, they have
different names, or they are of different type".  The test patch
you tried was a quick and dirty hack that said "under the
too-small condition, skip this one, but keep trying the rest of
the delta window".

Here is a cleaned up patch.  What it does is "under the
too-small condition, see if the object has the same basename,
and if so keep going, but otherwise skip the rest as before".

If you have objects like this and are trying to pack the first
object (this list is sorted in the order pack-object tries):

       (size)	(path)
	1000	t/0-11-AdjLite.deg
          10	t/0-11-AdjLite.deg
         800	s/0-11-AdjLite.deg
	  20	t/0-12-AdjLite.deg

the current code stops after checking t/0-11-AdjLite.deg.  The
test patch tries all of them.  This patch skips that file, but
tries "s/0-11-AdjLite.deg", and then stops at the next one.

-- >8 --

diff --git a/pack-objects.c b/pack-objects.c
index 09f4f2c..2173709 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1036,8 +1036,6 @@ static int try_delta(struct unpacked *cu
 	oldsize = old_entry->size;
 	sizediff = oldsize > size ? oldsize - size : size - oldsize;
 
-	if (size < 50)
-		return -1;
 	if (old_entry->depth >= max_depth)
 		return 0;
 
@@ -1048,20 +1046,27 @@ static int try_delta(struct unpacked *cu
 	 * more space-efficient (deletes don't have to say _what_ they
 	 * delete).
 	 */
-	max_size = size / 2 - 20;
-	if (cur_entry->delta)
-		max_size = cur_entry->delta_size-1;
-	if (sizediff >= max_size)
-		return -1;
-	delta_buf = diff_delta(old->data, oldsize,
-			       cur->data, size, &delta_size, max_size);
-	if (!delta_buf)
+	if (50 <= size) {
+		max_size = size / 2 - 20;
+		if (cur_entry->delta)
+			max_size = cur_entry->delta_size-1;
+		if (sizediff < max_size) {
+			delta_buf = diff_delta(old->data, oldsize,
+					       cur->data, size,
+					       &delta_size, max_size);
+			if (!delta_buf)
+				return 0;
+			cur_entry->delta = old_entry;
+			cur_entry->delta_size = delta_size;
+			cur_entry->depth = old_entry->depth + 1;
+			free(delta_buf);
+			return 0;
+		}
+	}
+	/* Keep going as long as the basename matches */
+	if (((cur_entry->hash ^ old_entry->hash) >>DIRBITS) == 0)
 		return 0;
-	cur_entry->delta = old_entry;
-	cur_entry->delta_size = delta_size;
-	cur_entry->depth = old_entry->depth + 1;
-	free(delta_buf);
-	return 0;
+	return -1;
 }
 
 static void progress_interval(int signum)
