Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2744C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 07:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDLHZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDLHZS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 03:25:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DCB3C2F
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 00:25:11 -0700 (PDT)
Received: (qmail 18363 invoked by uid 109); 12 Apr 2023 07:25:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 07:25:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17468 invoked by uid 111); 12 Apr 2023 07:25:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 03:25:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 03:25:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH v2 1/7] v0 protocol: fix infinite loop when parsing
 multi-valued capabilities
Message-ID: <20230412072510.GA1694877@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
 <20230412062924.GA1681312@coredump.intra.peff.net>
 <20230412064651.GA1681676@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412064651.GA1681676@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 02:46:51AM -0400, Jeff King wrote:

> So if we have something like:
> 
>    agent=i-like-symrefs symref=HEAD:refs/heads/foo
> 
> then we'd find the "symref" value in the agent line, increment
> feature_list, and then find the real one. But our pointer difference
> will again be too short! And incrementing "offset" rather than assigning
> it won't help, because those skipped bytes are not accounted for in the
> existing value of "offset".
> 
> So what we probably want is a third possibility I didn't allow for: keep
> the original value of feature_list intact, and use a separate pointer to
> increment. And then assigning "*offset = value + end - feature_list"
> will always be correct, because the offset will always be from the
> original, true beginning of the string.
> 
> The fix is easy, but let me see if I can come up with a test.

OK, this is indeed buggy, but I'm not sure you can actually get it to
produce a user-visible result with the incrementing patch applied.

The problem is that "offset" is incremented by too-small an amount. So
in the example above, we might end up partway through the value of
"symref=", rather than at the end. In the worst case we might see the
same "symref=" entry again, which would cause us to attach it to the
list a second time, leaking the memory. But either way we always make
forward progress through the string, so we'd never loop infinitely, nor
produce a wrong answer (we can never _skip_ an entry, only accidentally
process it twice).

So I think it's worth fixing, and even worth beefing up the test to
include this case, but sadly there's no specific case to check for. So I
just rolled it into the fix in patch 1.

Here's that patch (and I'll send a range-diff in a second). The rest are
the same, modulo a small textual conflict in patch 7 that touches a
nearby line, but I'll refrain from re-sending the rest of them until
I've gotten more review.

-- >8 --
Subject: v0 protocol: fix infinite loop when parsing multi-valued capabilities

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

One solution would be to account for those skipped bytes by incrementing
*offset, rather than assigning to it. But wait, there's more!

We also increment feature_list if we have a near-miss. Say we are
looking for "symref" and find "almost-symref". In that case we'll point
feature_list to the "y" in "almost-symref" and restart our search. But
that again means our offset won't be correct, as it won't account for
the bytes between the start of the string and that "y".

So instead, let's just record the beginning of the feature_list string
in a separate pointer that we never touch. That offset we take in and
return is meant to be using that point as a base, and now we'll do so
consistently.

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
 connect.c            |  5 +++--
 t/t5512-ls-remote.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index c0c8a38178..0dc739c4e5 100644
--- a/connect.c
+++ b/connect.c
@@ -597,6 +597,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 
 const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
 {
+	const char *orig_start = feature_list;
 	int len;
 
 	if (!feature_list)
@@ -616,7 +617,7 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 				if (lenp)
 					*lenp = 0;
 				if (offset)
-					*offset = found + len - feature_list;
+					*offset = found + len - orig_start;
 				return value;
 			}
 			/* feature with a value (e.g., "agent=git/1.2.3") */
@@ -628,7 +629,7 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 				if (lenp)
 					*lenp = end;
 				if (offset)
-					*offset = value + end - feature_list;
+					*offset = value + end - orig_start;
 				return value;
 			}
 			/*
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 20d063fb9a..cab67282df 100755
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
@@ -360,4 +373,43 @@ test_expect_success 'ls-remote prefixes work with all protocol versions' '
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
+	# Likewise we want to make sure our parser is not fooled by the string
+	# "symref" appearing as part of an earlier cap. But there is no way to
+	# do that via upload-pack, as arbitrary strings can appear only in a
+	# "symref" value itself (where we skip past the values as a whole)
+	# and "agent" (which always appears after "symref", so putting our
+	# parser in a confused state is less interesting).
+	caps="some other caps including a-fake-symref-cap" &&
+
+	test-tool pkt-line pack >input.q <<-EOF &&
+	$oid HEADQ$caps $symrefs
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

