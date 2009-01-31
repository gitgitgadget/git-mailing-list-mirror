From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] merge: fix out-of-bounds memory access
Date: Sat, 31 Jan 2009 15:39:10 +0100
Message-ID: <4984628E.8090600@lsrfire.ath.cx>
References: <49814BA4.6030705@zytor.com> <7vr62mha7a.fsf@gitster.siamese.dyndns.org> <20090129113846.GA10645@elte.hu> <20090129120539.GA26975@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sat Jan 31 15:41:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTH1c-0005CU-72
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 15:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbZAaOjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 09:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbZAaOjS
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 09:39:18 -0500
Received: from india601.server4you.de ([85.25.151.105]:42880 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbZAaOjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 09:39:17 -0500
Received: from [10.0.1.101] (p57B7DE5B.dip.t-dialin.net [87.183.222.91])
	by india601.server4you.de (Postfix) with ESMTPSA id 087052F8056;
	Sat, 31 Jan 2009 15:39:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090129120539.GA26975@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107928>

The following on top of master lets git finish the merge without segfault
(reporting a merge conflict) and valgrind doesn't find an more memory
errors here.  Can you confirm that, Ingo?

-- 8< --
The parameter n of unpack_callback() can have a value of up to
MAX_UNPACK_TREES.  The check at the top of unpack_trees() (its only
(indirect) caller) makes sure it cannot exceed this limit.

unpack_callback() passes it and the array src to unpack_nondirectories(),
which has this loop:

	for (i = 0; i < n; i++) {
		/* ... */
		src[i + o->merge] = o->df_conflict_entry;

o->merge can be 0 or 1, so unpack_nondirectories() potentially accesses
the array src at index MAX_UNPACK_TREES.  This patch makes it big enough.

Reported-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 unpack-trees.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 16bc2ca..e547282 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -240,8 +240,11 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
 	return ce;
 }
 
-static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmask, struct cache_entry *src[5],
-	const struct name_entry *names, const struct traverse_info *info)
+static int unpack_nondirectories(int n, unsigned long mask,
+				 unsigned long dirmask,
+				 struct cache_entry **src,
+				 const struct name_entry *names,
+				 const struct traverse_info *info)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
@@ -291,7 +294,7 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
 
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
 {
-	struct cache_entry *src[5] = { NULL, };
+	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
 	const struct name_entry *p = names;
 
-- 
1.6.1
