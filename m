From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] merge-recursive: sometimes, d/f conflict is not an issue
Date: Tue, 17 Jul 2007 18:13:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707171812490.14781@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0707080148370.4093@racer.site> <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707080248320.4093@racer.site> <7v644v5tr3.fsf@assigned-by-dhcp.cox.net>
 <7vwsxb4e2q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081353560.4248@racer.site>
 <7v8x9q1x5t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1351502384-1184692392=:14781"
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Vanicat <vanicat@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqcr-0000EC-GQ
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 19:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764185AbXGQRNh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 13:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757675AbXGQRNh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 13:13:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:33338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764099AbXGQRNg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 13:13:36 -0400
Received: (qmail invoked by alias); 17 Jul 2007 17:13:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 17 Jul 2007 19:13:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xczBZNY5xT+xTSdLJVO9r1PvhlkenxMMzL6ImpZ
	wiQaFPHMWNWqAT
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x9q1x5t.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52780>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1351502384-1184692392=:14781
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


When a merge has a d/f conflict on a path which was not touched
between the merge base(s) and the remote HEAD, and the index and
HEAD contain the same version for that path (even if empty), it
is not really a conflict.

Noticed by Rémi Vanicat, reported to the Git list by Gerrit Pape.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Turns out I was wrong with my "this is only half of it" remark.
	AFAICT "merge-tree -u -m" does not touch the files which have
	unmerged entries, but merge-recursive does.  And since
	fix_up_df_conflicts() is called before any of that, it just works.

 merge-recursive.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c8539ec..fb487ba 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -243,6 +243,91 @@ static int git_merge_trees(int index_only,
 	return rc;
 }
 
+/*
+ * If there were dir/file conflicts, which are not really dir/file
+ * conflicts, because only one side changed anything, take that
+ * side instead of outputting silly conflicts.
+ *
+ * We keep it nice and easy, in that we only fix the conflicts if one
+ * side was renamed without changing the contents _at all_.  We check that
+ * by comparing the hash.
+ */
+static inline int is_df(struct cache_entry *in_dir, struct cache_entry *file)
+{
+	int len = ce_namelen(file);
+	const char *name = in_dir->name;
+	return !memcmp(name, file->name, len) && name[len] == '/';
+}
+
+static int fix_up_df_conflicts(const unsigned char *base,
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
+		/* check if unchanged in HEAD */
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
+		/* check if HEAD changed type (e.g. dir->file) */
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
@@ -1542,6 +1627,8 @@ static int merge_trees(struct tree *head,
 		    sha1_to_hex(head->object.sha1),
 		    sha1_to_hex(merge->object.sha1));
 
+	fix_up_df_conflicts(common->object.sha1,
+			head->object.sha1, merge->object.sha1);
 	if (unmerged_index()) {
 		struct path_list *entries, *re_head, *re_merge;
 		int i;
-- 
1.5.3.rc1.16.g9d6f-dirty


--8323584-1351502384-1184692392=:14781--
