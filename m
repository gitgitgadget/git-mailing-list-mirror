Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B710E1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 21:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbeKGGjq (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 01:39:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:42794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388465AbeKGGjq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 01:39:46 -0500
Received: (qmail 15654 invoked by uid 109); 6 Nov 2018 21:12:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 21:12:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4385 invoked by uid 111); 6 Nov 2018 21:11:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 16:11:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 16:12:35 -0500
Date:   Tue, 6 Nov 2018 16:12:35 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] pack-objects: ignore ambiguous object warnings
Message-ID: <20181106211234.GA8383@sigill.intra.peff.net>
References: <pull.68.git.gitgitgadget@gmail.com>
 <pull.68.v2.git.gitgitgadget@gmail.com>
 <002868ee6bec3dac38749d0f05bf2db8da0969a5.1541536484.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <002868ee6bec3dac38749d0f05bf2db8da0969a5.1541536484.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 12:34:47PM -0800, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> A git push process runs several processes during its run, but one
> includes git send-pack which calls git pack-objects and passes
> the known have/wants into stdin using object ids. However, the
> default setting for core.warnAmbiguousRefs requires git pack-objects
> to check for ref names matching the ref_rev_parse_rules array in
> refs.c. This means that every object is triggering at least six
> "file exists?" queries.  When there are a lot of refs, this can
> add up significantly! I observed a simple push spending three
> seconds checking these paths.

Thanks, this fills out the details from the cover letter a bit better.

> The fix here is similar to 4c30d50 "rev-list: disable object/refname
> ambiguity check with --stdin". Save the value of the global
> warn_on_object_refname_ambiguity variable (which is usually set to
> the boolean config variable core.warnAmbiguousRefs) and change the
> state to false. Do this only during the get_object_list() method
> which reads the objects from stdin.

I think this parenthetical isn't quite right. We never change the value
of warn_on_object_refname_ambiguity based on user config. It's just that
if warn_ambiguous_refs is off, we do not even bother looking at the
object_refname variant.

So we'd never expect to see anything except "1" in our save_warning
variable. Doing a save/restore is just about code hygiene and
maintainability.

Other than that minor nit, this whole thing looks good to me.

-Peff
