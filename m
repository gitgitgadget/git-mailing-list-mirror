Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84157C83013
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2C920715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="aZO64k4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgKXA7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:59:38 -0500
Received: from out0.migadu.com ([94.23.1.103]:24356 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgKXA7h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 19:59:37 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 19:59:36 EST
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1606179211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=Ak4AF+pJQv6sQFmq/oZpWbMYfOGNVVLwqUdfIGxZbOc=;
        b=aZO64k4UECuwbsdteCC3CRekK8pOawGvQvSA8GuCn4OPoGFQK7tkxr51aUje7jTfw4fK3T
        m3QOjmmfwJK19YOsQ3Csgpq81XFUkZQgMs6DCBsOn8m267srdRjDjLUUNRu2h8DL02ajhh
        ny+oYZo76EGnIxtUK2OiKZM3dxuymhc=
Content-Type: text/plain; charset=UTF-8
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Felipe Contreras" <felipe.contreras@gmail.com>,
        "Alex Henrie" <alexhenrie24@gmail.com>
Cc:     "Git" <git@vger.kernel.org>,
        =?utf-8?q?V=C3=ADt_Ondruch?= <vondruch@redhat.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, "Jeff King" <peff@peff.net>,
        "Andreas Krey" <a.krey@gmx.de>,
        "John Keeping" <john@keeping.me.uk>,
        "Richard Hansen" <rhansen@rhansen.org>,
        "Philip Oakley" <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v7 1/1] pull: add ff-only option
Date:   Mon, 23 Nov 2020 19:32:07 -0500
Message-Id: <C7B2K1BLPDIO.1D6XVJIWIG3UZ@ziyou.local>
In-Reply-To: <CAMP44s0r1vf7x-wHP-b6KQRU7mcPSZzcMRK2VqqxU_SJRDs+kg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Nov 23, 2020 at 7:08 PM EST, Felipe Contreras wrote:
> I'd have no objection in refactoring this option so it's used for
> both, but this breaks existing behavior. A user that has
> "pull.ff=3Donly", and does a "git pull --rebase" might expect it to
> work.
>
> My main interest is what happens when the user has not configured
> anything, which I defined with a "push.mode=3Ddefault", any option (e.g.
> --rebase/--merge) would override that default.

I feel like the parsimonious change to make is simply defaulting the
existing "pull.ff" to "only". I think someone who has set "pull.rebase"
expects pull --rebase behavior just as much as someone who passes
--rebase on the command line. The issue in question is what someone who
has not made any changes to the settings expects to happen with a plain
"git pull", and I certainly agree that people who are not power users
expect a fast-forward (I try not to force my opinions on workflow or
style when onboarding people to Git, but I do always recommend
"pull.ff=3Donly" because I know this is a perennial pitfall).

The problem is that, as it stands now, this would just leave the user
with a cryptic error message ("Not possible to fast-forward, aborting")
when they wanted to see remote changes. I think this might warrant an
even more expanded message than the short one in this patch, but I'm
not sure exactly what it should say - there are a few things the user
might expect, but an error message isn't the best place for a crash
course.
