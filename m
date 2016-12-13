Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFED1FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 11:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932897AbcLMLoU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 06:44:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:55607 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753073AbcLMLoT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 06:44:19 -0500
Received: (qmail 29478 invoked by uid 109); 13 Dec 2016 11:44:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 11:44:18 +0000
Received: (qmail 13738 invoked by uid 111); 13 Dec 2016 11:44:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 06:44:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 06:44:15 -0500
Date:   Tue, 13 Dec 2016 06:44:15 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] tmp-objdir: quote paths we add to alternates
Message-ID: <20161213114414.masgfo7lf7e3utym@sigill.intra.peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
 <d83cd58f-9b52-cbc5-04dd-5aafe2822533@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d83cd58f-9b52-cbc5-04dd-5aafe2822533@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 09:53:11PM +0100, Johannes Sixt wrote:

> > The appropriate check there would be ";" anyway, but I am not
> > sure _that_ is allowed in paths, either.
> 
> That was also my line of thought. I tested earlier today whether a file name
> can have ";", and the OS did not reject it bluntly. Let me see whether I can
> adjust the test case for Windows.

The naive conversion is just:

diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 6275ec807..e195e168b 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -33,8 +33,13 @@ test_expect_success 'rejected objects are removed' '
 	test_cmp expect actual
 '
 
-# MINGW does not allow colons in pathnames in the first place
-test_expect_success !MINGW 'push to repo path with colon' '
+if test_have_prereq MINGW
+then
+	path_sep=';'
+else
+	path_sep=':'
+fi
+test_expect_success 'push to repo path with (semi-)colon separator' '
 	# The interesting failure case here is when the
 	# receiving end cannot access its original object directory,
 	# so make it likely for us to generate a delta by having
@@ -43,13 +48,13 @@ test_expect_success !MINGW 'push to repo path with colon' '
 	test-genrandom foo 4096 >file.bin &&
 	git add file.bin &&
 	git commit -m bin &&
-	git clone --bare . xxx:yyy.git &&
+	git clone --bare . xxx${path_sep}yyy.git &&
 
 	echo change >>file.bin &&
 	git commit -am change &&
 	# Note that we have to use the full path here, or it gets confused
 	# with the ssh host:path syntax.
-	git push "$PWD/xxx:yyy.git" HEAD
+	git push "$PWD/xxx${path_sep}yyy.git" HEAD
 '
 
 test_done

Does that work?

-Peff
