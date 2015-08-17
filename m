From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v9 3/6] note: extract parse_notes_merge_strategy to notes-utils
Date: Mon, 17 Aug 2015 14:33:31 -0700
Message-ID: <1439847214-2980-4-git-send-email-jacob.e.keller@intel.com>
References: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 23:33:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRS2U-0003aM-BI
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 23:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbbHQVdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 17:33:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:43514 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbbHQVdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 17:33:36 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,697,1432623600"; 
   d="scan'208";a="785910989"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276094>

From: Jacob Keller <jacob.keller@gmail.com>

Combining rewrite and notes-merge functionality has been left as an
exercise for a future contributor.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/notes.c | 12 +-----------
 notes-utils.c   | 18 ++++++++++++++++++
 notes-utils.h   |  1 +
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 042348082709..0e7aba98f4d7 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -797,17 +797,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 	o.remote_ref = remote_ref.buf;
 
 	if (strategy) {
-		if (!strcmp(strategy, "manual"))
-			o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
-		else if (!strcmp(strategy, "ours"))
-			o.strategy = NOTES_MERGE_RESOLVE_OURS;
-		else if (!strcmp(strategy, "theirs"))
-			o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
-		else if (!strcmp(strategy, "union"))
-			o.strategy = NOTES_MERGE_RESOLVE_UNION;
-		else if (!strcmp(strategy, "cat_sort_uniq"))
-			o.strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
-		else {
+		if (parse_notes_merge_strategy(strategy, &o.strategy)) {
 			error("Unknown -s/--strategy: %s", strategy);
 			usage_with_options(git_notes_merge_usage, options);
 		}
diff --git a/notes-utils.c b/notes-utils.c
index ccbf0737a34e..299e34bccc58 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -54,6 +54,24 @@ void commit_notes(struct notes_tree *t, const char *msg)
 	strbuf_release(&buf);
 }
 
+int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s)
+{
+	if (!strcmp(v, "manual"))
+		*s = NOTES_MERGE_RESOLVE_MANUAL;
+	else if (!strcmp(v, "ours"))
+		*s = NOTES_MERGE_RESOLVE_OURS;
+	else if (!strcmp(v, "theirs"))
+		*s = NOTES_MERGE_RESOLVE_THEIRS;
+	else if (!strcmp(v, "union"))
+		*s = NOTES_MERGE_RESOLVE_UNION;
+	else if (!strcmp(v, "cat_sort_uniq"))
+		*s = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
+	else
+		return -1;
+
+	return 0;
+}
+
 static combine_notes_fn parse_combine_notes_fn(const char *v)
 {
 	if (!strcasecmp(v, "overwrite"))
diff --git a/notes-utils.h b/notes-utils.h
index db5811e3f718..fa538e1d9502 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -37,6 +37,7 @@ struct notes_rewrite_cfg {
 	int mode_from_env;
 };
 
+int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s);
 struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const unsigned char *from_obj, const unsigned char *to_obj);
-- 
2.5.0.280.g4aaba03
