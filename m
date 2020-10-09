Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B47C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 11:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED7422268
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 11:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbgJILxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 07:53:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:54924 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732480AbgJILxg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 07:53:36 -0400
Received: (qmail 6293 invoked by uid 109); 9 Oct 2020 11:53:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Oct 2020 11:53:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1543 invoked by uid 111); 9 Oct 2020 11:53:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Oct 2020 07:53:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Oct 2020 07:53:35 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] contrib/git-resurrect.sh: use hash-agnostic OID
 pattern
Message-ID: <20201009115335.GA2855114@coredump.intra.peff.net>
References: <cover.1602139448.git.liu.denton@gmail.com>
 <6fad1fc7fdad98c3dda1ec334a10a6a9e311fef8.1602139448.git.liu.denton@gmail.com>
 <20201008161345.GD2823778@coredump.intra.peff.net>
 <20201008221101.GO1392312@camp.crustytoothpaste.net>
 <874kn3rfxy.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874kn3rfxy.fsf@igel.home>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 09:55:53AM +0200, Andreas Schwab wrote:

> >> >  search_merges () {
> >> >  	git rev-list --all --grep="Merge branch '$1'" \
> >> >  		--pretty=tformat:"%P %s" |
> >> > -	sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
> >> > +	sed -ne "/^$oid_pattern \($oid_pattern\) Merge .*/ {s//\1/p;$early_exit}"
> [...]
> I wonder why --pretty uses %s when it is filtered out again anyway?
> (There is also a duplicate --all.)

It does confirm that the commit in question is a (likely) merge commit,
and not one that happens to have "Merge branch 'foo'" in the body, which
the earlier --grep would have hit. But it doesn't actually check for
'foo' in the sed match, so it would be fooled by a commit message like:

  Merge branch 'bar'

    * bar:
      Merge branch 'foo'

If we wanted to tighten that up, then sed should match the branch name.
If we're willing to accept the looseness, the whole thing could probably
be:

  git rev-list --all --grep="Merge branch '$1'" \
    --min-parents 2 --parents ${early_exit:-"-1"} |
  awk '{print $3}'

I'm happy either way, but I'm not sure anybody overly cares. Let's not
derail Denton's actual fix to make the script work in a sha256 world.

-Peff
