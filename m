From: Junio C Hamano <junkio@cox.net>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 22:07:45 -0700
Message-ID: <7vu022gqji.fsf@assigned-by-dhcp.cox.net>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171134130.1971@xanadu.home>
	<7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171251210.1971@xanadu.home>
	<7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171437250.1971@xanadu.home>
	<20061017233630.72a0aae5.vsu@altlinux.ru>
	<Pine.LNX.4.64.0610171615340.1971@xanadu.home>
	<Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610171706260.1971@xanadu.home>
	<Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610171959070.1971@xanadu.home>
	<7vac3uif6i.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610172209070.1971@xanadu.home>
	<7v64eii7hh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 07:08:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga3et-0003u9-Fl
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 07:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWJRFHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 01:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWJRFHt
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 01:07:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14833 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750925AbWJRFHs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 01:07:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018050746.EIXT12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Oct 2006 01:07:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bh7Y1V00D1kojtg0000000
	Wed, 18 Oct 2006 01:07:33 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <7v64eii7hh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 17 Oct 2006 21:16:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29187>

Junio C Hamano <junkio@cox.net> writes:

> Ah, I misread the code that uses union actually checks the type
> in struct delta_entry (which embeds the union).  There won't be
> any collision problem and you support both types at the same
> time just fine.
>
> And your patch to compare only the first 20-bytes makes sense
> (assuming ulong is always shorter than 20-bytes which I think is
> safe to assume).

Does this sound fair (the code is yours, just asking about the
log message)?

If we really wanted to be purist, we could run comparison with
the union and obj->type as two keys, but I do not think it is
worth it.

-- >8 --
From: Nicolas Pitre <nico@cam.org>
Date: Tue, 17 Oct 2006 16:23:26 -0400
Subject: [PATCH] index-pack: compare the first 20-bytes of the key.

The "union delta_base" is a strange beast.  It is a 20-byte
binary blob key to search a binary searchable deltas[] array,
each element of which uses it to represent its base object with
either a full 20-byte SHA-1 or an offset in the pack.  Which
representation is used is determined by another field of the
deltas[] array element, obj->type, so there is no room for
confusion, as long as we make sure we compare the keys for the
same type only with appropriate length.  The code compared the
full union with memcmp().

When storing the in-pack offset, the union was first cleared
before storing an unsigned long, so comparison worked fine.

On 64-bit architectures, however, the union typically is 24-byte
long; the code did not clear the remaining 4-byte alignment
padding when storing a full 20-byte SHA-1 representation.  Using
memcmp() to compare the whole union was wrong.

This fixes the comparison to look at the first 20-bytes of the
union, regardless of the architecture.  As long as ulong is
smaller than 20-bytes this works fine.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 index-pack.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index fffddd2..56c590e 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -23,6 +23,12 @@ union delta_base {
 	unsigned long offset;
 };
 
+/*
+ * Even if sizeof(union delta_base) == 24 on 64-bit archs, we really want
+ * to memcmp() only the first 20 bytes.
+ */
+#define UNION_BASE_SZ	20
+
 struct delta_entry
 {
 	struct object_entry *obj;
@@ -211,7 +217,7 @@ static int find_delta(const union delta_
                 struct delta_entry *delta = &deltas[next];
                 int cmp;
 
-                cmp = memcmp(base, &delta->base, sizeof(*base));
+                cmp = memcmp(base, &delta->base, UNION_BASE_SZ);
                 if (!cmp)
                         return next;
                 if (cmp < 0) {
@@ -232,9 +238,9 @@ static int find_delta_childs(const union
 
 	if (first < 0)
 		return -1;
-	while (first > 0 && !memcmp(&deltas[first - 1].base, base, sizeof(*base)))
+	while (first > 0 && !memcmp(&deltas[first - 1].base, base, UNION_BASE_SZ))
 		--first;
-	while (last < end && !memcmp(&deltas[last + 1].base, base, sizeof(*base)))
+	while (last < end && !memcmp(&deltas[last + 1].base, base, UNION_BASE_SZ))
 		++last;
 	*first_index = first;
 	*last_index = last;
@@ -312,7 +318,7 @@ static int compare_delta_entry(const voi
 {
 	const struct delta_entry *delta_a = a;
 	const struct delta_entry *delta_b = b;
-	return memcmp(&delta_a->base, &delta_b->base, sizeof(union delta_base));
+	return memcmp(&delta_a->base, &delta_b->base, UNION_BASE_SZ);
 }
 
 static void parse_pack_objects(void)
-- 
1.4.2.4.gf9fe
