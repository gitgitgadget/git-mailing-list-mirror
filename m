Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A5C4332D
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9423B64E0F
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhA2UFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:05:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:40758 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233241AbhA2UEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:04:51 -0500
Received: (qmail 3590 invoked by uid 109); 29 Jan 2021 20:03:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 20:03:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8521 invoked by uid 111); 29 Jan 2021 20:04:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 15:04:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 15:04:08 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: [PATCH] p5303: avoid sed GNU-ism
Message-ID: <YBRqOI84MkU+HNzt@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
 <xmqqft2ktnpj.fsf@gitster.c.googlers.com>
 <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 02:32:50PM -0500, Jeff King wrote:

> > this construct:
> > 
> > 	... |
> > 	sed -n '1~5p' |
> > 	head -n "$1" |
> >         ...
> > 
> > which is a GNUism.  Peff often says that very small population
> > actually run our perf suite, and this seems to corroborate the
> > conjecture.
> 
> Oops. Looks like I was the one who introduced that. Nobody seems to have
> complained, so I'm somewhat tempted to leave it. But it would not be too
> hard to replace with perl, I think.

Maybe worth doing this?

-- >8 --
Subject: [PATCH] p5303: avoid sed GNU-ism

Using "1~5" isn't portable. Nobody seems to have noticed, since perhaps
people don't tend to run the perf suite on more exotic platforms. Still,
it's better to set a good example.

We can use:

  perl -ne 'print if $. % 5 == 1'

instead. But we can further observe that perl does a good job of the
other parts of this pipeline, and fold the whole thing together.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/p5303-many-packs.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index f4c2ab0584..ce0c42cc9f 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -21,10 +21,14 @@ repack_into_n () {
 	mkdir staging &&
 
 	git rev-list --first-parent HEAD |
-	sed -n '1~5p' |
-	head -n "$1" |
-	perl -e 'print reverse <>' \
-	>pushes
+	perl -e '
+		my $n = shift;
+		while (<>) {
+			last unless @commits < $n;
+			push @commits, $_ if $. % 5 == 1;
+		}
+		print reverse @commits;
+	' "$1" >pushes
 
 	# create base packfile
 	head -n 1 pushes |
-- 
2.30.0.759.g69d54d14a7

