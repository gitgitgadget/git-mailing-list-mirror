Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC0C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 07:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72CD61184
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 07:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhHWHV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 03:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhHWHV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 03:21:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD11C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OpHMPlkkRFvFuyShNpo7SkIL80ub85YcnY03DUGDHSE=;
        t=1629703274; x=1630912874; b=XAm6ZaxImYiCmc29H9HW11+5q8j3hSmju7nJmvGu0RFbKPO
        UHwvPcuZj+WpIaRleCUgi147bL7qLD/1hqonyXVaFvkBWy0a2LJ8P3Fw4yME8JoDTe0Q/MYT8YlUj
        BDY5I83ZwQ7GqxelulpU8GWO0DJBkvI4FI5gaJFaHFulDmPFqGZMScWKFS+U+gyEPzj2Z2l1+6C6a
        mF/uomL58tpYWTrKwn2jW3y6Xnh4yJgNxysVIevsGJjzGm/qowP9h2N2izuUE4bP4W7LXiPa0waR9
        bHG4mW53p2K+sPfvqb8dACfpIcp2KyreOTElpYeoLE95GIVS4VeiWRBtjPSCZvrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mI4Gd-00EkWD-Ot; Mon, 23 Aug 2021 09:21:11 +0200
Message-ID: <4d65ef5b0a9e4104d763facc42d10a20557d054d.camel@sipsolutions.net>
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Date:   Mon, 23 Aug 2021 09:21:10 +0200
In-Reply-To: <04ed58aa-94fa-010e-f4db-f41cd51876a5@gmail.com>
References: <20210820193504.37044-1-johannes@sipsolutions.net>
         <04ed58aa-94fa-010e-f4db-f41cd51876a5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> > +test_expect_success 'multi-pack-index with --object-dir need not be in repo' '
> > +	p="$(pwd)" &&
> > +	rm -f $objdir/multi-pack-index &&
> > +	cd / &&
> > +	git multi-pack-index --object-dir="$p/$objdir" write &&
> > +	cd "$p"
> 
> Why are you using "cd /" here? 
> 

I just needed to go outside the current test git directory, the tests
are running in a way that the current working directory is already the
git tree I'm operating in.

> Even if you mean to use "cd",
> please do so within a sub-shell.

I thought about it, but clearly all the tests are run in a sub-shell, so
it didn't seem necessary? But happy to change, I don't really care
either way.

Could you instead init a new repo within the current directory
and point the object-dir to that location?

I guess I could, but all the other stuff in here is already making a new
repo in the current working dir, and already initializing it with
objects, etc.

Doing it all over again seemed like a waste of time?

It could look something like this, (warning: I did not test this)

	git init other &&
	test_commit -C other first &&
	git multi-pack-index --object-dir=other/.git/objects write

Sure.

Actually, this won't work to test for the crash, I'd have to do
something like

git init other
test_commit -C other first &&
(
mkdir non-git &&
cd non-git &&
git multi-pack-index --object-dir=../other/.git/objects write
)

or so.

And is the only post-condition you are checking that we do not
crash?

Yes, I was assuming that it'd actually work at that point - maybe not
the best assumption, it could (erroneously) exit with a 0 exit status
but have done nothing.

> Or is there a specific result you are looking for? For
instance, we can double check that the MIDX was written:

	test_path_is_file other/.git/objects/pack/multi-pack-index

So I guess that would be a good idea.

but also you seem to be touching areas that delete files. Could
we 'touch' some of those and then see them get deleted?

Ah, well, that's the underlying issue but I'm not sure we even ever get
to that code? Then again, yes, the *.rev files should get removed, I'll
see - not even sure I know how to get them to be generated in the first
place, is that even supported already?

johannes

