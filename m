Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7BDC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 01:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEF120760
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 01:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbgJPBEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 21:04:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:33850 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388737AbgJPBEY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 21:04:24 -0400
Received: (qmail 25936 invoked by uid 109); 16 Oct 2020 01:04:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 01:04:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3264 invoked by uid 111); 16 Oct 2020 01:04:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 21:04:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 21:04:23 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Koutcher via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>
Subject: Re: [PATCH] credential: load default config
Message-ID: <20201016010423.GD2932796@coredump.intra.peff.net>
References: <pull.881.git.git.1602799160623.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.881.git.git.1602799160623.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 09:59:20PM +0000, Thomas Koutcher via GitGitGadget wrote:

> Make `git credential fill` honour the core.askPass variable.

Thanks, I agree this make sense to do.

>  builtin/credential.c | 3 +++
>  1 file changed, 3 insertions(+)

Perhaps it's worth squashing in this test?

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index bc2d74098f..a18f8a473b 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -265,6 +265,32 @@ test_expect_success 'internal getpass does not ask for known username' '
 	EOF
 '
 
+test_expect_success 'git-credential respects core.askPass' '
+	write_script alternate-askpass <<-\EOF &&
+	echo >&2 "alternate askpass invoked"
+	echo alternate-value
+	EOF
+	test_config core.askpass "$PWD/alternate-askpass" &&
+	(
+		# unset GIT_ASKPASS set by lib-credential.sh which would
+		# override our config, but do so in a subshell so that we do
+		# not interfere with other tests
+		sane_unset GIT_ASKPASS &&
+		check fill <<-\EOF
+		protocol=http
+		host=example.com
+		--
+		protocol=http
+		host=example.com
+		username=alternate-value
+		password=alternate-value
+		--
+		alternate askpass invoked
+		alternate askpass invoked
+		EOF
+	)
+'
+
 HELPER="!f() {
 		cat >/dev/null
 		echo username=foo
