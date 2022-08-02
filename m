Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E48C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiHBMTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiHBMTE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:19:04 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5730F50716
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:18:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31f661b3f89so138177307b3.11
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TSQSfPUELm2NChypc46QcOjdnO22iA8j1AyGkvvdjBM=;
        b=dL80LIJPFO/gs0AmAO1ID1Ps5RJIQ+L8ju+Q4SWvb6NgL3oCEgFBa5qIqUe+AB4PyC
         XB9nrDbAPacHwzu6Wj5vi6SiYSfQhm/uQXxppnOVTu+Z3qG9bUp69Gmq9VLTWIYmEgHy
         R6qIg+fEERY6In+DIKLZxKREFedUXTRCWqFJvPvrvVWfVIHWl0Q9H1efeVegeqWvYDxg
         NCn3CTWESloOVW9BN5JdJN5Z6bieFK6b6kNfMUZq6wq2bSsK0ynb4HWXUcihBydr0JAF
         CSBVp2XNWAOn46Bj6JnjifpFAD3m8LfxBNPoeE/ZVH5T2MTOxe+TO0YySm+22RWn4+n4
         7SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TSQSfPUELm2NChypc46QcOjdnO22iA8j1AyGkvvdjBM=;
        b=6qpiIupYgXMnF1g0YV4XZOLCKVUgeTs+ea/iJJfDPaliNtAJDbYVRDMUTlQoARvOk4
         9o3wnqzObtvBAlMussVVUZqcSKOspc/KkjSWgd05809dKwxie9HC3mmXzbc9JUezGhEg
         mgtLj41UbtiVkygkDnY7JqTUjKmSgoCP9QVZgEMO6OSUkNU+BPr2uNOZef6a92zDzobQ
         G63Etnv6I/YJw1frfUu6ccwbUhVV5n7Mf4wd8/IW4RBnLmNFA8J5ipnHluz5PW4rldZp
         7I4I9KWjJydCfv0i1cZ5/yy/zT3L4zN0JoJw+sPRDv4bh21sjFwBRCdJne8Kxlr3+pGL
         NMRg==
X-Gm-Message-State: ACgBeo0akkHMUSweo6HcXyRMKpxkRrNA2Y8os35VTtOFB1m4GnhYkkM8
        1sgDNzcshjwqpzltPgho0lVW4Kyy6Qd/VkxCUeiKIQ==
X-Google-Smtp-Source: AA6agR7bnF7XXzpX/JngbDIVajJLFXY1sFRIt9ah+iylxn2+zYbanV52HLv+9BnYc0i+ydwJf4ebfM2XOqUebpWBRUs=
X-Received: by 2002:a81:9245:0:b0:31f:4e3e:363d with SMTP id
 j66-20020a819245000000b0031f4e3e363dmr17621941ywg.119.1659442724301; Tue, 02
 Aug 2022 05:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220729101245.6469-1-worldhello.net@gmail.com> <20220729101245.6469-6-worldhello.net@gmail.com>
In-Reply-To: <20220729101245.6469-6-worldhello.net@gmail.com>
From:   Michael Heemskerk <mheemskerk@atlassian.com>
Date:   Tue, 2 Aug 2022 14:18:33 +0200
Message-ID: <CAJDSCnOFSnhOU06UHF6T9RT31Gq56BhJn5fQ4_ys2ERrN1stSw@mail.gmail.com>
Subject: Re: [PATCH 5/9] refs: avoid duplicate running of the
 reference-transaction hook
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 12:20 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> If there are references to be deleted in a transaction, we should remove
> each reference from both loose references and the "packed-refs" file.
> The "reference-transaction" hook will run twice, once for the primary
> ref-store (loose references), and another for the second ref-store (i.e.
> packed ref-store).
>
> To avoid duplicate running of the "reference-trancaction" hook, we pass
> a special "hook-flags" parameter to initialize the second ref-store.
> The "REF_TRANSACTION_RUN_PREPARED_HOOK" bit is preserved for the
> transaction of the second ref-store because we may still want to call
> command "reference-trancaction prepared" for some pre-checks, such as
> terminate unwanted transaction for the "packed-refs" file.

Can you elaborate on the rationale for continuing to invoke the "prepared"
reference-transaction hook for the "packed-refs" file? Did you have a specific
type of check in mind?

As far as I can tell, any ref update included in this 'extra' callback is also
provided to the "prepared" callback for the "files" backend, and that "files"
callback always happens - even when deleting a ref that only exists in
packed-refs. As a result, it _should_ be safe to also suppress the "prepared"
callback for the "packed-refs" backend. Patrick has a patch series that does
exactly that (suppress all "packed-refs" reference-transaction callbacks).

Your patch series will achieve the same (and more) if you change

> +                               packed_transaction = ref_store_transaction_begin_extended(
> +                                               refs->packed_ref_store,
> +                                               transaction->hook_flags &
> +                                                       REF_TRANSACTION_RUN_PREPARED_HOOK,
> +                                               err);

to

> +                               packed_transaction = ref_store_transaction_begin_extended(
> +                                               refs->packed_ref_store,
> +                                               0,
> +                                               err);

For illustration, here are some callbacks I see with your patches applied
(without the change I suggested above):

deleting a ref that only exists as a loose ref:
  1. prepared (for 'files')
  d6edcbf924697ab811a867421dab60d954ccad99
0000000000000000000000000000000000000000 refs/heads/basic_branching
  2. committed (for 'files')
  d6edcbf924697ab811a867421dab60d954ccad99
0000000000000000000000000000000000000000 refs/heads/basic_branching

deleting a ref that only exists in packed-refs:
  1. prepared (for 'packed-refs')
  0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/basic_branching
  2. prepared (for 'files')
  d6edcbf924697ab811a867421dab60d954ccad99
0000000000000000000000000000000000000000 refs/heads/basic_branching
  3. committed (for 'files')
  d6edcbf924697ab811a867421dab60d954ccad99
0000000000000000000000000000000000000000 refs/heads/basic_branching

deleting a ref that only exists both in packed-refs and as a loose ref:
  1. prepared (for 'packed-refs')
  0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/basic_branching
  2. prepared (for 'files')
  d6edcbf924697ab811a867421dab60d954ccad99
0000000000000000000000000000000000000000 refs/heads/basic_branching
  3. committed (for 'files')
  d6edcbf924697ab811a867421dab60d954ccad99
0000000000000000000000000000000000000000 refs/heads/basic_branching

a mixed update, containing some adds, deletes and updates where some
refs existed in packed-refs:
  1. prepared (for 'packed-refs')
  0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/branch_mod_merge
  0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/basic_branching
  2. prepared (for 'files')
  6053a1eaa1c009dd11092d09a72f3c41af1b59ad
0000000000000000000000000000000000000000 refs/heads/branch_mod_merge
  d6edcbf924697ab811a867421dab60d954ccad99
0000000000000000000000000000000000000000 refs/heads/basic_branching
  2e10dd2d1d5eea9291b296e78312e8a703964a95
9fbc34a0d905950131d73f352abe68520c6db2a3
refs/heads/out_of_order_branch
  0000000000000000000000000000000000000000
9b4e781dea0769888fe270e06ad76675f73851b1 refs/tags/retagged_2
  2. committed (for 'files')
  6053a1eaa1c009dd11092d09a72f3c41af1b59ad
0000000000000000000000000000000000000000 refs/heads/branch_mod_merge
  d6edcbf924697ab811a867421dab60d954ccad99
0000000000000000000000000000000000000000 refs/heads/basic_branching
  2e10dd2d1d5eea9291b296e78312e8a703964a95
9fbc34a0d905950131d73f352abe68520c6db2a3
refs/heads/out_of_order_branch
  0000000000000000000000000000000000000000
9b4e781dea0769888fe270e06ad76675f73851b1 refs/tags/retagged_2

In all of these cases, the "prepared (for 'packed-refs')" callback
seems unnecessary
overhead?

> The behavior of the following git commands and five testcases have been
> fixed in t1416:
>
>  * git cherry-pick
>  * git rebase
>  * git revert
>  * git update-ref -d <ref>
>  * git update-ref --stdin       # delete refs

Thanks for adding (and fixing) these test cases! We have a similar set of test
cases in Bitbucket Server to validate that we're interpreting the
reference-transaction
callbacks correctly in various scenarios. These tests still pass
against git with your patch
series applied, so from our end they look good.

Cheers,
Michael Heemskerk
