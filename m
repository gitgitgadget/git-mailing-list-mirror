From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] commit-slab.h: Fix memory allocation and addressing
Date: Sat, 27 Jul 2013 20:00:07 +0100
Message-ID: <51F418B7.30507@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 21:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V39pn-0005LQ-Bh
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 21:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab3G0THB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 15:07:01 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:55491 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752719Ab3G0TG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 15:06:59 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id D13C21280BF;
	Sat, 27 Jul 2013 20:06:57 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id B4B8A1280B5;
	Sat, 27 Jul 2013 20:06:56 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Sat, 27 Jul 2013 20:06:56 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231250>


The slab initialization code includes the calculation of the
slab 'elem_size', which is in turn used to determine the size
(capacity) of the slab. Each element of the slab represents an
array, of length 'stride', of 'elemtype'. (Note that it may be
clearer if the define_commit_slab macro parameter was called
'basetype' rather than 'elemtype'). However, the 'elem_size'
calculation incorrectly uses 'sizeof(struct slabname)' in the
expression, rather than 'sizeof(elemtype)'.

Within the slab access routine, <slabname>_at(), the given commit
'index' is transformed into an (slab#, slot#) pair used to address
the required element (a pointer to the first element of the array
of 'elemtype' associated with that commit). The current code to
calculate these address coordinates multiplies the commit index
by the 'stride' which, at least for the slab#, produces the wrong
result. Using the commit index directly, without scaling by the
'stride', produces the correct 'logical' address.

Also, when allocating a new slab, the size of the allocation only
allows for a slab containing elements of single element arrays of
'elemtype'. This should allow for elements of an array of length
'stride' of 'elemtype'. In order to fix this, we need to change
the element size parameter to xcalloc() by multiplying the current
element size (sizeof(**s->slab)) by the s->stride.

Having changed the calculation of the slot#, we now need to convert
the logical 'nth_slot', by scaling with s->stride, into the correct
physical address.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

While looking into a sparse warning, which involved the use of the
"commit-slab.h" header file, I noticed some problems with that code.
(at least I _think_ I did! ;-)

I was convinced, just by reading the code in the header, that when
used with stride > 1, the memory allocated to a slab would not be
sufficient. (ie it would be too small by:
    s->slab_size * (sizeof(**s->slab) * (stride - 1))
). So, I had expected t3202-show-branch-octopus.sh to provoke memory
error reports when run under valgrind.

Hmm, it didn't ... so much for that theory! :-D

So, I'm a little puzzled; I must be missing something obvious, which
is why this is marked RFC.

What am I missing?

ATB,
Ramsay Jones


 commit-slab.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/commit-slab.h b/commit-slab.h
index 7d48163..d4c8286 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -48,7 +48,7 @@ static void init_ ##slabname## _with_stride(struct slabname *s,		\
 	if (!stride)							\
 		stride = 1;						\
 	s->stride = stride;						\
-	elem_size = sizeof(struct slabname) * stride;			\
+	elem_size = sizeof(elemtype) * stride;				\
 	s->slab_size = COMMIT_SLAB_SIZE / elem_size;			\
 	s->slab_count = 0;						\
 	s->slab = NULL;							\
@@ -72,11 +72,10 @@ static void clear_ ##slabname(struct slabname *s)			\
 static elemtype *slabname## _at(struct slabname *s,			\
 				const struct commit *c)			\
 {									\
-	int nth_slab, nth_slot, ix;					\
+	int nth_slab, nth_slot;						\
 									\
-	ix = c->index * s->stride;					\
-	nth_slab = ix / s->slab_size;					\
-	nth_slot = ix % s->slab_size;					\
+	nth_slab = c->index / s->slab_size;				\
+	nth_slot = c->index % s->slab_size;				\
 									\
 	if (s->slab_count <= nth_slab) {				\
 		int i;							\
@@ -89,8 +88,8 @@ static elemtype *slabname## _at(struct slabname *s,			\
 	}								\
 	if (!s->slab[nth_slab])						\
 		s->slab[nth_slab] = xcalloc(s->slab_size,		\
-					    sizeof(**s->slab));		\
-	return &s->slab[nth_slab][nth_slot];				\
+					    sizeof(**s->slab) * s->stride);		\
+	return &s->slab[nth_slab][nth_slot * s->stride];				\
 }									\
 									\
 static int stat_ ##slabname## realloc
-- 
1.8.3
