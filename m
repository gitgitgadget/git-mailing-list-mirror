Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEA71F597
	for <e@80x24.org>; Wed,  1 Aug 2018 17:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404129AbeHAT21 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 15:28:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40795 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbeHAT20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 15:28:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so7981007wma.5
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=8j6VGz4oPwo3N8VqpOa6DTIUK186egdYDPsf+ooUc8A=;
        b=JyMgGeWa7up9UhAXVp207VXZShZ67NojL+siR+7fdxYhtp3c1QpDYOPSNHerR23967
         hgj20wp0sM4HhbCqBKtU+7jVOr5aXJ8Yi3RUw/qpEk2zPHy6cAAjBadH0Nb8BZN8o2FN
         RREZGdaeszFmH0ZpfQ6DUVi3zlM2gAyKf+JpBshHsjac3FcQEQkR9yDvac2sso45sIre
         W7NrbNPUEIQnuQ1oU6+GvQ/++99JfFg98R6go5XFtneqgJG+mWPQ0AkRBwQWHCDfWpBw
         tBc0H0x/uAY4bPLjjg9VRPCA/cEWhDHYSCuQfweHaW1moagVLwWH5UtkuGroxQeLNlMT
         x8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=8j6VGz4oPwo3N8VqpOa6DTIUK186egdYDPsf+ooUc8A=;
        b=k5n6dvcARKewe0Af+CVzPsaCi9hOva1eOOFwJSRZBF8a1OjJ256H+v1JYRPYJm7GJ9
         UaAxOCmHS4RR5esiw+5vUSeNmxnO/ayGKxlS7Zfiqt6QfjMbjRjMDy2f7pcb5e6UD4AT
         LSCSDSHvHEMWwdSDGXYXuHgfvD6Z4CpZfLRsao3LISD6kdeyakQ3AtNRgE7ad82i/+hU
         hyeNOBfMZYjhy0xZ5e96anAPd6Rr9pY2dKcy3rcRej+og7C8i31OcYosnJvaESsXxkjf
         +1mz7zMbUt2naWoREW9l9Svt4Jasay5oip7rIdgltICqoBD/lyHjQ5fb4GSOlxDutrz5
         9DTQ==
X-Gm-Message-State: AOUpUlElu8bszXB+AcqXTq114mja8Qw2bG80moUVSoXQUhXdpXP9fGg8
        7oeGi/hlJq6BjIk5bblm9eN9a0yb
X-Google-Smtp-Source: AAOMgpf7jTej7t/J2mAf5bGRbArPLyfcnbOAeNrbR2XDUIHzUo9rBumA0LLSSrMbvDIj2lZn4nJxEQ==
X-Received: by 2002:a1c:f001:: with SMTP id a1-v6mr3477829wmb.160.1533142192525;
        Wed, 01 Aug 2018 09:49:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p3-v6sm20670904wrg.47.2018.08.01.09.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 09:49:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2] remote: make refspec follow the same disambiguation rule as local refs
Date:   Wed, 01 Aug 2018 09:49:51 -0700
Message-ID: <xmqq8t5q821c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When matching a non-wildcard LHS of a refspec against a list of
refs, find_ref_by_name_abbrev() returns the first ref that matches
using any DWIM rules used by refname_match() in refs.c, even if a
better match occurs later in the list of refs.

This causes unexpected behavior when (for example) fetching using
the refspec "refs/heads/s:<something>" from a remote with both
"refs/heads/refs/heads/s" and "refs/heads/s"; even if the former was
inadvertently created, one would still expect the latter to be
fetched.  Similarly, when both a tag T and a branch T exist,
fetching T should favor the tag, just like how local refname
disambiguation rule works.  But because the code walks over
ls-remote output from the remote, which happens to be sorted in
alphabetical order and has refs/heads/T before refs/tags/T, a
request to fetch T is (mis)interpreted as fetching refs/heads/T.

Update refname_match(), all of whose current callers care only if it
returns non-zero (i.e. matches) to see if an abbreviated name can
mean the full name being tested, so that it returns a positive
integer whose magnitude can be used to tell the precedence, and fix
the find_ref_by_name_abbrev() function not to stop at the first
match but find the match with the highest precedence.

This is based on an earlier work, which special cased only the exact
matches, by Jonathan Tan.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time, with a log message, updated "precedence" number, a bit
   of in-code comment and a new test to show that the fix extends to
   non-exact disambiguation as well.

 refs.c           | 16 +++++++++++-----
 remote.c         | 13 ++++++++++---
 t/t5510-fetch.sh | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 20ba82b434..d1be61b1b5 100644
--- a/refs.c
+++ b/refs.c
@@ -487,16 +487,22 @@ static const char *ref_rev_parse_rules[] = {
 	NULL
 };
 
+/*
+ * Is it possible that the caller meant full_name with abbrev_name?
+ * If so return a non-zero value to signal "yes"; the magnitude of
+ * the returned value gives the precedence used for disambiguation.
+ *
+ * If abbrev_name cannot mean full_name, return 0.
+ */
 int refname_match(const char *abbrev_name, const char *full_name)
 {
 	const char **p;
 	const int abbrev_name_len = strlen(abbrev_name);
+	const int num_rules = ARRAY_SIZE(ref_rev_parse_rules) - 1;
 
-	for (p = ref_rev_parse_rules; *p; p++) {
-		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
-			return 1;
-		}
-	}
+	for (p = ref_rev_parse_rules; *p; p++)
+		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name)))
+			return &ref_rev_parse_rules[num_rules] - p;
 
 	return 0;
 }
diff --git a/remote.c b/remote.c
index c10d87c246..4a3e7ba136 100644
--- a/remote.c
+++ b/remote.c
@@ -1880,11 +1880,18 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const char *name)
 {
 	const struct ref *ref;
+	const struct ref *best_match = NULL;
+	int best_score = 0;
+
 	for (ref = refs; ref; ref = ref->next) {
-		if (refname_match(name, ref->name))
-			return ref;
+		int score = refname_match(name, ref->name);
+
+		if (best_score < score) {
+			best_match = ref;
+			best_score = score;
+		}
 	}
-	return NULL;
+	return best_match;
 }
 
 struct ref *get_remote_ref(const struct ref *remote_refs, const char *name)
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index da9ac00557..858381a788 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -535,6 +535,41 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	)
 '
 
+test_expect_success 'LHS of refspec follows ref disambiguation rules' '
+	mkdir lhs-ambiguous &&
+	(
+		cd lhs-ambiguous &&
+		git init server &&
+		test_commit -C server unwanted &&
+		test_commit -C server wanted &&
+
+		git init client &&
+
+		# Check a name coming after "refs" alphabetically ...
+		git -C server update-ref refs/heads/s wanted &&
+		git -C server update-ref refs/heads/refs/heads/s unwanted &&
+		git -C client fetch ../server +refs/heads/s:refs/heads/checkthis &&
+		git -C server rev-parse wanted >expect &&
+		git -C client rev-parse checkthis >actual &&
+		test_cmp expect actual &&
+
+		# ... and one before.
+		git -C server update-ref refs/heads/q wanted &&
+		git -C server update-ref refs/heads/refs/heads/q unwanted &&
+		git -C client fetch ../server +refs/heads/q:refs/heads/checkthis &&
+		git -C server rev-parse wanted >expect &&
+		git -C client rev-parse checkthis >actual &&
+		test_cmp expect actual &&
+
+		# Tags are preferred over branches like refs/{heads,tags}/*
+		git -C server update-ref refs/tags/t wanted &&
+		git -C server update-ref refs/heads/t unwanted &&
+		git -C client fetch ../server +t:refs/heads/checkthis &&
+		git -C server rev-parse wanted >expect &&
+		git -C client rev-parse checkthis >actual
+	)
+'
+
 # configured prune tests
 
 set_config_tristate () {
-- 
2.18.0-321-gffc6fa0e39

