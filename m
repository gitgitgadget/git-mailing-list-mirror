Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMhzr6JQ"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A5110D7
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40838915cecso12381365e9.2
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824265; x=1701429065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seWVrHYt7gjjYKLrqq9EHA2lVkjpouKA61HglcNJuhw=;
        b=ZMhzr6JQQbZ2uaBuwZGwHMH+3SVF68xO/igW1UsB8+linz/kreAyogJHG8+h51w1GZ
         e4sfQzdoKwBljtR2SRoP+NudQnIPLBIWk0OdOFJNcTIfr/PsF10TNlhW6lAFMnbP8naP
         +AaaW+DqWUyOp2/BXHbhpjOoznHdGXMusCFmGVxfmIX/fG1o6hYgngeenUDxjOru7mP7
         eC/S1WHzA0ekV7N6uyEtSpNl0/SrB9dLk0SB4myTwlWOyOCuLtNvwG4CKNKnrL7A3XLt
         UOPVe3iUZkgKOFtYKeAJTDiOdCqL4Oj8tgV550EhmONL5YL3dHGcO7VcGGrha8ik0s19
         6elA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824265; x=1701429065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seWVrHYt7gjjYKLrqq9EHA2lVkjpouKA61HglcNJuhw=;
        b=LFW3vIuaKgrQqdQBa6bk92RB9PopdQBLGmebyAYPhzEDboN0sb2FAq4zSL6wd3gopU
         MdNAhu9zcoHICvYDR/TxvUBQ3cfUERphZApcmM+RR0bG1BUMf8NKajlD+ijD+tyq8iMb
         SKrh/q+WNIgftXd/znVttS8ngFfUitXrjbKKtSh5swOo/nxPvf+SjUvqLybi7o4pagCu
         VHn1LcQnzuk8jg+Je8x2Z3OO0tNIuelspuoOOPI6NjTWUXhSNgHiRoeEWgU9BOEELYKT
         uvYlxvX4GT934bjmHjVRb60ru6HeTfUw3xQ3mn6Hnar4w/qV1hS35ubIuCw+adTl8XN1
         F2yQ==
X-Gm-Message-State: AOJu0YxM5VvDkn5IK1pWsLXV9BW/fiUk9i0tGBfGSvcbJh/OCk44o05P
	5TtxbsDDeuEK4gAfsf+fjeOIiTjV98Y=
X-Google-Smtp-Source: AGHT+IHo20/lQHrydomHSLm/H3dtUl8qfvHrmOV6ysiLSZvwxrkwU7dhqoamrPHHct3d4aBX6VWXSQ==
X-Received: by 2002:a05:600c:45c6:b0:40a:2796:618f with SMTP id s6-20020a05600c45c600b0040a2796618fmr1798129wmo.40.1700824265574;
        Fri, 24 Nov 2023 03:11:05 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:04 -0800 (PST)
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
Subject: [PATCH v8 03/14] replay: start using parse_options API
Date: Fri, 24 Nov 2023 12:10:32 +0100
Message-ID: <20231124111044.3426007-4-christian.couder@gmail.com>
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

Instead of manually parsing arguments, let's start using the parse_options
API. This way this new builtin will look more standard, and in some
upcoming commits will more easily be able to handle more command line
options.

Note that we plan to later use standard revision ranges instead of
hardcoded "<oldbase> <branch>" arguments. When we will use standard
revision ranges, it will be easier to check if there are no spurious
arguments if we keep ARGV[0], so let's call parse_options() with
PARSE_OPT_KEEP_ARGV0 even if we don't need ARGV[0] right now to avoid
some useless code churn.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 1998134683..7998f6ed04 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -15,7 +15,7 @@
 #include "lockfile.h"
 #include "merge-ort.h"
 #include "object-name.h"
-#include "read-cache-ll.h"
+#include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
 #include "sequencer.h"
@@ -92,6 +92,7 @@ static struct commit *create_commit(struct tree *tree,
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
+	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
 	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
@@ -105,16 +106,32 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct strbuf branch_name = STRBUF_INIT;
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h")) {
-		printf("usage: (EXPERIMENTAL!) git replay --onto <newbase> <oldbase> <branch>\n");
-		exit(129);
+	const char * const replay_usage[] = {
+		N_("(EXPERIMENTAL!) git replay --onto <newbase> <oldbase> <branch>"),
+		NULL
+	};
+	struct option replay_options[] = {
+		OPT_STRING(0, "onto", &onto_name,
+			   N_("revision"),
+			   N_("replay onto given commit")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
+
+	if (!onto_name) {
+		error(_("option --onto is mandatory"));
+		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (argc != 5 || strcmp(argv[1], "--onto"))
-		die("usage: read the code, figure out how to use it, then do so");
+	if (argc != 3) {
+		error(_("bad number of arguments"));
+		usage_with_options(replay_usage, replay_options);
+	}
 
-	onto = peel_committish(argv[2]);
-	strbuf_addf(&branch_name, "refs/heads/%s", argv[4]);
+	onto = peel_committish(onto_name);
+	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
 	/* Sanity check */
 	if (repo_get_oid(the_repository, "HEAD", &head))
@@ -126,6 +143,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		BUG("Could not read index");
 
 	repo_init_revisions(the_repository, &revs, prefix);
+
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
 	revs.cherry_mark = 1;
@@ -134,7 +152,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.right_only = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
-	strvec_pushl(&rev_walk_args, "", argv[4], "--not", argv[3], NULL);
+
+	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
 		ret = error(_("unhandled options"));
@@ -197,8 +216,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			       &last_commit->object.oid,
 			       &last_picked_commit->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[4]);
-			die("Failed to update %s", argv[4]);
+			error(_("could not update %s"), argv[2]);
+			die("Failed to update %s", argv[2]);
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
@@ -210,8 +229,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			       &last_commit->object.oid,
 			       &head,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[4]);
-			die("Failed to update %s", argv[4]);
+			error(_("could not update %s"), argv[2]);
+			die("Failed to update %s", argv[2]);
 		}
 	}
 	ret = (result.clean == 0);
-- 
2.43.0.14.g93e034faee

