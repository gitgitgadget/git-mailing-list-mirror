Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF02C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ABF21835
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NHLkymBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgATRd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:33:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43064 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726901AbgATRd6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 12:33:58 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06E74607F9;
        Mon, 20 Jan 2020 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579541637;
        bh=rhmLjLgtyq004uiUI7nuRf9N8VdVrjqa9NeFXc2rSrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NHLkymBFt+W9OcSsiOdcRMbori8zs59/WGCTEvUaiLg3osBp7A/a2nf0zw5a/gemN
         idGYWGM3ABXDHjk+14XHA0Ux2rykdZyhGai987V5hhpaopRqgCZQlEuTGR7Uv8xAds
         CkkOUkCBVOxa5zmtHqvImb0qekz3PdJO/R/3xvBXimoGWqmiM48h9iNx7HUjtSRgqq
         ADYb6ReQvfjxlWLqgAtrWrb1ekIJwHqFJQ6jkr22hHgMJbhikAW0joiTzRunaM1GY4
         vgNf7fQBmJfPtMlwY6pkqKRs95CKtiZKJeXwZP5HKarr+7CIBXG132qutM/y0PX/Hh
         I0W2UzHa+ibBxfkB6PJlxNiBMo49KSUW40s1rdnTQ0ZMOqgxMP/p9waaEOLNY9yFEV
         PKwdKo/zzreiYNBpru4RG2ziMwzZzElrvBTaik/vqw58SdCbpe+Rq2+LGuWipqA37K
         /IRLH0bDcHglDpQ/9GVO6DMs5uIZQRQ+WG5y5WyoXy00Z7DoZ2C
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v4 4/5] doc: dissuade users from trying to ignore tracked files
Date:   Mon, 20 Jan 2020 17:33:42 +0000
Message-Id: <20200120173343.4102954-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
In-Reply-To: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
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

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---

Peff, since I've adopted a significant portion of what you've said here,
it's probably worth getting your sign-off on this patch.

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
