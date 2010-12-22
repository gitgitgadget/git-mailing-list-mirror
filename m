From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] unpack_trees(): skip trees that are the same in all input
Date: Wed, 22 Dec 2010 14:13:47 -0800
Message-ID: <7vr5d94fs4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 22 23:14:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVWwe-0000vf-BE
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 23:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab0LVWN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 17:13:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab0LVWN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 17:13:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76E8B2744;
	Wed, 22 Dec 2010 17:14:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=fB8X
	vMSRV+/yiZI+zDH9wILQ3u8=; b=KaSfQZlEalnbrT8xlOcvU7rWVyZ/SHdlYTCs
	zf7C5K+AuLmMMLVdJZJshOIRrU1Jwm1/dVfw+TYomas/9s+/njNp6vxB6PoTxUvP
	dxax/3civFYFVbvME9wY+ucQROYHtpioJjxO//AY4VEPCpJsuckLYWLCa/z8NTsJ
	YG/LcMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	jwmGXngee0TudVEwnqsS7hFN8QDlEDVCS4Zeuws7DaWVvDtU9ywTcRJLbKIzkr5c
	yb1bc0ZEimX/FLafHLquKl9xepB3lpcSyoAIa3goV8ek3Sgrg59m52Yr6LTEiI9C
	NvZHVTwjgBrr/uFn6xjeMxiSfVlnitRDEwHUCCdjtCA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5607B2743;
	Wed, 22 Dec 2010 17:14:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 176562740; Wed, 22 Dec 2010
 17:14:18 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4314624-0E18-11E0-9E87-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164097>

unpack_trees() merges two trees (the current HEAD and the destination
commit) when switching to another branch, checking and updating the index
entry where the destination differs from the current HEAD.  It merges three
trees (the common ancestor, the current HEAD and the other commit) when
performing a three-way merge, checking and updating the index entry when
the merge result differs from the current HEAD.  It does so by walking the
input trees in parallel all the way down to the leaves.

One common special case is a directory is identical across the trees
involved in the merge.  In such a case, we do not have to descend into the
directory at all---we know that the end result is to keep the entries in
the current index.

This optimization cannot be applied in a few special cases in
unpack_trees(), though.  We need to descend into the directory and update
the index entries from the target tree in the following cases:

 - When resetting (e.g. "git reset --hard"); and

 - When checking out a tree for the first time into an empty working tree
   (e.g. "git read-tree -m -u HEAD HEAD" with missing .git/index).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 With and without this patch I tried to recreate a handful of recent
 merges in the kernel repository.  The result is somewhat mixed but
 overall in favor.

 <resulting merge commit>
 *** CURRENT ***
 /usr/bin/time output from "git merge" to reproduce it, without the patch
 *** NEW ***
 /usr/bin/time output from "git merge" to reproduce it, with the patch

 6313e3c21743cc88bb5bd8aa72948ee1e83937b6
 *** CURRENT ***
 3.88user 0.43system 0:04.31elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+47688outputs (0major+205724minor)pagefaults 0swaps
 *** NEW ***
 3.78user 0.46system 0:04.26elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+47688outputs (0major+185004minor)pagefaults 0swaps

 6dde39be39e636c1d41e73590668d5903b11535b
 *** CURRENT ***
 0.32user 0.12system 0:00.44elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+15272outputs (0major+23180minor)pagefaults 0swaps
 *** NEW ***
 0.24user 0.11system 0:00.34elapsed 102%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+15264outputs (0major+18288minor)pagefaults 0swaps

 f8f5d4f11dc7d321fb372b09fc8767069a18bf30
 *** CURRENT ***
 1.37user 0.14system 0:01.52elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+15336outputs (0major+43258minor)pagefaults 0swaps
 *** NEW ***
 1.40user 0.14system 0:01.54elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+15336outputs (0major+41767minor)pagefaults 0swaps

 2cedcc4f122934c3ad38dfb2a400b98a62703e6d
 *** CURRENT ***
 0.43user 0.10system 0:00.54elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+13696outputs (0major+24652minor)pagefaults 0swaps
 *** NEW ***
 0.30user 0.12system 0:00.43elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+13696outputs (0major+22156minor)pagefaults 0swaps

 81e8d2162566379adcf4b3700f03845c62577145
 *** CURRENT ***
 0.42user 0.12system 0:00.54elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+13544outputs (0major+24128minor)pagefaults 0swaps
 *** NEW ***
 0.35user 0.11system 0:00.50elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+13536outputs (0major+21667minor)pagefaults 0swaps

 unpack-trees.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index aa585be..7c0c963 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -436,6 +436,10 @@ static int switch_cache_bottom(struct traverse_info *info)
 	return ret;
 }
 
+static int fast_forward_merge(int n, unsigned long dirmask,
+			      struct name_entry *names,
+			      struct traverse_info *info);
+
 static int traverse_trees_recursive(int n, unsigned long dirmask,
 				    unsigned long df_conflicts,
 				    struct name_entry *names,
@@ -447,6 +451,11 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	struct traverse_info newinfo;
 	struct name_entry *p;
 
+	if (!df_conflicts) {
+		int status = fast_forward_merge(n, dirmask, names, info);
+		if (status)
+			return status;
+	}
 	p = names;
 	while (!p->mode)
 		p++;
@@ -694,6 +703,45 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
 		return NULL;
 }
 
+static int fast_forward_merge(int n, unsigned long dirmask,
+			      struct name_entry *names,
+			      struct traverse_info *info)
+{
+	int i;
+	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
+	struct unpack_trees_options *o = info->data;
+
+	/* merging two or more trees with an identical subdirectory? */
+	if ((n < 2) || ((1UL << n) - 1) != dirmask ||
+	    !o->merge || o->reset || o->initial_checkout)
+		return 0;
+	for (i = 1; i < n; i++)
+		if (hashcmp(names[i-1].sha1, names[i].sha1))
+			return 0;
+
+	/*
+	 * Instead of descending into the directory, keep the contents
+	 * of the current index.
+	 */
+	while (1) {
+		struct cache_entry *ce;
+		ce = next_cache_entry(o);
+		if (!ce)
+			break;
+		/* Is the entry still in that directory? */
+		if (do_compare_entry(ce, info, names))
+			break;
+		for (i = 0; i < n + 1; i++)
+			src[i] = ce;
+		mark_ce_used(ce, o);
+		if (call_unpack_fn(src, o) < 0)
+			return unpack_failed(o, NULL);
+		if (ce_stage(ce))
+			mark_ce_used_same_name(ce, o);
+	}
+	return dirmask;
+}
+
 static void debug_path(struct traverse_info *info)
 {
 	if (info->prev) {
-- 
1.7.3.4.804.g8883a
