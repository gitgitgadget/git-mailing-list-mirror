Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC02E208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 00:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbdHPAqK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 20:46:10 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:37342 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752913AbdHPAqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 20:46:09 -0400
Received: by mail-pg0-f53.google.com with SMTP id y129so15479008pgy.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0xtm6BB1MI4Kws1qiW6uY1hvoZUkWmVxSsIwhyL6xHs=;
        b=djUFyOQ7P0RL+5uAC24aLSi3fLQWQ4GePo29Su6x+jqtm4V+V8uCbhZTMF7MMEDA7j
         AKr5P9yxNfyXDKc43O0LZzs2GTFYBdCEMv9G5E6iPArjmdTFanV16laejV9S8eNEC/cQ
         m4j5HId5Drku7Q7xJt8OwMycnRRYpar6IgrvLV+5YUnD+GT5lrV3gdxtOePd6CmSiGgt
         K0ofx6rV0i221jRkwkEs2bMHS8e4oHOnzBFF56hQWEO0sIFuQ7+6Gro9bEa3tGGhcYAH
         emc3ZCNnszejNMD4e3Ljt5Wx2RtOEfPrpj70cVQc32PPh0yzG3EWbHJ+JQz2zXgYAI5A
         X+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0xtm6BB1MI4Kws1qiW6uY1hvoZUkWmVxSsIwhyL6xHs=;
        b=uWduR85i7WbiNC/Vz8j00XVCUteENHS/UrCU20beASopCijF12A+rZh+SS4jtFU8t7
         q2Lz+PrxZXL+lieDndTSRgq8X17xxdu2MFNDME04/kXDZgiuugTftKA0mnm/CCKnuggI
         8n50RLCyyvv9IV1AfuMhrM/zfPwOlLEmCYCmavLiUJOicIca6sbUTHcfqUS8bBjNHdSA
         5Sy6Jioyd9ZBCe3K0SPIB/jdwMIVZZAzZcU76gsjBiL4fzRrYlvY0P0X7D5L6RO7mTBp
         N033UqmHy6b1Sd3Z4bc2+TTvhWTwGnMRxxz+hplFyA8Df66h6YOEV+tL2yQmQsoUP+Pf
         llQg==
X-Gm-Message-State: AHYfb5iqV/7eDzU6ZUVNfpsU6kEBv5xM1rp4INlm+DvVnC04JO/t6CHh
        +d4oFk3YDt59VhI8
X-Received: by 10.98.10.206 with SMTP id 75mr5509pfk.132.1502844368635;
        Tue, 15 Aug 2017 17:46:08 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:f954:a93e:8e20:9fe8])
        by smtp.gmail.com with ESMTPSA id z8sm3293784pgs.25.2017.08.15.17.46.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 17:46:07 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] convert add_to_alternates_file to use repository struct
Date:   Tue, 15 Aug 2017 17:45:58 -0700
Message-Id: <20170816004558.6706-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The long term plan is to move most functionality to be included via
the repository struct, starting somewhere, convert add_to_alternates_file
in this patch, which has link_alt_odb_entries, which is converted, too.
Any caller outside add_to_alternates_file, just uses `the_repository`
as the repository argument to keep the functionality the same.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  For the series "object store is embedded in the repository object",
  I realized we have to convert sha1_file first as that is the foundation
  of all the object loading and writing. However there are currently other
  series in flight, such that I do not want to change all of sha1_file
  as it would yield serious conflicts. 

  This goes on top of origin/sb/sha1-file-cleanup and is one of the
  minimum viable things to get started with converting sha1_file to
  use the repository object.
  
  Thanks,
  Stefan

 builtin/clone.c |  9 +++++----
 cache.h         |  2 +-
 sha1_file.c     | 23 +++++++++++++++--------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 08b5cc433c..b8d170d055 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -25,6 +25,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
+#include "repository.h"
 
 /*
  * Overall FIXMEs:
@@ -327,7 +328,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	} else {
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addf(&sb, "%s/objects", ref_git);
-		add_to_alternates_file(sb.buf);
+		add_to_alternates_file(the_repository, sb.buf);
 		strbuf_release(&sb);
 	}
 
@@ -369,12 +370,12 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 		if (!line.len || line.buf[0] == '#')
 			continue;
 		if (is_absolute_path(line.buf)) {
-			add_to_alternates_file(line.buf);
+			add_to_alternates_file(the_repository, line.buf);
 			continue;
 		}
 		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
 		if (!normalize_path_copy(abs_path, abs_path))
-			add_to_alternates_file(abs_path);
+			add_to_alternates_file(the_repository, abs_path);
 		else
 			warning("skipping invalid relative alternate: %s/%s",
 				src_repo, line.buf);
@@ -452,7 +453,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 	if (option_shared) {
 		struct strbuf alt = STRBUF_INIT;
 		strbuf_addf(&alt, "%s/objects", src_repo);
-		add_to_alternates_file(alt.buf);
+		add_to_alternates_file(the_repository, alt.buf);
 		strbuf_release(&alt);
 	} else {
 		struct strbuf src = STRBUF_INIT;
diff --git a/cache.h b/cache.h
index 4109efcf24..fe1f1bc66a 100644
--- a/cache.h
+++ b/cache.h
@@ -1565,7 +1565,7 @@ struct alternate_object_database *alloc_alt_odb(const char *dir);
  * Add the directory to the on-disk alternates file; the new entry will also
  * take effect in the current process.
  */
-extern void add_to_alternates_file(const char *dir);
+extern void add_to_alternates_file(struct repository *r, const char *dir);
 
 /*
  * Add the directory to the in-memory list of alternates (along with any
diff --git a/sha1_file.c b/sha1_file.c
index 9186e2c6c7..298185f550 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -22,6 +22,7 @@
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
+#include "repository.h"
 #include "streaming.h"
 #include "dir.h"
 #include "mru.h"
@@ -422,8 +423,9 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(const char *alt, int len, int sep,
-				 const char *relative_base, int depth)
+static void link_alt_odb_entries(const struct repository *r, const char *alt,
+				 int len, int sep, const char *relative_base,
+				 int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -470,7 +472,8 @@ static void read_info_alternates(const char * relative_base, int depth)
 	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	link_alt_odb_entries(map, mapsz, '\n', relative_base, depth);
+	link_alt_odb_entries(the_repository, map, mapsz, '\n',
+			     relative_base, depth);
 
 	munmap(map, mapsz);
 }
@@ -487,10 +490,11 @@ struct alternate_object_database *alloc_alt_odb(const char *dir)
 	return ent;
 }
 
-void add_to_alternates_file(const char *reference)
+void add_to_alternates_file(struct repository *r, const char *reference)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	char *alts = git_pathdup("objects/info/alternates");
+	char *alts = repo_git_path(r, "objects/info/alternates");
+
 	FILE *in, *out;
 
 	hold_lock_file_for_update(lock, alts, LOCK_DIE_ON_ERROR);
@@ -527,7 +531,8 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(lock))
 			die_errno("unable to move new alternates file into place");
 		if (alt_odb_tail)
-			link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
+			link_alt_odb_entries(r, reference, strlen(reference),
+					     '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -540,7 +545,8 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
+	link_alt_odb_entries(the_repository, reference, strlen(reference),
+			     '\n', NULL, 0);
 }
 
 /*
@@ -643,7 +649,8 @@ void prepare_alt_odb(void)
 	if (!alt) alt = "";
 
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
+	link_alt_odb_entries(the_repository, alt, strlen(alt),
+			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
 }
-- 
2.14.0.rc0.3.g6c2e499285

