Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA34E936ED
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 23:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjJDXpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 19:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjJDXpk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 19:45:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA00C0
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 16:45:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09B301A427A;
        Wed,  4 Oct 2023 19:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=sbOE2ER9XskDr1weW6qwVNiDmR0saSYxPL8jEA
        YhV90=; b=Ua64+3wqsB1mOWVWeINK9imOFdSSwHGVAq6FARzFqCqKsa1WNJy5Hf
        9fvc+xbjlyr+R1W6Ohp9KryjzVi7d3/fXuGtSalxXBhqD56JPbhRtxM9/GlJqift
        93JOOmP2PJURE82yRqo6j1DT/BZvjiIjwEPoB2OA2nvB66zkST/kA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 018FD1A4278;
        Wed,  4 Oct 2023 19:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6414C1A4277;
        Wed,  4 Oct 2023 19:45:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/2] attr: add attr.tree for setting the treeish to
 read attributes from
In-Reply-To: <446bce03a96836f35f94e9ef8548cf4a2b041ba8.1696443502.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Wed, 04 Oct 2023 18:18:20
        +0000")
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
        <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
        <446bce03a96836f35f94e9ef8548cf4a2b041ba8.1696443502.git.gitgitgadget@gmail.com>
Date:   Wed, 04 Oct 2023 16:45:33 -0700
Message-ID: <xmqqv8bmlzoi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C866E7C-6310-11EE-95E0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: JTan CC'ed as he seems to have took over the polishing of
b1bda751 (parse: separate out parsing functions from config.h,
2023-09-29)]

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/attr.c b/attr.c
> index 71c84fbcf86..bb0d54eb967 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -1205,6 +1205,13 @@ static void compute_default_attr_source(struct object_id *attr_source)
>  	if (!default_attr_source_tree_object_name)
>  		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
>  
> +	if (!default_attr_source_tree_object_name) {
> +		char *attr_tree;
> +
> +		if (!git_config_get_string("attr.tree", &attr_tree))
> +			default_attr_source_tree_object_name = attr_tree;
> +	}
> +
>  	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
>  		return;

As this adds a new call to git_config_get_string(), which will only
be available by including <config.h>, a merge-fix into 'seen' of
this topic needs to revert what b1bda751 (parse: separate out
parsing functions from config.h, 2023-09-29) did, which made this
file include only <parse.h>.

As this configuration variable was invented to improve the way the
attribute source tree is supported by emulating how mailmap.blob is
done, it deserves a bit of comparison.

The way mailmap.c does this is not have any code that reads or
parses configuration in mailmap.c (which is a rather library-ish
place), and leaves it up to callers to pre-populate the global
variable git_mailmap_blob with config.c:git_default_config().  That
way, they do not need to include <config.h> (nor <parse.h>) that is
closer to the UI layer.  I am wondering why we are not doing the
same, and instead making an ad-hoc call to git_config_get_string()
in this code, and if it is a good direction to move the codebase to
(in which case we may want to make sure that the same pattern is
followed in other places).

Folks interested in libification, as to the direction of that
effort, what's your plan on where to draw a line between "library"
and "userland"?  Should library-ish code be allowed to call
git_config_anything()?  I somehow suspect that it might be cleaner
if they didn't, and instead have the user of the "attr" module to
supply the necessary values from outside.

On the other hand, once the part we have historically called
"config" API gets a reasonably solid abstraction so that they become
pluggable and replaceable, random ad-hoc calls from library code
outside the "config" library code may not be a huge problem, as long
as we plumb the necessary object handles around (so "attr" library
would need to be told which "config" backend is in use, probably in
the form of a struct that holds the various states in to replace
the current use of globals, plus a vtable to point at
implementations of the "config" service, and git_config_get_string()
call in such a truly libified world would grab the value of the named
variable transparently from whichever "config" backend is currently
in use).

Anyway, I think I wiggled this patch into 'seen' so I'll push out
today's integration result shortly.

