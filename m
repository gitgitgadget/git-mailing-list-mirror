Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619EC433E1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 12:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7296221D79
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 12:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGNMdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:33:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:57008 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbgGNMdf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 08:33:35 -0400
Received: (qmail 6115 invoked by uid 109); 14 Jul 2020 12:33:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2020 12:33:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31686 invoked by uid 111); 14 Jul 2020 12:33:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2020 08:33:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jul 2020 08:33:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 0/4] deterministic commit timestamps in tests
Message-ID: <20200714123334.GB2587001@coredump.intra.peff.net>
References: <20200709203336.GA2748777@coredump.intra.peff.net>
 <xmqqa707rpuu.fsf@gitster.c.googlers.com>
 <20200714123142.GA2587001@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714123142.GA2587001@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 14, 2020 at 08:31:42AM -0400, Jeff King wrote:

> We _could_ fix this by sorting before removing duplicates, but
> presumably it's a useful part of the test to make sure the trees appear
> in the same order in both spots. Likewise, we could use something like:
> 
>   perl -ne 'print unless $seen{$_}++'
> 
> to remove duplicates without impacting the order. But that doesn't work
> either, because there are actually multiple (non-duplicate) commits with
> the same trees (we change a file mode and then change it back). So we'd
> actually have to de-duplicate the combination of subject and tree. Which
> then further throws off t9100.18, which compares the tree hashes
> exactly; we'd have to strip the result back down.

Actually, that last one isn't _too_ bad. It looks something like this:

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index b80952f0ac..4502c5f97d 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -204,8 +204,10 @@ GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
     'git svn init "$svnrepo" && git svn fetch &&
-     git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
-     git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
+     git log --format="tree %T %s" remotes/git-svn |
+	perl -lne "print unless \$seen{\$_}++" |
+	cut -d" " -f1-2 >a &&
+     git log --format="tree %T" remotes/alt >b &&
      test_cmp a b'
 
 name='check imported tree checksums expected tree checksums'

It does lose a little bit of information, which is that in the original
we confirmed that the duplicates were always next to each other. But I'm
not sure that's important. We'd get confused if the same subject
appeared twice, but all of the commits have distinct hard-coded
subjects in the earlier tests.

-Peff
