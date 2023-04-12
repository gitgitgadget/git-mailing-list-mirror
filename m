Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685ABC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDLG32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDLG31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:29:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA324C24
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:29:25 -0700 (PDT)
Received: (qmail 17837 invoked by uid 109); 12 Apr 2023 06:29:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 06:29:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17071 invoked by uid 111); 12 Apr 2023 06:29:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 02:29:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 02:29:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH 1/7] v0 protocol: fix infinite loop when parsing multi-valued
 capabilities
Message-ID: <20230412062924.GA1681312@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412062300.GA838367@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If Git's client-side parsing of an upload-pack response (so git-fetch or
ls-remote) sees multiple instances of a single capability, it can enter
an infinite loop due to a bug in advancing the "offset" parameter in the
parser.

This bug can't happen between a client and server of the same Git
version. The client bug is in parse_feature_value() when the caller
passes in an offset parameter. And that only happens when the v0
protocol is parsing "symref" and "object-format" capabilities, via
next_server_feature_value(). But Git has never produced multiple
object-format capabilities, and it stopped producing multiple symref
values in d007dbf7d6 (Revert "upload-pack: send non-HEAD symbolic refs",
2013-11-18).

However, upload-pack did produce multiple symref entries for a while,
and they are valid. Plus other implementations, such as Dulwich will
still do so. So we should handle them. And even if we do not expect it,
it is obviously a bug for the parser to enter an infinite loop.

The bug itself is pretty simple. Commit 2c6a403d96 (connect: add
function to parse multiple v1 capability values, 2020-05-25) added the
"offset" parameter, which is used as both an in- and out-parameter. When
parsing the first "symref" capability, *offset will be 0 on input, and
after parsing the capability, we set *offset to an index just past the
value by taking a pointer difference "(value + end) - feature_list".

But on the second call, now *offset is set to that larger index, which
lets us skip past the first "symref" capability. However, we do so by
incrementing feature_list. That means our pointer difference is now too
small; it is counting from where we resumed parsing, not from the start
of the original feature_list pointer. And because we incremented
feature_list only inside our function, and not the caller, that
increment is lost next time the function is called.

The simplest solution is to account for those skipped bytes by
incrementing *offset, rather than assigning to it. (The other possible
solution is to add an extra level of pointer indirection to feature_list
so that the caller knows we moved it forward, but that seems more
complicated).

Since the bug can't be reproduced using the current version of
git-upload-pack, we'll instead hard-code an input which triggers the
problem. Before this patch it loops forever re-parsing the second symref
entry. Now we check both that it finishes, and that it parses both
entries correctly (a case we could not test at all before).

We don't need to worry about testing v2 here; it communicates the
capabilities in a completely different way, and doesn't use this code at
all. There are tests earlier in t5512 that are meant to cover this (they
don't, but we'll address that in a future patch).

Reported-by: Jonas Haag <jonas@lophus.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c            |  4 ++--
 t/t5512-ls-remote.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index c0c8a38178..5e265ba9d7 100644
--- a/connect.c
+++ b/connect.c
@@ -616,7 +616,7 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 				if (lenp)
 					*lenp = 0;
 				if (offset)
-					*offset = found + len - feature_list;
+					*offset += found + len - feature_list;
 				return value;
 			}
 			/* feature with a value (e.g., "agent=git/1.2.3") */
@@ -628,7 +628,7 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 				if (lenp)
 					*lenp = end;
 				if (offset)
-					*offset = value + end - feature_list;
+					*offset += value + end - feature_list;
 				return value;
 			}
 			/*
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 20d063fb9a..64dc6fa91c 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -15,6 +15,19 @@ generate_references () {
 	done
 }
 
+test_expect_success 'set up fake upload-pack' '
+	# This can be used to simulate an upload-pack that just shows the
+	# contents of the "input" file (prepared with the test-tool pkt-line
+	# helper), and does not do any negotiation (since ls-remote does not
+	# need it).
+	write_script cat-input <<-\EOF
+	# send our initial advertisement/response
+	cat input
+	# soak up the flush packet from the client
+	cat
+	EOF
+'
+
 test_expect_success 'dies when no remote found' '
 	test_must_fail git ls-remote
 '
@@ -360,4 +373,35 @@ test_expect_success 'ls-remote prefixes work with all protocol versions' '
 	test_cmp expect actual.v2
 '
 
+test_expect_success 'v0 clients can handle multiple symrefs' '
+	# Modern versions of Git will not return multiple symref capabilities
+	# for v0, so we have to hard-code the response. Note that we will
+	# always use both v0 and object-format=sha1 here, as the hard-coded
+	# response reflects a server that only supports those.
+	oid=1234567890123456789012345678901234567890 &&
+	symrefs="symref=refs/remotes/origin/HEAD:refs/remotes/origin/main" &&
+	symrefs="$symrefs symref=HEAD:refs/heads/main" &&
+
+	test-tool pkt-line pack >input.q <<-EOF &&
+	$oid HEADQ$symrefs
+	$oid refs/heads/main
+	$oid refs/remotes/origin/HEAD
+	$oid refs/remotes/origin/main
+	0000
+	EOF
+	q_to_nul <input.q >input &&
+
+	cat >expect <<-EOF &&
+	ref: refs/heads/main	HEAD
+	$oid	HEAD
+	$oid	refs/heads/main
+	ref: refs/remotes/origin/main	refs/remotes/origin/HEAD
+	$oid	refs/remotes/origin/HEAD
+	$oid	refs/remotes/origin/main
+	EOF
+
+	git ls-remote --symref --upload-pack=./cat-input . >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.0.493.gfc602f1919

