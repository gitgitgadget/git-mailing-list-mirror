From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: sometimes, d/f conflict is not an issue
Date: Sun, 8 Jul 2007 05:35:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707080526170.4093@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0707080148370.4093@racer.site> <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707080248320.4093@racer.site> <Pine.LNX.4.64.0707080311280.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 06:43:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Oc7-0007qj-VM
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 06:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbXGHEnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 00:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbXGHEnL
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 00:43:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:58974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751026AbXGHEnK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 00:43:10 -0400
Received: (qmail invoked by alias); 08 Jul 2007 04:43:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 08 Jul 2007 06:43:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lCV15NuNlhUliGC0CthPQ6ZTo/yjMSz3XDQMDVH
	8UpshwMxXKpzXq
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707080311280.4093@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51860>

Hi,

On Sun, 8 Jul 2007, Johannes Schindelin wrote:

> Well, I try to cobble up a patch for merge-recursive like you suggested, 
> and stay away from threeway_merge() as far as I can, for the rest of my 
> life.

Here is a WIP. Note: it only does half of the job. For performance 
reasons, we do not write out the working tree changes for intermediate 
merges. However, in the last step, we do. And this patch does not reflect 
that, but only updates the index.

Ciao,
Dscho

 merge-recursive.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index dbd06aa..99da2bb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -243,6 +243,92 @@ static int git_merge_trees(int index_only,
 	return rc;
 }
 
+/*
+ * If there were dir/file conflicts, which are not really dir/file
+ * conflicts, because only one side changed anything, take that
+ * side instead of outputting silly conflicts.
+ *
+ * NOTE! unpack_trees() would have a much better chance at resolving
+ * these conflicts, since it gets the _tree_ objects we have to
+ * reconstruct tediously, and it could get away with one simple
+ * comparison between sha1's, while that is not possible here.
+ */
+static inline int is_df(struct cache_entry *in_dir, struct cache_entry *file)
+{
+	int len = ce_namelen(file);
+	const char *name = in_dir->name;
+	return !memcmp(name, file->name, len) && name[len] == '/';
+}
+
+static int try_to_fix_up_df_conflicts_which_are_none(const unsigned char *base,
+		const unsigned char *head, const unsigned char *merge)
+{
+	int i;
+	for (i = 0; i + 2 < active_nr; i++) {
+		int last;
+		unsigned char sha1[20], sha2[20];
+		unsigned dummy;
+		char *name;
+		struct cache_entry *ce = active_cache[i], *ce1, *ce2;
+
+		if (ce_stage(ce) == 0)
+			continue;
+		ce1 = active_cache[i + 1];
+		ce2 = active_cache[i + 2];
+		if (ce_same_name(ce, ce2) || !is_df(ce2, ce)) {
+			/* not a d/f conflict */
+			i += 2;
+			continue;
+		}
+		for (last = i + 3; last < active_nr &&
+				is_df(active_cache[last], ce); last++)
+			; /* do nothing */
+		/* check if HEAD as an unchanged file, remote a dir */
+		if (ce_same_name(ce, ce1)) {
+			if (ce_stage(ce) != 1 ||
+					hashcmp(ce->sha1, ce1->sha1)) {
+				/* file was changed */
+				i = last - 1;
+				continue;
+			}
+			/* other side removed file, added dir */
+			if (!remove_file_from_cache(ce->name))
+				return error("index error");
+			for (i -= 2, last -= 2; i < last; i++)
+				active_cache[i]->ce_flags &=
+					~ntohs(CE_STAGEMASK);
+			i--;
+			continue;
+		}
+		if (i + 1 == last)
+			continue;
+		/* check if HEAD changed dir to a file */
+		if (ce_stage(ce) == 1) {
+			i = last - 1;
+			continue;
+		}
+		name = xstrndup(ce->name, ce_namelen(ce));
+		if (get_tree_entry(base, name, sha1, &dummy) ||
+				get_tree_entry(ce_stage(ce) == 2 ?
+					merge : head,
+					name, sha2, &dummy)) {
+			free(name);
+			i = last - 1;
+			continue;
+		}
+		free(name);
+		if (!hashcmp(sha1, sha2)) {
+			/* remove tree */
+			memmove(active_cache + i + 1, active_cache + last,
+				(active_nr - last) *
+				sizeof(struct cache_entry *));
+			active_nr -= last - i - 1;
+			ce->ce_flags &= ~ntohs(CE_STAGEMASK);
+		}
+	}
+	return 0;
+}
+
 static int unmerged_index(void)
 {
 	int i;
@@ -1520,6 +1606,8 @@ static int merge_trees(struct tree *head,
 		    sha1_to_hex(head->object.sha1),
 		    sha1_to_hex(merge->object.sha1));
 
+	try_to_fix_up_df_conflicts_which_are_none(common->object.sha1,
+			head->object.sha1, merge->object.sha1);
 	if (unmerged_index()) {
 		struct path_list *entries, *re_head, *re_merge;
 		int i;
