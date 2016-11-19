Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C751FE4E
	for <e@80x24.org>; Sat, 19 Nov 2016 00:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbcKSA6U (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 19:58:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:51846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753261AbcKSA6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 19:58:18 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP; 18 Nov 2016 16:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,660,1473145200"; 
   d="scan'208";a="6355626"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2016 16:58:16 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 1/2] pretty: add %(trailers) format for displaying trailers of a commit message
Date:   Fri, 18 Nov 2016 16:58:14 -0800
Message-Id: <20161119005815.3646-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
In-Reply-To: <20161119005815.3646-1-jacob.e.keller@intel.com>
References: <20161119005815.3646-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Recent patches have expanded on the trailers.c code and we have the
builtin commant git-interpret-trailers which can be used to add or
modify trailer lines. However, there is no easy way to simply display
the trailers of a commit message.

Add support for %(trailers) format modifier which will use the
trailer_info_get() calls to read trailers in an identical way as git
interpret-trailers does. Use a long format option instead of a short
name so that future work can more easily unify ref-filter and pretty
formats.

Add documentation and tests for the same.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/pretty-formats.txt |  2 ++
 pretty.c                         | 17 +++++++++++++++++
 t/t4205-log-pretty-formats.sh    | 26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 3bcee2ddb124..47b286b33e4e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -199,6 +199,8 @@ endif::git-rev-list[]
   than given and there are spaces on its left, use those spaces
 - '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
   respectively, but padding both sides (i.e. the text is centered)
+-%(trailers): display the trailers of the body as interpreted by
+  linkgit:git-interpret-trailers[1]
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 37b2c3b1f995..5e683830d9d6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -10,6 +10,7 @@
 #include "color.h"
 #include "reflog-walk.h"
 #include "gpg-interface.h"
+#include "trailer.h"
 
 static char *user_format;
 static struct cmt_fmt_map {
@@ -889,6 +890,16 @@ const char *format_subject(struct strbuf *sb, const char *msg,
 	return msg;
 }
 
+static void format_trailers(struct strbuf *sb, const char *msg)
+{
+	struct trailer_info info;
+
+	trailer_info_get(&info, msg);
+	strbuf_add(sb, info.trailer_start,
+		   info.trailer_end - info.trailer_start);
+	trailer_info_release(&info);
+}
+
 static void parse_commit_message(struct format_commit_context *c)
 {
 	const char *msg = c->message + c->message_off;
@@ -1292,6 +1303,12 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, msg + c->body_off);
 		return 1;
 	}
+
+	if (starts_with(placeholder, "(trailers)")) {
+		format_trailers(sb, msg + c->subject_off);
+		return strlen("(trailers)");
+	}
+
 	return 0;	/* unknown placeholder */
 }
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f5435fd250ba..21eb8c8587f2 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -535,4 +535,30 @@ test_expect_success 'clean log decoration' '
 	test_cmp expected actual1
 '
 
+cat >trailers <<EOF
+Signed-off-by: A U Thor <author@example.com>
+Acked-by: A U Thor <author@example.com>
+[ v2 updated patch description ]
+Signed-off-by: A U Thor <author@example.com>
+EOF
+
+test_expect_success 'pretty format %(trailers) shows trailers' '
+	echo "Some contents" >trailerfile &&
+	git add trailerfile &&
+	git commit -F - <<-EOF &&
+	trailers: this commit message has trailers
+
+	This commit is a test commit with trailers at the end. We parse this
+	message and display the trailers using %bT
+
+	$(cat trailers)
+	EOF
+	git log --no-walk --pretty="%(trailers)" >actual &&
+	cat >expect <<-EOF &&
+	$(cat trailers)
+
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.rc2.152.g4d04e67

