Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C2C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 17:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiGGRl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbiGGRlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 13:41:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B090D4F1A6
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 10:40:57 -0700 (PDT)
Received: (qmail 6313 invoked by uid 109); 7 Jul 2022 17:40:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 17:40:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2952 invoked by uid 111); 7 Jul 2022 17:40:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 13:40:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 13:40:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/3] clone: propagate empty remote HEAD even with other
 branches
Message-ID: <Yscaoz8qmPYiiLO5@coredump.intra.peff.net>
References: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
 <YsVB2eOMp5guQfVr@coredump.intra.peff.net>
 <xmqqr12ygl3p.fsf@gitster.g>
 <xmqq5yk9hpd9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yk9hpd9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2022 at 03:01:54PM -0700, Junio C Hamano wrote:

> > I am kind of surprised that the code still behaves differently
> > between empty and non-empty cases.  Given the earlier decision above
> > to consistently use the remote's HEAD, I would have expected that
> > setting HEAD to point at an non-existent ref would be done at one
> > place, instead of being done for empty and non-empty clone
> > separately.  We'll find out why while reading the patch, I think.
> 
> OK, that is because we have if/else on the number of refs mapped via
> the refspec by wanted_peer_refs(), and setup_unborn_head is done
> independently in each of these if/else arms.

Right. I was hoping to avoid disturbing the logic too much, because I
didn't want to introduce new bugs. But I took a stab at it and it
doesn't seem too bad:

diff --git a/builtin/clone.c b/builtin/clone.c
index aa0729f62d..7b270d436a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1290,32 +1290,28 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
 			guess_remote_head(remote_head, mapped_refs, 0);
-
-		if (option_branch) {
-			our_head_points_at =
-				find_remote_branch(mapped_refs, option_branch);
-
-			if (!our_head_points_at)
-				die(_("Remote branch %s not found in upstream %s"),
-				    option_branch, remote_name);
-		} else {
-			our_head_points_at = remote_head_points_at;
-			if (!our_head_points_at)
-				setup_unborn_head(transport_ls_refs_options.unborn_head_target,
-						  reflog_msg.buf);
-		}
+	} else {
+		remote_head_points_at = NULL;
+		remote_head = NULL;
 	}
-	else {
-		if (option_branch)
+
+	if (option_branch) {
+		/* this is a noop if mapped_refs is NULL, but should be OK */
+		our_head_points_at = find_remote_branch(mapped_refs, option_branch);
+		if (!our_head_points_at)
 			die(_("Remote branch %s not found in upstream %s"),
-					option_branch, remote_name);
+			    option_branch, remote_name);
+	} else if (remote_head_points_at) {
+		our_head_points_at = remote_head_points_at;
+	} else {
+		if (!mapped_refs) {
+			warning(_("You appear to have cloned an empty repository."));
+			/* could do this even in mapped_refs case, but we'd
+			 * want to issue a warning ourselves then */
+			option_no_checkout = 1;
+		}
 
-		warning(_("You appear to have cloned an empty repository."));
 		our_head_points_at = NULL;
-		remote_head_points_at = NULL;
-		remote_head = NULL;
-		option_no_checkout = 1;
-
 		setup_unborn_head(transport_ls_refs_options.unborn_head_target,
 				  reflog_msg.buf);
 	}

In fact, I think it may make things more clear. We avoid the duplicate
die() condition for option_branch, and we now have only one call to
setup_unborn_head(). So we could drop patch 2 and just keep it inline
here.

> The following rewrite with the same behaviour may be a bit easier to
> follow.
> [...]
> -		} else {
> +		} else if (remote_head_points_at) {
>  			our_head_points_at = remote_head_points_at;
> -			if (!our_head_points_at)
> -				setup_unborn_head(transport_ls_refs_options.unborn_head_target,
> -						  reflog_msg.buf);
> +		} else {
> +			our_head_points_at = NULL;
> +			setup_unborn_head(transport_ls_refs_options.unborn_head_target,
> +					  reflog_msg.buf);
>  		}

Heh, I actually wrote it that way initially, but then realized it
collapsed to the more terse version. I don't mind doing it either way,
but maybe it's worth the rewrite I showed above.

If so, do you prefer to go straight there in patch 3 (and drop patch 2,
keeping the unborn setup inline), or do you prefer to see it on top?
Normally I'd suggest the former, but I worry that doing it all in one
patch means it's reorganizing the code _and_ changing the behavior all
at once, which is harder to reason about. And I don't see an easy way to
reorganize the code without changing the behavior.

-Peff
