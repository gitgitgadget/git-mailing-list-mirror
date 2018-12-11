Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1BB520A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbeLKKpE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:45:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:37962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726114AbeLKKpE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:45:04 -0500
Received: (qmail 14593 invoked by uid 109); 11 Dec 2018 10:45:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:45:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3989 invoked by uid 111); 11 Dec 2018 10:44:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:44:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:44:39 -0500
Date:   Tue, 11 Dec 2018 05:44:39 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 3/3] upload-pack: support hidden refs with protocol v2
Message-ID: <20181211104439.GC7233@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211104236.GA6899@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the v2 protocol, upload-pack's advertisement has been moved to the
"ls-refs" command. That command does not respect hidden-ref config (like
transfer.hiderefs) at all, and advertises everything.

While there are some features that are not supported in v2 (e.g., v2
always allows fetching any sha1 without respect to advertisements), the
lack of this feature is not documented and is likely just a bug. Let's
make it work, as otherwise upgrading a server to a v2-capable git will
start exposing these refs that the repository admin has asked to remain
hidden.

Note that we depend on the config_context from the caller here to
realize that we should respect uploadpack.hiderefs. When run from the
"git-serve" tool, we won't have that context and will only respect
transfer.hiderefs. This should be OK, as git-serve is not actually used
for normal protocol operations.

Signed-off-by: Jeff King <peff@peff.net>
---
 ls-refs.c            | 12 ++++++++++++
 t/t5512-ls-remote.sh |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/ls-refs.c b/ls-refs.c
index e8e31475f0..8a8143338b 100644
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
 
@@ -69,6 +73,12 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int ls_refs_config(const char *var, const char *value,
+			  void *config_context)
+{
+	return parse_hide_refs_config(var, value, config_context);
+}
+
 int ls_refs(struct repository *r,
 	    const char *config_section,
 	    struct argv_array *keys,
@@ -78,6 +88,8 @@ int ls_refs(struct repository *r,
 
 	memset(&data, 0, sizeof(data));
 
+	git_config(ls_refs_config, (void *)config_section);
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
2.20.0.734.gb4f2c0d2be
