Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79F520AC5
	for <e@80x24.org>; Sat, 21 Jan 2017 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbdAUV7p (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 16:59:45 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38710 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751415AbdAUV7j (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 16:59:39 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D01B7280AE;
        Sat, 21 Jan 2017 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485035965;
        bh=TZ12WEjEZgtEpuS5mFGueQUFhYCsnNdv4jSKrSQnaa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Pamwk5+kl+MSd5enr0WQn71PgO1C/KQxoc1cyUyjlmhCbFQvRWIn0E5L4L5c63l6
         2DoHffFqXmAZChOpL0doKhW0i5kFpFwDOYva/jPHqWImoNnosrFG5UBa+m42jIolhi
         YTjQLC0vnPpiPrfZ1v6ewBKtXYnA2B1SJsxR2OCIiMPZpmabnSHi7DB/mO9VaKTlG0
         UAlVAoPV8Z6o14yS6KXIRlcG5UvTF+on+7LsNa8nVHj0LvcDkRFi3ZPKWxyxXms06x
         tNtdoGcSbHh513XOZ5b1FvJB23up6RiKiIU/JoIcctJm+2a6ex4QkysYTvm9wMbwte
         f8avX3Fay/ohF1FjeuVbsfmCqyEOLIa1/pGdcVUWXGfQ2wh61UpTDjmJANqmcz8Xl0
         MiOL0MH+qARNJk+tznxA+x3Mq9/95FbUqSEBfhkSWQIMnvGXXC5Gl+BFuZQZi7FS6I
         ueFVJSYk4PPjtqaNUVVtHlD6FsJhlZDs2TzABTneIJIYyY+AYsP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH 2/7] Documentation: modernize cat-texi.perl
Date:   Sat, 21 Jan 2017 21:59:07 +0000
Message-Id: <20170121215912.246691-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170121215912.246691-1-sandals@crustytoothpaste.net>
References: <20170121215912.246691-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good style for Perl includes using the strict and warnings pragmas, and
preferring lexical file handles over bareword file handles.  Using
lexical file handles necessitates being explicit when $_ is printed, so
that Perl does not get confused and instead print the glob ref.

The benefit of this modernization is that a formerly obscured bug is now
visible, which will be fixed in a followup patch.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/cat-texi.perl | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index b1fe52e8b..1bc84d3c7 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -1,9 +1,12 @@
 #!/usr/bin/perl -w
 
+use strict;
+use warnings;
+
 my @menu = ();
 my $output = $ARGV[0];
 
-open TMP, '>', "$output.tmp";
+open my $tmp, '>', "$output.tmp";
 
 while (<STDIN>) {
 	next if (/^\\input texinfo/../\@node Top/);
@@ -13,9 +16,9 @@ while (<STDIN>) {
 	}
 	s/\(\@pxref\{\[(URLS|REMOTES)\]}\)//;
 	s/\@anchor\{[^{}]*\}//g;
-	print TMP;
+	print $tmp $_;
 }
-close TMP;
+close $tmp;
 
 printf '\input texinfo
 @setfilename gitman.info
@@ -34,10 +37,10 @@ for (@menu) {
 	print "* ${_}::\n";
 }
 print "\@end menu\n";
-open TMP, '<', "$output.tmp";
-while (<TMP>) {
+open $tmp, '<', "$output.tmp";
+while (<$tmp>) {
 	print;
 }
-close TMP;
+close $tmp;
 print "\@bye\n";
 unlink "$output.tmp";
