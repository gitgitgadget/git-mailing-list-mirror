Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A02B1FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 02:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbdJLCKr (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 22:10:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64542 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752123AbdJLCKq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 22:10:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28C9198B42;
        Wed, 11 Oct 2017 22:10:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=NKcP
        HO1Ad4BRA/yheayg/1KSths=; b=Up6gY4nVUvZLQ1en8FIuPERfELMgVMQ6zrnt
        Qlgz6Cvdin40Hi/QCW6sFUrLbLXIzb0ig9RvZtx8v3nyyvC6bMPAVX3ibADHMi3v
        u0Xa2ktThmCHIhDbTUWR0WzsDZu30RWjJjReMycnRcHWimKJ0VbVDex1Qeg/bXbC
        ANm1lJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        hYcqa5+5+c1Op4E/6jvoyTkkRbnM2JwmrLK0TFR2vDR30Awvv95QjLoe+bLlQKwe
        iEyT4/rFov06kEn5phnKMLU97tVHetIc/XDdcgFpE3XSn0lxkiZE96seEg4Vk0xw
        mwJPjyzGN68Mz8lbh3jTxuuiwTw3CDfRlYN0xT/LELo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FFBB98B41;
        Wed, 11 Oct 2017 22:10:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8031298A6C;
        Wed, 11 Oct 2017 22:10:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
Date:   Thu, 12 Oct 2017 11:10:06 +0900
Message-Id: <20171012021007.7441-2-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc1-151-g44fe2f342f
In-Reply-To: <20171012021007.7441-1-gitster@pobox.com>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
X-Pobox-Relay-ID: 79B652B6-AEF2-11E7-92C7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

An earlier patch downgraded "always" that comes via the ui.color
configuration variable to "auto", in order to work around an
unfortunate regression to "git add -i".

That "fix" however regressed other third-party tools that depend on
"git -c color.ui=always cmd" as the way to defeat any end-user
configuration and force coloured output from git subcommand, even
when the output does not go to a terminal.

It is a bit ugly to treat "-c color.ui=always" from the command line
differently from a definition that comes from on-disk configuration
files, but it is a moral equivalent of "--color=always" option given
to the subcommand from the command line, i.e. a signal that tells us
that the script writer knows what s/he is doing.  So let's take that
route to unbreak this case while defeating a (now declared to be)
misguided color.ui that is set to always in the configuration file.

NEEDS-SIGN-OFF-BY: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 color.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/color.c b/color.c
index 17e2713f96..5b06c76bdc 100644
--- a/color.c
+++ b/color.c
@@ -307,8 +307,21 @@ int git_config_colorbool(const char *var, const char *value)
 	if (value) {
 		if (!strcasecmp(value, "never"))
 			return 0;
-		if (!strcasecmp(value, "always"))
-			return var ? GIT_COLOR_AUTO : 1;
+		if (!strcasecmp(value, "always")) {
+			/*
+			 * Command-line options always respect "always".
+			 * Likewise for "-c" config on the command-line.
+			 */
+			if (!var ||
+			    current_config_scope() == CONFIG_SCOPE_CMDLINE)
+				return 1;
+
+			/*
+			 * Otherwise, we're looking at on-disk config;
+			 * downgrade to auto.
+			 */
+			return GIT_COLOR_AUTO;
+		}
 		if (!strcasecmp(value, "auto"))
 			return GIT_COLOR_AUTO;
 	}
-- 
2.15.0-rc1-151-g44fe2f342f

