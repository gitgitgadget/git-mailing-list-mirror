From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] pass struct commit to diff_tree_combined_merge()
Date: Sat, 17 Dec 2011 11:20:07 +0100
Message-ID: <4EEC6CD7.2030408@lsrfire.ath.cx>
References: <4EEC6BD4.4040302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6?= =?ISO-8859-15?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 11:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrNM-0002Um-1R
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab1LQKUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:20:16 -0500
Received: from india601.server4you.de ([85.25.151.105]:40064 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab1LQKUO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:20:14 -0500
Received: from [192.168.2.105] (p579BE8BE.dip.t-dialin.net [87.155.232.190])
	by india601.server4you.de (Postfix) with ESMTPSA id 1E2E92F8038;
	Sat, 17 Dec 2011 11:20:13 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4EEC6BD4.4040302@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187368>

Instead of passing the hash of a commit and then searching that
same commit in the single caller, simply pass the commit directly.

---
 combine-diff.c |    7 +++----
 diff.h         |    3 ++-
 log-tree.c     |    4 +---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index cfe6230..a2e8dcf 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1196,10 +1196,9 @@ void diff_tree_combined(const unsigned char *sha1,
 	}
 }
 
-void diff_tree_combined_merge(const unsigned char *sha1,
-			     int dense, struct rev_info *rev)
+void diff_tree_combined_merge(const struct commit *commit, int dense,
+			      struct rev_info *rev)
 {
-	struct commit *commit = lookup_commit(sha1);
 	struct commit_list *parent = commit->parents;
 	struct sha1_array parents = SHA1_ARRAY_INIT;
 
@@ -1207,6 +1206,6 @@ void diff_tree_combined_merge(const unsigned char *sha1,
 		sha1_array_append(&parents, parent->item->object.sha1);
 		parent = parent->next;
 	}
-	diff_tree_combined(sha1, &parents, dense, rev);
+	diff_tree_combined(commit->object.sha1, &parents, dense, rev);
 	sha1_array_clear(&parents);
 }
diff --git a/diff.h b/diff.h
index 96085cb..ae71f4c 100644
--- a/diff.h
+++ b/diff.h
@@ -13,6 +13,7 @@ struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
 struct sha1_array;
+struct commit;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -198,7 +199,7 @@ extern void show_combined_diff(struct combine_diff_path *elem, int num_parent,
 
 extern void diff_tree_combined(const unsigned char *sha1, const struct sha1_array *parents, int dense, struct rev_info *rev);
 
-extern void diff_tree_combined_merge(const unsigned char *sha1, int, struct rev_info *);
+extern void diff_tree_combined_merge(const struct commit *commit, int dense, struct rev_info *rev);
 
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b);
 
diff --git a/log-tree.c b/log-tree.c
index e7694a3..319bd31 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -599,9 +599,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 
 static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 {
-	unsigned const char *sha1 = commit->object.sha1;
-
-	diff_tree_combined_merge(sha1, opt->dense_combined_merges, opt);
+	diff_tree_combined_merge(commit, opt->dense_combined_merges, opt);
 	return !opt->loginfo;
 }
 
-- 
1.7.8
