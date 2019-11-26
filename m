Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2B3C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6F020409
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKZAIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:08:40 -0500
Received: from mailout08.hostingdiscounter.nl ([91.217.57.99]:35445 "EHLO
        mailout08.hostingdiscounter.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbfKZAIk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Nov 2019 19:08:40 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 19:08:39 EST
Received: from localhost (localhost [127.0.0.1])
        by mailout08.hostingdiscounter.nl (Postfix) with ESMTP id 43940643;
        Tue, 26 Nov 2019 01:02:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mailout08.hostingdiscounter.nl
Received: from mailout08.hostingdiscounter.nl ([127.0.0.1])
        by localhost (mailout08.hostingdiscounter.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w73kJP8jC+eW; Tue, 26 Nov 2019 01:02:26 +0100 (CET)
Received: from mail41.hostingdiscounter.nl (mail41.hostingdiscounter.nl [IPv6:2a00:1478:200:0:f:1053:0:1])
        by mailout08.hostingdiscounter.nl (Postfix) with ESMTPS;
        Tue, 26 Nov 2019 01:02:26 +0100 (CET)
Received: from [192.168.1.105] (130-208-201-31.ftth.glasoperator.nl [31.201.208.130])
        by mail41.hostingdiscounter.nl (Postfix) with ESMTPSA id 95FE144118;
        Tue, 26 Nov 2019 01:02:59 +0100 (CET)
To:     git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Nieder <jrnieder@gmail.com>
From:   Ruud van Asseldonk <dev@veniogames.com>
Subject: [PATCH] t5150: skip request-pull test if Perl is disabled
Message-ID: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
Date:   Tue, 26 Nov 2019 01:02:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-request-pull.sh script invokes Perl, so it requires Perl to be
available, but the associated test t5150 does not skip itself when Perl
has been disabled, which then makes subtest 4 through 10 fail. Subtest 3
still passes, but for the wrong reasons (it expects git-request-pull to
fail, and it does fail when Perl is not available). The initial two
subtests that do pass are only doing setup.

To prevent t5150 from failing the build when NO_PERL=1, add a check that
sets skip_all when "! test_have_prereq PERL", just like how for example
t3701-add-interactive skips itself when Perl has been disabled.

Signed-off-by: Ruud van Asseldonk <dev@veniogames.com>
---
I discovered this issue in the Git package in Nixpkgs. The Nix package
manager tries to make it hard to accidentally introduce undeclared
dependencies, and it has a sandbox that hides things in /usr/bin. So
when it builds with NO_PERL=1, it really makes no Perl available, so you
cannot accidentally depend on the Perl in /usr/bin/perl. For the tests
it does set PERL_PATH, but it does not point to a binary in /usr/bin.

 t/t5150-request-pull.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 852dcd913f..1ad4ecc29a 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -4,6 +4,12 @@ test_description='Test workflows involving pull request.'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL
+then
+	skip_all='skipping request-pull tests, perl not available'
+	test_done
+fi
+
 test_expect_success 'setup' '
 
 	git init --bare upstream.git &&
-- 
2.24.0
