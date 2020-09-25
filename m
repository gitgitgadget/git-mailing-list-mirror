Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D3C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2464520878
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgIYSeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:34:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:41256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729834AbgIYSeh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:34:37 -0400
Received: (qmail 15703 invoked by uid 109); 25 Sep 2020 18:34:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 18:34:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22121 invoked by uid 111); 25 Sep 2020 18:34:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 14:34:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 14:34:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] protocol: re-enable v2 protocol by default
Message-ID: <20200925183436.GA659633@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Protocol v2 became the default in v2.26.0 via 684ceae32d (fetch: default
to protocol version 2, 2019-12-23). More widespread use turned up a
regression in negotiation. That was fixed in v2.27.0 via 4fa3f00abb
(fetch-pack: in protocol v2, in_vain only after ACK, 2020-04-27), but we
also reverted the default to v0 as a precuation in 11c7f2a30b (Revert
"fetch: default to protocol version 2", 2020-04-22).

In v2.28.0, we re-enabled it for experimental users with 3697caf4b9
(config: let feature.experimental imply protocol.version=2, 2020-05-20)
and haven't heard any complaints. v2.28 has only been out for 2 months,
but I'd generally expect people turning on feature.experimental to also
stay pretty up-to-date. So we're not likely to collect much more data by
waiting. In addition, we have no further reports from people running
v2.26.0, and of course some people have been setting protocol.version
manually for ages.

Let's move forward with v2 as the default again. It's possible there are
still lurking bugs, but we won't know until it gets more widespread use.
And we can find and squash them just like any other bug at this point.

Signed-off-by: Jeff King <peff@peff.net>
---
After seeing yet another round of "if you use the v2 protocol, all of
your issues fetching a non-tip object for submodules or CI will go away"
advice today, I was reminded that we haven't picked up the question
again of when we should look at v2 becoming the default again.

 Documentation/config/feature.txt  | 4 ----
 Documentation/config/protocol.txt | 3 +--
 protocol.c                        | 6 +-----
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index c0cbf2bb1c..cdecd04e5b 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -14,10 +14,6 @@ feature.experimental::
 +
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
-+
-* `protocol.version=2` speeds up fetches from repositories with many refs by
-allowing the client to specify which refs to list before the server lists
-them.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
index c46e9b3d00..756591d77b 100644
--- a/Documentation/config/protocol.txt
+++ b/Documentation/config/protocol.txt
@@ -48,8 +48,7 @@ protocol.version::
 	If set, clients will attempt to communicate with a server
 	using the specified protocol version.  If the server does
 	not support it, communication falls back to version 0.
-	If unset, the default is `0`, unless `feature.experimental`
-	is enabled, in which case the default is `2`.
+	If unset, the default is `2`.
 	Supported versions:
 +
 --
diff --git a/protocol.c b/protocol.c
index 8d964fc65e..052d7edbb9 100644
--- a/protocol.c
+++ b/protocol.c
@@ -17,7 +17,6 @@ static enum protocol_version parse_protocol_version(const char *value)
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
-	int val;
 	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
 	const char *git_test_v;
 
@@ -31,9 +30,6 @@ enum protocol_version get_protocol_version_config(void)
 		return version;
 	}
 
-	if (!git_config_get_bool("feature.experimental", &val) && val)
-		return protocol_v2;
-
 	git_test_v = getenv(git_test_k);
 	if (git_test_v && *git_test_v) {
 		enum protocol_version env = parse_protocol_version(git_test_v);
@@ -43,7 +39,7 @@ enum protocol_version get_protocol_version_config(void)
 		return env;
 	}
 
-	return protocol_v0;
+	return protocol_v2;
 }
 
 enum protocol_version determine_protocol_version_server(void)
-- 
2.28.0.1085.g44a0350633
