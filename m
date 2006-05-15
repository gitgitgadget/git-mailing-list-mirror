From: Nicolas Pitre <nico@cam.org>
Subject: pack-object mystery explained
Date: Mon, 15 May 2006 11:29:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605132305580.18071@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_/mn/fRq/j4su0Y47Lzv3cA)"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:30:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fff1C-0005sl-Io
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWEOP3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWEOP3r
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:29:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61496 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964949AbWEOP3q
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 11:29:46 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZB004RZCDDZYE0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 May 2006 11:29:38 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Content-id: <Pine.LNX.4.64.0605142133310.18071@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20056>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_/mn/fRq/j4su0Y47Lzv3cA)
Content-id: <Pine.LNX.4.64.0605142133311.18071@localhost.localdomain>
Content-type: TEXT/PLAIN; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT

As Junio certainly knows since he added it himself, there is some code 
currently surrounded with #if 0 ... #endif in pack-objects.c that was 
meant to improve delta window usage.

The idea was to _not_ keep any object in the object window which delta 
depth reached the maximum depth since it obviously cannot be used as a 
base for any further deltification anyway.  In doing so the object 
window would always be filled only with objects that are not too deep 
and therefore increase the possibility for better delta match.

In theory... only.

Because, in practice, doing so produces pack files that are between 20% 
to 60% *larger* than without this "optimization".

This is just so counter-intuitive that I wanted to find out why.  So I 
added a few lines to output the target object sha1, and the sha1 of each 
object in the object window as well as the return code from try_delta(), 
the object depth and the size of the best delta, something like the 
attached patch.  Then diffing the output between a run with the code as 
is and another run with the "optimization" enabled produce a really 
interesting result.

Looking at the diff:

--- /tmp/l1      2006-05-13 22:38:06.000000000 -0400
+++ /tmp/l2     2006-05-13 23:04:53.000000000 -0400
@@ -1255,7 +1255,6 @@
  0 src 57cefdea530171c71c72229a85aa0212dedb2c5a depth 5 delta_sz 115
 nbdelta = 34 deltasz = 25794
 trg f24cfd2b46a65bde53610eecb6998fa615b62363
- 0 src 0b90fb9ae3396d0f2b0a9ebf9acad8374f3db317 depth 10 delta_sz 0
  1 src 8866189332568a317183f6f895014519515f67e7 depth 9 delta_sz 20146
  1 src 4c1b0c3039a84c4c786a09ba70a84df46f995186 depth 8 delta_sz 3357
  0 src 226d71966d4a0e8a8611ea09e35719688a987ceb depth 7 delta_sz 3357
@@ -1265,10 +1264,10 @@
  0 src e44310f5a8115011eafce41362d1752c4ee0f72f depth 3 delta_sz 1365
  0 src b35d400ee1a2e8b5c97ca6ad82f6d91818519456 depth 2 delta_sz 1365
  0 src b60fa8d2417c32cf72331e9869d4d3a3208e953f depth 2 delta_sz 1365
+ 0 src 57cefdea530171c71c72229a85aa0212dedb2c5a depth 5 delta_sz 1365
 nbdelta = 35 deltasz = 27159
 trg 553e1e1749ab537a71c7a1cfb97f18f85dc9ef1f
  1 src f24cfd2b46a65bde53610eecb6998fa615b62363 depth 6 delta_sz 990
- 0 src 0b90fb9ae3396d0f2b0a9ebf9acad8374f3db317 depth 10 delta_sz 990
  0 src 8866189332568a317183f6f895014519515f67e7 depth 9 delta_sz 990
  0 src 4c1b0c3039a84c4c786a09ba70a84df46f995186 depth 8 delta_sz 990
  0 src 226d71966d4a0e8a8611ea09e35719688a987ceb depth 7 delta_sz 990
@@ -1277,11 +1276,11 @@
  0 src 42b0d59e8c15dff0d72b0d3a486d0248bd767dfe depth 4 delta_sz 248
  0 src e44310f5a8115011eafce41362d1752c4ee0f72f depth 3 delta_sz 248
  0 src b35d400ee1a2e8b5c97ca6ad82f6d91818519456 depth 2 delta_sz 248
+ 0 src b60fa8d2417c32cf72331e9869d4d3a3208e953f depth 2 delta_sz 248
 nbdelta = 36 deltasz = 27407
[...]

So the object that reached a delta depth of 10 is clearly not added to 
the window in the second log.

But here's the interesting part:

 trg f3c92c971e65e9df72fafdab52b4935866a0a794
- 0 src e85f1c17089a1da95b264909cfc50235c74471da depth 10 delta_sz 0
- 0 src 134d405ba2e6dd41c7501aa9e078a8879ba8025f depth 10 delta_sz 0
- 0 src 6a241aab054a8d6b5c021aba77bba795d7684196 depth 10 delta_sz 0
- 0 src 85cd595802ca565f380a9851efd5a3551c959db0 depth 10 delta_sz 0
- 0 src 89fda42efb678d2f9f9e802454fe561b4452a167 depth 10 delta_sz 0
- 0 src c10067c17ff9eef3ce0f01e5c14ba86bd2273d54 depth 10 delta_sz 0
- 0 src 8e953a67596cf0f5c12f2d8c66055759a7d2201c depth 10 delta_sz 0
  1 src 553e1e1749ab537a71c7a1cfb97f18f85dc9ef1f depth 6 delta_sz 6223
  0 src f24cfd2b46a65bde53610eecb6998fa615b62363 depth 6 delta_sz 6223
- 0 src 0b90fb9ae3396d0f2b0a9ebf9acad8374f3db317 depth 10 delta_sz 6223
-nbdelta = 44 deltasz = 40076
+ 1 src 8866189332568a317183f6f895014519515f67e7 depth 9 delta_sz 5135
+ 0 src 4c1b0c3039a84c4c786a09ba70a84df46f995186 depth 8 delta_sz 5135
+ 0 src 226d71966d4a0e8a8611ea09e35719688a987ceb depth 7 delta_sz 5135
+ 0 src 78129ec0cd5fb9767caefee8a8dc1a17dc095bdb depth 6 delta_sz 5135
+ 0 src 93a50b4444e3bba210f6879795979d0894ad5aaf depth 5 delta_sz 5135
+ 0 src 42b0d59e8c15dff0d72b0d3a486d0248bd767dfe depth 4 delta_sz 5135
+ 0 src e44310f5a8115011eafce41362d1752c4ee0f72f depth 3 delta_sz 5135
+ 0 src b35d400ee1a2e8b5c97ca6ad82f6d91818519456 depth 2 delta_sz 5135
+nbdelta = 44 deltasz = 38988
 trg fe925609b4024119c6171dd32350a6570bea8516
- 1 src f3c92c971e65e9df72fafdab52b4935866a0a794 depth 7 delta_sz 99
- 0 src e85f1c17089a1da95b264909cfc50235c74471da depth 10 delta_sz 99
- 0 src 134d405ba2e6dd41c7501aa9e078a8879ba8025f depth 10 delta_sz 99
- 0 src 6a241aab054a8d6b5c021aba77bba795d7684196 depth 10 delta_sz 99
- 0 src 85cd595802ca565f380a9851efd5a3551c959db0 depth 10 delta_sz 99
- 0 src 89fda42efb678d2f9f9e802454fe561b4452a167 depth 10 delta_sz 99
- 0 src c10067c17ff9eef3ce0f01e5c14ba86bd2273d54 depth 10 delta_sz 99
- 0 src 8e953a67596cf0f5c12f2d8c66055759a7d2201c depth 10 delta_sz 99
- 0 src 553e1e1749ab537a71c7a1cfb97f18f85dc9ef1f depth 6 delta_sz 99
- 0 src f24cfd2b46a65bde53610eecb6998fa615b62363 depth 6 delta_sz 99
-nbdelta = 45 deltasz = 40175
+ 1 src 553e1e1749ab537a71c7a1cfb97f18f85dc9ef1f depth 6 delta_sz 6006
+ 0 src f24cfd2b46a65bde53610eecb6998fa615b62363 depth 6 delta_sz 6006
+ 1 src 8866189332568a317183f6f895014519515f67e7 depth 9 delta_sz 5027
+ 0 src 4c1b0c3039a84c4c786a09ba70a84df46f995186 depth 8 delta_sz 5027
+ 0 src 226d71966d4a0e8a8611ea09e35719688a987ceb depth 7 delta_sz 5027
+ 0 src 78129ec0cd5fb9767caefee8a8dc1a17dc095bdb depth 6 delta_sz 5027
+ 0 src 93a50b4444e3bba210f6879795979d0894ad5aaf depth 5 delta_sz 5027
+ 0 src 42b0d59e8c15dff0d72b0d3a486d0248bd767dfe depth 4 delta_sz 5027
+ 0 src e44310f5a8115011eafce41362d1752c4ee0f72f depth 3 delta_sz 5027
+ 0 src b35d400ee1a2e8b5c97ca6ad82f6d91818519456 depth 2 delta_sz 5027
+nbdelta = 45 deltasz = 44015
[...]

Here we can see that f3c92c97 benefits from a window that has none of 
those objects with a depth of 10 so it can find a better delta base.  
But in doing so it becomes itself depth 10 and is therefore discarded 
from the object window right away.  And the unfortunate fact is that 
f3c92c97 would have been the best base for the next object (fe925609) by 
far with a delta size of 99 bytes instead of 5027 bytes.

And then the story repeats itself for a while since fe925609 also 
becomes depth 10 which means the object window doesn't get refreshed as 
long as best match are based on 88661893 with a delta size around 5000 
bytes instead of 100 bytes if f3c92c97 didn't reach depth 10 initially.

So it is like a priority inversion problem. Instead of evicting max 
depth objects early to always have a full window of potential usable 
base object to delta against andimprove the delta packing, this early 
eviction of objects with max depth may enter a perverse state where the 
object window is not recycled with new objects for a while, which is 
especially bad if the window content is the source of suboptimal delta 
matches.  And that perverse state will remain until the delta match 
becomes bad enough to break the link with 88661893.

I thought about recording the second best delta base for any object that 
reached maximum delta depth and reverting to that base whenever an 
object of maximum depth would allow for a delta of greater saving if it 
wasn't of max depth already and could be used as a delta base again.  
But this quickly gets complicated if we want to retroactively consider 
previous objects that didn't constitute a good enough saving to motivate 
the switch of given object to its second best base but could benefit 
from such a switch if some other objects are making that switch anyway, 
and then it would be necessary to make sure not to exceed the depth of 
objects already deltified from the object we're considering moving, 
etc.  In short it gets really twisted for an incertain gain.

But... there is still a way to improve things with a really really 
simple euristic...


Nicolas

--Boundary_(ID_/mn/fRq/j4su0Y47Lzv3cA)
Content-id: <Pine.LNX.4.64.0605140008140.18071@localhost.localdomain>
Content-type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=trace.patch
Content-transfer-encoding: 7BIT
Content-disposition: ATTACHMENT; FILENAME=trace.patch
Content-description:

diff --git a/pack-objects.c b/pack-objects.c
index 523a1c7..8ff7f30 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1116,8 +1116,10 @@ static void find_deltas(struct object_en
 		if (!n->index)
 			die("out of memory");
 
+fprintf(stderr, "trg %s\n", sha1_to_hex(entry->sha1));
 		j = window;
 		while (--j > 0) {
+			int rc;
 			unsigned int other_idx = idx + j;
 			struct unpacked *m;
 			if (other_idx >= window)
@@ -1125,10 +1127,15 @@ static void find_deltas(struct object_en
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			if (try_delta(n, m, m->index, depth) < 0)
+			rc = try_delta(n, m, m->index, depth);
+fprintf(stderr, "% d src %s depth %d delta_sz %d\n", rc, sha1_to_hex(m->entry->sha1), m->entry->depth, n->entry->delta_size);
+			if (rc < 0)
 				break;
 		}
+static int nbdelta=0, deltasz=0;
+if (n->entry->delta) nbdelta++, deltasz += n->entry->delta_size;
+fprintf(stderr, "nbdelta = %d deltasz = %d\n", nbdelta, deltasz);
 #if 1
 		/* if we made n a delta, and if n is already at max
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.

--Boundary_(ID_/mn/fRq/j4su0Y47Lzv3cA)--
