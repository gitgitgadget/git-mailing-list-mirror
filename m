Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DFFC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E4B2077B
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfLLDzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:55:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:44736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726769AbfLLDzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 22:55:16 -0500
Received: (qmail 9725 invoked by uid 109); 12 Dec 2019 03:55:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Dec 2019 03:55:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11171 invoked by uid 111); 12 Dec 2019 03:59:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Dec 2019 22:59:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Dec 2019 22:55:15 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2] config: add string mapping for enum config_scope
Message-ID: <20191212035515.GB1200720@coredump.intra.peff.net>
References: <20191211233820.185153-1-emilyshaffer@google.com>
 <20191212031003.GA1196215@coredump.intra.peff.net>
 <20191212034547.GA226275@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191212034547.GA226275@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 07:45:47PM -0800, Emily Shaffer wrote:

> > There are no callers added here, so I'm not sure exactly how the new
> > function is meant to be used. But I'd caution that it might be worth
> > showing the scope _and_ the path, instead of one or the other.
> 
> Yeah, I hear you - I had added this originally to the config-based hooks
> topic to get an output like this:
> 
> $ git hook --list pre-commit
> 001	global	~/foo.sh
> 002	local	~/bar.sh
> 
> That's a scenario where it might be handy to add the path, especially if
> it's coming in via an import, sure. (For brevity I think I'd want to
> turn it on via an argument.)

Yeah, there I think showing the file path would be helpful.

> As I was working through the comments on v3 of git-bugreport, though, I
> saw a request to add the origin of the configs - and that's a case where
> I don't necessarily want someone to see, say:
> 
> [Selected Configs]
> user.name (/home/emily/robot-revolution/stairclimber/.git/config) : Emily Shaffer
> 
> when I mail that bugreport to the Git list.

Yeah, agreed. You'd want less information there, because we should be
sensitive to sharing user filesystem paths.

> So, I think I hear what you're saying - use wisely - but I think it's OK
> for a user to say:
> 
>   printf("%s (%s): %s = %s\n",
>          current_config_name(),
> 	 config_scope_to_string(current_config_scope()),
> 	 var,
> 	 value);
> 
> That is, I don't think the right solution is to make
> current_config_name() provide a stringification of
> current_config_scope() as well.

Yes, I think the way you're thinking about it all makes sense. We
definitely can't just change current_config_name(); its output ends up
in --show-origin, which is plumbing.

> Or, I guess we can decide that the bugreport scenario is different
> enough that this helper should exist only there, and everybody else
> should use current_config_name().

No, I think this helper makes sense in config.c. And then callers can
choose how much (and in what format) to show the various bits as
appropriate.

So this seems like the right direction.

-Peff
