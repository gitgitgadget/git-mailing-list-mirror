Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDD2C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CFA20767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pzV2hQNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgFVSEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40018 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730204AbgFVSE3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:29 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0560D60A62;
        Mon, 22 Jun 2020 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849068;
        bh=yQOdB7S15WUWZTux2ZQssAlHBbgqcss0fLvq+Q0HWZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=pzV2hQNQFRzxKWltnOQMV22kphvuC7P0zTy4CeLdouG5/2hF8ElxNMLD8pYgzKtyL
         8OZLG3AZl2Zvq5yd2B3V1fU4sx/zvX4FuGulL+NHdyGBNSmar1D2Y95F38A4KKInOo
         jLD2jYzsXJNRKLjrxk1dGjgTS3XvkWF7yFn7ItXa1qV4JcMHgnhYLEmWmgXngeZ4jY
         Wh1aiZA1lGVMKPsRGD8WWLwur0T9WgvyGsynQE+1T+VbOTJ1NqyZUAtNgGstyMvAjd
         6BBhQRujnS2ALUBMXucRPEpBmZvGAt6ryU/AcrmvMNKbCSnrrxRqHv9xbLtCCl/8Al
         deWW6fexDzYUUR5JqU8L3qTZvlUvnPC/bimMnmIp/8vWvwChNyF/UhEX/g0EWMLyP1
         KLfYyGWjnhlbo39cIROM7AjQYakuaa57CPKu5RPTuZgM7OVPD8b6bPBGzUaB0sZzfm
         tEApFWfnGjAdqbXu8MKgYR76hx0mRJOgJby0uQaVOq0GCSSVnAX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/14] t/lib-git-svn: make hash size independent
Date:   Mon, 22 Jun 2020 18:04:11 +0000
Message-Id: <20200622180418.2418483-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200622180418.2418483-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The record size used in the git svn storage is four bytes plus the
length of the binary hash.  Pass the hash length into our Perl
invocation and use it to compute the size of the records.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/lib-git-svn.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 7d248e6588..547eb3c31a 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -78,21 +78,24 @@ maybe_start_httpd () {
 }
 
 convert_to_rev_db () {
-	perl -w -- - "$@" <<\EOF
+	perl -w -- - "$(test_oid rawsz)" "$@" <<\EOF
 use strict;
+my $oidlen = shift;
 @ARGV == 2 or die "usage: convert_to_rev_db <input> <output>";
+my $record_size = $oidlen + 4;
+my $hexlen = $oidlen * 2;
 open my $wr, '+>', $ARGV[1] or die "$!: couldn't open: $ARGV[1]";
 open my $rd, '<', $ARGV[0] or die "$!: couldn't open: $ARGV[0]";
 my $size = (stat($rd))[7];
-($size % 24) == 0 or die "Inconsistent size: $size";
-while (sysread($rd, my $buf, 24) == 24) {
-	my ($r, $c) = unpack('NH40', $buf);
-	my $offset = $r * 41;
+($size % $record_size) == 0 or die "Inconsistent size: $size";
+while (sysread($rd, my $buf, $record_size) == $record_size) {
+	my ($r, $c) = unpack("NH$hexlen", $buf);
+	my $offset = $r * ($hexlen + 1);
 	seek $wr, 0, 2 or die $!;
 	my $pos = tell $wr;
 	if ($pos < $offset) {
-		for (1 .. (($offset - $pos) / 41)) {
-			print $wr (('0' x 40),"\n") or die $!;
+		for (1 .. (($offset - $pos) / ($hexlen + 1))) {
+			print $wr (('0' x $hexlen),"\n") or die $!;
 		}
 	}
 	seek $wr, $offset, 0 or die $!;
