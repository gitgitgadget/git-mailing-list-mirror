Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557591F405
	for <e@80x24.org>; Tue, 18 Dec 2018 12:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeLRMrz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 07:47:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:44752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726471AbeLRMrx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 07:47:53 -0500
Received: (qmail 15701 invoked by uid 109); 18 Dec 2018 12:47:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 12:47:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12743 invoked by uid 111); 18 Dec 2018 12:47:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 07:47:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 07:47:50 -0500
Date:   Tue, 18 Dec 2018 07:47:50 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual
 commands
Message-ID: <20181218124750.GC30471@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <20181211104342.GA7233@sigill.intra.peff.net>
 <xmqqo99oeu4u.fsf@gitster-ct.c.googlers.com>
 <20181214082050.GA11777@sigill.intra.peff.net>
 <xmqq5zvvd418.fsf@gitster-ct.c.googlers.com>
 <20181216102544.GA13704@sigill.intra.peff.net>
 <xmqqo99lbu9o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo99lbu9o.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 08:12:03PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I agree that such a "pass this through" struct full of options and
> > context would make sense. I just wouldn't tie it to the "serve"
> > machinery.
> >
> > Did you read the side-thread between me and Jonathan? Another option
> > here is to just have ls-refs assume that the client will tell it the
> > context (and assume uploadpack for now, since that's all that v2
> > currently does).
> 
> Yes, I'd be 100% happy with that, too.  And it certainly is simpler.

OK, let's do that, then. The user-visible behavior is no different, so
we can always reverse course later when the v2 push scheme materializes.
Patch is below.

> P.S. I expect to be mostly offline for the coming 72 hours, as I and
> my wife are both down with a cold.  I am guessing that we will enter
> slower weeks in many parts of the world, and hoping this won't be
> too disruptive.

Hope you are feeling better. I'll be active through the rest of this
week, and then probably offline quite a bit for the two weeks following.

-Peff

-- >8 --
Subject: [PATCH] upload-pack: support hidden refs with protocol v2

In the v2 protocol, upload-pack's advertisement has been moved to the
"ls-refs" command. That command does not respect hidden-ref config (like
transfer.hiderefs) at all, and advertises everything.

While there are some features that are not supported in v2 (e.g., v2
always allows fetching any sha1 without respect to advertisements), the
lack of this feature is not documented and is likely just a bug. Let's
make it work, as otherwise upgrading a server to a v2-capable git will
start exposing these refs that the repository admin has asked to remain
hidden.

Note that we assume we're operating on behalf of a fetch here, since
that's the only thing implemented in v2 at this point. See the in-code
comment. We'll have to figure out how this works when the v2 push
protocol is designed (both here in ls-refs, but also rejecting updates
to hidden refs).

Signed-off-by: Jeff King <peff@peff.net>
---
 ls-refs.c            | 16 ++++++++++++++++
 t/t5512-ls-remote.sh |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/ls-refs.c b/ls-refs.c
index a06f12eca8..9c9a7c647f 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -5,6 +5,7 @@
 #include "argv-array.h"
 #include "ls-refs.h"
 #include "pkt-line.h"
+#include "config.h"
 
 /*
  * Check if one of the prefixes is a prefix of the ref.
@@ -40,6 +41,9 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	const char *refname_nons = strip_namespace(refname);
 	struct strbuf refline = STRBUF_INIT;
 
+	if (ref_is_hidden(refname_nons, refname))
+		return 0;
+
 	if (!ref_match(&data->prefixes, refname))
 		return 0;
 
@@ -69,6 +73,16 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int ls_refs_config(const char *var, const char *value, void *data)
+{
+	/*
+	 * We only serve fetches over v2 for now, so respect only "uploadpack"
+	 * config. This may need to eventually be expanded to "receive", but we
+	 * don't yet know how that information will be passed to ls-refs.
+	 */
+	return parse_hide_refs_config(var, value, "uploadpack");
+}
+
 int ls_refs(struct repository *r, struct argv_array *keys,
 	    struct packet_reader *request)
 {
@@ -76,6 +90,8 @@ int ls_refs(struct repository *r, struct argv_array *keys,
 
 	memset(&data, 0, sizeof(data));
 
+	git_config(ls_refs_config, NULL);
+
 	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
 		const char *arg = request->line;
 		const char *out;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 32e722db2e..ca69636fd5 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -204,6 +204,12 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	grep refs/tags/magic actual
 '
 
+test_expect_success 'protocol v2 supports hiderefs' '
+	test_config uploadpack.hiderefs refs/tags &&
+	git -c protocol.version=2 ls-remote . >actual &&
+	! grep refs/tags actual
+'
+
 test_expect_success 'ls-remote --symref' '
 	git fetch origin &&
 	cat >expect <<-EOF &&
-- 
2.20.1.748.g4743e5683b

