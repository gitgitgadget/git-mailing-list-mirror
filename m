Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A401FE4E
	for <e@80x24.org>; Sat, 19 Nov 2016 00:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbcKSA6S (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 19:58:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:51846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753248AbcKSA6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 19:58:18 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP; 18 Nov 2016 16:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,660,1473145200"; 
   d="scan'208";a="6355625"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2016 16:58:16 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 0/2] add format specifiers to display trailers
Date:   Fri, 18 Nov 2016 16:58:13 -0800
Message-Id: <20161119005815.3646-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This is based off of jt/use-trailer-api-in-commands so that we can make
use of the public trailer API that will parse a string for trailers.

I use trailers as a way to store extra commit metadata, and would like a
convenient way to obtain the trailers of a commit message easily. This
adds format specifiers to both the ref-filter API and the pretty
format specifiers, using %(trailers) for both (and also
contents:trailers for ref-filter).

Additionally, I am somewhat not a fan of the way that if you have a
series of trailers which are trailer format, but not recognized, such
as the following:

	<text>

	My-tag: my value
	My-other-tag: my other value
	[non-trailer line]
	My-tag: my third value

Git interpret-trailers will not recognize this as a trailer block
because it doesn't have any standard git tags within it.

Junio suggested that we should treat all the configured trailer prefixes
as recognized so that it would work as well, but it doesn't appear to
do this at least for jt/use-trailer-api-in-commands

I think that's the right solution, since it's extensible, though it
would mean that interpret-trailers would behave differently on different
systems... not really sure it's all bad though.

interdiff v1:
diff --git c/Documentation/pretty-formats.txt w/Documentation/pretty-formats.txt
index 9ee68a4cb64a..47b286b33e4e 100644
--- c/Documentation/pretty-formats.txt
+++ w/Documentation/pretty-formats.txt
@@ -138,7 +138,6 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
-- '%bT': trailers of body as interpreted by linkgit:git-interpret-trailers[1]
 - '%B': raw body (unwrapped subject and body)
 ifndef::git-rev-list[]
 - '%N': commit notes
@@ -200,6 +199,8 @@ endif::git-rev-list[]
   than given and there are spaces on its left, use those spaces
 - '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
   respectively, but padding both sides (i.e. the text is centered)
+-%(trailers): display the trailers of the body as interpreted by
+  linkgit:git-interpret-trailers[1]
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git c/pretty.c w/pretty.c
index ea8764334865..5e683830d9d6 100644
--- c/pretty.c
+++ w/pretty.c
@@ -1300,16 +1300,15 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
		format_sanitized_subject(sb, msg + c->subject_off);
		return 1;
	case 'b':	/* body */
-		switch (placeholder[1]) {
-		case 'T':
-			format_trailers(sb, msg + c->subject_off);
-			return 2;
-		default:
-			break;
-		}
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
 
diff --git c/t/t4205-log-pretty-formats.sh w/t/t4205-log-pretty-formats.sh
index 7a35941ddcbd..21eb8c8587f2 100755
--- c/t/t4205-log-pretty-formats.sh
+++ w/t/t4205-log-pretty-formats.sh
@@ -542,7 +542,7 @@ Acked-by: A U Thor <author@example.com>
 Signed-off-by: A U Thor <author@example.com>
 EOF
 
-test_expect_success 'pretty format %bT shows trailers' '
+test_expect_success 'pretty format %(trailers) shows trailers' '
	echo "Some contents" >trailerfile &&
	git add trailerfile &&
	git commit -F - <<-EOF &&
@@ -553,7 +553,7 @@ test_expect_success 'pretty format %bT shows trailers' '
 
	$(cat trailers)
	EOF
-	git log --no-walk --pretty="%bT" >actual &&
+	git log --no-walk --pretty="%(trailers)" >actual &&
	cat >expect <<-EOF &&
	$(cat trailers)
 

Jacob Keller (2):
  pretty: add %bT format for displaying trailers of a commit message
  ref-filter: add support to display trailers as part of contents

 Documentation/git-for-each-ref.txt |  2 ++
 Documentation/pretty-formats.txt   |  1 +
 pretty.c                           | 18 ++++++++++++++++++
 ref-filter.c                       | 22 +++++++++++++++++++++-
 t/t4205-log-pretty-formats.sh      | 26 ++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 26 ++++++++++++++++++++++++++
 6 files changed, 94 insertions(+), 1 deletion(-)

-- 
2.11.0.rc2.152.g4d04e67

