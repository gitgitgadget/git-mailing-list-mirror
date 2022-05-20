Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118B7C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 11:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348758AbiETLxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 07:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbiETLxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 07:53:52 -0400
Received: from hrbata.com (hrbata.com [109.123.216.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4600C2EA24
        for <git@vger.kernel.org>; Fri, 20 May 2022 04:53:50 -0700 (PDT)
Received: from localhost (ip-89-102-24-184.net.upcbroadband.cz [89.102.24.184])
        by hrbata.com (Postfix) with ESMTPSA id 74FBA44CDE;
        Fri, 20 May 2022 13:53:49 +0200 (CEST)
Date:   Fri, 20 May 2022 13:53:49 +0200
From:   Frantisek Hrbata <frantisek@hrbata.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] transport: remove unnecessary indenting in
 transport_push()
Message-ID: <YoeBTeJOCbP449BW@fedora>
Reply-To: Frantisek Hrbata <frantisek@hrbata.com>
References: <20220520081723.1031830-1-frantisek@hrbata.com>
 <20220520103507.1717236-1-frantisek@hrbata.com>
 <20220520103507.1717236-2-frantisek@hrbata.com>
 <220520.86y1yw1lxj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220520.86y1yw1lxj.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2022 at 01:24:28PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, May 20 2022, Frantisek Hrbata wrote:
> 
> > Remove the big indented block for push_refs() check in transport vtable
> > and let's just return error immediately. Hopefully this makes the code
> > more readable.
> 
> s/push_refs/transport_push/, push_refs is the name of the field in the
> callback (and there's more than just this function).

uf, I will fix that, thank you for noticing.

> 
> This looks good to me....
> 
> > Is there a reason to return 1 instead of -1 when push_refs() is not
> > set in transport vtable? Looking at the code I think it might return
> > -1 also and make it more consistent.
> 
> No, looking at it (I tried renaming the function) the only user is
> builtin/push.c, which we can easily see doesn't care about the 1 v.s. -1 here.
> 
> Perhaps it's worthwhile to add this in-between the two patches you have:
> 	
> 	diff --git a/transport.c b/transport.c
> 	index 0b9c5a427d7..5348fac36ef 100644
> 	--- a/transport.c
> 	+++ b/transport.c
> 	@@ -1283,22 +1283,23 @@ int transport_push(struct repository *r,
> 	 	int quiet = (transport->verbose < 0);
> 	 	int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
> 	 	int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
> 	-	int push_ret, ret, err;
> 	+	int push_ret, err;
> 	+	int ret = -1;
> 	 	struct transport_ls_refs_options transport_options =
> 	 		TRANSPORT_LS_REFS_OPTIONS_INIT;
> 	 
> 	 	*reject_reasons = 0;
> 	 
> 	 	if (transport_color_config() < 0)
> 	-		return -1;
> 	+		goto done;
> 	 
> 	 	if (!transport->vtable->push_refs)
> 	-		return 1;
> 	+		goto done;
> 	 
> 	 	local_refs = get_local_heads();
> 	 
> 	 	if (check_push_refs(local_refs, rs) < 0)
> 	-		return -1;
> 	+		goto done;
> 	 
> 	 	refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
> 	 
> 	@@ -1319,7 +1320,7 @@ int transport_push(struct repository *r,
> 	 		match_flags |= MATCH_REFS_FOLLOW_TAGS;
> 	 
> 	 	if (match_push_refs(local_refs, &remote_refs, rs, match_flags))
> 	-		return -1;
> 	+		goto done;
> 	 
> 	 	if (transport->smart_options &&
> 	 	    transport->smart_options->cas &&
> 	@@ -1333,7 +1334,7 @@ int transport_push(struct repository *r,
> 	 
> 	 	if (!(flags & TRANSPORT_PUSH_NO_HOOK))
> 	 		if (run_pre_push_hook(transport, remote_refs))
> 	-			return -1;
> 	+			goto done;
> 	 
> 	 	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
> 	 		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
> 	@@ -1417,6 +1418,7 @@ int transport_push(struct repository *r,
> 	 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
> 	 		fprintf(stderr, "Everything up-to-date\n");
> 	 
> 	+done:
> 	 	return ret;
> 	 }
> 
> Which would make your new 3/3 truly trivial, i.e. just adding the
> free_refs() for the two.

I was thinking about this too. Just use the done label as a single exit point.
Let me incorporate your suggestions in v3. I will add a 2/3 patch e.g.
"unify return values and exit point for transport_push()"

> 
> *Maybe* (but probably not) it would then make sense to do this as that 3/3:
> 	
> 	diff --git a/transport.c b/transport.c
> 	index 5348fac36ef..d4952bf5f6a 100644
> 	--- a/transport.c
> 	+++ b/transport.c
> 	@@ -1291,15 +1291,17 @@ int transport_push(struct repository *r,
> 	 	*reject_reasons = 0;
> 	 
> 	 	if (transport_color_config() < 0)
> 	-		goto done;
> 	+		return ret;
> 	 
> 	 	if (!transport->vtable->push_refs)
> 	-		goto done;
> 	+		return ret;
> 	 
> 	 	local_refs = get_local_heads();
> 	 
> 	-	if (check_push_refs(local_refs, rs) < 0)
> 	+	if (check_push_refs(local_refs, rs) < 0) {
> 	+		remote_refs = NULL;
> 	 		goto done;
> 	+	}
> 	 
> 	 	refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
> 	 
> 	@@ -1419,6 +1421,8 @@ int transport_push(struct repository *r,
> 	 		fprintf(stderr, "Everything up-to-date\n");
> 	 
> 	 done:
> 	+	free_refs(local_refs);
> 	+	free_refs(remote_refs);
> 	 	return ret;
> 	 }
> 
> I.e. entirely skip the NULL assignment for the two, which helps the
> compiler catch if we don't init it before the later goto's, but because
> of that we'd need to "return" instead of "goto done" for the early ones,
> and set it for the check_push_refs() failure case.
> 
> So nah, probably best just to keep it as you have it, i.e. always "goto
> done".

I agree. Let me prepare v3 and let's see what happens :)

Thank you for your input!

-- 
Frantisek Hrbata
