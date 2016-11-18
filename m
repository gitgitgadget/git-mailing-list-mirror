Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05C32022D
	for <e@80x24.org>; Fri, 18 Nov 2016 23:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbcKRXI3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 18:08:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:37381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753161AbcKRXI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 18:08:28 -0500
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP; 18 Nov 2016 15:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,660,1473145200"; 
   d="scan'208";a="33066055"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga005.fm.intel.com with ESMTP; 18 Nov 2016 15:08:27 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 1/2] pretty: add %bT format for displaying trailers of a commit message
Date:   Fri, 18 Nov 2016 15:08:24 -0800
Message-Id: <20161118230825.20952-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
In-Reply-To: <20161118230825.20952-1-jacob.e.keller@intel.com>
References: <20161118230825.20952-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Recent patches have expanded on the trailers.c code and we have the
builtin commant git-interpret-trailers which can be used to add or
modify trailer lines. However, there is no easy way to simply display
the trailers of a commit message. Add support for %bT format modifier
which will use the trailer_info_get() calls to read trailers in an
identical way as git interpret-trailers does.

Add documentation and tests for the same.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/pretty-formats.txt |  1 +
 pretty.c                         | 18 ++++++++++++++++++
 t/t4205-log-pretty-formats.sh    | 26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 3bcee2ddb124..9ee68a4cb64a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -138,6 +138,7 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
+- '%bT': trailers of body as interpreted by linkgit:git-interpret-trailers[1]
 - '%B': raw body (unwrapped subject and body)
 ifndef::git-rev-list[]
 - '%N': commit notes
diff --git a/pretty.c b/pretty.c
index 37b2c3b1f995..ea8764334865 100644
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
@@ -1289,6 +1300,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		format_sanitized_subject(sb, msg + c->subject_off);
 		return 1;
 	case 'b':	/* body */
+		switch (placeholder[1]) {
+		case 'T':
+			format_trailers(sb, msg + c->subject_off);
+			return 2;
+		default:
+			break;
+		}
 		strbuf_addstr(sb, msg + c->body_off);
 		return 1;
 	}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f5435fd250ba..7a35941ddcbd 100755
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
+test_expect_success 'pretty format %bT shows trailers' '
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
+	git log --no-walk --pretty="%bT" >actual &&
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

