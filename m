From: Jeff King <peff@peff.net>
Subject: [PATCH 09/10] pack-revindex: use unsigned to store number of objects
Date: Wed, 10 Jul 2013 07:50:26 -0400
Message-ID: <20130710115026.GI21963@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:50:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwsup-00060z-E5
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab3GJLub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:50:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:47875 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753854Ab3GJLub (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:50:31 -0400
Received: (qmail 25692 invoked by uid 102); 10 Jul 2013 11:51:47 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:51:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:50:26 -0400
Content-Disposition: inline
In-Reply-To: <20130710113447.GA20113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230050>

A packfile may have up to 2^32-1 objects in it, so the
"right" data type to use is uint32_t. We currently use a
signed int, which means that we may behave incorrectly for
packfiles with more than 2^31-1 objects on 32-bit systems.

Nobody has noticed because having 2^31 objects is pretty
insane. The linux.git repo has on the order of 2^22 objects,
which is hundreds of times smaller than necessary to trigger
the bug.

Let's bump this up to an "unsigned". On 32-bit systems, this
gives us the correct data-type, and on 64-bit systems, it is
probably more efficient to use the native "unsigned" than a
true uint32_t.

While we're at it, we can fix the binary search not to
overflow in such a case if our unsigned is 32 bits.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't look farther in the pack code to see if we have other
problematic instances. So there may be others lurking, but these ones
were close to the area I was working in.

 pack-revindex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 77a0465..1aa9754 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -72,8 +72,8 @@ static void create_pack_revindex(struct pack_revindex *rix)
 static void create_pack_revindex(struct pack_revindex *rix)
 {
 	struct packed_git *p = rix->p;
-	int num_ent = p->num_objects;
-	int i;
+	unsigned num_ent = p->num_objects;
+	unsigned i;
 	const char *index = p->index_data;
 
 	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
@@ -114,7 +114,7 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 {
 	int num;
-	int lo, hi;
+	unsigned lo, hi;
 	struct pack_revindex *rix;
 	struct revindex_entry *revindex;
 
@@ -132,7 +132,7 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 	lo = 0;
 	hi = p->num_objects + 1;
 	do {
-		int mi = (lo + hi) / 2;
+		unsigned mi = lo + (hi - lo) / 2;
 		if (revindex[mi].offset == ofs) {
 			return revindex + mi;
 		} else if (ofs < revindex[mi].offset)
-- 
1.8.3.rc3.24.gec82cb9
