Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD5FC61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCMTyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCMTyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 15:54:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C1D30B18
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:54:12 -0700 (PDT)
Received: (qmail 24001 invoked by uid 109); 13 Mar 2023 19:54:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Mar 2023 19:54:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10444 invoked by uid 111); 13 Mar 2023 19:54:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Mar 2023 15:54:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Mar 2023 15:54:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] diff: add --default-prefix option
Message-ID: <ZA9/Y6HN7y5dAy0T@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
 <xmqq5yb9q42e.fsf@gitster.g>
 <ZAr7+zW+pkOXoIfL@coredump.intra.peff.net>
 <xmqqcz5g7d2i.fsf@gitster.g>
 <ZA9SmZaUyrgbH2fb@coredump.intra.peff.net>
 <xmqqpm9cv9rb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm9cv9rb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2023 at 10:31:04AM -0700, Junio C Hamano wrote:

> > -		     "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
> > +		     "--default-prefix", "--no-renames",
> [...]
> Of course, nothing breaks without the above one-liner so it is
> somewhere between a "Meh" and a "clean-up we should do before we
> forget".

So here it is as a patch, if you want to throw it on top of
jk/format-patch-ignore-noprefix.

I have to admit that after writing the relatively weak argument in the
commit message, it does feel a bit like churn. So I am also OK to just
leave it as-is.

-- >8 --
Subject: rebase: prefer --default-prefix to --{src,dst}-prefix for format-patch

When git-rebase invokes format-patch, it wants to make sure we use the
normal prefixes, and are not confused by diff.noprefix or similar. When
this was added in 5b220a6876f (Add --src/dst-prefix to git-formt-patch
in git-rebase.sh, 2010-09-09), we only had --src-prefix and --dst-prefix
to do so, which requires re-specifying the prefixes we expect to see.
These days we can say what we want more directly: just use the defaults.

This is a minor cleanup that should have no behavior change, but
hopefully the result expresses more clearly what the code is trying to
accomplish.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d529..a47dfd45efd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -660,7 +660,7 @@ static int run_am(struct rebase_options *opts)
 	format_patch.git_cmd = 1;
 	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
 		     "--full-index", "--cherry-pick", "--right-only",
-		     "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
+		     "--default-prefix", "--no-renames",
 		     "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
 		     "--no-base", NULL);
 	if (opts->git_format_patch_opt.len)
-- 
2.40.0.572.gc7ee6f1a071

