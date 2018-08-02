Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE751F597
	for <e@80x24.org>; Thu,  2 Aug 2018 22:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeHCAPB (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 20:15:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55154 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbeHCAPB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 20:15:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so4193477wmb.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=krQbv4YhzgSnrlhKGNP+kXrqaI+nrmhNougDwrE0vUU=;
        b=Li8pLc9kVEI70wcPPmZ61kruBcz++Prjph0nRP7Aw0MEo35WqF2vO6NYRT6WJZFm4i
         SIu4OqZd5imx9QB06My3TqNcpPSacwa6I6npJe9w9wSU2BdvYAvQTDB4/kN3j8hKklLU
         V1+TZmX5x1v63l5OSRsHkSAllMIipGylwHzm09bClQNw4qFcENAe4cdibIyiCuUrUKsC
         4g6k2pWlxawoyNo/8LSU8clDiCW/q/QGUB6/RKATnuxZpwN0aNe34QX2aqJ3HT1EifGn
         bjkdVsajLbLReWT23WjeMpS1FtRyFOS+TM5wJe1TBm8B/NdwYQLsu5BlkN6LrqrOnYvw
         6/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=krQbv4YhzgSnrlhKGNP+kXrqaI+nrmhNougDwrE0vUU=;
        b=P2r/9VCPXNlAlL75EaT7ncciYtI5/zLmnreT+GE69c6omPPjDx5W2U+ltZdVItfZpS
         MoQndwYMJzxuTV/oIXSHQyLFFkGxq1A39I/HTGddxaUdD+QFX/oWjXsXxcaXCWjjQfOL
         DpDGv0frzvi+8vreUJpEUrCQ74iSM4OyYJ8NeWFhXKOdHFC6tyye/gcsHRdxwi/0qLu8
         DxfLxNn5TNSxjD1Vdzkzwgsgywmx16wxDmipikL/vUAJlK/KoCwXs1uI9bjU2RDyGtwH
         8rf3biD24NRhpTBSfqlwKdVst23llZ26WW5J+VLdoxnmHZgMkk1Gesi9XxiHE8mDiLXT
         KDYQ==
X-Gm-Message-State: AOUpUlG773eE2zg8sOcBt8NesnEUbO+XXD7OqVSf6N6PabO9JZWkWGfy
        Tc6Ul+uWL9V8n95loLh+VyQ=
X-Google-Smtp-Source: AAOMgpdP10s/X4vC3ipC3z4rLF98ayg24xD7H8HkUsclnKjzkLxauVhAA1LX874i7AAW92Nssn9wLw==
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr3064003wma.101.1533248508225;
        Thu, 02 Aug 2018 15:21:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l5-v6sm2008690wrq.86.2018.08.02.15.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 15:21:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3] remote: make refspec follow the same disambiguation rule as local refs
References: <xmqq8t5q821c.fsf@gitster-ct.c.googlers.com>
        <20180801230802.GC189024@aiede.svl.corp.google.com>
        <xmqqo9el4ige.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 02 Aug 2018 15:21:45 -0700
In-Reply-To: <xmqqo9el4ige.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 01 Aug 2018 19:21:05 -0700")
Message-ID: <xmqq8t5oz9xi.fsf_-_@gitster-ct.c.googlers.com>
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

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * OK, with the NUM_REV_PARSE_RULES constant this time.

 refs.c           | 18 +++++++++++++-----
 remote.c         | 13 ++++++++++---
 t/t5510-fetch.sh | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 20ba82b434..2ca715d099 100644
--- a/refs.c
+++ b/refs.c
@@ -487,16 +487,24 @@ static const char *ref_rev_parse_rules[] = {
 	NULL
 };
 
+#define NUM_REV_PARSE_RULES (ARRAY_SIZE(ref_rev_parse_rules) - 1)
+
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
+	const int num_rules = NUM_REV_PARSE_RULES;
 
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

