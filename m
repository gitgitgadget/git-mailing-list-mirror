Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C84AC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D2D20776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aeE7cA3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404635AbgFSR4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404364AbgFSR4a (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4A38D60A74;
        Fri, 19 Jun 2020 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589384;
        bh=5tWITec1XvUpGU34jbqxhafBFLo7Ap2izOu3L993MKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=aeE7cA3cOEvGP+cwwYgJvP01wCXIVf0MDtD2KxyY4aTYxXPk0y+z8xRTCCPOnuFy2
         9HCnZWPWDCS9ku28FVbQTm5JEOYks7iymOmtXsq35A5jRtZ+WaDnXZqKcCerZ/UnF4
         tJn5b0wsmhr9lUWd5/1QVZEV4O1yTNl4Zy0Nvw4feGkcEnIDbo5fVoPd13rV0g8DYf
         1fdiN4qk8NPQ8HnopH4odwlCVBr2xuMM2DNkn9zB50GtjtXiYnRvXlR24JJ6RdJNlR
         +3ga7xa3xLjPedzV+hAtIe+g9i8hxZTBlzR3TbYxSklK7BFCYnjVMypDh+gUME2wXd
         dqDu52cEbuzfoRG5gOcss5CWlRqjjYYh92c8Rdo/R+sZRNSejPY3SEjUDmB2O+52lv
         2VDQqImOdEI9z39rGOZS9uPfnIJbouWgMpf4VGvRFSdrW+nhjFwaWlZca4wdXCTuHX
         znYjDhboPODNzQKhMTocEo5cnORcX1LuaEEpGAgtewMZPzeNfDT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 22/44] setup: set the_repository's hash algo when checking format
Date:   Fri, 19 Jun 2020 17:55:39 +0000
Message-Id: <20200619175601.569856-23-sandals@crustytoothpaste.net>
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

When we're checking the repository's format, set the hash algorithm at
the same time.  This ensures that we perform a suitable initialization
early enough to avoid confusing any parts of the code.  If we defer
until later, we can end up with portions of the code which are confused
about the hash algorithm, resulting in segfaults when working with
SHA-256 repositories.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index 65fe5ecefb..019a1c6367 100644
--- a/setup.c
+++ b/setup.c
@@ -1273,6 +1273,7 @@ void check_repository_format(struct repository_format *fmt)
 		fmt = &repo_fmt;
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
+	repo_set_hash_algo(the_repository, fmt->hash_algo);
 	clear_repository_format(&repo_fmt);
 }
 
