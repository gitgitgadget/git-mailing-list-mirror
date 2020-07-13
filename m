Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DF4C43460
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80484206B6
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yMkgz3NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgGMCuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40826 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728499AbgGMCuH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:50:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ABF9460A70;
        Mon, 13 Jul 2020 02:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608576;
        bh=kxZYNK6Va1MuOmXfxizmLHhju9aeB8cDRgPk/U5hImM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yMkgz3NSip4cvwa+7cvj6BjfsKdmzu+R9cIdBJbiaIH+cGXPDu1SKYbm0NzpYndcO
         NmBFyYNtxreWdnBdoSdjUq4NOW0xPXhfFaBOdnQyxs13iejdGacle2Jr1US3+EHvgD
         qiqOeGaynXcPJe3iKXfwYLmKGfpLxmwE0jmb/tgu0OBOAShE4lE7Md1+B+OIFBxlwf
         KtkgYk/Vibbg62xghyxKVD7CPN8md43Vmi8VtkStqLHXLpPuQTDwsgMvLWnH1Yw3vH
         VxS70WuMYptcrXtmZAU05LNcW63LCdGbA/p/FdhsBprBTIaZEm6Fjv/mn0/0Vb4uzG
         IgCOc76RwI32tk75wz9zYPDvAKe0PAP/3cwQV+Ja14/SyT7qve0uOEyfDd/Ssh76lz
         iZ6/YHGNkLt6ovGPDhVzNXcZqOiLsbBLTxIoGifmD6W+BhFIU885GDI3g7K7jWOUk4
         i+Ki2a7x0v75cM/jaBYTr1jGmKUstXo9lPUI+fMu0tMI9TegzS4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 26/39] t9700: make hash size independent
Date:   Mon, 13 Jul 2020 02:48:56 +0000
Message-Id: <20200713024909.3714837-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
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
 
