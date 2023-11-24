Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX6xA9wS"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B40D59
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40838915cecso12381615e9.2
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824268; x=1701429068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55UfTATPmaTTrs1J6snK2Oj8frBggV9uL0Kjh3KxBks=;
        b=ZX6xA9wSFLyjcQvyJhePYNWJzNkiSLwydLnh60CJ5pwW0AzoItcMhqe+FenwHld+gS
         iZfxy33rGrAfsFbeo2+xLWDJ0VlSjyl2Rwb4PS9CdO33fBLYPsOFHghPvx4lLiYRCk0R
         GRfplN9M5Xu5WmHUQd1tp5pMx5VXl3m4LkzMWWV5DvtK0j7hO1QTmskvO7gfL8SoQYIX
         HsmlaxxDv5YC1O4a15kGhuQInq07IWf+ac545jpX+E0IbkrqapFhlfwnz4D9T1jb4Ae6
         4SspFxY49FoQeN30pFTFrCYb87O/z3Nw2dxqzqwY/Dmh7+347WwjEwc6F3UCcuVtudXb
         ry3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824268; x=1701429068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55UfTATPmaTTrs1J6snK2Oj8frBggV9uL0Kjh3KxBks=;
        b=ADS3PvmUBGpB23yE7HWLTbhRrKsBv7dgYY1DbqRfXL6yLXgR9oZ8lkFtgo06atW4+r
         jnyuqe4niATYJJPdqTp9a8HatYrnnIXSKThEBwtyp5b5idUorDxz0lt++y5hAJlmexgs
         eumxCOATEls3uDx9GOBII/SHGI7OZ/CaZcKORTdV3sVa4Z+4geZ1aruvcYBGUZqeSf2m
         5We4FLZ4DXb0I76VNNoxepiXIzYZaxenSlM/Hbx4N0XGw2xstxeH4MTL7zdMKKaY/dNB
         BvnPm1uwyIKm49oD7jB5PYnSEqEEDCimWC2qg3rMBUzWoNGoMYX5LEPqk8dl06N7sk18
         fmDA==
X-Gm-Message-State: AOJu0YyBD1ZomGbvs09i/Oqb1/r0GBQtul5KXQF6P0k7KGKfnVNj/Kk6
	qdyRY+753sNtKP8e/I/pQCRVNFj9yYY=
X-Google-Smtp-Source: AGHT+IGNt7tF6Gi8F8raFnhtsF7cULlQFfRvyPfufkHjg90R5y6cS2vDAQt8OxoxgOys+NKFpeyYZg==
X-Received: by 2002:a05:600c:3ca0:b0:40a:48af:4820 with SMTP id bg32-20020a05600c3ca000b0040a48af4820mr2238922wmb.30.1700824268025;
        Fri, 24 Nov 2023 03:11:08 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:07 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 05/14] replay: introduce pick_regular_commit()
Date: Fri, 24 Nov 2023 12:10:34 +0100
Message-ID: <20231124111044.3426007-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.14.g93e034faee
In-Reply-To: <20231124111044.3426007-1-christian.couder@gmail.com>
References: <20231115143327.2441397-1-christian.couder@gmail.com>
 <20231124111044.3426007-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

Let's refactor the code to handle a regular commit (a commit that is
neither a root commit nor a merge commit) into a single function instead
of keeping it inside cmd_replay().

This is good for separation of concerns, and this will help further work
in the future to replay merge commits.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 54 ++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index f48c5ed255..d039467cd4 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -89,6 +89,35 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
+static struct commit *pick_regular_commit(struct commit *pickme,
+					  struct commit *last_commit,
+					  struct merge_options *merge_opt,
+					  struct merge_result *result)
+{
+	struct commit *base;
+	struct tree *pickme_tree, *base_tree;
+
+	base = pickme->parents->item;
+
+	pickme_tree = repo_get_commit_tree(the_repository, pickme);
+	base_tree = repo_get_commit_tree(the_repository, base);
+
+	merge_opt->branch2 = short_commit_name(pickme);
+	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+
+	merge_incore_nonrecursive(merge_opt,
+				  base_tree,
+				  result->tree,
+				  pickme_tree,
+				  result);
+
+	free((char*)merge_opt->ancestor);
+	merge_opt->ancestor = NULL;
+	if (!result->clean)
+		return NULL;
+	return create_commit(result->tree, pickme, last_commit);
+}
+
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
@@ -100,7 +129,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
-	struct tree *next_tree, *base_tree, *head_tree;
+	struct tree *head_tree;
 	struct merge_result result;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
@@ -175,7 +204,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	result.tree = head_tree;
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
-		struct commit *base;
+		struct commit *pick;
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
@@ -185,26 +214,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		base = commit->parents->item;
-
-		next_tree = repo_get_commit_tree(the_repository, commit);
-		base_tree = repo_get_commit_tree(the_repository, base);
-
-		merge_opt.branch2 = short_commit_name(commit);
-		merge_opt.ancestor = xstrfmt("parent of %s", merge_opt.branch2);
-
-		merge_incore_nonrecursive(&merge_opt,
-					  base_tree,
-					  result.tree,
-					  next_tree,
-					  &result);
-
-		free((char*)merge_opt.ancestor);
-		merge_opt.ancestor = NULL;
-		if (!result.clean)
+		pick = pick_regular_commit(commit, last_commit, &merge_opt, &result);
+		if (!pick)
 			break;
+		last_commit = pick;
 		last_picked_commit = commit;
-		last_commit = create_commit(result.tree, commit, last_commit);
 	}
 
 	merge_finalize(&merge_opt, &result);
-- 
2.43.0.14.g93e034faee

