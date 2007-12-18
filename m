From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix segfault in diff-delta.c when FLEX_ARRAY is 1
Date: Mon, 17 Dec 2007 22:12:03 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712172146070.21557@woody.linux-foundation.org>
References: <1197941997-11421-1-git-send-email-madcoder@debian.org> <20071218014455.GB14981@artemis.madism.org> <alpine.LFD.0.9999.0712172032090.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, spearce@spearce.org,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 07:19:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4VnJ-0004U4-UI
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 07:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbXLRGSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 01:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbXLRGSo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 01:18:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59516 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751080AbXLRGSn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 01:18:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBI6C3O6023367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Dec 2007 22:12:04 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBI6C3H3022284;
	Mon, 17 Dec 2007 22:12:03 -0800
In-Reply-To: <alpine.LFD.0.9999.0712172032090.21557@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.513 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_61,J_CHICKENPOX_63,J_CHICKENPOX_65,J_CHICKENPOX_66,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68702>



On Mon, 17 Dec 2007, Linus Torvalds wrote:
> 
> However, one indication that there may still be something wrong is that if 
> you re-make git with FLEX_ARRAY set to some big insane value (say, 1234), 
> then git will still fail the test-suite. So maybe there's a "sizeof()" 
> that isn't just used for allocation sizes.

No, that's a different thing. In at least unpack-trees.c (line 593), we do

	..
	if (same(old, merge)) {
		*merge = *old;
	} else {
	..

and that "merge" is a cache_entry pointer. If we have a non-zero 
FLEX_ARRAY size, it will cause us to copy the first few bytes of the name 
too.

That is technically wrong even for FLEX_ARRAY being 1, but you'll never 
notice, since the names are always at least one byte, and the filenames 
should basically always be the same. But if we do the same thing for a 
rename, we'd be screwed.

So we probably should look out for those things too. A quick hack to 
sparse shows that that was the only such occurrence in the current tree, 
though.

Anyway, with this patch to current git, it passes all the test-suite with 
FLEX_ARRAY artificially set to 123, and the only complaints from my 
hacked-up sparse are about "sizeof()" calls (ie no pointer arithmetic, and 
no assignments to flex-array-structures).

*Most* of the remaining sizeof() uses, in turn, are allocation-size 
related, ie passed in to calloc() and friends, and while I didn't check 
them all, such uses of sizeof() is fine (even if it causes some 
unnecessarily big allocations).

But there's a few that aren't obviously allocations (this is a list done 
with grep and sparse, I didn't look at whether the values used are then 
all allocation-related):

 - builtin-blame.c:128     memset(o, 0, sizeof(*o));
 - diff-delta.c:250        memsize = sizeof(*index)
 - object-refs.c:23        size_t size = sizeof(*refs) + count*sizeof(struct object *);
 - object-refs.c:61        size_t size = sizeof(*refs) + j*sizeof(struct object *);
 - attr.c:220              sizeof(*res) +
 - remote.c:467            memset(ret, 0, sizeof(struct ref) + namelen);
 - remote.c:474            memcpy(ret, ref, sizeof(struct ref) + strlen(ref->name) + 1);
 - transport.c:491         memset(ref, 0, sizeof(struct ref));

maybe somebody else can check them out (I've not sent out the hacky patch 
to 'sparse' that found that assignment in unpack-trees.c, but since that 
one was the only one it found, nobody should care - and it really was 
pretty hacky).

		Linus

---
 diff-delta.c   |    2 +-
 unpack-trees.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 9e440a9..601b49e 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -264,7 +264,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	index->src_size = bufsize;
 	index->hash_mask = hmask;
 
-	mem = index + 1;
+	mem = index->hash;
 	packed_hash = mem;
 	mem = packed_hash + (hsize+1);
 	packed_entry = mem;
diff --git a/unpack-trees.c b/unpack-trees.c
index e9eb795..aa2513e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -590,7 +590,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		 * a match.
 		 */
 		if (same(old, merge)) {
-			*merge = *old;
+			memcpy(merge, old, offsetof(struct cache_entry, name));
 		} else {
 			verify_uptodate(old, o);
 			invalidate_ce_path(old);
