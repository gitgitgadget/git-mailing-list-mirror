Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6DEC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8229920708
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DEHW7j/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGJCtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40466 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727070AbgGJCsn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E8B3260A6F;
        Fri, 10 Jul 2020 02:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349315;
        bh=kxZYNK6Va1MuOmXfxizmLHhju9aeB8cDRgPk/U5hImM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DEHW7j/y6+u5Mecaa3ZKfgEymF3LzueCDAhAYmzdt3ajJ/vtQHLprL2ZmoGJCDXtg
         7KlvoDaYeYLZAcKmTOsVS15JHcpdf4ga3fRBMl19lTtW4nZXzDAfIE3DW4ImKTY+DR
         vll6nsOQ7KgdhNiKlAFMOfYbjbR57+Wpn25EWCzFGfl/QF6l1Z3oOFLHjW6FOhFF9R
         UnS2iIBneatRrknuibLg6uCMh4lvFSAfNpUQe6dGgpEYRvnY/hQuUJH7HiqM1pZ4xj
         NxeqSUAHitR1bXDJxXfhkKdATHJZAFc+bCGF8bI2Xc+irneJgO3M7BD38d/RJ1zvJi
         Zpw9Z6y8ReQwPaxIiJ1lRYenzeqbelwkG6Q10nJb14ZQxC3cMhIZL1BBhzETXyVM+E
         0+qSzuvCo8zokcYMnpY4oT9VwuG6ZrjyjyePGnuoHOmgOSIvHbGAzDBK8u2Knarlrm
         tAlsytH4jCh4xr41Y1ynWlI5JCrNL4S3tL6i99+cBvSW9mD3hmP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 26/38] t9700: make hash size independent
Date:   Fri, 10 Jul 2020 02:47:16 +0000
Message-Id: <20200710024728.3100527-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Perl test script for t9700 was matching on exactly 40 hex
characters.  With SHA-256, we'll have 64 hex-character object IDs.
Create a variable with a regex which matches exactly 40 or 64 hex
characters and use that to match the output.  Note that both of the uses
of this can be anchored, which makes the code simpler, so do that as
well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9700/test.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 34cd01366f..071ff6d82a 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -23,6 +23,8 @@ sub adjust_dirsep {
 	return $path;
 }
 
+my $oid_re = qr/^[0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})?$/;
+
 BEGIN { use_ok('Git') }
 
 # set up
@@ -93,7 +95,7 @@ sub adjust_dirsep {
 open TEMPFILE, ">$tmpfile" or die "Can't open $tmpfile: $!";
 print TEMPFILE my $test_text = "test blob, to be inserted\n";
 close TEMPFILE or die "Failed writing to $tmpfile: $!";
-like(our $newhash = $r->hash_and_insert_object($tmpfile), qr/[0-9a-fA-F]{40}/,
+like(our $newhash = $r->hash_and_insert_object($tmpfile), $oid_re,
      "hash_and_insert_object: returns hash");
 open TEMPFILE, "+>$tmpfile" or die "Can't open $tmpfile: $!";
 is($r->cat_blob($newhash, \*TEMPFILE), length $test_text, "cat_blob: roundtrip size");
@@ -119,7 +121,7 @@ sub adjust_dirsep {
 
 # commands in sub directory
 my $last_commit = $r2->command_oneline(qw(rev-parse --verify HEAD));
-like($last_commit, qr/^[0-9a-fA-F]{40}$/, 'rev-parse returned hash');
+like($last_commit, $oid_re, 'rev-parse returned hash');
 my $dir_commit = $r2->command_oneline('log', '-n1', '--pretty=format:%H', '.');
 isnt($last_commit, $dir_commit, 'log . does not show last commit');
 
