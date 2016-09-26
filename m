Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21FA209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 11:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034271AbcIZL7U (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 07:59:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:48009 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030407AbcIZL7S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 07:59:18 -0400
Received: (qmail 18540 invoked by uid 109); 26 Sep 2016 11:59:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 11:59:17 +0000
Received: (qmail 4317 invoked by uid 111); 26 Sep 2016 11:59:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 07:59:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 07:59:15 -0400
Date:   Mon, 26 Sep 2016 07:59:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 02/10] get_sha1: avoid repeating ourselves via ONLY_TO_DIE
Message-ID: <20160926115915.7lo6tr2mvs5irza2@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the revision code cannot parse an argument like
"HEAD:foo", it will call maybe_die_on_misspelt_object_name(),
which re-runs get_sha1() with an extra ONLY_TO_DIE flag. We
then spend more effort to generate a better error message.

Unfortunately, a side effect is that our second call may
repeat the same error messages from the original get_sha1()
call. You can see this with:

  $ git show 0017
  error: short SHA1 0017 is ambiguous.
  error: short SHA1 0017 is ambiguous.
  fatal: ambiguous argument '0017': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

where the second "error:" line comes from the ONLY_TO_DIE
call.

To fix this, we can make ONLY_TO_DIE imply QUIETLY. This is
a little odd, because the whole point of ONLY_TO_DIE is to
output error messages. But what we want to do is tell the
rest of the get_sha1() code (particularly get_sha1_1()) that
the _regular_ messages should be quiet, but the only-to-die
ones should not.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c                         | 3 +++
 t/t1512-rev-parse-disambiguation.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index f9812ff..fe05ba0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1391,6 +1391,9 @@ static int get_sha1_with_context_1(const char *name,
 	const char *cp;
 	int only_to_die = flags & GET_SHA1_ONLY_TO_DIE;
 
+	if (only_to_die)
+		flags |= GET_SHA1_QUIETLY;
+
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
 	ret = get_sha1_1(name, namelen, sha1, flags);
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index e221167..16f9709 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -291,4 +291,10 @@ test_expect_success 'ambiguous short sha1 ref' '
 	grep "refname.*${REF}.*ambiguous" err
 '
 
+test_expect_success C_LOCALE_OUTPUT 'ambiguity errors are not repeated' '
+	test_must_fail git rev-parse 00000 2>stderr &&
+	grep "is ambiguous" stderr >errors &&
+	test_line_count = 1 errors
+'
+
 test_done
-- 
2.10.0.492.g14f803f

