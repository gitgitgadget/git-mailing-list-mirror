Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI3cdjFP"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2746D72
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b39d33fe0so4636295e9.0
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824270; x=1701429070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBVVnZ6kjgNi2Syu+AtDhT1o9WE1YPHMcqPfrZTtyNc=;
        b=iI3cdjFPjdoHYYUoLsCe9dtKg2NAYEmSQRVKtm5oVm7l6aOLmEBsm6QVtGLXaBSNPT
         trY9etFe/prl0iPk4Lfu7ksTGda/cY6pp7QvWmEsGap1XfAoAP1CAE/QTFS8B3FgS4rD
         NfS5KmsN2bAZt9F0ZkQoc1g/iqinLgawbKAJCPwrwF8B9Ba3GtZRswp83FSw0oLVpdGK
         Kj5JovvdFv++cliT3cYhdAGqzsnMMYJxnJsQj+OOh7L8H8MD+HzYgX6vGq1unSSikjNf
         holnh2nt3VV17sVs7rRrssMDrN044eE5LAEzv9kC+vd8f/H/drwK0zz812hFkPDlyMQj
         ptlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824270; x=1701429070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBVVnZ6kjgNi2Syu+AtDhT1o9WE1YPHMcqPfrZTtyNc=;
        b=rfInsQnPFUXdF+mYYSCH+EPnjgFq7yv9WoVFA6nflp6xHv4w9K+JTYVPZJsRmBQqHt
         cQSSSrEpd73t/lUixSLwvFdnos+yTXvocgJcsmxWHJfGq66spDrgFY8LDciIbaX+vNA+
         7PWb+OctwsKi2D+jmGC7uExyCEmH+HgKFhmlRM6inmHBxPz+dSvjYrbFPvPdSW1NkapR
         7GK71pBThs/n65/ojvmqeSODX30bUHUORKjzRCD4Dz02Lobif4t7S3wN++AVE6MkWv4v
         gG8k80SMnnnigBSai4VINOVVPkG42h3lrgzLIBaaH9Es6mHO37i6/PZZ/LNsCgHjnCpV
         pL8Q==
X-Gm-Message-State: AOJu0Yx3GtxkgjvawCMA5sdbidxfv1+RggHNaoyA4btnbSoWnzm+Wj3d
	7vKqd/mFXrM1VASjQqnONiEEJTFGgzE=
X-Google-Smtp-Source: AGHT+IFBnp0h11NSUb8ge2SdqXA9E23vgVtrj66RqfjtIH9oEpuGfzx9e+EKW4fMfmoCeXtfOvK+cA==
X-Received: by 2002:a05:600c:4ed0:b0:40b:2b86:c886 with SMTP id g16-20020a05600c4ed000b0040b2b86c886mr2023184wmq.31.1700824269806;
        Fri, 24 Nov 2023 03:11:09 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:08 -0800 (PST)
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
Subject: [PATCH v8 06/14] replay: change rev walking options
Date: Fri, 24 Nov 2023 12:10:35 +0100
Message-ID: <20231124111044.3426007-7-christian.couder@gmail.com>
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

Let's force the rev walking options we need after calling
setup_revisions() instead of before.

This might override some user supplied rev walking command line options
though. So let's detect that and warn users by:

  a) setting the desired values, before setup_revisions(),
  b) checking after setup_revisions() whether these values differ from
     the desired values,
  c) if so throwing a warning and setting the desired values again.

We want the command to work from older commits to newer ones by default.
Also we don't want history simplification, as we want to deal with all
the commits in the affected range.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index d039467cd4..2f664218be 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -173,22 +173,56 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
-	revs.verbose_header = 1;
-	revs.max_parents = 1;
-	revs.cherry_mark = 1;
-	revs.limited = 1;
+	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
+
+	/*
+	 * Set desired values for rev walking options here. If they
+	 * are changed by some user specified option in setup_revisions()
+	 * below, we will detect that below and then warn.
+	 *
+	 * TODO: In the future we might want to either die(), or allow
+	 * some options changing these values if we think they could
+	 * be useful.
+	 */
 	revs.reverse = 1;
-	revs.right_only = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
-
-	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
+	revs.simplify_history = 0;
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
 		ret = error(_("unhandled options"));
 		goto cleanup;
 	}
 
+	/*
+	 * Detect and warn if we override some user specified rev
+	 * walking options.
+	 */
+	if (revs.reverse != 1) {
+		warning(_("some rev walking options will be overridden as "
+			  "'%s' bit in 'struct rev_info' will be forced"),
+			"reverse");
+		revs.reverse = 1;
+	}
+	if (revs.sort_order != REV_SORT_IN_GRAPH_ORDER) {
+		warning(_("some rev walking options will be overridden as "
+			  "'%s' bit in 'struct rev_info' will be forced"),
+			"sort_order");
+		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	}
+	if (revs.topo_order != 1) {
+		warning(_("some rev walking options will be overridden as "
+			  "'%s' bit in 'struct rev_info' will be forced"),
+			"topo_order");
+		revs.topo_order = 1;
+	}
+	if (revs.simplify_history != 0) {
+		warning(_("some rev walking options will be overridden as "
+			  "'%s' bit in 'struct rev_info' will be forced"),
+			"simplify_history");
+		revs.simplify_history = 0;
+	}
+
 	strvec_clear(&rev_walk_args);
 
 	if (prepare_revision_walk(&revs) < 0) {
-- 
2.43.0.14.g93e034faee

