Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE25C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 06:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDRGtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 02:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDRGtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 02:49:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98846187
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 23:48:49 -0700 (PDT)
Received: (qmail 2845 invoked by uid 109); 18 Apr 2023 06:48:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 06:48:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31486 invoked by uid 111); 18 Apr 2023 06:48:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 02:48:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 02:48:46 -0400
From:   Jeff King <peff@peff.net>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     git@vger.kernel.org, Jaydeep P Das <jaydeepjd.8914@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: gpg-related crash with custom formatter (BUG:
 gpg-interface.c:915: invalid trust level requested -1)
Message-ID: <20230418064846.GA1414@coredump.intra.peff.net>
References: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 08:12:03AM +0200, Rolf Eike Beer wrote:

> When I now run "git log" in a repository that contains commits signed by 
> people not in my keyring (e.g. the Gentoo git) I get this backtrace:
> 
> BUG: gpg-interface.c:915: invalid trust level requested -1

Thanks for giving an example repo. After cloning:
 
  https://anongit.gentoo.org/git/repo/gentoo.git

I can reproduce just by running "git log -1 --format=%GT". Bisecting
turns up 803978da49 (gpg-interface: add function for converting trust
level to string, 2022-07-11), which is not too surprising.

Before that we returned an empty string. I don't know if the fix is a
simple as:

diff --git a/gpg-interface.c b/gpg-interface.c
index aceeb08336..edb0da1bda 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -934,7 +934,10 @@ const char *gpg_trust_level_to_str(enum signature_trust_level level)
 {
 	struct sigcheck_gpg_trust_level *trust;
 
-	if (level < 0 || level >= ARRAY_SIZE(sigcheck_gpg_trust_level))
+	if (level < 0)
+		return "";
+
+	if (level >= ARRAY_SIZE(sigcheck_gpg_trust_level))
 		BUG("invalid trust level requested %d", level);
 
 	trust = &sigcheck_gpg_trust_level[level];

which restores the original behavior, or if the original was papering
over another bug (e.g., should this be "undefined"?). Certainly the
empty string matches other placeholders like %GS for this case (since we
obviously don't know anything about the signer).

+cc folks who worked on 803978da49.

-Peff
