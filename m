Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVFax49G"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A0AD67
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso12469535e9.2
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824281; x=1701429081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RfQTjFDb7BYMxSIibHknTuflDQ0Q8yabih36g6QVnU=;
        b=jVFax49GeVf1F0dCL/4PrX8kEqBBkGw556B00O6mw0ngopnr89NOIlA+33wcnJuvP3
         l+SzEsWjK6wJeAlBw9xGU0q/UXw2rAvgpb5F3MxGUGcy39xBZOvpBiMLqoSyYSBCTW5/
         wX2qb00lD79zpW0J5/M9Fm0AtpTp+fxHU7OYbcqr+pFrpDmPsYBqcUJLGykO0vQyjm6Q
         JTDtLKCRsQ114M0xoMmn1hXaMlTkhORjoDyOXNUZSfNfdXg0LPH5V+6AU/hYf1LR2c6p
         5T4kxBz4Y8by9B+V1zFMYRoWNEpM+lS7IUP+61vrJZvRRYC9LByBwhV74bbDWWUfSY9+
         iSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824281; x=1701429081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RfQTjFDb7BYMxSIibHknTuflDQ0Q8yabih36g6QVnU=;
        b=e7oxxnA2GXBY/VgZF01miilE0WkiuvJdwhLKPeynD991znfKTMAXZN0vVRxogfcz93
         Z+bu9BDCh0cMrUOz/HdGILaACDRtesDha80cBflrhayJQUgyZ1YqmiCMjxmd2nktSU94
         qqT7qE1v3h7O206lzCFMF4aTqYbIxRpR1VtIYJ2zQDhaxvUXtsS12UZEm9vDZv7kwii+
         9srEG1SP4MT+EBrBSynGmXgUliNC5TXoEA/9xvCsX8B1zKgBGb/IYPvfg2YVfhR51+lM
         U6Ah+GBS+VHY4glwJ+A8AWRmliDp2rgNeyFpXS3KANh6HfJW8VAcL2jbgPDrK4fAt49t
         L/qw==
X-Gm-Message-State: AOJu0Yz06sbEKvQW6Pyiy9yXEgbGjcE2nuY+EtmP9PSHGqqz6b15Xzgv
	e2wA17+b8Kg9b5DT/3+wcwZgHdlxGno=
X-Google-Smtp-Source: AGHT+IGi052/gC2M+fDmy93owlTpMT7fTPhFdDfwLPh7EfR/hWeYQ/ri9Xyx0oHCzeXPHRirpl9UuA==
X-Received: by 2002:a05:600c:19c9:b0:409:1d9a:1ded with SMTP id u9-20020a05600c19c900b004091d9a1dedmr1983433wmq.39.1700824280915;
        Fri, 24 Nov 2023 03:11:20 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:19 -0800 (PST)
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
Subject: [PATCH v8 13/14] replay: add --contained to rebase contained branches
Date: Fri, 24 Nov 2023 12:10:42 +0100
Message-ID: <20231124111044.3426007-14-christian.couder@gmail.com>
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

Let's add a `--contained` option that can be used along with
`--onto` to rebase all the branches contained in the <revision-range>
argument.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt | 12 +++++++++++-
 builtin/replay.c             | 14 ++++++++++++--
 t/t3650-replay-basics.sh     | 29 +++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index c4c64f955a..f6c269c62d 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
 
 DESCRIPTION
 -----------
@@ -96,6 +96,16 @@ top of the exact same new base, they only differ in that the first
 provides instructions to make mybranch point at the new commits and
 the second provides instructions to make target point at them.
 
+What if you have a stack of branches, one depending upon another, and
+you'd really like to rebase the whole set?
+
+------------
+$ git replay --contained --onto origin/main origin/main..tipbranch
+update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
+update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
+update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
+------------
+
 When calling `git replay`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
 do:
diff --git a/builtin/replay.c b/builtin/replay.c
index f26806d7e2..df14657e2f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -258,6 +258,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	const char *advance_name = NULL;
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
+	int contained = 0;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -268,7 +269,9 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	int ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("(EXPERIMENTAL!) git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
+		N_("(EXPERIMENTAL!) git replay "
+		   "([--contained] --onto <newbase> | --advance <branch>) "
+		   "<revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -278,6 +281,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &onto_name,
 			   N_("revision"),
 			   N_("replay onto given commit")),
+		OPT_BOOL(0, "contained", &contained,
+			 N_("advance all branches contained in revision-range")),
 		OPT_END()
 	};
 
@@ -289,6 +294,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		usage_with_options(replay_usage, replay_options);
 	}
 
+	if (advance_name && contained)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--advance", "--contained");
+
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	/*
@@ -377,7 +386,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			continue;
 		while (decoration) {
 			if (decoration->type == DECORATION_REF_LOCAL &&
-			    strset_contains(update_refs, decoration->name)) {
+			    (contained || strset_contains(update_refs,
+							  decoration->name))) {
 				printf("update %s %s %s\n",
 				       decoration->name,
 				       oid_to_hex(&last_commit->object.oid),
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 68a87e7803..d6286f9580 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -114,4 +114,33 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
 	test_must_fail git replay topic1..topic2 >result
 '
 
+test_expect_success 'using replay to also rebase a contained branch' '
+	git replay --contained --onto main main..topic3 >result &&
+
+	test_line_count = 2 result &&
+	cut -f 3 -d " " result >new-branch-tips &&
+
+	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
+	test_write_lines F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
+	test_write_lines H G F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic1 " >expect &&
+	printf "%s " $(head -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic1 >>expect &&
+	printf "update refs/heads/topic3 " >>expect &&
+	printf "%s " $(tail -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic3 >>expect &&
+
+	test_cmp expect result
+'
+
+test_expect_success 'using replay on bare repo to also rebase a contained branch' '
+	git -C bare replay --contained --onto main main..topic3 >result-bare &&
+	test_cmp expect result-bare
+'
+
 test_done
-- 
2.43.0.14.g93e034faee

