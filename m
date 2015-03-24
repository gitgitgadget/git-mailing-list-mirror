From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] read-cache: tighten checks for do_read_index
Date: Tue, 24 Mar 2015 18:00:29 +0100
Message-ID: <1427216429-15569-1-git-send-email-t.gummerer@gmail.com>
References: <CACsJy8CYi+hYu8zwOy=m7zZk3-8fr+Jq9uT4kEf8fLCOcjHJzw@mail.gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 18:52:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaT0G-00086c-3D
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbbCXRwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:52:32 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35415 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbbCXRAh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:00:37 -0400
Received: by wgdm6 with SMTP id m6so176220377wgd.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZpmVIQtAz1/yg8GDDT6hb6d7pCx8ZEWpTBaYyckNZs=;
        b=0BNJKMzxSJO2naEOAbejKhoqqOCL0iriWK/lSVWuoBuM46R1en9FI3kDmHmygfD6/Q
         fkqQRIoIZ1jUPb1+I9H1jZXAAeoJVXeoMfZKMDZ9v1f0nNe/Dctz8/w/T8ILopMz/7CK
         Jwiviip3Q36c6n2ve0h5HRM+jy2JFMYZasKKlmG9p+lZ/4+rvn3KO9tzcKuc5yp6BXCD
         onmlo9UVz6Xha1wwMwsj0F05J+/hidjJPcOu0BDHVUYY0pbkXBPyzEMs+jA0Sm9AMnrh
         maSomySS5CQxqi4x1sx2a2sQAhYqAuijveUfqsDrjLtb+5ZKnE+vIPq+Lf5iwING64NA
         mpWg==
X-Received: by 10.194.185.68 with SMTP id fa4mr9373387wjc.111.1427216436086;
        Tue, 24 Mar 2015 10:00:36 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id z13sm6863877wjr.44.2015.03.24.10.00.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 10:00:35 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.264.g0463184.dirty
In-Reply-To: <CACsJy8CYi+hYu8zwOy=m7zZk3-8fr+Jq9uT4kEf8fLCOcjHJzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266214>

03f15a7 read-cache: fix reading of split index moved the checks for the
correct order of index entries out of do_read_index.  This loosens the
checks more than necessary.  Re-introduce the checks for the order, but
don't error out when we have multiple stage-0 entries in the index.
Return a flag for the caller instead, if we have multiple stage-0
entries and let the caller decide if we need to error out.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This is a patch on top of my previous patch, as that one has already
been merged to next.

 cache.h                 |  2 +-
 read-cache.c            | 54 ++++++++++++++++++++++++++++++++-----------------
 test-dump-split-index.c |  2 +-
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index e7b24a2..3eaa258 100644
--- a/cache.h
+++ b/cache.h
@@ -487,7 +487,7 @@ struct lock_file;
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct pathspec *pathspec);
 extern int do_read_index(struct index_state *istate, const char *path,
-			 int must_exist); /* for testting only! */
+			 int must_exist, int *multiple_stage_entries); /* for testting only! */
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
diff --git a/read-cache.c b/read-cache.c
index 36ff89f..2ba67ce 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1488,30 +1488,39 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
-static void check_ce_order(struct index_state *istate)
+static int check_ce_order(struct cache_entry *ce, struct cache_entry *next_ce,
+			   int gentle_multiple_stage)
 {
-	unsigned int i;
-
-	for (i = 1; i < istate->cache_nr; i++) {
-		struct cache_entry *ce = istate->cache[i - 1];
-		struct cache_entry *next_ce = istate->cache[i];
-		int name_compare = strcmp(ce->name, next_ce->name);
+	int name_compare = strcmp(ce->name, next_ce->name);
 
-		if (0 < name_compare)
-			die("unordered stage entries in index");
-		if (!name_compare) {
-			if (!ce_stage(ce))
+	if (0 < name_compare)
+		die("unordered stage entries in index");
+	if (!name_compare) {
+		if (!ce_stage(ce)) {
+			if (gentle_multiple_stage)
+				return 1;
+			else
 				die("multiple stage entries for merged file '%s'",
 				    ce->name);
-			if (ce_stage(ce) > ce_stage(next_ce))
-				die("unordered stage entries for '%s'",
-				    ce->name);
 		}
+		if (ce_stage(ce) > ce_stage(next_ce))
+			die("unordered stage entries for '%s'",
+			    ce->name);
 	}
+	return 0;
+}
+
+static void check_istate_order(struct index_state *istate)
+{
+	unsigned int i;
+
+	for (i = 1; i < istate->cache_nr; i++)
+		check_ce_order(istate->cache[i - 1], istate->cache[i], 0);
 }
 
 /* remember to discard_cache() before reading a different cache! */
-int do_read_index(struct index_state *istate, const char *path, int must_exist)
+int do_read_index(struct index_state *istate, const char *path, int must_exist,
+		  int *multiple_stage_entries)
 {
 	int fd, i;
 	struct stat st;
@@ -1571,6 +1580,11 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		ce = create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
 
+		if (i > 0)
+			if (check_ce_order(istate->cache[i - 1], ce, 1) > 0 &&
+			    multiple_stage_entries)
+				*multiple_stage_entries |= 1;
+
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
@@ -1607,15 +1621,17 @@ int read_index_from(struct index_state *istate, const char *path)
 {
 	struct split_index *split_index;
 	int ret;
+	int multiple_stage_entries = 0;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
 	if (istate->initialized)
 		return istate->cache_nr;
 
-	ret = do_read_index(istate, path, 0);
+	ret = do_read_index(istate, path, 0, &multiple_stage_entries);
 	split_index = istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
-		check_ce_order(istate);
+		if (multiple_stage_entries)
+			check_istate_order(istate);
 		return ret;
 	}
 
@@ -1625,7 +1641,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 	ret = do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
-				     sha1_to_hex(split_index->base_sha1)), 1);
+				     sha1_to_hex(split_index->base_sha1)), 1, NULL);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
 		    sha1_to_hex(split_index->base_sha1),
@@ -1633,7 +1649,7 @@ int read_index_from(struct index_state *istate, const char *path)
 				     sha1_to_hex(split_index->base_sha1)),
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
-	check_ce_order(istate);
+	check_istate_order(istate);
 	return ret;
 }
 
diff --git a/test-dump-split-index.c b/test-dump-split-index.c
index 9cf3112..fc9ced7 100644
--- a/test-dump-split-index.c
+++ b/test-dump-split-index.c
@@ -12,7 +12,7 @@ int main(int ac, char **av)
 	struct split_index *si;
 	int i;
 
-	do_read_index(&the_index, av[1], 1);
+	do_read_index(&the_index, av[1], 1, NULL);
 	printf("own %s\n", sha1_to_hex(the_index.sha1));
 	si = the_index.split_index;
 	if (!si) {
-- 
2.1.0.264.g0463184.dirty
