Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556B6C4332F
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 19:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbhLATaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:30:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:41302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233978AbhLAT30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 14:29:26 -0500
Received: (qmail 17343 invoked by uid 109); 1 Dec 2021 19:26:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Dec 2021 19:26:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9654 invoked by uid 111); 1 Dec 2021 19:26:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Dec 2021 14:26:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Dec 2021 14:26:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 4/6] refs: add REF_SKIP_REFNAME_VERIFICATION flag
Message-ID: <YafMS6qI+6t6SOtg@coredump.intra.peff.net>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
 <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
 <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
 <xmqqbl224k09.fsf@gitster.g>
 <CAFQ2z_M35tbF6+C2MkMRm7hO8CNdUSrGTcx+8Os348+rHu4ojg@mail.gmail.com>
 <xmqqh7bs177v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7bs177v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 01, 2021 at 11:00:04AM -0800, Junio C Hamano wrote:

> > The test helper takes the flag as an argument, in decimal. If you look
> > for 2048, you should find it.
> 
> Awful---when the symbolic constants change in the code, the test
> will silently break?

Agreed, this is quite nasty.

> It has been this way since 80f2a609 (t/helper: add test-ref-store to
> test ref-store functions, 2017-03-26), so it is nothing new, but at
> some point, we should do a better job.  Even if it is used only as a
> tool for testing, we shouldn't have to force developers to write in
> assembly ;-)

Sort of. The code to pass the flags was added then, but nobody was using
it until now.

At least for ref updates. Symref creation allowed "1" for force, but
that is a true boolean. It looks like some pack-refs calls pass "3" for
PACK_REFS_PRUNE|PACK_REFS_ALL.

So it may be considered a "new" issue in that sense.

> Perhaps when the dust settles after this series graduates to be a
> part of released version.  It may be a good bite-sized microproject
> material for aspiring new developers.

It is annoying to have to plumb through the names of the flags, but in
practice I don't think we need all (or even most) of them. And it's
equally annoying not to be able to grep for the flags. I already had a
hard enough time just grepping for the callers, and resorted to:

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 3986665037..1b7a124a86 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -271,6 +271,8 @@ int cmd__ref_store(int argc, const char **argv)
 	const char *func;
 	struct command *cmd;
 
+	trace_argv_printf(argv, "trace: test-tool:");
+
 	setup_git_directory();
 
 	argv = get_store(argv + 1, &refs);

to find them.

-Peff
