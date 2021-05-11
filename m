Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25BBC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9A06146E
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKVYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 17:24:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:51360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhEKVYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 17:24:31 -0400
Received: (qmail 24613 invoked by uid 109); 11 May 2021 21:23:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 21:23:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28284 invoked by uid 111); 11 May 2021 21:23:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 17:23:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 17:23:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: fix clone on sha256 repos
Message-ID: <YJr1y9jqguEQQXk3@coredump.intra.peff.net>
References: <20210511103730.GA15003@dcvr>
 <874kf9tjgj.fsf@evledraar.gmail.com>
 <YJrMNmH92mKrIX0N@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJrMNmH92mKrIX0N@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 02:25:58PM -0400, Jeff King wrote:

> It would be nice if there was a way to use an environment variable like
> GIT_TEST_DEFAULT_HASH to mean "be hash X on the server, but Y on the
> client". But I don't think we can easily do that. The "git init" command
> which is used to create a repo that is later used for server access
> doesn't _know_ that's what it's being used for. Possibly we could have
> an extra variable that instructs git-clone to use a separate default
> hash. And then:
> 
>   GIT_TEST_DEFAULT_HASH=sha256 \
>   GIT_TEST_CLONE_DEFAULT_HASH=sha1 \
>   make test
> 
> might possibly trigger some interesting cases.

So this triggers several test failures:

diff --git a/builtin/clone.c b/builtin/clone.c
index eeb74c0217..622447daf7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -992,6 +992,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("clone");
 
+	/* hack to test cross-hash interop */
+	{
+		const char *x = getenv("GIT_TEST_DEFAULT_CLONE_HASH");
+		if (x)
+			setenv("GIT_DEFAULT_HASH", x, 1);
+	}
+
 	git_config(git_clone_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,

For example, running:

  GIT_TEST_DEFAULT_CLONE_HASH=sha1 \
  GIT_TEST_DEFAULT_HASH=sha256 \
  ./t5550-http-fetch-dumb.sh -v -i

fails in test 3, which shows the problem Eric found. And indeed,
applying his patch fixes it. We then go on to fail in test 7 ("empty
dumb HTTP repository has default hash algorithm"), which is not all that
surprising, since there is no longer one "the default".

So I'm not sure if the technique is a good one. It did find a bug, but
it's not clear to me if the other dozen failures it finds are also bugs,
or places where the tests should be modified to handle this case, or
just weird problems caused by the hacky implementation above. A lot of
them seem to involve submodules, which is not surprising; we'd probably
end up here with a sha256 superproject and cloned sha1 modules.

-Peff
