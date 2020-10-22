Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B23C2D0A3
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 01:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C6C2237B
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 01:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894636AbgJVBSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 21:18:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54412 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442672AbgJVBSu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Oct 2020 21:18:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 251EB6042C;
        Thu, 22 Oct 2020 01:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1603329499;
        bh=KBxI0LwpCvSxwhUqQnajQRnmrCM131dD8skBjFrb/aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Qw671kX5LNFqSHAOSO6+2xMbkAPPcFziOviB1p7LHIFr9/SBIbPvq0K51NDsCu9WN
         Ch0iMa1tQyR7wSmsoy6nnLjldzVLgp6z4E80fQeL978zjkpsZgws7grhif7GfqXwpC
         tij+28LjN+gQvs4gFKi9kShrisykSGNz+Bckd4dWQ8Q2vQQQg6k2SvTH+1hityRoyT
         r4sdpvBR0IGKc5lafi7VeEbKzILYmdjYOfREYGm85QnW6L1Qhir+x4PWF8AavGpzTT
         3rCqpwUGpV0ynyOi6jzNN7xdFnBtY+brCUhbIy7HEFF69IRYFYHZEhM/jMQ0+J2r2C
         MRNzyIxzWPw4R3gfQzwReYogO/1hTk12yf9hij7ZUvNbdGL21IApvDLeaELOvNfyGU
         giIWdqwH15qS+d1NbkOwm4o1m6FNGGSEbvWfX9PGalzD5Xmvu/2xo/lOPJkNi26kLK
         AaAq63qF7RoKwbF89LUWKoYswVjQuCd3FoyoYXpG2Q518UGtIup
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Nikos Chantziaras <realnc@gmail.com>
Subject: [PATCH] svn: use correct variable name for short OID
Date:   Thu, 22 Oct 2020 01:18:11 +0000
Message-Id: <20201022011811.853465-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <rmpve5$q2s$1@ciao.gmane.io>
References: <rmpve5$q2s$1@ciao.gmane.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit 9ab33150a0 ("perl: create and switch variables for hash
constants", 2020-06-22) converted each instance of the variable
$sha1_short into $oid_short in the Subversion code, since git-svn now
understands SHA-256.  However, one conversion was missed.

As a result, Perl complains about the use of this variable:

  Use of uninitialized value $sha1_short in regexp compilation at
  /usr/lib64/perl5/vendor_perl/5.30.3/Git/SVN/Log.pm line 301, <$fh>
  line 6.

Because we're parsing raw diff output here, the likelihood is very low
that we'll actually misparse the data, since the only lines we're going
to get starting with colons are the ones we're expecting.  Even if we
had a newline in a path, we'd end up with a quoted path.  Our regex is
just less strict than we'd like it to be.

However, it's obviously undesirable that our code is emitting Perl
warnings, so let's convert it to use the proper variable name.

Reported-by: Nikos Chantziaras <realnc@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 perl/Git/SVN/Log.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
index 3858fcf27d..9c819188ea 100644
--- a/perl/Git/SVN/Log.pm
+++ b/perl/Git/SVN/Log.pm
@@ -298,7 +298,7 @@ sub cmd_show_log {
 			get_author_info($c, $1, $2, $3);
 		} elsif (/^${esc_color}(?:tree|parent|committer) /o) {
 			# ignore
-		} elsif (/^${esc_color}:\d{6} \d{6} $::sha1_short/o) {
+		} elsif (/^${esc_color}:\d{6} \d{6} $::oid_short/o) {
 			push @{$c->{raw}}, $_;
 		} elsif (/^${esc_color}[ACRMDT]\t/) {
 			# we could add $SVN->{svn_path} here, but that requires
