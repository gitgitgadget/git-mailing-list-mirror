Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D261C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 13:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFEF2075F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 13:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="YHI9nIaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbgI3N3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 09:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgI3N2y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 09:28:54 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8127EC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nY4nWVDWGN52tDMfwY36G88UKcH76ekY/snStl3TtbM=; b=YHI9nIaDDWY7KgaMR7F9goV0rj
        rpY0It+5GzNC+Jdyes31NxzMz6WxGcUxlbh7ihMkQ7KC71zrBXBDQuhOx99YDw0VBrRoyz4FabQ1b
        5yzyLjiJXUbunGx2FwJd86gwxXt16smsFQolw+H0o9Gellso6jZWGaujNK9SmdruNV60=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.home.arpa)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1kNcA7-0001Qj-Lv; Wed, 30 Sep 2020 13:28:51 +0000
Date:   Wed, 30 Sep 2020 14:28:46 +0100
From:   Andrew Oakley <andrew@adoakley.name>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, luke@diamand.org
Subject: Re: [PATCH 0/7] Submodules and partial clones
Message-ID: <20200930142846.0eeaa33a@ado-tr.home.arpa>
In-Reply-To: <20200929180508.118066-1-jonathantanmy@google.com>
References: <20200929155350.49066-1-andrew@adoakley.name>
        <20200929180508.118066-1-jonathantanmy@google.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 29 Sep 2020 11:05:08 -0700
Jonathan Tan <jonathantanmy@google.com> wrote:

> > I've been investigating what is required to get submodules and
> > partial clones to work well together.  The issue seems to be that
> > the correct repository is not passed around, so we sometimes end up
> > trying to fetch objects from the wrong place.
> > 
> > These patches don't make promisor_remote_get_direct handle different
> > repositories because I've not found a case where that is necessary.
> 
> Anything that reads a submodule object without spawning another
> process to do so (e.g. grep, which adds submodule object stores as
> alternates in order to read from them) will need to be prepared to
> lazy-fetch objects into those stores.

Yes, grep just calls `add_to_alternates_memory` and will be broken.

When handling nested submodules `config_from_gitmodules` does the same
thing, so that will also be broken if some of the .gitmodules files
need fetching.

Fixing these probably does require supporting fetching of objects from
submodules.

> > The patches rework various cases where objects from a submodule are
> > added to the object store of the main repository.  There are some
> > remaining cases where add_to_alternates_memory is used to do this,
> > but add_submodule_odb has been removed.
> > 
> > I expect there will be some remaining issues, but these changes
> > seem to be enough to get the basics working.  
> 
> What are the basics that work?

I've tried at least the following, in a repo with several submodules and
large objects (but no nested submodules):
- git clone --recursive --filter=blob:limit=1M ...
- git pull --rebase --recurse-submodules=on-demand
- git show --submodue=diff <commit-with-big-submodule-object>
- git push --recurse-submodules=check
- git push --recurse-submodules=on-demand

I used the partial clone for a while and didn't hit any problems, but I
can't say what (relevant) commands I might have used.

An important thing that I've not tried is a merge that needs to fetch
objects.  I should probably write a testcase for that.

> When I looked into this, my main difficulty lay in getting the
> lazy fetch to work in another repository. Now that lazy fetches are
> done using a separate process, the problem has shifted to being able
> to invoke run_command() in a separate Git repository. I haven't
> figured out the best way to ensure that run_command() is run with a
> clean set of environment variables (so no inheriting of GIT_DIR
> etc.), but that doesn't seem insurmountable.

Yes, I think that to fix promisor_remote_get_direct we need to:
- store the promisor configuration per-repository
- run the fetch process in the correct repository

AFAICT we just need to set cp.dir and call prepare_submodule_repo_env
to get the right environment for the fetch process. The per-repository
configuration looks more fiddly to do.  I'm happy to try and make these
additional changes (but it won't be quick as I'm busy with the day job).

In any case we need to pass the right repository around.
