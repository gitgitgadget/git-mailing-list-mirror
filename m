Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E35D1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 23:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeJaIOZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 04:14:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:33516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726376AbeJaIOY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 04:14:24 -0400
Received: (qmail 28949 invoked by uid 109); 30 Oct 2018 23:18:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Oct 2018 23:18:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5328 invoked by uid 111); 30 Oct 2018 23:18:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Oct 2018 19:18:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2018 19:18:51 -0400
Date:   Tue, 30 Oct 2018 19:18:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 1/3] t1450: check large blob in trailing-garbage test
Message-ID: <20181030231850.GA32038@sigill.intra.peff.net>
References: <20181030231232.GA6141@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181030231232.GA6141@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit cce044df7f (fsck: detect trailing garbage in all
object types, 2017-01-13) added two tests of trailing
garbage in a loose object file: one with a commit and one
with a blob. The point of having two is that blobs would
follow a different code path that streamed the contents,
instead of loading it into a buffer as usual.

At the time, merely being a blob was enough to trigger the
streaming code path. But since 7ac4f3a007 (fsck: actually
fsck blob data, 2018-05-02), we now only stream blobs that
are actually large. So since then, the streaming code path
is not tested at all for this case.

We can restore the original intent of the test by tweaking
core.bigFileThreshold to make our small blob seem large.
There's no easy way to externally verify that we followed
the streaming code path, but I did check before/after using
a temporary debug statement.

Signed-off-by: Jeff King <peff@peff.net>
---
I prepared this series on master, but it occurs to me you may want to
apply patch 2 on top of f6371f9210 or thereabouts, which introduced the
bug it fixes. If so, then obviously this one doesn't make sense back
then, and should go on top of 7ac4f3a007. It should be semantically
independent, though there may be a minor text conflict.

 t/t1450-fsck.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0f2dd26f74..3421f12e8a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -673,13 +673,13 @@ test_expect_success 'fsck detects trailing loose garbage (commit)' '
 	test_i18ngrep "garbage.*$commit" out
 '
 
-test_expect_success 'fsck detects trailing loose garbage (blob)' '
+test_expect_success 'fsck detects trailing loose garbage (large blob)' '
 	blob=$(echo trailing | git hash-object -w --stdin) &&
 	file=$(sha1_file $blob) &&
 	test_when_finished "remove_object $blob" &&
 	chmod +w "$file" &&
 	echo garbage >>"$file" &&
-	test_must_fail git fsck 2>out &&
+	test_must_fail git -c core.bigfilethreshold=5 fsck 2>out &&
 	test_i18ngrep "garbage.*$blob" out
 '
 
-- 
2.19.1.1235.g6b27db57c2

