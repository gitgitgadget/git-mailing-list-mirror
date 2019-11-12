Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 171861F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfKLKix (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42505 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKLKiq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so17892302wrf.9
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATdesPK0Kjx1rwWjckSnBmKU5mjWMYxtnejXtoipAaE=;
        b=jz+lyubI2WWXlkmUSuWEuSD8fEMknGRHN38m9UT/kQxBqYS2eZ4V55r4kyME91FKBa
         tuacj1lH6GQjjQF4NzykgcYkee0zbYDE08fv8jiA39af+9wuKfYjGkG571a4pVR8IdFr
         TPDCFfLvLVSApCwR6ylnKbI8l2YVTyj1N58Zc+holKhOFwuTPZCEfNqqHOh9Mfy2kDdV
         +5zTds4kZTw7b0XcVze4g9gpyyIZ3k+ogqBv/Gxc0BP5GeOBF7wAGfXHG/MfW1uCx/uR
         zdVcC5R4PPWDK/FStS2/kd0IhsQAnK8QOqE+CfrpWhVbw6r7RJ3prLzehbgbQxKU0L1M
         uI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATdesPK0Kjx1rwWjckSnBmKU5mjWMYxtnejXtoipAaE=;
        b=IazTSRn5APMQvl90Gkk+x1nDeNLVYGy0rWrLpVMjiqCEseyQXEyH1WM4NygSWpRpcx
         FBD8kV31LGMSpsj1CUR3STsrGxWoZdB1FxWfQYC0ShMVseXTByAxntWkVnPk+q+N65d6
         MAkNY4ZiwxfWWlAzeiQez9TI4mVmbEBN7Nnkq/v+fP9NuxgK06twx37VErzGM+cV03Im
         jr889hhlGKh2tMVL9/pECucTjifmHKSWsiLPV/HH9/K3gREcZ/pVg3sfG4YCHwkJSArR
         pyKFLWhm71GTEyrAqgDgxtesvPiVEaBTblRXPG2qaWJ3JHP01CChwx1xUYuECtixAnOt
         y5lA==
X-Gm-Message-State: APjAAAXflQPMtWv+7mlUBGSWjzpkHzYt5bRdFSpbKt1sqjhUmR0krpJf
        T51C7zNUrwdKuc2UxVCLphM=
X-Google-Smtp-Source: APXvYqz3WNrtfyf1cmtawjPHIQv96NOVE+AA1AkEjglzghh9miWdNL9gTR23YYbMIEFqt4Jt16SWOg==
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr25320297wrf.221.1573555123316;
        Tue, 12 Nov 2019 02:38:43 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:42 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 12/13] name-rev: eliminate recursion in name_rev()
Date:   Tue, 12 Nov 2019 11:38:20 +0100
Message-Id: <20191112103821.30265-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name_rev() function calls itself recursively for each interesting
parent of the commit it got as parameter, and, consequently, it can
segfault when processing a deep history if it exhausts the available
stack space.  E.g. running 'git name-rev --all' and 'git name-rev
HEAD~100000' in the gcc, gecko-dev, llvm, and WebKit repositories
results in segfaults on my machine ('ulimit -s' reports 8192kB of
stack size limit), and nowadays the former segfaults in the Linux repo
as well (it reached the necessasry depth sometime between v5.3-rc4 and
-rc5).

Eliminate the recursion by inserting the interesting parents into a
LIFO 'prio_queue' [1] and iterating until the queue becomes empty.

Note that the parent commits must be added in reverse order to the
LIFO 'prio_queue', so their relative order is preserved during
processing, i.e. the first parent should come out first from the
queue, because otherwise performance greatly suffers on mergy
histories [2].

The stacksize-limited test 'name-rev works in a deep repo' in
't6120-describe.sh' demonstrated this issue and expected failure.  Now
the recursion is gone, so flip it to expect success.  Also gone are
the dmesg entries logging the segfault of that segfaulting 'git
name-rev' process on every execution of the test suite.

Note that this slightly changes the order of lines in the output of
'git name-rev --all', usually swapping two lines every 35 lines in
git.git or every 150 lines in linux.git.  This shouldn't matter in
practice, because the output has always been unordered anyway.

This patch is best viewed with '--ignore-all-space'.

[1] Early versions of this patch used a 'commit_list', resulting in
    ~15% performance penalty for 'git name-rev --all' in 'linux.git',
    presumably because of the memory allocation and release for each
    insertion and removal. Using a LIFO 'prio_queue' has basically no
    effect on performance.

[2] We prefer shorter names, i.e. 'v0.1~234' is preferred over
    'v0.1^2~5', meaning that usually following the first parent of a
    merge results in the best name for its ancestors.  So when later
    we follow the remaining parent(s) of a merge, and reach an already
    named commit, then we usually find that we can't give that commit
    a better name, and thus we don't have to visit any of its
    ancestors again.

    OTOH, if we were to follow the Nth parent of the merge first, then
    the name of all its ancestors would include a corresponding '^N'.
    Those are not the best names for those commits, so when later we
    reach an already named commit following the first parent of that
    merge, then we would have to update the name of that commit and
    the names of all of its ancestors as well.  Consequently, we would
    have to visit many commits several times, resulting in a
    significant slowdown.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c  | 99 +++++++++++++++++++++++++++++----------------
 t/t6120-describe.sh |  2 +-
 2 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index fc61d6fa71..a3b796eac4 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -6,6 +6,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "prio-queue.h"
 #include "sha1-lookup.h"
 #include "commit-slab.h"
 
@@ -104,49 +105,77 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 		return NULL;
 }
 
-static void name_rev(struct commit *commit,
+static void name_rev(struct commit *start_commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int from_tag)
 {
-	struct rev_name *name = get_commit_rev_name(commit);
-	struct commit_list *parents;
-	int parent_number = 1;
-
-	for (parents = commit->parents;
-			parents;
-			parents = parents->next, parent_number++) {
-		struct commit *parent = parents->item;
-		const char *new_name;
-		int generation, distance;
-
-		parse_commit(parent);
-		if (parent->date < cutoff)
-			continue;
+	struct prio_queue queue;
+	struct commit *commit;
+	struct commit **parents_to_queue = NULL;
+	size_t parents_to_queue_nr, parents_to_queue_alloc = 0;
+
+	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
+	prio_queue_put(&queue, start_commit);
+
+	while ((commit = prio_queue_get(&queue))) {
+		struct rev_name *name = get_commit_rev_name(commit);
+		struct commit_list *parents;
+		int parent_number = 1;
+
+		parents_to_queue_nr = 0;
+
+		for (parents = commit->parents;
+				parents;
+				parents = parents->next, parent_number++) {
+			struct commit *parent = parents->item;
+			const char *new_name;
+			int generation, distance;
+
+			parse_commit(parent);
+			if (parent->date < cutoff)
+				continue;
 
-		if (parent_number > 1) {
-			size_t len;
+			if (parent_number > 1) {
+				size_t len;
+
+				strip_suffix(name->tip_name, "^0", &len);
+				if (name->generation > 0)
+					new_name = xstrfmt("%.*s~%d^%d",
+							   (int)len,
+							   name->tip_name,
+							   name->generation,
+							   parent_number);
+				else
+					new_name = xstrfmt("%.*s^%d", (int)len,
+							   name->tip_name,
+							   parent_number);
+				generation = 0;
+				distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
+			} else {
+				new_name = name->tip_name;
+				generation = name->generation + 1;
+				distance = name->distance + 1;
+			}
 
-			strip_suffix(tip_name, "^0", &len);
-			if (name->generation > 0)
-				new_name = xstrfmt("%.*s~%d^%d", (int)len, tip_name,
-						   name->generation,
-						   parent_number);
-			else
-				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
-						   parent_number);
-			generation = 0;
-			distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
-		} else {
-			new_name = tip_name;
-			generation = name->generation + 1;
-			distance = name->distance + 1;
+			if (create_or_update_name(parent, new_name, taggerdate,
+						  generation, distance,
+						  from_tag)) {
+				ALLOC_GROW(parents_to_queue,
+					   parents_to_queue_nr + 1,
+					   parents_to_queue_alloc);
+				parents_to_queue[parents_to_queue_nr] = parent;
+				parents_to_queue_nr++;
+			}
 		}
 
-		if (create_or_update_name(parent, new_name, taggerdate,
-					  generation, distance,
-					  from_tag))
-			name_rev(parent, new_name, taggerdate, from_tag);
+		/* The first parent must come out first from the prio_queue */
+		while (parents_to_queue_nr)
+			prio_queue_put(&queue,
+				       parents_to_queue[--parents_to_queue_nr]);
 	}
+
+	clear_prio_queue(&queue);
+	free(parents_to_queue);
 }
 
 static int subpath_matches(const char *path, const char *filter)
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 0d119e9652..09c50f3f04 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -381,7 +381,7 @@ test_expect_success 'describe tag object' '
 	test_i18ngrep "fatal: test-blob-1 is neither a commit nor blob" actual
 '
 
-test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
 	do
-- 
2.24.0.388.gde53c094ea

