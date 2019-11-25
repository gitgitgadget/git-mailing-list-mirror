Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A52C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFF12084D
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfKYQrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:47:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:60096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728852AbfKYQrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 11:47:21 -0500
Received: (qmail 26957 invoked by uid 109); 25 Nov 2019 16:47:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Nov 2019 16:47:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19826 invoked by uid 111); 25 Nov 2019 16:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2019 11:51:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Nov 2019 11:47:20 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] t/perf: don't depend on Git.pm
Message-ID: <20191125164720.GA18080@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The perf suite's aggregate.perl depends on Git.pm, which is a mild
annoyance if you've built git with NO_PERL. It turns out that the only
thing we use it for is a single call of the command_oneline() helper.
We can just replace this with backticks or similar.

Annoyingly, perl has no backtick equivalent that avoids a shell eval,
which means our $arg would require quoting. This probably doesn't matter
for our purposes, but it's better to be safe and model good style. So
we'll just provide a short helper around open(), which takes its
arguments as a list.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/aggregate.perl | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 66554d2161..a46ef67a2b 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -4,7 +4,6 @@
 use strict;
 use warnings;
 use Getopt::Long;
-use Git;
 use Cwd qw(realpath);
 
 sub get_times {
@@ -85,6 +84,11 @@ sub format_size {
 	return $out;
 }
 
+sub sane_backticks {
+	open(my $fh, '-|', @_);
+	return <$fh>;
+}
+
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
     $codespeed, $sortby, $subsection, $reponame);
 
@@ -102,7 +106,8 @@ sub format_size {
 	my $prefix = '';
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
-		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
+		my $rev = sane_backticks(qw(git rev-parse --verify), $arg);
+		chomp $rev;
 		$dir = "build/".$rev;
 	} elsif ($arg eq '.') {
 		$dir = '.';
-- 
2.24.0.716.g722aff65ed
