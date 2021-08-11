Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D60C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE07660E78
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhHKXII (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:08:08 -0400
Received: from avasout04.plus.net ([212.159.14.19]:33770 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhHKXIH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 19:08:07 -0400
Received: from satellite ([147.147.167.4])
        by smtp with ESMTPA
        id DxJzmDZb4OQhvDxK1mVl73; Thu, 12 Aug 2021 00:07:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1628723261; bh=U1KGIZZt+agujaeggvrhp6S/KSQGySQ+PoXO1YXlcAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AA/EUHikdGMh+LPKU83A2H6rKZPVF3xkZ3xKklpe5TVi9Y7s+wNkAV/xPmHjU7ePu
         7YI98d8PJUd4B9YtqTP+V1XOhT20Z4BZdT/jsjwvZxO62zTiKyDkFzJFfdNlPOowV0
         IS1fEDSy0xiCOATEc8pJJC6iCo9Ct9c3KXWmrdh21YB2h3B2vLYkyb29c9HwJgBcWn
         g2CtSMJiqMvLS2jZnrbr1uwjFP8XLlUah7TTe/cLF5t9gZ0vJXqqLgsv0ac9XKSxbi
         ShLtCY9fba+n89W5mgdv3sUUI92qn5NkUhz36Q/tKR9v7TVqEig4Ab1qCVHug47iX1
         h6dc9OTVV0E+A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IvmFjI3g c=1 sm=1 tr=0
 a=ClpcMUpIpdFe3QrT4g3KPA==:117 a=ClpcMUpIpdFe3QrT4g3KPA==:17
 a=kj9zAlcOel0A:10 a=1XWaLZrsAAAA:8 a=C4bOBg53Muni8pNyyUIA:9 a=CjuIK1q_8ugA:10
X-AUTH: ramsayjones@:2500
Date:   Thu, 12 Aug 2021 00:07:38 +0100
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/7] grep: typesafe versions of grep_source_init
Message-ID: <YRRYOmwW9yKhvldn@satellite>
References: <cover.1628618950.git.jonathantanmy@google.com>
 <e5e6a0dc1ef59b2ab419816e463814d93115e7f6.1628618950.git.jonathantanmy@google.com>
 <YRREPNA8GPyKdWBr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRREPNA8GPyKdWBr@google.com>
X-CMAE-Envelope: MS4wfNYeo45oFafd5z7y71dX4xZ+Dof/+k3bnPZIjbSUyjRbeCAbJS0rCO7XvWn+GFbI3XnrcrzF1CVogbtXNGFqcnvlulctgOrAOv3bpOeuB5nJXRoTO2E6
 u/GrxXyhtYOrmcrzft7sOBXQcS2+5fiaYM2cHl1g3xkgyea1Dcn76dGM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 02:42:20PM -0700, Emily Shaffer wrote:
> On Tue, Aug 10, 2021 at 11:28:41AM -0700, Jonathan Tan wrote:
> > 
> > grep_source_init() can create "struct grep_source" objects and,
> > depending on the value of the type passed, some void-pointer parameters have
> > different meanings. Because one of these types (GREP_SOURCE_OID) will
> > require an additional parameter in a subsequent patch, take the
> > opportunity to increase clarity and type safety by replacing this
> > function with individual functions for each type.
> > 
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Like Junio said, it is very neat.

[Sorry for piggy-backing, I have already deleted the original mail :( ]

Just a quick note: grep_source_init_buf() is only called from
grep.c:1833, before its definition at grep.c:1869, so it could be marked
as static (as things stand). Do you anticipate any future callers from
outside of grep.c? (after removing the declaration from grep.h, you
would need to add a forward declaration or, better, move the definition
to before the call (or the call (and grep_buffer()) after the definition)).

ATB,
Ramsay Jones


