Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E082022A
	for <e@80x24.org>; Wed,  2 Nov 2016 18:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756807AbcKBSXE (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 14:23:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:37595 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756505AbcKBSXE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 14:23:04 -0400
Received: (qmail 8996 invoked by uid 109); 2 Nov 2016 18:23:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 18:23:03 +0000
Received: (qmail 4847 invoked by uid 111); 2 Nov 2016 18:23:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 14:23:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 14:23:01 -0400
Date:   Wed, 2 Nov 2016 14:23:01 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 4/4] t0021: fix filehandle usage on older perl
Message-ID: <20161102182301.hezruhtuhra6uoft@sigill.intra.peff.net>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rot13-filter.pl script calls methods on implicitly
defined filehandles (STDOUT, and the result of an open()
call).  Prior to perl 5.13, these methods are not
automatically loaded, and perl will complain with:

  Can't locate object method "flush" via package "IO::Handle"

Let's explicitly load IO::File (which inherits from
IO::Handle). That's more than we need for just "flush", but
matches what perl has done since:

  http://perl5.git.perl.org/perl.git/commit/15e6cdd91beb4cefae4b65e855d68cf64766965d

Signed-off-by: Jeff King <peff@peff.net>
---
I see J6t solved this a week ago using "FileHandle". These days that is
basically a compatibility synonym for IO::File. I think both should be
available pretty much everywhere, so I went with IO::File for the
reasons above. But if that doesn't work for some reason, switching to
"use FileHandle" should be OK, too.

I don't have an old enough perl easily available to test it either way.

 t/t0021/rot13-filter.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index e3ea58e1e..4d5697ee5 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -21,6 +21,7 @@
 
 use strict;
 use warnings;
+use IO::File;
 
 my $MAX_PACKET_CONTENT_SIZE = 65516;
 my @capabilities            = @ARGV;
-- 
2.11.0.rc0.258.gf434c15
