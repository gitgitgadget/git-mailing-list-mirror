Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C144C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 18:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiK1Sx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiK1SxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 13:53:25 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5891E3E3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:53:24 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-348608c1cd3so104127017b3.10
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6eu3EuPEbvF8MI1gt7NrC0L3yxqB/FDIKSfWWSKJC+U=;
        b=s8ODCDBT95vmJWnvVyVKYSDQY7EIia3HR1VdDxzzDOAjG57vyw3bCEYKuYbNbNUyP4
         nKHdwJKa5GaPQ1Z7L8UeN7WLKTvjwiUOoyI0QSwKaws9/wa5B5VqXorkSTHivIvdSLCH
         rZ1bKg4aAG79HRrCf1GSdgUEJ+FHBW8HPIsbBXj0ozTiQZH6XG1mTOm44Bagy6nBVHtu
         Kj+1aWVlua2VAFQn30VdPvaI2TtLy2OE8IDY7zawhWzpscqzKdCpLhurip7di4+Jw1+J
         d0sMzZt3H0leIxBFiOsY362ZrAW4sP2BDflhzkOAzN+vSmaYucRlyW37m8NAhidd5fxq
         14Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eu3EuPEbvF8MI1gt7NrC0L3yxqB/FDIKSfWWSKJC+U=;
        b=rRMMf4gMln37tJCM4kHc3nHqJEuGcEW7VgcjxrcM6RSY07yqx2cfpDaShJBRSzp/yp
         xXJ2RILtTaMPTEjHrP34B+UC3xuvZs5wKDG6WV3UNI0R0W/m/8xLoGFZMS2nhx9napUz
         Gpeiz/qCMnLcJ3AXluoW33nrbrZznIXDtf/mDGq48fdy8LeXXnloUI9m+Ysx+zBr8zPR
         0CrLkR7Gbj2QwKrtpLFERslTPbsvXCHAWgLJ0PFVpNsJLcwS/+5qgq4ZR4TKtGG8dfXc
         iOZvoZm5ysHVaOS8pHOAWsoxRGctZo7P7k+FOUl6ZrtVsmOb4GfNaYmXmCXuz8dyu77b
         mmnw==
X-Gm-Message-State: ANoB5plJNqESHpu0d3QjC6tCXoQLo7ptrnGA8yQhDCCJJg+GtAverkog
        +dGqbz9a4GNjOCBVUrUOA/k49xHlvcWDrlTyC7xu
X-Google-Smtp-Source: AA0mqf47XSandFy7cKiYzYsU/1B8nvbRvGd6z0U1F3sIebzcZUO4G/wjisiISDFFs5uHFtftc51mJQqKtIG1IIp8Xnlw
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8390:0:b0:6de:5b33:4a29 with
 SMTP id t16-20020a258390000000b006de5b334a29mr32230202ybk.485.1669661603822;
 Mon, 28 Nov 2022 10:53:23 -0800 (PST)
Date:   Mon, 28 Nov 2022 10:53:19 -0800
In-Reply-To: <Y37DF7THHv3wEbUc@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221128185320.2735382-1-jonathantanmy@google.com>
Subject: Re: [Design RFC] Being more defensive about fetching commits in
 partial clone
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> On Wed, Nov 23, 2022 at 04:42:05PM -0800, Jonathan Tan wrote:
> 
> > A question remains of whether we would need to undo all this work if we decide
> > to support commit filters in partial clones. Firstly, there are good arguments
> > against (and, of course, for) commit filters in partial clones, so commit
> > filters may not work out in the end anyway. Secondly, even if we do have commit
> > filters, we at $DAYJOB think that we still need to differentiate, in some way,
> > a fetch that we have accounted for in our design and a fetch that we haven't;
> > commit chains have much greater lengths than tree chains and users wouldn't
> > want to wait for Git to fetch commit by commit (or segment by segment, if we
> > end up batch fetching commits as we probably will). So we would be building on
> > the defensiveness of fetching commits in this case, not tearing it down.
> > 
> > My next step will be to send a patch modifying repo_parse_commit() to not
> > lazy-fetch, and I think that future work will lie in identifying when we know
> > that we are reading a commit and inhibiting lazy-fetches in those cases. If
> > anyone has an opinion on this, feel free to let us know (hence the "RFC" in
> > the subject).
> 
> In general, I think partial clones tend to know which filters were used
> to create them, because we save that filter in the config. Would it be
> reasonable before lazy-fetching to say "I am looking for an object of
> type X; would my configured filters have skipped such an object?".
> 
> Then not only would you get the behavior you want for commits (which are
> never skipped), but a blob:none clone would not try to lazy-fetch trees
> (but a tree:depth one would lazy-fetch both trees and blobs).
> 
> The gotcha I'd worry about is that the config doesn't necessarily match
> how the repository was originally created. There is nothing right now
> saying you cannot partial-clone with one filter, then change the config
> going forward.
> 
> -Peff

Thanks for weighing in. In the general case, we indeed do know what kind of
object we're fetching, so it does make sense to generalize my idea to trees and
blobs as well. On the other hand, though, besides the issue that the user may
subsequently change the config, the benefits of distinguishing between a blob
and tree are not that great, I think - we would fail fast when, say, a tree
is missing due to object store corruption when trying to check out something
in a blob:none clone, but the same object store corruption probably would
mean that commits are missing too, so even if we just did this for commits, we
would already fail equally as fast. Because of this (and the user being able
to change the config), it makes sense to me to handle only the commit case, at
least for now.

Having said that, this is not forwards incompatible with restricting lazy fetch
for trees and blobs, so if we see fit later to do that, we can still do it.
