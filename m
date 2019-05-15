Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54121F461
	for <e@80x24.org>; Wed, 15 May 2019 21:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfEOVph (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 17:45:37 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34246 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEOVpg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 17:45:36 -0400
Received: by mail-qk1-f201.google.com with SMTP id h11so981631qkk.1
        for <git@vger.kernel.org>; Wed, 15 May 2019 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8dnbstZVSWSgC1W2FsdIJLQFPeYf9t3nne5YySeBKBs=;
        b=VrcqCTn2/C3OhYVFPGeiwb7i+2qYlDK+zfXd5JArgzr+EhLbTs1M2TnE5+yCnVT+rA
         v2zx2dtxtU7pvA1GPeasLyUac9euvHK2+/OFyi8yo/Sgdo5vLuXus7OVsRAe6nMIFutU
         dZl/N9uenltFqZmCl2I54H93zRHMDwtzuks/BY1S0+piA2HWzYLOFCAZsnYRd0sYSrdp
         0qvv/a99/qt9qwyu8/G+vnqgBoo+J0wlKV+WF2chRzfET1Noj9kTdl5PkFC/DXy3A8Xn
         qFv83o5iJlN+30PInhjYgs95jrCK1/2nTnJGmUwCiMaZ5yzHo7wWDoD7w3jrcQm9tqbF
         kJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8dnbstZVSWSgC1W2FsdIJLQFPeYf9t3nne5YySeBKBs=;
        b=nlj3ur4TaA6HoXcd9oJm0OGKcHNoGGXTmXF6Z3bz5ntRwFfeQg/gDsXQHMERXjdIMs
         TT2iRJqiLoKgYZUDgplP7uWwJy3kBqpize8fjBAhpQnlTzzGlcmJaJMqKttiy1uGRq1Z
         td1BBju4lJ+EDfTbybXXQHhewYStwu/kXpLdQ8kEEixxda3oTRqw+DlZc7ZKFwEJ1qQI
         nBpGHv4mOjQ6QCl71Q6ZCGvNnTPXIxPPf9zipnobm89VFXgfsrQYH67ES3j5JAC5IjUy
         ttXScu5XSaaTxFuXD9/RtL02j1NP9Q2dJ9ANtrYfc/3P+tHXVdIDmzIz4Pf+3KL3wYy+
         L4xA==
X-Gm-Message-State: APjAAAVpCWYTzkhSVlGbYRvVTd/gg/A9ePglxy3i91Svuveat4p5mmtg
        AKgeuivuNQOO3cuWaV8w7roSdUp140HNthLQTeh6dlGeRKsoRT3+XKWQpHTO8f2pOPQGWCzvxyx
        dfjdkqbLPE+gFvCkqI4jnyjv8HMGvGXRS7NAXomquknZOxv+I82vO
X-Google-Smtp-Source: APXvYqznqHntPMnK8CX3781ifGDUCNuWdkFPa2ZPFGyYxBCrCSDrvflXhJ7F++JE/KI9YRKheTmyuREw
X-Received: by 2002:a05:6214:10c8:: with SMTP id r8mr36821835qvs.161.1557956734997;
 Wed, 15 May 2019 14:45:34 -0700 (PDT)
Date:   Wed, 15 May 2019 17:45:03 -0400
In-Reply-To: <20190515214503.77162-1-brho@google.com>
Message-Id: <20190515214503.77162-9-brho@google.com>
Mime-Version: 1.0
References: <20190515214503.77162-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v7 8/8] blame: use the fingerprint heuristic to match ignored lines
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit integrates the fuzzy fingerprint heuristic into
guess_line_blames().

We actually make two passes.  The first pass uses the fuzzy algorithm to
find a match within the current diff chunk.  If that fails, the second
pass searches the entire parent file for the best match.

For an example of scanning the entire parent for a match, consider:

	commit-a 30) #include <sys/header_a.h>
	commit-b 31) #include <header_b.h>
	commit-c 32) #include <header_c.h>

Then commit X alphabetizes them:

	commit-X 30) #include <header_b.h>
	commit-X 31) #include <header_c.h>
	commit-X 32) #include <sys/header_a.h>

If we just check the parent's chunk (i.e. the first pass), we'd get:

	commit-b 30) #include <header_b.h>
	commit-c 31) #include <header_c.h>
	commit-X 32) #include <sys/header_a.h>

That's because commit X actually consists of two chunks: one chunk is
removing sys/header_a.h, then some context, and the second chunk is
adding sys/header_a.h.

If we scan the entire parent file, we get:

	commit-b 30) #include <header_b.h>
	commit-c 31) #include <header_c.h>
	commit-a 32) #include <sys/header_a.h>

Signed-off-by: Barret Rhoden <brho@google.com>
---
 blame.c                       | 60 ++++++++++++++++++++++++++++++++---
 t/t8014-blame-ignore-fuzzy.sh |  3 --
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/blame.c b/blame.c
index 7ef283166f29..e20d88dd74d8 100644
--- a/blame.c
+++ b/blame.c
@@ -998,12 +998,19 @@ static void fill_origin_fingerprints(struct blame_origin *o, mmfile_t *file)
 		return;
 	o->num_lines = find_line_starts(&line_starts, o->file.ptr,
 					o->file.size);
-	/* TODO: Will fill in fingerprints in a future commit */
+	o->fingerprints = xcalloc(sizeof(struct fingerprint), o->num_lines);
+	get_line_fingerprints(o->fingerprints, o->file.ptr, line_starts,
+			      0, o->num_lines);
 	free(line_starts);
 }
 
 static void drop_origin_fingerprints(struct blame_origin *o)
 {
+	if (o->fingerprints) {
+		free_line_fingerprints(o->fingerprints, o->num_lines);
+		o->num_lines = 0;
+		FREE_AND_NULL(o->fingerprints);
+	}
 }
 
 /*
@@ -1581,9 +1588,34 @@ static int are_lines_adjacent(struct blame_line_tracker *first,
 	       first->s_lno + 1 == second->s_lno;
 }
 
+static int scan_parent_range(struct fingerprint *p_fps,
+			     struct fingerprint *t_fps, int t_idx,
+			     int from, int nr_lines)
+{
+	int sim, p_idx;
+	#define FINGERPRINT_FILE_THRESHOLD	10
+	int best_sim_val = FINGERPRINT_FILE_THRESHOLD;
+	int best_sim_idx = -1;
+
+	for (p_idx = from; p_idx < from + nr_lines; p_idx++) {
+		sim = fingerprint_similarity(&t_fps[t_idx], &p_fps[p_idx]);
+		if (sim < best_sim_val)
+			continue;
+		/* Break ties with the closest-to-target line number */
+		if (sim == best_sim_val && best_sim_idx != -1 &&
+		    abs(best_sim_idx - t_idx) < abs(p_idx - t_idx))
+			continue;
+		best_sim_val = sim;
+		best_sim_idx = p_idx;
+	}
+	return best_sim_idx;
+}
+
 /*
- * This cheap heuristic assigns lines in the chunk to their relative location in
- * the parent's chunk.  Any additional lines are left with the target.
+ * The first pass checks the blame entry (from the target) against the parent's
+ * diff chunk.  If that fails for a line, the second pass tries to match that
+ * line to any part of parent file.  That catches cases where a change was
+ * broken into two chunks by 'context.'
  */
 static void guess_line_blames(struct blame_origin *parent,
 			      struct blame_origin *target,
@@ -1592,11 +1624,22 @@ static void guess_line_blames(struct blame_origin *parent,
 {
 	int i, best_idx, target_idx;
 	int parent_slno = tlno + offset;
+	int *fuzzy_matches;
 
+	fuzzy_matches = fuzzy_find_matching_lines(parent, target,
+						  tlno, parent_slno, same,
+						  parent_len);
 	for (i = 0; i < same - tlno; i++) {
 		target_idx = tlno + i;
-		best_idx = target_idx + offset;
-		if (best_idx < parent_slno + parent_len) {
+		if (fuzzy_matches && fuzzy_matches[i] >= 0) {
+			best_idx = fuzzy_matches[i];
+		} else {
+			best_idx = scan_parent_range(parent->fingerprints,
+						     target->fingerprints,
+						     target_idx, 0,
+						     parent->num_lines);
+		}
+		if (best_idx >= 0) {
 			line_blames[i].is_parent = 1;
 			line_blames[i].s_lno = best_idx;
 		} else {
@@ -1604,6 +1647,7 @@ static void guess_line_blames(struct blame_origin *parent,
 			line_blames[i].s_lno = target_idx;
 		}
 	}
+	free(fuzzy_matches);
 }
 
 /*
@@ -2380,6 +2424,12 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 			if (!porigin)
 				continue;
 			pass_blame_to_parent(sb, origin, porigin, 1);
+			/*
+			 * Preemptively drop porigin so we can refresh the
+			 * fingerprints if we use the parent again, which can
+			 * occur if you ignore back-to-back commits.
+			 */
+			drop_origin_blob(porigin);
 			if (!origin->suspects)
 				goto finish;
 		}
diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 7c09aeb9e14d..c49971909a27 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -3,9 +3,6 @@
 test_description='git blame ignore fuzzy heuristic'
 . ./test-lib.sh
 
-# short circuit until blame has the fuzzy capabilities
-test_done
-
 pick_author='s/^[0-9a-f^]* *(\([^ ]*\) .*/\1/'
 
 # Each test is composed of 4 variables:
-- 
2.21.0.1020.gf2820cf01a-goog

