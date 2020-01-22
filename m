Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BECEC33CA1
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 03:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A3321835
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 03:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BAuJPSj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAVDp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:45:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44120 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728900AbgAVDpz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Jan 2020 22:45:55 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EAED6607F9;
        Wed, 22 Jan 2020 03:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579664754;
        bh=jkT/L4fUuUBg0LoLEkZFL7jJu13AcBppWImCtAe4Kyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BAuJPSj5zTl6HTVkzEXBHW8byc5dvznQJ7sfYHgjc9bL4hART52dfYT0yfaYpBtUX
         Q8TO0FpEXeF/gzDzTXQd9DVNdODrzKuKbPJICp1+EubTnBvMByyeMzzKfhd28PcRT3
         HeeENdnohTEyyKArd/2cAF+tt5C9kij7RJBDFfnUuFOVNXum12WWa77jPHfbGQR4Gf
         NU7Gwovvg8Y05rmLskE72ApwiGjSL3Hrdqx8CNsK6SG0jIZayK9aHGiEgmjHuVn8P2
         aDjydck6XwUH3QBK2I21Lhyk2mXiGfkd1MD8Z+3NOi9rbkt9qBoCjvgP5sAlHdlGCT
         XT3EmrshbZPSWp3mDnGZUfx8tWrKWQq9qSwgH/OF7N8eojDBeAZwhhNQATFGaClMR4
         wYyBvkADDG0iD+iO9JZ1c0HvOegBZ/0rgV5vIS/4QrmeWU7L3t3ZAQM5XViuBlo9v9
         6dDzjybMgl+zFi2F5MUbAtzWZ7M6kBX4RiCWFVF2kD42A19jwKa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 4/5] doc: dissuade users from trying to ignore tracked files
Date:   Wed, 22 Jan 2020 03:45:42 +0000
Message-Id: <20200122034543.18927-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
In-Reply-To: <20200122034543.18927-1-sandals@crustytoothpaste.net>
References: <20200122034543.18927-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is quite common for users to want to ignore the changes to a file
that Git tracks.  Common scenarios for this case are IDE settings and
configuration files, which should generally not be tracked and possibly
generated from tracked files using a templating mechanism.

However, users learn about the assume-unchanged and skip-worktree bits
and try to use them to do this anyway.  This is problematic, because
when these bits are set, many operations behave as the user expects, but
they usually do not help when git checkout needs to replace a file.

There is no sensible behavior in this case, because sometimes the data
is precious, such as certain configuration files, and sometimes it is
irrelevant data that the user would be happy to discard.

Since this is not a supported configuration and users are prone to
misuse the existing features for unintended purposes, causing general
sadness and confusion, let's document the existing behavior and the
pitfalls in the documentation for git update-index so that users know
they should explore alternate solutions.

In addition, let's provide a recommended solution to dealing with the
common case of configuration files, since there are well-known
approaches used successfully in many environments.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-update-index.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index c7a6271daf..1489cb09a0 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -549,6 +549,22 @@ The untracked cache extension can be enabled by the
 `core.untrackedCache` configuration variable (see
 linkgit:git-config[1]).
 
+NOTES
+-----
+
+Users often try to use the assume-unchanged and skip-worktree bits
+to tell Git to ignore changes to files that are tracked.  This does not
+work as expected, since Git may still check working tree files against
+the index when performing certain operations.  In general, Git does not
+provide a way to ignore changes to tracked files, so alternate solutions
+are recommended.
+
+For example, if the file you want to change is some sort of config file,
+the repository can include a sample config file that can then be copied
+into the ignored name and modified.  The repository can even include a
+script to treat the sample file as a template, modifying and copying it
+automatically.
+
 SEE ALSO
 --------
 linkgit:git-config[1],
