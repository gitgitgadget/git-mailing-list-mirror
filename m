Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86701C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 22:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiGFWDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 18:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiGFWCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 18:02:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B3E2C133
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 15:02:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E16B1368C6;
        Wed,  6 Jul 2022 18:01:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GPU4x199JSCcEiDA1mJh+w92/u/9kf48gJn+ug
        dTRiQ=; b=OBRVewm1j3NWxz063+iHZvitNIqJlwDZH1jvHbXsoTjd552mM9XlPe
        wX1UvZyWUYOetsuXdBH1DLBfhGjzPvr+7YB79SnGvseIpMoLAekJEqg5jUXvF//U
        RB/rzSCURpadgG95CaqQzNmLkYgo6ULXPPoIlLXxia1pFTD0/WsBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 843C51368C5;
        Wed,  6 Jul 2022 18:01:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C31441368C4;
        Wed,  6 Jul 2022 18:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/3] clone: propagate empty remote HEAD even with other
 branches
References: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
        <YsVB2eOMp5guQfVr@coredump.intra.peff.net>
        <xmqqr12ygl3p.fsf@gitster.g>
Date:   Wed, 06 Jul 2022 15:01:54 -0700
In-Reply-To: <xmqqr12ygl3p.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Jul 2022 11:19:22 -0700")
Message-ID: <xmqq5yk9hpd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FFD7DBE-FD77-11EC-ADF0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
>>    For a bare clone, it won't emit any warning at all (but will still
>>    set up HEAD appropriately). That's probably fine. There's no part of
>>    the operation we were unable to perform, so any "by the way, the
>>    remote HEAD wasn't there but we pointed our HEAD to it anyway"
>>    message would be purely informational. Though perhaps one could argue
>>    the same about the current "empty repository" message in a bare
>>    clone.
>
> I am kind of surprised that the code still behaves differently
> between empty and non-empty cases.  Given the earlier decision above
> to consistently use the remote's HEAD, I would have expected that
> setting HEAD to point at an non-existent ref would be done at one
> place, instead of being done for empty and non-empty clone
> separately.  We'll find out why while reading the patch, I think.

OK, that is because we have if/else on the number of refs mapped via
the refspec by wanted_peer_refs(), and setup_unborn_head is done
independently in each of these if/else arms.

> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1298,9 +1298,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			if (!our_head_points_at)
>  				die(_("Remote branch %s not found in upstream %s"),
>  				    option_branch, remote_name);
> -		}
> -		else
> +		} else {
>  			our_head_points_at = remote_head_points_at;
> +			if (!our_head_points_at)
> +				setup_unborn_head(transport_ls_refs_options.unborn_head_target,
> +						  reflog_msg.buf);
> +		}
>  	}
>  	else {
>  		if (option_branch)

The following rewrite with the same behaviour may be a bit easier to
follow.

Thanks.

 builtin/clone.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git c/builtin/clone.c w/builtin/clone.c
index cb7b347c5a..0b172af9e4 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -1298,11 +1298,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			if (!our_head_points_at)
 				die(_("Remote branch %s not found in upstream %s"),
 				    option_branch, remote_name);
-		} else {
+		} else if (remote_head_points_at) {
 			our_head_points_at = remote_head_points_at;
-			if (!our_head_points_at)
-				setup_unborn_head(transport_ls_refs_options.unborn_head_target,
-						  reflog_msg.buf);
+		} else {
+			our_head_points_at = NULL;
+			setup_unborn_head(transport_ls_refs_options.unborn_head_target,
+					  reflog_msg.buf);
 		}
 	}
 	else {
