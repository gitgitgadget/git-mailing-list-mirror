Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E78C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BAE20739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCTFXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:23:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:44716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726897AbgCTFXP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 01:23:15 -0400
Received: (qmail 30928 invoked by uid 109); 20 Mar 2020 05:23:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Mar 2020 05:23:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2894 invoked by uid 111); 20 Mar 2020 05:32:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2020 01:32:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Mar 2020 01:23:14 -0400
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] t4124: fix test for non-compliance diff
Message-ID: <20200320052314.GB499858@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <285c6830c5182cb602d4fe559525083f69a158e9.1584625896.git.congdanhqx@gmail.com>
 <20200319163334.GG3513282@coredump.intra.peff.net>
 <20200320015223.GG1858@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320015223.GG1858@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 08:52:23AM +0700, Danh Doan wrote:

> > diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> > index 971a5a7512..15cb0c81b7 100755
> > --- a/t/t4124-apply-ws-rule.sh
> > +++ b/t/t4124-apply-ws-rule.sh
> > @@ -50,8 +50,9 @@ test_fix () {
> >  	# fix should not barf
> >  	apply_patch --whitespace=fix || return 1
> >  
> > -	# find touched lines
> > -	$DIFF file target | sed -n -e "s/^> //p" >fixed
> > +	# find touched lines; handle either normal or unified
> > +	# diff, as system diff may generate either
> > +	$DIFF file target | grep '^[>+][^+]' >fixed
> >  
> >  	# the changed lines are all expected to change
> >  	fixed_cnt=$(wc -l <fixed)
> > 
> > seems to work for with both busybox diff and GNU diff.
> 
> 3 lines after this one:
> 
> 	?*) expect_cnt=$(grep "[$1]" <fixed | wc -l) ;;
> 
> As of now, we could simply replace sed with grep entirely,
> because ! "$1" ~"[>+]".
> 
> Considering the complicated of:
> 
> 	test_expect_success "rule=$rule" '
> 		git config core.whitespace "$rule" &&
> 		test_fix "$tt$ts$ti$th"
> 	'
> 
> I think it's better to use sed here.

Fair enough. I think it's OK now, but I agree that it puts a pretty
subtle assumption into the test_fix function (and that's far removed
from what actual tests will call it with, so it's easy to miss). Using
sed should be more maintainable.

-Peff
