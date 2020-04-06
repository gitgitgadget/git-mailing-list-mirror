Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9A8C2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 21:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F63920753
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 21:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgDFVqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:46:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:35028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725933AbgDFVqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 17:46:08 -0400
Received: (qmail 27800 invoked by uid 109); 6 Apr 2020 21:46:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Apr 2020 21:46:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18375 invoked by uid 111); 6 Apr 2020 21:56:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2020 17:56:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Apr 2020 17:46:07 -0400
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200406214607.GA1251506@coredump.intra.peff.net>
References: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
 <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
 <20200328131553.GA643242@coredump.intra.peff.net>
 <20200406160439.gg5uu6kepnyxpvuc@feanor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406160439.gg5uu6kepnyxpvuc@feanor>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 06:04:39PM +0200, Damien Robert wrote:

> Heres what happen with such a triangular workflow when we do a `git push`:
> - with push.default=simple, we have
> 	case PUSH_DEFAULT_SIMPLE:
> 		if (triangular)
> 			setup_push_current(remote, branch);
> 		else
> 			setup_push_upstream(remote, branch, triangular, 1);
> 		break;
>   so the current branch is always pushed.

Yeah, otherwise every push to a remote other than origin would require a
refspec. I think with respect to for-each-ref, this "triangular" case
would only kick in if you define remote.pushDefault (since you can't
specify a remote on the command-line).

Though hmm. I guess maybe it could kick in if the upstream of the branch
is on a non-default remote? For push, that would work because
remote_get() will look at the current branch. But of course in
for-each-ref, we're asking speculatively about other branches.

So I think if we want to support this triangular logic in for-each-ref,
we need to have a more careful definition than what's in push.c's
is_workflow_triangular(). I.e., it would probably make sense to consider
it from the position of "if we were on this branch, what would it push".

And ditto for @{push}, I guess.

> - with push.default=upstream, we have
> 	case PUSH_DEFAULT_UPSTREAM:
> 		setup_push_upstream(remote, branch, triangular, 0);
> 		break;
>   which then gives
>   	if (triangular)
> 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
> 		      "your current branch '%s', without telling me what to push\n"
> 		      "to update which remote branch."),
> 
> By the way this matches what the documentation says.

Yeah. I think in the triangular case (at least as defined in push.c)
we'd always be pushing to the non-upstream, so this die() makes sense.

In for-each-ref, I guess we'd hit this case with remote.pushDefault
again. Without that, we'd always be pushing to the upstream anyway.

> However here is the result of
> git -c push.default=$value for-each-ref --format="%(push:remotename),%(push:remoteref),%(push)" refs/heads/master
> for $value=
> - simple: to,,
> - upstream: to,refs/heads/other,refs/remotes/from/other
> 
> Note that without my patch the %(push:remoteref) values would always be empty,
> but my patch does not touch %(push).
> 
> So in both branch_get_push_1 and branch_get_push_remoteref I should first
> detect if we have a triangular workflow, and update the logic of the code
> accordingly.

Yes, I agree this could be improved. I'm OK leaving that as a separate
fix to your current remoteref work, though.

-Peff
