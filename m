Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C261FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 02:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbdJLCKO (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 22:10:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59591 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751757AbdJLCKN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 22:10:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AEDCB61A6;
        Wed, 11 Oct 2017 22:10:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Ugv2
        BhvgGYlq3eKU3bQbSpteNm8=; b=ACsIdfj36TdLR1EOyXtnJD6mddxv6ljvehgn
        oNv5EtxDNj7koG1KvdG5kJv8+uvCtqmrd92NGFTNH262Q0JS+JUn9Cs1qVI+58LX
        b3DqebX2QQjzJfr5tuZrhSQCzdTbRwHC+qtVjxAuL2eKhvGeY2kQzsV56BGhCpSD
        mnsUIfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=xQg6qA
        Pm7S3/ZR1vhSlUmgjm5hLWEl/JdISPApq9qvUra1vlkL5qAGZnN0EFLle4qlre16
        ypntmfUmfJy6lWf08pemPzLicOOH+AVYgAVhITZ84O25dew/Iv5UYNE5h9jCIy3o
        kD8WcAf17B1P1prcKG2gwon8uQMNPkTqi6Oiw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73651B61A5;
        Wed, 11 Oct 2017 22:10:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5AC3B61A4;
        Wed, 11 Oct 2017 22:10:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] color: discourage use of ui.color=always
Date:   Thu, 12 Oct 2017 11:10:07 +0900
Message-Id: <20171012021007.7441-3-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc1-151-g44fe2f342f
In-Reply-To: <20171012021007.7441-1-gitster@pobox.com>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
X-Pobox-Relay-ID: 7A8E2BAA-AEF2-11E7-BC6C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Warn when we read such a configuration from a file, and nudge the
users to spell them 'auto' instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 2 +-
 color.c                  | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cb0f951ddc..ba01b8d3df 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1178,7 +1178,7 @@ color.ui::
 	or the `--color` option. Set it to `true` or `auto` to enable
 	color when output is written to the terminal (this is also the
 	default since Git 1.8.4). The value `always` is a historical
-	synonym for `auto`.
+	synonym for `auto` and its use is discouraged.
 
 column.ui::
 	Specify whether supported commands should output in columns.
diff --git a/color.c b/color.c
index 5b06c76bdc..5119f9bca0 100644
--- a/color.c
+++ b/color.c
@@ -308,6 +308,8 @@ int git_config_colorbool(const char *var, const char *value)
 		if (!strcasecmp(value, "never"))
 			return 0;
 		if (!strcasecmp(value, "always")) {
+			static int warn_once;
+
 			/*
 			 * Command-line options always respect "always".
 			 * Likewise for "-c" config on the command-line.
@@ -320,6 +322,11 @@ int git_config_colorbool(const char *var, const char *value)
 			 * Otherwise, we're looking at on-disk config;
 			 * downgrade to auto.
 			 */
+			if (!warn_once) {
+				warn_once++;
+				warning("setting '%s' to '%s' is no longer valid; "
+					"set it to 'auto' instead", var, value);
+			}
 			return GIT_COLOR_AUTO;
 		}
 		if (!strcasecmp(value, "auto"))
-- 
2.15.0-rc1-151-g44fe2f342f

