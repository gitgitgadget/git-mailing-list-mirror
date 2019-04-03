Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A940C202BB
	for <e@80x24.org>; Wed,  3 Apr 2019 17:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDCR1Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 13:27:24 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41144 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCR1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 13:27:24 -0400
Received: by mail-pg1-f202.google.com with SMTP id v9so556922pgg.8
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=vned4Gh/AbZtw8joZemr3UUbNXr05pEDw48TruziuOk=;
        b=Wn8KXfN0bQWQftrjEwir7Su44W8RcZBsjIf1h+aT1SiKxjm/3X14lfRm41Hma/XCNY
         xzBNUnwgxKwQsu42UkFhRyRtWz8ucz1VlWVwsglPRDFvziwzDu7NPfl1SCIQPNL4iBav
         RIoNs8dlTwvEsVShsgp4KCfi3Ymkbz0/GwbR4sQQby7GvMou4CBMKd7MaGcb8s/4VPfE
         D7na9e5xTkuQ+ywlltY3ahghMyJOlE6fVzaUEvAus+WC3A3T2CZR0jn5HgGSZt12KALD
         HB2iD+WQj25wpn206KoRegUB3EufCWt/NY5TR6QeVwM1I0a7iMgp0uZ+n3gXs0kaL8rK
         guXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=vned4Gh/AbZtw8joZemr3UUbNXr05pEDw48TruziuOk=;
        b=PTYoSXcVms+QAB3EDgyIUMZzVYFwihd2BzU2IftCrZRNBXaBzxe+MUabEML4yShZ2h
         4JIjY2JRIz06otaSsmosbFjs3H+KelIjY+lcpfWO6yZs4j/t7jhSRYtO0UC5TtjzKmp9
         9Ut9TSdtROmO5nrATnYUZJuGn+8/LBJoruBImSRsAnwFJzBRoLG1EsWT6dogQWVVzkEa
         ZyT5P4KYMHC8kjLqhmHMYqydKUhniZsaHAiH17SvTOZvajOq3X9fPj/z1XTCpCoCuGrj
         iMz7eGzXjKzWbxLJVwZaqDUiM+/vDtim/1qX32eJ4PAfi8i4gzThfV9V+ajV27Yg6px7
         /hzw==
X-Gm-Message-State: APjAAAXNK2ZcGk1L3Thsn19J6aDd/9ctm9A506w7Va0fb8uJcJXZG5ZM
        9YqSHajzMdth42alOYvwTt00tCdWf+XdG7sp0W8zemx50TmSF1oz6Gegm4nAssWWkNncxRnTONf
        ky0R8+LEQlALQxjZ6reDC4KtiGvasOB+5PnBK9QyCZavNWTkGDaPrJqrbZCchrFk=
X-Google-Smtp-Source: APXvYqyTlMBwq0qBCH+eqQSZM+aemCa+L5gPoEfLhHLZHZX3IDkZzITKx5i2aXzMfq0GzokGGDXQaRMzS7jVDA==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr38918ply.65.1554312443850;
 Wed, 03 Apr 2019 10:27:23 -0700 (PDT)
Date:   Wed,  3 Apr 2019 10:27:21 -0700
Message-Id: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] clone: do faster object check for partial clones
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For partial clones, doing a full connectivity check is wasteful; we skip
promisor objects (which, for a partial clone, is all known objects), and
excluding them all from the connectivity check can take a significant
amount of time on large repos.

At most, we want to make sure that we get the objects referred to by any
wanted refs. For partial clones, just check that these objects were
transferred.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/clone.c |  6 ++++--
 connected.c     | 15 +++++++++++++++
 connected.h     |  8 ++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..fdbbd8942a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -657,7 +657,8 @@ static void update_remote_refs(const struct ref *refs,
 			       const char *branch_top,
 			       const char *msg,
 			       struct transport *transport,
-			       int check_connectivity)
+			       int check_connectivity,
+			       int check_refs_only)
 {
 	const struct ref *rm = mapped_refs;
 
@@ -666,6 +667,7 @@ static void update_remote_refs(const struct ref *refs,
 
 		opt.transport = transport;
 		opt.progress = transport->progress;
+		opt.check_refs_only = !!check_refs_only;
 
 		if (check_connected(iterate_ref_map, &rm, &opt))
 			die(_("remote did not send all necessary objects"));
@@ -1224,7 +1226,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
-			   !is_local);
+			   !is_local, filter_options.choice);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
diff --git a/connected.c b/connected.c
index 1bba888eff..c297cdc5ab 100644
--- a/connected.c
+++ b/connected.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "connected.h"
@@ -49,6 +50,20 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strbuf_release(&idx_file);
 	}
 
+	if (opt->check_refs_only) {
+		/*
+		 * For partial clones, we don't want to walk the full commit
+		 * graph because we're skipping promisor objects anyway. We
+		 * should just check that objects referenced by wanted refs were
+		 * transferred.
+		 */
+		do {
+			if (!repo_has_object_file(the_repository, &oid))
+				return 1;
+		} while (!fn(cb_data, &oid));
+		return 0;
+	}
+
 	if (opt->shallow_file) {
 		argv_array_push(&rev_list.args, "--shallow-file");
 		argv_array_push(&rev_list.args, opt->shallow_file);
diff --git a/connected.h b/connected.h
index 8d5a6b3ad6..bb4afcb301 100644
--- a/connected.h
+++ b/connected.h
@@ -46,6 +46,14 @@ struct check_connected_options {
 	 * during a fetch.
 	 */
 	unsigned is_deepening_fetch : 1;
+
+	/*
+	 * If non-zero, only check the top-level objects referenced by the
+	 * wanted refs (passed in as cb_data). This is useful for partial
+	 * clones, where this can be much faster than excluding all promisor
+	 * objects prior to walking the commit graph.
+	 */
+	unsigned check_refs_only : 1;
 };
 
 #define CHECK_CONNECTED_INIT { 0 }
-- 
2.21.0.392.gf8f6787159e-goog

