Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA6DC04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 09:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiHYJlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 05:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiHYJlA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 05:41:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E99E0C4
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 02:40:59 -0700 (PDT)
Received: (qmail 14014 invoked by uid 109); 25 Aug 2022 09:40:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Aug 2022 09:40:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27540 invoked by uid 111); 25 Aug 2022 09:40:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Aug 2022 05:40:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Aug 2022 05:40:51 -0400
From:   Jeff King <peff@peff.net>
To:     Arturo Seijas Fernandez <arturo.seijas@canonical.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git config --unset is not idempotent
Message-ID: <YwdDo0yMAaJsCquk@coredump.intra.peff.net>
References: <CAHckPJS6ibtxbU+VKwDaU6pFMtJ5SMcWnBi6D2pY+ekqpWsqXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHckPJS6ibtxbU+VKwDaU6pFMtJ5SMcWnBi6D2pY+ekqpWsqXg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2022 at 10:52:16AM +0200, Arturo Seijas Fernandez wrote:

> The command "git config --unset [option]" is not idempotent. It is
> currently returning a success  code when the property had already been
> set and a 5 error code otherwise.
> 
> I would expect the error code to be set according to the current state
> when compared to the target state, regardless of the previous state of
> the option.

You can get what you want in the shell with:

  # passes "set -e", but could also be used in an "if"
  git config --unset ... || test $? = 5

That's obviously not as convenient. The flip side is that returning 0
would make it very hard for callers to tell if they removed something
(if they care).

If we were designing the tool now, I could definitely see an argument
for returning 0 in this case. But we have over a decade with the "5"
exit code documented for a plumbing tool. We won't change it now without
a good reason and without a deprecation schedule, and IMHO this doesn't
rise to that level.

-Peff
