Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EEAC433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E50720767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0fW1JbQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbgFVSEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39990 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730329AbgFVSEg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 49EF860A67;
        Mon, 22 Jun 2020 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849070;
        bh=YpC9mCELaC60Sj+3WlcVzyOVoGz2YB+ad2YkjK6/c90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0fW1JbQCgjr2hSwFCUTpemkezGF+Zhn4hwK/S26+eaeDWWIp66MuO6MecUPJVrFSa
         QTWoVpajSSqc7NGYR1cqrRUtBy4hIpqSrVP/0koyS23b13cyoVAluGUGfo6piL05hs
         gcpJoeQrnYIDs7ydljXYoe9ppEPt+HkoMnW5glQNKue64piXJkm8Q7ev+3CuFdaI7g
         IB9M+4DsOt1rj91uN6XQe/2h1F0I+KbAX5hyv/ndk7seg6PDPvdwj+q+NdjmCJ+Q5Y
         1S4Rj70D5mAhStvV16PQpD32Jpv7xgOQF5+39KM65C0eq3s04jhxvm1eNIadsnOG3b
         V4iUDbnUBKxGkVIPlk26HIBRysXsBMCDGLIoUwUPLnUFvWKhsi7PC0wO8krnNSRjai
         WWsWwCCWpZtAtQ4dQIK6PaFCFtMjnlZW8BHLLaNZyngjxzAUD0V0SmFTezdv/hjMfV
         d5Awbg3PntyOsX5kFi1Qe4cGDgg1EMtD0FHJMZ1qq2So90S/JkW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/14] git-svn: set the OID length based on hash algorithm
Date:   Mon, 22 Jun 2020 18:04:15 +0000
Message-Id: <20200622180418.2418483-12-sandals@crustytoothpaste.net>
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

When reading the configuration or when creating a new repository, load
the extensions.objectFormat value and set the object ID length to 64 if
it's "sha256".  Note that we use the hex length in git-svn because most
of our processing is done on hex values, not binary ones.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-svn.perl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git-svn.perl b/git-svn.perl
index 00276c051b..58f5a7ac8f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -500,6 +500,7 @@ sub do_git_init_db {
 		command_noisy('config', "$pfx.preserve-empty-dirs", 'true');
 		command_noisy('config', "$pfx.placeholder-filename", $$fname);
 	}
+	load_object_format();
 }
 
 sub init_subdir {
@@ -1977,9 +1978,15 @@ sub read_git_config {
 			}
 		}
 	}
+	load_object_format();
 	delete @$opts{@config_only} if @config_only;
 }
 
+sub load_object_format {
+	chomp(my $hash = `git config --get extensions.objectformat`);
+	$::oid_length = 64 if $hash eq 'sha256';
+}
+
 sub extract_metadata {
 	my $id = shift or return (undef, undef, undef);
 	my ($url, $rev, $uuid) = ($id =~ /^\s*git-svn-id:\s+(.*)\@(\d+)
