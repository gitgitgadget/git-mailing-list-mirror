Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8858C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9FC20776
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDWU7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:59:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:37820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725877AbgDWU7P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:59:15 -0400
Received: (qmail 17808 invoked by uid 109); 23 Apr 2020 20:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Apr 2020 20:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13397 invoked by uid 111); 23 Apr 2020 21:10:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Apr 2020 17:10:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Apr 2020 16:59:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/2] test-bloom: check that we have expected arguments
Message-ID: <20200423205914.GB1634224@coredump.intra.peff.net>
References: <20200423205851.GA1633985@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423205851.GA1633985@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If "test-tool bloom" is not fed a command, or if arguments are missing
for some commands, it will just segfault. Let's check argc and write a
friendlier usage message.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-bloom.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index f9c0ce2bae..77eb27adac 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -43,10 +43,21 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 	print_bloom_filter(filter);
 }
 
+static const char *bloom_usage = "\n"
+"  test-tool bloom get_murmer3 <string>\n"
+"  test-tool bloom generate_filter <string> [<string>...]\n"
+"  test-tool get_filter_for_commit <commit-hex>\n";
+
 int cmd__bloom(int argc, const char **argv)
 {
+	if (argc < 2)
+		usage(bloom_usage);
+
 	if (!strcmp(argv[1], "get_murmur3")) {
-		uint32_t hashed = murmur3_seeded(0, argv[2], strlen(argv[2]));
+		uint32_t hashed;
+		if (argc < 3)
+			usage(bloom_usage);
+		hashed = murmur3_seeded(0, argv[2], strlen(argv[2]));
 		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
 	}
 
@@ -56,9 +67,8 @@ int cmd__bloom(int argc, const char **argv)
 		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
 		filter.data = xcalloc(filter.len, sizeof(unsigned char));
 
-		if (!argv[2]) {
-			die("at least one input string expected");
-		}
+		if (argc - 1 < i)
+			usage(bloom_usage);
 
 		while (argv[i]) {
 			add_string_to_filter(argv[i], &filter);
@@ -71,6 +81,8 @@ int cmd__bloom(int argc, const char **argv)
 	if (!strcmp(argv[1], "get_filter_for_commit")) {
 		struct object_id oid;
 		const char *end;
+		if (argc < 3)
+			usage(bloom_usage);
 		if (parse_oid_hex(argv[2], &oid, &end))
 			die("cannot parse oid '%s'", argv[2]);
 		init_bloom_filters();
-- 
2.26.2.827.g3c1233342b
