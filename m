Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8A1EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 07:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjFOHLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 03:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbjFOHLU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 03:11:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36FA26B6
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 00:09:31 -0700 (PDT)
Received: (qmail 19211 invoked by uid 109); 15 Jun 2023 07:09:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jun 2023 07:09:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19503 invoked by uid 111); 15 Jun 2023 07:09:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jun 2023 03:09:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jun 2023 03:09:30 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v3 2/2] credential: erase all matching credentials
Message-ID: <20230615070930.GB1460739@coredump.intra.peff.net>
References: <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
 <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
 <e06d80e99a00c30fb8430afcd457576bb0bf9ce5.1686809004.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e06d80e99a00c30fb8430afcd457576bb0bf9ce5.1686809004.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 06:03:24AM +0000, M Hickford via GitGitGadget wrote:

> From: M Hickford <mirth.hickford@gmail.com>
> 
> `credential reject` sends the erase action to each helper, but the
> exact behaviour of erase isn't specified in documentation or tests.
> Some helpers (such as credential-libsecret) delete all matching
> credentials, others (such as credential-cache and credential-store)
> delete at most one matching credential.
> 
> Test that helpers erase all matching credentials. This behaviour is
> easiest to reason about. Users expect that `echo
> "url=https://example.com" | git credential reject` or `echo
> "url=https://example.com\nusername=tim" | git credential reject` erase
> all matching credentials.
> 
> Fix credential-cache and credential-store.

This last sentence is out of date now, right? We are only fixing
credential-cache.

> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index f80ff59f18a..06bbfa4dd03 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -35,7 +35,6 @@ static int parse_credential_file(const char *fn,
>  			found_credential = 1;
>  			if (match_cb) {
>  				match_cb(&entry);
> -				break;
>  			}
>  		}
>  		else if (other_cb)

This hunk is wrong, isn't it? We should not be touching credential-store
at all (and losing the "break" means that we'd accidentally print
multiple matching entries for "get").

-Peff
