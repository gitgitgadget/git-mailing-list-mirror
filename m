Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A494C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 17:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiFPRov (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFPRou (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 13:44:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC161E3D9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 10:44:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 037C5129746;
        Thu, 16 Jun 2022 13:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bLFpNxMKs1RrRYESvvkGC9N7hQSObeeBjX4yIT
        2fFLE=; b=ILMOX8hLtUtzqqHZXqevJ9FidZHh63UiWGQOR8a65c3K/ZXEMXRBku
        aqPH3fhtA/Lx2FVVizyjOPIdMEPpf8dlpF01uthpThhz0t7gD/GtcixQ0PEcyqkc
        Pha//F976PR+BXChuQ66uMRzSkv49k9ONZjtasTz2UnSj3A56/im0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEE7A129745;
        Thu, 16 Jun 2022 13:44:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6367A129744;
        Thu, 16 Jun 2022 13:44:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Oliver <roliver@roku.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] mktree: Make '--missing' behave as documented
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
        <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
        <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
        <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
        <YqkpRE8nykqVv8cn@nand.local>
        <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
        <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
        <xmqqa6adzln6.fsf@gitster.g>
        <1566aed1-a38f-a9ca-241c-21b56d732328@roku.com>
Date:   Thu, 16 Jun 2022 10:44:47 -0700
In-Reply-To: <1566aed1-a38f-a9ca-241c-21b56d732328@roku.com> (Richard Oliver's
        message of "Thu, 16 Jun 2022 16:46:00 +0100")
Message-ID: <xmqqy1xwtsds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04497790-ED9C-11EC-B49B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Oliver <roliver@roku.com> writes:

> Subject: [PATCH] mktree: Make '--missing' behave as documented

I would intead title the change as

	   mktree: disable object verification under '--missing'

if I were writing this change.  It is a tad longer, but "as
documented" is much less informative when this appears in "git
shortlog --no-merges".

But wait for a bit.  I am not sold on "disable" 100% yet.

> Do not make use of the object store to verify object type for
> 'allow_missing' objects in mktree_line(). GIT-MKTREE(1) documents
> '--missing' as disabling "verif[ication] that each tree entry's sha1
> identifies an existing object".

I am on the fence on this.  The current behaviour is not exactly
forcing verification with "--missing".  Even if oid_object_info(),
after consulting the promisor remote, says that the object is not
available, the code does not complain, and in that sense, it is
working as documented.  It's just that it is doing unnecessary work
that you know you are not going to use.

> This change retains the check for '<mode>' and '<type>' for
> 'allow_missing' objects as this check is merely input validation that
> avoids interrogating the object store.
>
> Signed-off-by: Richard Oliver <roliver@roku.com>
> ---
>  builtin/mktree.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

31c8221a (mktree: validate entry type in input, 2009-05-14) was
overly eager to check with the local object store. They called the
sha1_object_info() API to obtain the type information, allowed the
call to silently fail when the object was missing locally, but
sanity checked the types opportunistically when the object did
exist.  That implementation is hurting us now, but it is sort of
excusable because back then there was no lazy/on-demand downloading
of individual objects that causes a long delay and materializes the
object, hence defeating the point of using "--missing".

And that is why the code back then was OK but not anymore in today's
world.  Something like the analysis in the above paragraph should be
in the commit log message to explain why we are making this change
today.

This patch would be a good first cut as a starting point, but we
probably can do better by doing oid_object_info_extended() call with
OBJECT_INFO_SKIP_FETCH_OBJECT bit (and probably QUICK bit, too) set,
with the current code structure.

And when we do so, the title would not match the purpose of the
change.  The verification was disabled with "--missing" all along
and that is not what we are changing.  What we will be fixing is the
wasteful implementation.

    mktree: do not check types of remote objects

    With 31c8221a (mktree: validate entry type in input, 2009-05-14), we
    called the sha1_object_info() API to obtain the type information,
    but allowed the call to silently fail when the object was missing
    locally, so that we can sanity-check the types opportunistically
    when the object did exist.

    The implementation is understandable because back then there was no
    lazy/on-demand downloading of individual objects from the promisor
    remotes that causes a long delay and materializes the object, hence
    defeating the point of using "--missing".  The design is hurting us
    now.

    We could bypass the opportunistic type/mode consistency check
    altogether when "--missing" is given, but instead, use the
    oid_object_info_extended() API and tell it that we are only
    interested in objects that locally exist and are immediately
    available by passing OBJECT_INFO_SKIP_FETCH_OBJECT bit to it.  That
    way, we will still retain the cheap and opportunistic sanity check
    for local objects.

or something like that, perhaps?

Thanks.

> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index 902edba6d2..f41fda6e7d 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -116,15 +116,12 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
>  			path, ptr, type_name(mode_type));
>  	}
>  
> -	/* Check the type of object identified by sha1 */
> -	obj_type = oid_object_info(the_repository, &oid, NULL);
> -	if (obj_type < 0) {
> -		if (allow_missing) {
> -			; /* no problem - missing objects are presumed to be of the right type */
> -		} else {
> +	if (!allow_missing) {
> +		/* Check the type of object identified by sha1 */
> +		obj_type = oid_object_info(the_repository, &oid, NULL);
> +		if (obj_type < 0) {
>  			die("entry '%s' object %s is unavailable", path, oid_to_hex(&oid));
>  		}
> -	} else {
>  		if (obj_type != mode_type) {
>  			/*
>  			 * The object exists but is of the wrong type.
