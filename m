Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F18C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 05:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B82227BF
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 05:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfLSFFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 00:05:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:50038 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725817AbfLSFFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 00:05:47 -0500
Received: (qmail 21638 invoked by uid 109); 19 Dec 2019 05:05:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Dec 2019 05:05:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1471 invoked by uid 111); 19 Dec 2019 05:10:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Dec 2019 00:10:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Dec 2019 00:05:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] config: allow user to know scope of config options
Message-ID: <20191219050545.GC89333@coredump.intra.peff.net>
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
 <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
 <xmqqa77pe7sx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa77pe7sx.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 11:46:06AM -0800, Junio C Hamano wrote:

> It almost makes me point fingers at config.c::config_with_options()
> where config_source is inspected and git_config_from_*() helpers are
> called without setting the current_parsing_scope.  Unlike these
> cases, when do_git_config_sequence() is called from that function,
> the scope is recorded in the variable before each standard config
> source file is opened and read.  What would we be breaking if we
> taught the function to set the current_parsing_scope variable
> correctly even when reading from the config_source?  That would
> certainly simplify this function quite a lot, but if the other parts
> of the codebase relies on the current behaviour, we cannot make such
> a change lightly.

As the author of the SCOPE enum, I think this is the right direction.
The only users of current_config_scope() are in config callbacks (e.g.,
upload_pack_config() checks it for the "packobjectshook"), which you
couldn't trigger via "git config" anyway.

The main reason I didn't set the scope before in config_with_options()
is that it's not given the scope at all; git-config resolves it to the
filename. So if git_config_source grows an enum to select the type, and
all that filename-resolution gets pushed down into config_with_options(),
the whole thing would fall out naturally, I think.

-Peff
