Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFACDC677F1
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjBWJiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjBWJhz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:37:55 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C053EEE
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:37:43 -0800 (PST)
Received: (qmail 22802 invoked by uid 109); 23 Feb 2023 09:37:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 09:37:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17589 invoked by uid 111); 23 Feb 2023 09:37:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 04:37:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 04:37:42 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v10 1/3] t5563: add tests for basic and anoymous HTTP
 access
Message-ID: <Y/cz5g1PJoYeh0Fw@coredump.intra.peff.net>
References: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
 <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
 <f3ccc53055acf5d5c25d0ad3eed3867ea8670e55.1676586881.git.gitgitgadget@gmail.com>
 <Y/cu7K5uFjvOMXLu@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/cu7K5uFjvOMXLu@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 04:16:28AM -0500, Jeff King wrote:

> Hmm, today I learned about NPH scripts.
> 
> Obviously it works here, but I have to wonder: is there a reason we need
> this? AFAICT the only thing we do is set the HTTP response code, which
> could also be done with a Status: header.
> 
> I.e., this passes your test:

Having looked at patch 3 now, this also needs:

diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index 64d2acd032..afdf388677 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -37,7 +37,7 @@ expect_credential_query () {
 
 per_test_cleanup () {
 	rm -f *.cred &&
-	rm -f "$HTTPD_ROOT_PATH"/custom-auth.*
+	rm -f "$HTTPD_ROOT_PATH"/custom-auth.valid "$HTTPD_ROOT_PATH"/custom-auth.challenge
 }
 
 test_expect_success 'setup repository' '

or comedy ensues. But more importantly, realized why you want to use NPH
here. Apache will happily munge:

  WWW-Authenticate: foo
  WWW-Authenticate: bar

into:

  WWW-Authenticate: foo, bar

and you want to stress the parser with specific syntactic forms. So that
makes sense, and I agree NPH is the right solution here.

I think you did try to say this in the commit message as:

  Leverage a no-parsed headers (NPH) CGI script so that we can directly
  control the HTTP responses to simulate a multitude of good, bad and
  ugly remote server implementations around auth.

but I was too dense to realize quite what that meant. :)

-Peff
