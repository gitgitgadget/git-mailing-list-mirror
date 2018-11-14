Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 479751F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbeKNKPI (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:15:08 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52211 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKPI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:15:08 -0500
Received: by mail-vs1-f74.google.com with SMTP id p1so6114663vsc.18
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ebO+gFh8SHzWJ9UK7UTM5Sy+lR6HWdI3pHOvZKqKZLM=;
        b=iEGjR0yXeUXFcgV+Ph7hrVQaYcKmjQlmUuhYpQErX3caq2CWrCejdI2E5a4KC1JAM4
         6f/dybPOx6CtHzl5Ay1hQz8UGbBPYK3j8w6mZCqUmA/rW+xE+FJKBvbrFergW3oMXqmp
         vi6Ip/AzH9f9oG4LogYTeLIxGoFNI6GUiArtryxB5JGyrvADIkUExiEqy5O6H6c/LK/D
         5lsVOO6xiro7MG/JjMDTmpv/AfNvVhRRkeeEc3WQQQF28SoknKTqGE/ZcBNBLXYQXC1/
         tkCm5dP+yD1R9IwM1HuOdH+Fy85iyZvzWrZbJcCQ04xUlAGUYmMJKSRAa9dmYdB4q8Jm
         l94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ebO+gFh8SHzWJ9UK7UTM5Sy+lR6HWdI3pHOvZKqKZLM=;
        b=WIdOo/hvF7E7ow8Gv40HegFmK54Kyn+KvhZOUe4qmpd2LMhhO8aqftjHJeKoA7aum4
         r5fJuwKw5iTTskUjS4rtn88dp344EvdFKhuM1KQSDFpupd/zdaABjMoqNCCSkh9EgMie
         IPV0dbFec640VqBMHdC6BolYPuElPVnKGMQTDXiNJFitcHnJmWEg7DmBzd7yaWa0nqg7
         r3t3y7Mrh4bLoDVekkJIBsta2BRHOL7jdTD4zpjEZKM0jokadu5+tAAWihmPtJpVurgN
         UDNim1HjxnlFcQl9DB7qp3/mbnN+Js3vfZ+LisTqbSlDcRgN6chbjMZFeqheYJbfSXZt
         dEBw==
X-Gm-Message-State: AGRZ1gKqzYfM2ElOWp+unEVveOjHq56kC/752D4PNC1xKILdewg41CXp
        FARYBzmbtcfTmqeq9lZa+hsgfdzkEktG
X-Google-Smtp-Source: AJdET5fnbfmQToZL+3VspVfEaMd0/fPFScUAdaRkYCiqCPf71YhJy+muUpTOg/unSq0KJgXS7UDl6N/AVtmO
X-Received: by 2002:a1f:fc0b:: with SMTP id a11mr6036802vki.23.1542154464602;
 Tue, 13 Nov 2018 16:14:24 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:13:04 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-22-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 21/23] commit: prepare free_commit_buffer and
 release_commit_memory for any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the object pool to free_commit_buffer and release_commit_memory,
such that we can eliminate access to 'the_repository'.

Also remove the TODO in release_commit_memory, as commit->util was
removed in 9d2c97016f (commit.h: delete 'util' field in struct commit,
2018-05-19)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fsck.c     | 3 ++-
 builtin/log.c      | 6 ++++--
 builtin/rev-list.c | 3 ++-
 commit.c           | 9 ++++-----
 commit.h           | 4 ++--
 object.c           | 2 +-
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 06eb421720..c476ac6983 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -382,7 +382,8 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 	if (obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
 	if (obj->type == OBJ_COMMIT)
-		free_commit_buffer((struct commit *)obj);
+		free_commit_buffer(the_repository->parsed_objects,
+				   (struct commit *)obj);
 	return err;
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 061d4fd864..64c2649c7c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -395,7 +395,8 @@ static int cmd_log_walk(struct rev_info *rev)
 			 * We may show a given commit multiple times when
 			 * walking the reflogs.
 			 */
-			free_commit_buffer(commit);
+			free_commit_buffer(the_repository->parsed_objects,
+					   commit);
 			free_commit_list(commit->parents);
 			commit->parents = NULL;
 		}
@@ -1922,7 +1923,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		    open_next_file(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("Failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
-		free_commit_buffer(commit);
+		free_commit_buffer(the_repository->parsed_objects,
+				   commit);
 
 		/* We put one extra blank line between formatted
 		 * patches and this flag is used by log-tree code
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index cc1b70522f..2b301fa315 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -196,7 +196,8 @@ static void finish_commit(struct commit *commit, void *data)
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 	}
-	free_commit_buffer(commit);
+	free_commit_buffer(the_repository->parsed_objects,
+			   commit);
 }
 
 static inline void finish_object__ma(struct object *obj)
diff --git a/commit.c b/commit.c
index 7d2f3a9a93..4fe74aa4bc 100644
--- a/commit.c
+++ b/commit.c
@@ -328,10 +328,10 @@ void repo_unuse_commit_buffer(struct repository *r,
 		free((void *)buffer);
 }
 
-void free_commit_buffer(struct commit *commit)
+void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
 {
 	struct commit_buffer *v = buffer_slab_peek(
-		the_repository->parsed_objects->buffer_slab, commit);
+		pool->buffer_slab, commit);
 	if (v) {
 		FREE_AND_NULL(v->buffer);
 		v->size = 0;
@@ -354,13 +354,12 @@ struct object_id *get_commit_tree_oid(const struct commit *commit)
 	return &get_commit_tree(commit)->object.oid;
 }
 
-void release_commit_memory(struct commit *c)
+void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
 {
 	c->maybe_tree = NULL;
 	c->index = 0;
-	free_commit_buffer(c);
+	free_commit_buffer(pool, c);
 	free_commit_list(c->parents);
-	/* TODO: what about commit->util? */
 
 	c->object.parsed = 0;
 }
diff --git a/commit.h b/commit.h
index 2e6b799b26..d2779a23f6 100644
--- a/commit.h
+++ b/commit.h
@@ -140,7 +140,7 @@ void repo_unuse_commit_buffer(struct repository *r,
 /*
  * Free any cached object buffer associated with the commit.
  */
-void free_commit_buffer(struct commit *);
+void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
 struct tree *get_commit_tree(const struct commit *);
 struct object_id *get_commit_tree_oid(const struct commit *);
@@ -149,7 +149,7 @@ struct object_id *get_commit_tree_oid(const struct commit *);
  * Release memory related to a commit, including the parent list and
  * any cached object buffer.
  */
-void release_commit_memory(struct commit *c);
+void release_commit_memory(struct parsed_object_pool *pool, struct commit *c);
 
 /*
  * Disassociate any cached object buffer from the commit, but do not free it.
diff --git a/object.c b/object.c
index 003f870484..c4170d2d0c 100644
--- a/object.c
+++ b/object.c
@@ -540,7 +540,7 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 		if (obj->type == OBJ_TREE)
 			free_tree_buffer((struct tree*)obj);
 		else if (obj->type == OBJ_COMMIT)
-			release_commit_memory((struct commit*)obj);
+			release_commit_memory(o, (struct commit*)obj);
 		else if (obj->type == OBJ_TAG)
 			release_tag_memory((struct tag*)obj);
 	}
-- 
2.19.1.1215.g8438c0b245-goog

