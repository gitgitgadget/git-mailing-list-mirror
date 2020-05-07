Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5237AC35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2970920A8B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I5Sy/szP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEGW1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 18:27:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64600 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgEGW1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 18:27:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5151AD1E5F;
        Thu,  7 May 2020 18:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mDvL4VhU0dUHeDIP6u2QXLjjZe4=; b=I5Sy/s
        zPQiAB1Kl5GKRwhudU194wcNqwWET6VGbdUlu84XULXy6+E69vJk/TXANahYn0Qr
        SB/DfHJdl7jEKZbFO8nHVfyFIFJTQOmib9MJHWLr5Fz9BdRlZdOq9H/OzjHMJkGH
        zHw2/VNAd3cO9UjLEK8rRo6fxwC2/AJ2sFUKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uN9/lq81BXpS6wTVjqEu59QESlpbYJ4i
        DFW42BeI1bUwXkwU89r8vzJCcx9SyDxcS+lZ3+H8Db95bYoJFDXbcenQPufVDrhh
        mdYbDfZkCYjgoe03YZlUpzhyz/WLz69JYiM1zmKQSkNGdk6ato6B077NFG4TXWju
        EE6SzAm1vT4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4917AD1E5E;
        Thu,  7 May 2020 18:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90EAAD1E5D;
        Thu,  7 May 2020 18:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmaill.com, peff@peff.net,
        me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/10] unpack-trees: avoid array out-of-bounds error
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
        <5bfe3f3fc8a99b3d4fdd4286da17cd935090c614.1588857462.git.gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 15:27:28 -0700
In-Reply-To: <5bfe3f3fc8a99b3d4fdd4286da17cd935090c614.1588857462.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 07 May 2020
        13:17:33 +0000")
Message-ID: <xmqqk11n2xf3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0760D26-90B1-11EA-878F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The loop in warn_conflicted_path() that checks for the count of entries
> with the same path uses "i+count" for the array entry. However, the loop
> only verifies that the value of count is below the array size. Fix this
> by adding i to the condition.
>
> I hit this condition during a test of the in-tree sparse-checkout
> feature, so it is exercised by the end of the series.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 9a3ccd9d083..4f880f2da90 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -563,10 +563,11 @@ static int warn_conflicted_path(struct index_state *istate,
>  	add_rejected_path(o, WARNING_SPARSE_UNMERGED_FILE, conflicting_path);
>  
>  	/* Find out how many higher stage entries at same path */
> -	while (++count < istate->cache_nr &&
> +	while (i + ++count < istate->cache_nr &&
>  	       !strcmp(conflicting_path,
>  		       istate->cache[i+count]->name))
>  		/* do nothing */;

Eek.  Yes, it is obvious that the original is wrong once you point
it out.  But "i + ++count" looks like a line noise, and funny way
that lines are wrapped in the original does not help X-<.

We may want to fix the style and the grammar while we are at it,
perhaps like the attached.

In any case, thanks for a fix.

 unpack-trees.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 6bbf58d28e..c38938d96c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -562,11 +562,11 @@ static int warn_conflicted_path(struct index_state *istate,
 
 	add_rejected_path(o, WARNING_SPARSE_UNMERGED_FILE, conflicting_path);
 
-	/* Find out how many higher stage entries at same path */
-	while (++count < istate->cache_nr &&
-	       !strcmp(conflicting_path,
-		       istate->cache[i+count]->name))
-		/* do nothing */;
+	/* Find out how many higher stage entries are at same path */
+	while ((++count) + i < istate->cache_nr &&
+	       !strcmp(conflicting_path, istate->cache[count + i]->name))
+		; /* do nothing */
+
 	return count;
 }
 
