From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH 4/4] git update-index --cacheinfo can be used to select a stage when there are merged and unmerged entries
Date: Wed, 20 Aug 2014 13:26:03 +0200
Message-ID: <af54b2b3e80a6ff76b07ea129ead43079ef06a7a.1408533065.git.jsorianopastor@gmail.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
 <cover.1408533065.git.jsorianopastor@gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 13:27:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK43P-0004yh-1F
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 13:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbaHTL1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 07:27:12 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:47099 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbaHTL1K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 07:27:10 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so7732944wes.29
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eMmwOuH0RKGlNKprzMlLR/tEHBhyiOJ8RqHBoT/D3/U=;
        b=teMV01oPRhNeUAXAEWKFuDCG6eL2TVp4Povzbq9oyr9tNS1lNQJfECg5B8ZNUqYv0E
         h7fuPtjfsv3Vm0YZmI/OKXIlnXXN/oinffbkoSS7zPz8Gpy3rjYz1xJKR95pwGJ/fW19
         66fo4nhXIEsbVZfT7xJqzD6d85YwSCEgpDGBvXBU75hLiUi6d7qwIJEj5EHV3xBRxaDU
         4zLl9I/qwzleE4rQY1CPG5SdIhft3cdA0yLGLyP8bwkCIcHHYmkjxkOrRmdjUy6uo1T/
         4d7pL6wjYzMhd/0UgD4DzwLxySTWM3KvRViVI8lGJmUnjOcik9V2JoRmMR3IoCITlHqY
         Qwug==
X-Received: by 10.180.100.230 with SMTP id fb6mr14680371wib.0.1408534028606;
        Wed, 20 Aug 2014 04:27:08 -0700 (PDT)
Received: from ubuntu-jsoriano.tuenti.local (50.red-80-26-152.adsl.static.ccgg.telefonica.net. [80.26.152.50])
        by mx.google.com with ESMTPSA id je17sm8301873wic.22.2014.08.20.04.27.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 04:27:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.4.gaf54b2b
In-Reply-To: <cover.1408533065.git.jsorianopastor@gmail.com>
In-Reply-To: <cover.1408533065.git.jsorianopastor@gmail.com>
References: <cover.1408533065.git.jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255564>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 builtin/update-index.c                     |  1 +
 cache.h                                    |  1 +
 read-cache.c                               |  3 ++-
 t/t9904-unmerged-file-with-merged-entry.sh | 14 +++++++++++---
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ebea285..509fae7 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -239,6 +239,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 		ce->ce_flags |= CE_VALID;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
+	option |= ADD_CACHE_OK_TO_REPLACE_MERGED;
 	if (add_cache_entry(ce, option))
 		return error("%s: cannot add to the index - missing --add option?",
 			     path);
diff --git a/cache.h b/cache.h
index c708062..ecac41c 100644
--- a/cache.h
+++ b/cache.h
@@ -474,6 +474,7 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
+#define ADD_CACHE_OK_TO_REPLACE_MERGED 32 /* Ok to replace even if a merged entry exists */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 extern int remove_index_entry_at(struct index_state *, int pos);
diff --git a/read-cache.c b/read-cache.c
index d549d0b..c4ddefe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -933,6 +933,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int pos;
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
+	int ok_to_replace_merged = option & ADD_CACHE_OK_TO_REPLACE_MERGED;
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 	int new_only = option & ADD_CACHE_NEW_ONLY;
 	int replaced = 0;
@@ -955,7 +956,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	 */
 	if (pos < istate->cache_nr && ce_stage(ce) == 0) {
 		while (ce_same_name(istate->cache[pos], ce)) {
-			if (replaced)
+			if (replaced && !ok_to_replace_merged)
 				die("Merged and unmerged entries found for "
 				    "'%s', check 'git ls-files -s \"%s\"'",
 				    ce->name, ce->name);
diff --git a/t/t9904-unmerged-file-with-merged-entry.sh b/t/t9904-unmerged-file-with-merged-entry.sh
index 945bc1c..9138821 100755
--- a/t/t9904-unmerged-file-with-merged-entry.sh
+++ b/t/t9904-unmerged-file-with-merged-entry.sh
@@ -28,11 +28,11 @@ setup_stage_state() {
 
 test_expect_success 'setup - two branches with conflicting files' '
 	setup_repository &&
-	setup_stage_state &&
+	git merge master
 	git ls-files -s conflict > output &&
-	test_line_count = 4 output &&
+	test_line_count = 3 output &&
 	git ls-files -s conflict2 > output &&
-	test_line_count = 4 output &&
+	test_line_count = 3 output &&
 	rm output
 '
 
@@ -83,4 +83,12 @@ test_expect_success 'git reset --hard' '
 	test_cmp expected current
 '
 
+test_expect_success 'git update-index --cacheinfo to select a stage to use' '
+	setup_stage_state &&
+	git cat-file blob :1:conflict > conflict &&
+	git update-index --cacheinfo 100644,`git hash-object conflict`,conflict
+	git ls-files -s conflict > output &&
+	test_line_count = 1 output
+'
+
 test_done
-- 
2.0.4.4.gaf54b2b
