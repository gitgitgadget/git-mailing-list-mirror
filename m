Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27281F453
	for <e@80x24.org>; Tue, 23 Oct 2018 00:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJWI1E (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 04:27:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:50022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725799AbeJWI1E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 04:27:04 -0400
Received: (qmail 21421 invoked by uid 109); 23 Oct 2018 00:06:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Oct 2018 00:06:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12744 invoked by uid 111); 23 Oct 2018 00:05:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Oct 2018 20:05:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2018 20:06:16 -0400
Date:   Mon, 22 Oct 2018 20:06:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] archive: initialize archivers earlier
Message-ID: <20181023000616.GA27393@sigill.intra.peff.net>
References: <cover.1539990488.git.steadmon@google.com>
 <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
 <20181022223536.GB19019@sigill.intra.peff.net>
 <20181022235127.GE233961@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181022235127.GE233961@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 04:51:27PM -0700, Josh Steadmon wrote:

> > > +test_expect_success GZIP 'git archive with --output and --remote uses expected format' '
> > > +	git archive --output=d5.tgz --remote=. HEAD &&
> > > +	gzip -d -c < d5.tgz > d5.tar &&
> > > +	test_cmp_bin b.tar d5.tar
> > > +'
> > 
> > This nicely tests the more-interesting tgz case. But unfortunately it
> > won't run on machines without the GZIP prerequisite. I'd think that
> > would really be _most_ machines, but is it worth having a separate zip
> > test to cover machines without gzip? I guess that just creates the
> > opposite problem: not everybody has ZIP.
> 
> Added a test to compare the file lists from the .zip file to the
> reference .tar file. I'm not sure if this is the best way to do things,
> but it at least verifies that a .zip is produced. However, it's brittle
> if the output of "zip -sf" changes. Let me know if you have a better
> idea.

I wonder if we could do something more black-box. What we really care
about here is not the exact output, but rather that "-o foo.zip"
produces the same output as "--format zip". Could we do that without
even relying on ZIP?

I think it should follow even for tgz, because we use "-n" for a
repeatable output. But there we are relying on an external gzip just to
_create_ the file, so we'd still need the GZIP prereq.

Hmm. Looks like we already have a similar test in t5003. So maybe just:

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 55c7870997..cf19f56924 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -158,11 +158,16 @@ test_expect_success 'git archive --format=zip with --output' \
     'git archive --format=zip --output=d2.zip HEAD &&
     test_cmp_bin d.zip d2.zip'
 
-test_expect_success 'git archive with --output, inferring format' '
+test_expect_success 'git archive with --output, inferring format (local)' '
 	git archive --output=d3.zip HEAD &&
 	test_cmp_bin d.zip d3.zip
 '
 
+test_expect_success 'git archive with --output, ferring format (remote)' '
+	git archive --remote=. --output=d4.zip HEAD &&
+	test_cmp_bin d.zip d4.zip
+'
+
 test_expect_success \
     'git archive --format=zip with prefix' \
     'git archive --format=zip --prefix=prefix/ HEAD >e.zip'

which I think exposes the bug and can run everywhere?

-Peff
