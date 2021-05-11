Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D88C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53B2617ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhEKS1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:27:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:50910 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhEKS1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:27:06 -0400
Received: (qmail 23971 invoked by uid 109); 11 May 2021 18:25:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 18:25:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26241 invoked by uid 111); 11 May 2021 18:25:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 14:25:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 14:25:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: fix clone on sha256 repos
Message-ID: <YJrMNmH92mKrIX0N@coredump.intra.peff.net>
References: <20210511103730.GA15003@dcvr>
 <874kf9tjgj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kf9tjgj.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 04:47:28PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Tue, May 11 2021, Eric Wong wrote:
> 
> > I'm not very familiar with the way some of this stuff works, but
> > the patch below seems to fix clone for me.
> 
> Me neither, but it seems that whatever issue we have here we've got a
> big blind spot in our test suite.
> 
> GIT_SMART_HTTP in the environment will be ignored by test-lib.sh,
> manually changing the code to use it leads to a lot of test failures,
> some are definitely expected (incompatible server responses), but some
> might not be...

There are specific dumb-http tests in t5550. And I think we can and do
run the suite with GIT_TEST_DEFAULT_HASH=sha256. But I suspect that
covers up the problem. If I understand the problem correctly, it comes
about when the client thinks the default hash is sha1, but the server is
sha256. Whereas GIT_TEST_DEFAULT_HASH affects _both_ sides.

So I think we'd want interop tests in t5550 that specifically create a
sha256 server and access it with a sha1 client (and possibly vice
versa).

It would be nice if there was a way to use an environment variable like
GIT_TEST_DEFAULT_HASH to mean "be hash X on the server, but Y on the
client". But I don't think we can easily do that. The "git init" command
which is used to create a repo that is later used for server access
doesn't _know_ that's what it's being used for. Possibly we could have
an extra variable that instructs git-clone to use a separate default
hash. And then:

  GIT_TEST_DEFAULT_HASH=sha256 \
  GIT_TEST_CLONE_DEFAULT_HASH=sha1 \
  make test

might possibly trigger some interesting cases.

-Peff
