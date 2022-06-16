Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DDFC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 22:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbiFPWhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiFPWha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 18:37:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8431AE
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:37:28 -0700 (PDT)
Received: (qmail 15960 invoked by uid 109); 16 Jun 2022 22:37:28 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jun 2022 22:37:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 16 Jun 2022 18:37:27 -0400
From:   Jeff King <peff@peff.net>
To:     Brad Forschinger via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Brad Forschinger <bnjf@bnjf.id.au>
Subject: Re: [PATCH] git-prompt: use builtin test
Message-ID: <YquwpxEoAVWen8tZ@coredump.intra.peff.net>
References: <pull.1260.git.1655197751403.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1260.git.1655197751403.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 09:09:11AM +0000, Brad Forschinger via GitGitGadget wrote:

> From: Brad Forschinger <bnjf@bnjf.id.au>
> 
> The test and [ commands are used throughout the prompt generation.  They
> also happen to be valid function names that can be defined, leading to
> unintentional results.  Prevent the somewhat unusual case of this
> happening by simply using [[, which is reserved.

Hmm. I do think we need to be a bit more paranoid about style in the
prompt and completion code, because they are sourced into the user's
shell alongside whatever other weird customizations they'd have. So we
already have adjustments to work under "set -u", and so forth.

But at some point we may say "you have made the environment too hostile
for us to function". Is redefining "test" to something that doesn't
behave the same way such a case? Part of me wants to say yes. :)

That said, if it's not _hard_ to support, maybe it is worth doing to be
on the cautious side? A few thoughts:

  - my biggest concern on cost is that this is an unusual style for our
    project (which usually writes in POSIX shell, though of course this
    file is meant to be bash/zsh specific). Will it be a maintenance
    burden going forward?

  - this only changes git-prompt.sh; doesn't the completion code have
    the same issue?

  - I don't write much bash-specific code, but I seem to recall that
    "[[" has some subtle differences to "[". Is it sufficiently a
    superset that these conversions are all equivalent?

    I think some like:

> -	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
> +	if [[ $pcmode = yes ]] && [[ $ps1_expanded = yes ]]; then

    are not equivalent, but it's an actual improvement (bash's builtin
    "[[" isn't confused by unquoted empty variables), but I don't know
    if there may be other gotchas.

    (I doubt this is an actual bug in the current code, as $pcmode
    always seems to be set, but just a more defensive style).

-Peff
