Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2232C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865972177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 09:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHGJck (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:32:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:51562 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgHGJck (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 05:32:40 -0400
Received: (qmail 30415 invoked by uid 109); 7 Aug 2020 09:32:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 09:32:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12339 invoked by uid 111); 7 Aug 2020 09:32:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 05:32:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 05:32:39 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: fix interleaving hook calls with
 reference-transaction hook
Message-ID: <20200807093239.GA1228157@coredump.intra.peff.net>
References: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
 <20200807075837.GA32344@coredump.intra.peff.net>
 <20200807090412.GA1407904@tanuki.pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807090412.GA1407904@tanuki.pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 11:04:12AM +0200, Patrick Steinhardt wrote:

> > It's perhaps more justifiable when there isn't a hook (we're still just
> > paying that one access(), but it's proportionally bigger). I kind of
> > doubt it's measurable, though, since a ref write requires a bunch of
> > syscalls anyway.
> 
> Yeah, this really was done to not have to pay a performance penalty if
> updating thousands of refs if no reference-transaction hook exists. E.g.
> if doing a non-atomic push of n reference, we'd have n calls to
> access(3P). See [1] for reference.
> 
> I've just did another quick benchmark without the cache, and it still
> consistently shows a non-zero performance hit without it:
> 
> Test                         pks-reftx-hook-interleaving   no-cache
> --------------------------------------------------------------------------------
> 1400.2: update-ref           2.82(2.13+0.81)               2.86(2.19+0.78) +1.4%
> 1400.3: update-ref --stdin   0.22(0.07+0.15)               0.22(0.07+0.15) +0.0%

I'm skeptical that those results are useful. In the first test, we're
running update-ref 1000 times, so:

  - the cache shouldn't be helping at all, since we only have one ref to
    update (well, I guess once for "prepare" and once for "commit", so
    really it's saving one syscall total per process).

  - I'd expect a lot of noise because we're spending most of our time in
    starting up the process

In the second test, we run 1000 ref operations per update-ref process.
So we should be cutting down on our hook-lookup overhead by a factor of
1000. Yet it shows no improvement.

That implies you're just seeing noise. And indeed, with the patch below
I get:

Test                         HEAD^             HEAD
--------------------------------------------------------------------
1400.2: update-ref           1.93(1.57+0.42)   1.91(1.55+0.42) -1.0%
1400.3: update-ref --stdin   0.07(0.02+0.05)   0.07(0.02+0.05) +0.0%

Running it a second time gets me +0.5%. :)

---
 refs.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 2dd851fe81..427bf5843c 100644
--- a/refs.c
+++ b/refs.c
@@ -2031,24 +2031,16 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-static const char hook_not_found;
-static const char *hook;
-
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
+	const char *hook = find_hook("reference-transaction");
 	int ret = 0, i;
 
-	if (hook == &hook_not_found)
-		return ret;
 	if (!hook)
-		hook = find_hook("reference-transaction");
-	if (!hook) {
-		hook = &hook_not_found;
 		return ret;
-	}
 
 	argv_array_pushl(&proc.args, hook, state, NULL);
 	proc.in = -1;
-- 
2.28.0.520.g10e2ce7e11

