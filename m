Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D68C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9451520716
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMRWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:22:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:58026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgHMRWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:22:07 -0400
Received: (qmail 20994 invoked by uid 109); 13 Aug 2020 17:22:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 17:22:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16540 invoked by uid 111); 13 Aug 2020 17:22:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 13:22:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 13:22:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>, Nuthan Munaiah <nm6061@rit.edu>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] t8003: check output of coalesced blame
Message-ID: <20200813172206.GA1597339@coredump.intra.peff.net>
References: <20200813052054.GA1962792@coredump.intra.peff.net>
 <20200813052305.GA2514880@coredump.intra.peff.net>
 <xmqq4kp64guk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kp64guk.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 10:04:51AM -0700, Junio C Hamano wrote:

> >  	cat >expect <<-EOF &&
> > -	$oid 1) ABC
> > -	$oid 2) DEF
> > +	$oid 1 1 2
> > +	$oid 2 2
> >  	EOF
> 
> It has become a bit harder to grok, but for the purpose of the later
> steps to see where things exactly came from (including their line
> numbers), it is easier to see what is going on with the new format.

Yeah, I agree the numbers are a bit more inscrutable. We could do
something like:

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index ba8013b002..9486888e5a 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -301,12 +301,14 @@ test_expect_success 'setup coalesce tests' '
 '
 
 test_expect_success 'blame coalesce' '
-	cat >expect <<-EOF &&
+	q_to_tab >expect <<-EOF &&
 	$orig 1 1 2
+	QABC
 	$orig 2 2
+	QDEF
 	EOF
 	git blame --porcelain $final giraffe >actual.raw &&
-	grep "^$orig" actual.raw >actual &&
+	egrep "^($orig|	)" actual.raw >actual &&
 	test_cmp expect actual
 '

but IMHO that isn't much more readable (largely due to the
tab-handling in the here-doc).

-Peff
