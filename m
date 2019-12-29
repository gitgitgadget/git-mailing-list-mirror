Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EDBC3F68F
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDEF208E4
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 06:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfL2G21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 01:28:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:54904 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725800AbfL2G21 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 01:28:27 -0500
Received: (qmail 20873 invoked by uid 109); 29 Dec 2019 06:28:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 29 Dec 2019 06:28:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5065 invoked by uid 111); 29 Dec 2019 06:33:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2019 01:33:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Dec 2019 01:28:25 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] commit-graph: examine changed-path objects in pack
 order
Message-ID: <20191229062825.GA222211@coredump.intra.peff.net>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
 <20191222093206.GA3460818@coredump.intra.peff.net>
 <8b331ef6-f431-56ef-37a9-1d6e263ea0fe@gmail.com>
 <20191229061246.GB220034@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191229061246.GB220034@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 29, 2019 at 01:12:46AM -0500, Jeff King wrote:

> Yeah, I expected that would cover it, too. But instrumenting it to dump
> the position of each commit (see patch below), and then decorating "git
> log" output with the positions (see script below) shows that we're all
> over the map:

I forgot the patch, of course. :)

I just dumped this trace:

---
diff --git a/commit-graph.c b/commit-graph.c
index a6c4ab401e..1cb77be45f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -61,6 +61,7 @@ static void set_commit_pos(struct repository *r, const struct object_id *oid)
 	if (!commit)
 		return; /* should never happen, but be lenient */
 
+	trace_printf("pos %s = %d", oid_to_hex(oid), max_pos);
 	*commit_pos_at(&commit_pos, commit) = max_pos++;
 }
 

with:

  rm -f .git/objects/info/commit-graph
  GIT_TRACE=$PWD/trace.out git commit-graph write --changed-paths --reachable

and then used:

  cat >foo.pl <<\EOF
  #!/usr/bin/perl
  
  my %deco = do {
  	open(my $fh, '<', 'trace.out');
  	map { /pos (\S+) = (\d+)/ ? ($1 => $2) : () } <$fh>
  };
  while (<>) {
  	s/([0-9a-f]{40})/$deco{$1}/;
  	print;
  }
  EOF

like so:

  git log --graph --format=%H |
  perl foo.pl |
  less

-Peff
