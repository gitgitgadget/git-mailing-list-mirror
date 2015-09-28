From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 3/4] mark_reachable_objects(): optionally collect broken
 symrefs
Date: Mon, 28 Sep 2015 16:01:35 +0200
Organization: gmx
Message-ID: <b0403395b261a70b7e0d31e02420930adc8d97ea.1443448748.git.johannes.schindelin@gmx.de>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1443448748.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 16:01:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgZ02-0004gh-Le
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 16:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933922AbbI1OBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 10:01:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:62485 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932920AbbI1OBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 10:01:44 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MHLNn-1Zu5nn1mUt-00E5Qg; Mon, 28 Sep 2015 16:01:36
 +0200
In-Reply-To: <cover.1443448748.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:oi5kEhSf8UcN8KWyUCYd2PTzHnetyb42f9EtjTxvdno5FPrAIid
 Ha9npKZM//5IBokV9lfKqbMPwbv2PiQV/8O2ucGeRmjIyXhG9x20DwIHp52x3JRFT7wAHjU
 TnSSTYPRuijfkN/qv0VPEKBQD11IeVJnikrvJ5nX/rSAiWyAW8fIpwBrqyp4hMlpRysRcuL
 30wSRDdnyC7ZJTYBLVuJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pn3nErGTBtQ=:39AtLUGU4HQeqwxPbVVabx
 3KNg7XC7HHQBoW0hUQf6LtiKZ/RZ21W+sifQlApQ44gKuJhrfQTQ4h+n6VQhik4Ckuwej97Io
 XMJAbVM1gLvyBiQ64TTb3l8DMBZzWruxHc/CSCT6PRC2TqfcJCHH7X9oxuSKbVWjzyED+KGJe
 oBohZD9rUoT8IykrCrWOLQLVpBeQzKzMjSRQZF/WKokWZnW6Z5gr0gUOKFzpmpHku4IotBS81
 2ALeYbNE12+WIk7KSSiDKMDBHiEJC2h6nl79p+JiTdhBmQ9kk++wCxQrNeJZWeT3SYZX41wnk
 GnD1DHswwed4fQvBxEPLEQcSiXrFP/RcYOjhED94edVHpXydEGCIb01XHtdy/LmyspWSdeuVA
 NcGUBETZZh01g4w8wlmSqRB9a4tAaHrRWV/pbw/dR9qpz5ohcWwwtodzrjVhSHjOqzTaLiIb/
 vq7bjk9CpfLtdJHo3xMR0oEmBlCcXyHtQ2Jusi+RqJ7K4z968RlEJ9b/+qExL5SduJTxOxTpb
 Wsx6Lm++u4eQYxDE5TQeagIUAEt8NMPhmvAPXS5pH0NYY23Qi0PTGD7qWjB9mrox2Cqzg506p
 NGDynT5hMgzgD2dlaj0LF3dmDOCdVqvgqGeg6xpF4Rj9J8JlAEkySavToMovgGHtXLdUBhQdp
 enyZ62rntZWRsTJEyBGnicrN5kr/FsBTqO+KrLcXsGalRy8uootov82DiPfgtW5CfaLka9pbT
 rw0XDNbWCzJtkDUmVhYOGGYx05zyDy2I1Ti+LA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278727>

The behavior of `mark_reachable_objects()` without this patch is that
it warns if it encounters a broken symref. Sometimes the caller wants
to act upon broken symrefs, e.g. when garbage collecting in a repository
with a broken remote HEAD.

So let's introduce an optional parameter to collect broken symrefs. The
behavior of the function is unchanged if that parameter is `NULL`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/prune.c  |  2 +-
 builtin/reflog.c |  2 +-
 reachable.c      | 25 +++++++++++++++++++------
 reachable.h      |  3 ++-
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 10b03d3..d6f664f 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -136,7 +136,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
 
-	mark_reachable_objects(&revs, 1, expire, progress);
+	mark_reachable_objects(&revs, 1, expire, progress, NULL);
 	stop_progress(&progress);
 	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
 				      prune_cruft, prune_subdir, NULL);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index f96ca2a..cb8758a 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -583,7 +583,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		init_revisions(&cb.cmd.revs, prefix);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("Marking reachable objects...");
-		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
+		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL, NULL);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
 	}
diff --git a/reachable.c b/reachable.c
index 64289f3..25c4932 100644
--- a/reachable.c
+++ b/reachable.c
@@ -15,6 +15,11 @@ struct connectivity_progress {
 	unsigned long count;
 };
 
+struct add_one_data {
+	struct rev_info *revs;
+	struct string_list *broken_symrefs;
+};
+
 static void update_progress(struct connectivity_progress *cp)
 {
 	cp->count++;
@@ -25,16 +30,19 @@ static void update_progress(struct connectivity_progress *cp)
 static int add_one_ref(const char *path, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct rev_info *revs = (struct rev_info *)cb_data;
+	struct add_one_data *data = (struct add_one_data *)cb_data;
 	struct object *object;
 
 	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
-		warning("ref is broken: %s", path);
+		if (data->broken_symrefs)
+			string_list_append(data->broken_symrefs, path);
+		else
+			warning("ref is broken: %s", path);
 		return 0;
 	}
 
 	object = parse_object_or_die(oid->hash, path);
-	add_pending_object(revs, object, "");
+	add_pending_object(data->revs, object, "");
 
 	return 0;
 }
@@ -159,9 +167,11 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    unsigned long mark_recent,
-			    struct progress *progress)
+			    struct progress *progress,
+			    struct string_list *broken_symrefs)
 {
 	struct connectivity_progress cp;
+	struct add_one_data data;
 
 	/*
 	 * Set up revision parsing, and mark us as being interested
@@ -174,11 +184,14 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	/* Add all refs from the index file */
 	add_index_objects_to_pending(revs, 0);
 
+	data.revs = revs;
+	data.broken_symrefs = broken_symrefs;
+
 	/* Add all external refs */
-	for_each_ref(add_one_ref, revs);
+	for_each_ref(add_one_ref, &data);
 
 	/* detached HEAD is not included in the list above */
-	head_ref(add_one_ref, revs);
+	head_ref(add_one_ref, &data);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/reachable.h b/reachable.h
index d23efc3..06f1400 100644
--- a/reachable.h
+++ b/reachable.h
@@ -5,6 +5,7 @@ struct progress;
 extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 						  unsigned long timestamp);
 extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
-				   unsigned long mark_recent, struct progress *);
+				   unsigned long mark_recent, struct progress *,
+				   struct string_list *broken_symrefs);
 
 #endif
-- 
2.5.3.windows.1.3.gc322723
