Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CDC4345A
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9D72065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="to59aXG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgGZTzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40712 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727957AbgGZTyy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E74F161013;
        Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793293;
        bh=kxZYNK6Va1MuOmXfxizmLHhju9aeB8cDRgPk/U5hImM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=to59aXG/mUAkhTghrgX4oNqhh+eBdzAwoJetuBAH27aFAl5ULsibfqUOLFKwZOs+W
         eIAxroDUot0urDM2wKsTn+0jKv6cItw7rmt/a1+DvxXw6qzcH4dq8jg4c8Fcc706pq
         PqzWe7CrpXX3VdpncjH+v3sJhLxi5Up+56C/kUuY8H/XF62+/cLleeez6vsHkv/A97
         T3k+I8ZROWGHaadGZt3QhJ6mo2fKvtn3DqDehBBJTT8Ybed4W8LZAoRBEQMtuUFCrW
         g1MH1RoKdAr83p8B2lrtsl3qnlmiIW4htycm91LkeTjtdfHQyhDvjJY5jkfuZsEh47
         HmwGt8FnAzwabd02kc+7UB7jn9GXhDq/QmCWXeHH/5oQkE6VDSrz4qVRyfBhdD0E6G
         8yM7Ebzh8lwoGu0PLdGmwJ76vBWGs7aBgo6Y6GfwlDR6fcA/0AmFIJu+S8BORYQUHQ
         VKpNOLd0fLAvaSOHs51hc+XBR1xVsKx3zckSd7xfrzHwUTQKs6S
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 26/39] t9700: make hash size independent
Date:   Sun, 26 Jul 2020 19:54:11 +0000
Message-Id: <20200726195424.626969-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
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
 
