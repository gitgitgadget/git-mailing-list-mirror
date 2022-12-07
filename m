Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2944AC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 06:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLGGrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 01:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLGGru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 01:47:50 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB87EE02
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 22:47:48 -0800 (PST)
Received: (qmail 17969 invoked by uid 109); 7 Dec 2022 06:47:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Dec 2022 06:47:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30948 invoked by uid 111); 7 Dec 2022 06:47:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Dec 2022 01:47:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Dec 2022 01:47:46 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/3] commit: don't lazy-fetch commits
Message-ID: <Y5A3EkxY8p6XptWt@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670373420.git.jonathantanmy@google.com>
 <c5fe42deb04285b85d5354a57e90bf9410cc2420.1670373420.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5fe42deb04285b85d5354a57e90bf9410cc2420.1670373420.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 04:40:53PM -0800, Jonathan Tan wrote:

> @@ -516,8 +527,8 @@ int repo_parse_commit_internal(struct repository *r,
>  		return 0;
>  	if (use_commit_graph && parse_commit_in_graph(r, item))
>  		return 0;
> -	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
> -	if (!buffer)
> +
> +	if (oid_object_info_extended(r, &item->object.oid, &oi, flags) < 0)

Nice. And this swap-out is much more obviously correct in this version
of the series because read_object_file_extended() is now clearly a thin
wrapper around oid_object_info_extended(), after your patch 2.

I actually think it would be beneficial to do a bit more refactoring
there to eliminate read_object() entirely (in favor of just having the
two callers use oid_object_info_extended() directly), and having
repo_read_object_extended() pass OBJECT_INFO_LOOKUP_REPLACE instead of
doing its own lookup.

But as that's all orthogonal to your goal, I don't mind if we punt on it
for now. We can do it later on top.

-Peff
