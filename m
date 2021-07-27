Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DDAC432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 09:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB426125F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 09:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhG0JMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 05:12:30 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:56922 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbhG0JM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 05:12:29 -0400
Date:   Tue, 27 Jul 2021 09:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1627377115;
        bh=Qp0x+25Tcput+Iq7JLZQ6/bCWKhf9NOrmVc524icDmo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=JdKEw41U7NWVM44KPlP+H0P0mL+MG3kktxi31iKCPqAm+K5z3wVFwB/yx14CrXGaH
         3d3rHDVBBazAd9rX6+hhqRfd3Y9EfAp9/4lFbIaZaruVW+3n5srysXdyimb4ZS20pN
         /40OdCs7iV77Jsj8WNGHsfOjGjCCw7LkVtH/7nX6NjG8ez/cGXe0vYoVOlShwlsdCK
         u2HSs1WRLT63i51l1whDYeS/kEMwaBKfH7WX1Tq2pEqWmmCoC+Ul8hXtNTawrUIEOQ
         T5xiEyLCuhRi25wimuUTwihhcuQMOpPtjZkMSF5W51GvrhsQo0eLf/vYcNmaXWMrPr
         kEuYUwmRwk0yg==
To:     Jonathan Tan <jonathantanmy@google.com>
From:   Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, bwilliamseng@gmail.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: ref-in-want does not consider namespace
Message-ID: <CD3T1FV0ICZK.1QYV25UTSU768@schmidt>
In-Reply-To: <20210726164414.2208736-1-jonathantanmy@google.com>
References: <pMV5dJabxOBTD8kJBaPuWK0aS6OJhRQ7YFGwfhPCeSJEbPDrIFBza36nXBCgUCeUJWGmpjPI1rlOGvZJEh71Ruz4SqljndUwOCoBUDRHRDU=@eagain.st> <20210726164414.2208736-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jonathan

> Your expectation that "want-ref refs/heads/main" should match
> "refs/namespaces/foo/refs/heads/main" when you run upload-pack with
> "--namespace=3Dfoo" makes sense to me. Just to clarify - does this mean
> tha 2.31.1 works like you expect?

"ref-prefix" works as expected in the newer version, but not "want-ref". I
haven't properly bisected, but the fix seems to coincide with b3970c7, alth=
ough
I'm not sure if that was intentional.

> In any case, t5703 should contain a namespace test, but it doesn't seem
> to.

Yes I noticed that your original patch did contain a test for this.

> Would you be able to contribute a patch?

With some handholding, I'd be at least up for giving it a spin :)

One thing that is unclear to me is how "hideRefs" is supposed to interact w=
ith
"want-ref". At the moment, it seems like a client can "want-ref" _any_ ref,=
 even
if it is hidden by "hideRefs". It might seem sensible to ignore hidden refs=
, but
then the situation could occur that the effective list of "want-ref"s is em=
pty.

If that happens, and the client did not send any "want"s either, "upload-pa=
ck"
ignores the fetch command altogether and just waits for the next command. I=
n
this case, the client can only recover by timing out the connection.

So should this be special-cased somehow and result in an error response?

