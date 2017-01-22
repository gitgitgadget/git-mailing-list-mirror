Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589971F89C
	for <e@80x24.org>; Sun, 22 Jan 2017 02:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdAVCmR (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 21:42:17 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39226 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750884AbdAVCmI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 21:42:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 03E00280AE;
        Sun, 22 Jan 2017 02:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485052926;
        bh=TZ12WEjEZgtEpuS5mFGueQUFhYCsnNdv4jSKrSQnaa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lujgnlSBdk/3wjElWmqDOv0Eg9EgYqOUVdVS5eJGq2bNI0ZY/3onOf0k7mKlxi4Wc
         Ai6jcbOxPg2K630WSUnExXW/uqQErW05N9afHjnHUNFJ1SOH7iAZHo36oID6dcStHq
         9xknvbrSCHdL9NwoqcIERatX224e/yLggmt4wGsfgL+VoYVDQuG9PUakpytrD06eB6
         ZMOR0hftfoCySw9CTsfeFgHY0nvkwGbFH4wZLTn+X2qI4Q4zpRelONEg1sKqaYlFjA
         nHMe2ps/opLorchXyoHrc+Y0n0Vpk2qMRUDyBRcKl2DXvvNnucAJwYPp6A+k4g8LPG
         SDiVZKxblNCZ2dSJswVnEzpZZ7Dj2XemCqdoWC6L0dPKVM+VQEJbz+X/b1WPNGlujB
         POalkLyETB+Qj4OHnawjuY+lncud2Xtr8syJj8DjgSCVWMMdL2mROKgY9TiThb7ZXY
         1BBlSX30QpqWlzPViVFRdplzxoMeVELC3s7MYxbikpDMvd4xZAN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 2/7] Documentation: modernize cat-texi.perl
Date:   Sun, 22 Jan 2017 02:41:51 +0000
Message-Id: <20170122024156.284180-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170122024156.284180-1-sandals@crustytoothpaste.net>
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
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
