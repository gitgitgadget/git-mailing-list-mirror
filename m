Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1BA20899
	for <e@80x24.org>; Sun, 20 Aug 2017 15:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbdHTPrb (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 11:47:31 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33255 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbdHTPra (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 11:47:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id 30so1547243wrk.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n0QQtbxK7BJ7wEjLDdikEfLCgJhH/RkmVqXisZD1Pl8=;
        b=QnF+GCMJsbPyuhGjsa5U7i9vM8fMXIuxMx6sT/yzyxJkOpU00cSnj41/RCGes6u13P
         7U1RUdr3DXa6ncEogcund1wE9R85qzFcHe/yVP8xQwfuWj96ZL7sPFkrl97+3a/DzjsW
         g6+FC7Q9q8ssaYURgkWU2cDdjnIBTEaGHhirZzhMy2MOzNXYpp4nFY2tlxv2k4MK1QU4
         BuIs+ql22FmmHx6lUkF75FCJiDO6eS9PwfHKxZb9DDxDM38qU1+lPLymf4+andGp4kmw
         aC7k2vREKPJ0fGXLtYechlZxeGRpeky0DGQCzY/Z+YGoup16FQP/izqyrw4/ALwrpqLz
         eQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n0QQtbxK7BJ7wEjLDdikEfLCgJhH/RkmVqXisZD1Pl8=;
        b=cyZ/sgIXwUYfr9wymYhVrJaUw8aB4hKfk19u4paZKl6cs2NpXSQ1ynMYOSfIKAGK1I
         +MdRhUew98vFIBeFlm5Eqc2TJp74RzZUsccDA9zeP5sXjeg+f46g+2C9F/h5AERkYXfK
         U7ilPPE80GUk5dk1zt6YolMjzOXzzb5scVpbuyBAKfbPa2z9pHWKIRIq8GxU/jApWyBU
         p8q3KPvXP/92/1xb4eaz9+VDlbLPsG0dM6BkpHSk2s8ye/iXfEKXwi3K+fl7IbuwJBb9
         ANyTgX07uD3JT+fhrikNOB3nB0J89oMmxN00CYl5YF5OjubDS2M9nzajEmpOmVsgjJcm
         iJLw==
X-Gm-Message-State: AHYfb5hFHBqIdElbpB9WK3L4ujakUOP3z97yGkuHun60OCc1jG2S4A3z
        i8zPnlzgcXJe+A9h
X-Received: by 10.28.11.131 with SMTP id 125mr4764396wml.82.1503244048600;
        Sun, 20 Aug 2017 08:47:28 -0700 (PDT)
Received: from localhost.localdomain (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b15sm5960702wrb.95.2017.08.20.08.47.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Aug 2017 08:47:27 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com
Subject: [PATCH v1] convert: display progress for filtered objects that have been delayed
Date:   Sun, 20 Aug 2017 17:47:20 +0200
Message-Id: <20170820154720.32259-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2841e8f ("convert: add "status=delayed" to filter process protocol",
2017-06-30) we taught the filter process protocol to delayed responses.
These responses are processed after the "Checking out files" phase.
If the processing takes noticeable time, then the user might think Git
is stuck.

Display the progress of the delayed responses to let the user know that
Git is still processing objects. This works very well for objects that
can be filtered quickly. If filtering of an individual object takes
noticeable time, then the user might still think that Git is stuck.
However, in that case the user would at least know what Git is doing.

It would be technical more correct to display "Checking out files whose
content filtering has been delayed". For brevity we only print
"Filtering content".

The finish_delayed_checkout() call was moved below the stop_progress()
call in unpack-trees.c to ensure that the "Checking out files" progress
is properly stopped before the "Filtering content" progress starts in
finish_delayed_checkout().

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Suggested-by: Taylor Blau <me@ttaylorr.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/8c3f433083
    Checkout: git fetch https://github.com/larsxschneider/git filter-process/progress-v1 && git checkout 8c3f433083

 entry.c        | 16 +++++++++++++++-
 unpack-trees.c |  2 +-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 65458f07a4..1d1a09f47e 100644
--- a/entry.c
+++ b/entry.c
@@ -3,6 +3,7 @@
 #include "dir.h"
 #include "streaming.h"
 #include "submodule.h"
+#include "progress.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -161,16 +162,23 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
 int finish_delayed_checkout(struct checkout *state)
 {
 	int errs = 0;
+	unsigned delayed_object_count;
+	off_t filtered_bytes = 0;
 	struct string_list_item *filter, *path;
+	struct progress *progress;
 	struct delayed_checkout *dco = state->delayed_checkout;
 
 	if (!state->delayed_checkout)
 		return errs;
 
 	dco->state = CE_RETRY;
+	delayed_object_count = dco->paths.nr;
+	progress = start_progress_delay(
+		_("Filtering content"), delayed_object_count, 50, 1);
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
 			struct string_list available_paths = STRING_LIST_INIT_NODUP;
+			display_progress(progress, delayed_object_count - dco->paths.nr);
 
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
@@ -216,11 +224,17 @@ int finish_delayed_checkout(struct checkout *state)
 				}
 				ce = index_file_exists(state->istate, path->string,
 						       strlen(path->string), 0);
-				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
+				if (ce) {
+					errs |= checkout_entry(ce, state, NULL);
+					filtered_bytes += ce->ce_stat_data.sd_size;
+					display_throughput(progress, filtered_bytes);
+				} else
+					errs = 1;
 			}
 		}
 		string_list_remove_empty_items(&dco->filters, 0);
 	}
+	stop_progress(&progress);
 	string_list_clear(&dco->filters, 0);
 
 	/* At this point we should not have any delayed paths anymore. */
diff --git a/unpack-trees.c b/unpack-trees.c
index 862cfce661..90fb270d77 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -395,8 +395,8 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 	}
-	errs |= finish_delayed_checkout(&state);
 	stop_progress(&progress);
+	errs |= finish_delayed_checkout(&state);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
 	return errs != 0;

base-commit: b3622a4ee94e4916cd05e6d96e41eeb36b941182
-- 
2.14.1

