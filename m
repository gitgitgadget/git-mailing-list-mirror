Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940A7C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719E921527
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DO4jS+4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436564AbgFSR5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39446 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404581AbgFSR4h (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:37 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1788660A6E;
        Fri, 19 Jun 2020 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589391;
        bh=wSBvyjey21gbVX/7xAGCthcffF4q4jyfM63IKoHZXnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DO4jS+4L1L/AxhqgRdZNxA8SngmpyMRCmbEPNBvAULIlQJS86l5YMlT+vL0CxmOV9
         T6ODUVefOlfEyS8idxE1P3UshNcm52xd0lku12lzzgimFwBXslpvPw8FoIunMROl5p
         BQDpzHZe00eGiZUgD/HEuXNPU18Oyc7yAiHO1+reElcerWQ9+GoZZV7xeCr8ul2paj
         2vlEMeiLVhoUpLIBJvasxsLdwEZueDAJ7kUKexByQRRoYc2W4KGzU8Ig6tToloix59
         Xg8OO+M/GhgtfXJLcZxc0QX8KbWgNjmGhh9GeTOsx6+8oIr4UWhuku0Pb9DmN9GFCh
         sgiUih7qpNCOl+v3KAPQKTaVl/StFOUSQkoRRi2urZ7W4BMs+q7MwKqabZISXS2IOo
         bpgVhQXZRHBlj33ASp+Y34X4XEzM/LME8OqZUTinSaOso8Jv5aBWt2HKgg1B2s1oqH
         zygVwu+I5H2vWTWtSU+DhqthEcCoFFCTCt2qOBVXfav/jTuvBM2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 35/44] builtin/index-pack: add option to specify hash algorithm
Date:   Fri, 19 Jun 2020 17:55:52 +0000
Message-Id: <20200619175601.569856-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git index-pack is usually run in a repository, but need not be. Since
packs don't contains information on the algorithm in use, instead
relying on context, add an option to index-pack to tell it which one
we're using in case someone runs it outside of a repository.  Since
using --stdin necessarily implies a repository, don't allow specifying
an object format if it's provided to prevent users from passing an
option that won't work.  Add documentation for this option.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-index-pack.txt | 8 ++++++++
 builtin/index-pack.c             | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index d5b7560bfe..9316d9a80b 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -93,6 +93,14 @@ OPTIONS
 --max-input-size=<size>::
 	Die, if the pack is larger than <size>.
 
+--object-format=<hash-algorithm>::
+	Specify the given object format (hash algorithm) for the pack.  The valid
+	values are 'sha1' and (if enabled) 'sha256'.  The default is the algorithm for
+	the current repository (set by `extensions.objectFormat`), or 'sha1' if no
+	value is set or outside a repository.
++
+This option cannot be used with --stdin.
+
 NOTES
 -----
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7bea1fba52..f865666db9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1667,6 +1667,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	unsigned char pack_hash[GIT_MAX_RAWSZ];
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
 	int report_end_of_input = 0;
+	int hash_algo = 0;
 
 	/*
 	 * index-pack never needs to fetch missing objects except when
@@ -1760,6 +1761,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					die(_("bad %s"), arg);
 			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
 				max_input_size = strtoumax(arg, NULL, 10);
+			} else if (skip_prefix(arg, "--object-format=", &arg)) {
+				hash_algo = hash_algo_by_name(arg);
+				if (hash_algo == GIT_HASH_UNKNOWN)
+					die(_("unknown hash algorithm '%s'"), arg);
+				repo_set_hash_algo(the_repository, hash_algo);
 			} else
 				usage(index_pack_usage);
 			continue;
@@ -1776,6 +1782,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		die(_("--fix-thin cannot be used without --stdin"));
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
+	if (from_stdin && hash_algo)
+		die(_("--object-format cannot be used with --stdin"));
 	if (!index_name && pack_name)
 		index_name = derive_filename(pack_name, "idx", &index_name_buf);
 
