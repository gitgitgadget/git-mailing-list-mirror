From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fixlets on top of Nico's clean-up.
Date: Wed, 29 Jun 2005 00:32:11 -0700
Message-ID: <7vpsu5ehz8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0506290246130.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 09:26:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnWws-00058a-PZ
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 09:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVF2Hc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 03:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVF2Hc2
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 03:32:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38354 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262465AbVF2HcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 03:32:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050629073211.ZOJF8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Jun 2005 03:32:11 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0506290246130.1667@localhost.localdomain> (Nicolas Pitre's message of "Wed, 29 Jun 2005 02:49:56 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Do we care about a corner case where delta_size is not smaller
than 4 bytes, *datap passed to get_delta_hdr_size() points at
some bytes before a mmaped page boundary, and all the bytes til
the end of that page have high-bit set?  The said inline
function would step over the page boundary and would presumably
segfault/sigbus.

Other than that, with the attached patch on top of it, I find
your clean-up very pleasant to read.  Please consider it acked.

------------
If we prefer 0 as maxsize for diff_delta() to say "unlimited",
let's be consistent about it.

This patch also fixes type mismatch in a call to get_delta_hdr_size() 
from packed_delta_info().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diffcore-break.c |    2 +-
 sha1_file.c      |   11 ++++-------
 test-delta.c     |    2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -65,7 +65,7 @@ static int should_break(struct diff_file
 
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
-			   &delta_size, ~0UL);
+			   &delta_size, 0);
 
 	/* Estimate the edit size by interpreting delta. */
 	if (count_delta(delta, delta_size,
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -598,9 +598,9 @@ static int packed_delta_info(unsigned ch
 			     char *type,
 			     unsigned long *sizep)
 {
-	unsigned char *data;
+	const unsigned char *data;
 	unsigned char delta_head[64];
-	unsigned long data_size, result_size, base_size, verify_base_size;
+	unsigned long result_size, base_size, verify_base_size;
 	z_stream stream;
 	int st;
 
@@ -609,13 +609,10 @@ static int packed_delta_info(unsigned ch
 	if (sha1_object_info(base_sha1, type, &base_size))
 		die("cannot get info for delta-pack base");
 
-	data = base_sha1 + 20;
-	data_size = left - 20;
-
 	memset(&stream, 0, sizeof(stream));
 
-	stream.next_in = data;
-	stream.avail_in = data_size;
+	data = stream.next_in = base_sha1 + 20;
+	stream.avail_in = left - 20;
 	stream.next_out = delta_head;
 	stream.avail_out = sizeof(delta_head);
 
diff --git a/test-delta.c b/test-delta.c
--- a/test-delta.c
+++ b/test-delta.c
@@ -61,7 +61,7 @@ int main(int argc, char *argv[])
 	if (argv[1][1] == 'd')
 		out_buf = diff_delta(from_buf, from_size,
 				     data_buf, data_size,
-				     &out_size, ~0UL);
+				     &out_size, 0);
 	else
 		out_buf = patch_delta(from_buf, from_size,
 				      data_buf, data_size,
------------------------------------------------
