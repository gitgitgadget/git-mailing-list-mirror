From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/2] read-cache: fix reading of split index
Date: Fri, 20 Mar 2015 22:43:14 +0100
Message-ID: <1426887794-9655-3-git-send-email-t.gummerer@gmail.com>
References: <20150320195943.GB6545@hank>
 <1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 22:43:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ4hj-0007Jn-NC
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 22:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbbCTVnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 17:43:32 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36692 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbCTVn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 17:43:29 -0400
Received: by wgra20 with SMTP id a20so99685372wgr.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j2eN6FQSP65fSlVkWG/8Wo76QnNg7Btf3jTniUYsW7c=;
        b=mfjxXr7HLWB8iJ+o42LQe+fU2YFQUQ4IjNM58FXyvxkDzzKDyHar/AJ5HNUFyq1Sj0
         db+u+Uv2ahaI4F9Ukia+Oy7eTIAtsjghUpn8D99jsytuSyQgjph3K0Nx6z6T4KP7za1o
         BLyVVZjwjdM8YmNhh0ui9qo4x2/dm4umUbg1FMdCxXwWZCbRIVhacEZiF4Jgscf9BCYr
         bOz2DIptP1vcUBmFY5TIj16TTTXNovchkl0bmGaKQashAY2VOLoVWT64q5nQZ9J1e/8x
         3eZ3dy7PgTCQOEoL0xli34dz84bcNeifnGl1EI6Ed8aiNmrWeNTV2uAj/owbmWJ/Cbpm
         duww==
X-Received: by 10.180.79.232 with SMTP id m8mr28376597wix.81.1426887808228;
        Fri, 20 Mar 2015 14:43:28 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id ga8sm630897wib.11.2015.03.20.14.43.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 14:43:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.264.g0463184.dirty
In-Reply-To: <1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265969>

The split index extension uses ewah bitmaps to mark index entries as
deleted, instead of removing them from the index directly.  This can
result in an on-disk index, in which entries of stage #0 and higher
stages appear, which are removed later when the index bases are merged.

15999d0 read_index_from(): catch out of order entries when reading an
index file introduces a check which checks if the entries are in order
after each index entry is read in do_read_index.  This check may however
fail when a split index is read.

Fix this by moving checking the index after we know there is no split
index or after the split index bases are successfully merged instead.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8d71860..1bf78a4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1486,18 +1486,25 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
-static void check_ce_order(struct cache_entry *ce, struct cache_entry *next_ce)
-{
-	int name_compare = strcmp(ce->name, next_ce->name);
-	if (0 < name_compare)
-		die("unordered stage entries in index");
-	if (!name_compare) {
-		if (!ce_stage(ce))
-			die("multiple stage entries for merged file '%s'",
-				ce->name);
-		if (ce_stage(ce) > ce_stage(next_ce))
-			die("unordered stage entries for '%s'",
-				ce->name);
+static void check_ce_order(struct index_state *istate)
+{
+	unsigned int i;
+
+	for (i = 1; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i - 1];
+		struct cache_entry *next_ce = istate->cache[i];
+		int name_compare = strcmp(ce->name, next_ce->name);
+
+		if (0 < name_compare)
+			die("unordered stage entries in index");
+		if (!name_compare) {
+			if (!ce_stage(ce))
+				die("multiple stage entries for merged file '%s'",
+				    ce->name);
+			if (ce_stage(ce) > ce_stage(next_ce))
+				die("unordered stage entries for '%s'",
+				    ce->name);
+		}
 	}
 }
 
@@ -1562,9 +1569,6 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		ce = create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
 
-		if (i > 0)
-			check_ce_order(istate->cache[i - 1], ce);
-
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
@@ -1608,11 +1612,10 @@ int read_index_from(struct index_state *istate, const char *path)
 
 	ret = do_read_index(istate, path, 0);
 	split_index = istate->split_index;
-	if (!split_index)
-		return ret;
-
-	if (is_null_sha1(split_index->base_sha1))
+	if (!split_index || is_null_sha1(split_index->base_sha1)) {
+		check_ce_order(istate);
 		return ret;
+	}
 
 	if (split_index->base)
 		discard_index(split_index->base);
@@ -1628,6 +1631,7 @@ int read_index_from(struct index_state *istate, const char *path)
 				     sha1_to_hex(split_index->base_sha1)),
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
+	check_ce_order(istate);
 	return ret;
 }
 
-- 
2.1.0.264.g0463184.dirty
