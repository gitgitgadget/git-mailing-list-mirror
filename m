Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77674C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510D8223BE
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FqZgYYCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgFSWvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:51:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39746 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729716AbgFSWvg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 18:51:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 65E9060A67;
        Fri, 19 Jun 2020 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592607094;
        bh=XDT8JqlrKYZAZ5ln7hANMpFRbcqJsRJdQRDYIzoT3Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FqZgYYCPVcfT60hknpaxMQcuF53HK+PL3MY6jAyV7mxy7UQfgzMzdXczhXbvbDP4r
         JahAP90Qy2dZBSdsiHkpsZ9Y2uB1sf6GibJAcqRzQlTNeAaySzNZl0kpssXGhdiydz
         a0gi4gdl4/8SSCO0h/+gZSS7aZTnh9TEI+Na/XVz1Es3+61v1VXhhpBh+ZUWp3OLuH
         UZRYB0HS8ZsOhIb+QsozSbid6WGX2jjj7YLpXgqBh+TEpiHJiySGG3/VLiBJqXLpYI
         V+SBiX/443DIFQrKEi7HfbAoLBdZQb2LwfxgAPkQH0CdL/xsAhDowHxZs1N5eViu2T
         w7hMDs0Du8rCrPWYCJhJ0nZpU1F3Sa+ZOwc8JxZL124RUsggXVe1l0DYIotGw1FbKs
         7PuP0L47eXdC80Yb/YGRSQmgfCL8IFwt+RRmoqw2SOu3eV606Id7EKwdZAQM1LGdnd
         oKpfeFWfi2kqwoxwjWVkOgVD5lXNAwCky8gY4/4bJMa1/8+CSeK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 07/14] t/lib-git-svn: make hash size independent
Date:   Fri, 19 Jun 2020 22:39:40 +0000
Message-Id: <20200619223947.947067-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
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
 t/lib-git-svn.sh | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 7d248e6588..4780b45337 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -78,29 +78,30 @@ maybe_start_httpd () {
 }
 
 convert_to_rev_db () {
-	perl -w -- - "$@" <<\EOF
-use strict;
+	perl -w -e "use strict; my \$oidlen = $(test_oid rawsz);" -e '
 @ARGV == 2 or die "usage: convert_to_rev_db <input> <output>";
-open my $wr, '+>', $ARGV[1] or die "$!: couldn't open: $ARGV[1]";
-open my $rd, '<', $ARGV[0] or die "$!: couldn't open: $ARGV[0]";
+my $record_size = $oidlen + 4;
+my $hexlen = $oidlen * 2;
+open my $wr, "+>", $ARGV[1] or die "$!: couldn'\''t open: $ARGV[1]";
+open my $rd, "<", $ARGV[0] or die "$!: couldn'\''t open: $ARGV[0]";
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
 	print $wr $c,"\n" or die $!;
 }
 close $wr or die $!;
-close $rd or die $!;
-EOF
+close $rd or die $!;' \
+	-- "$@"
 }
 
 require_svnserve () {
