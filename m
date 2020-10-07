Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C48FC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 11:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266E520872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 11:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgJGLIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 07:08:01 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44515 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgJGLH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 07:07:57 -0400
X-Originating-IP: 103.82.80.10
Received: from localhost (unknown [103.82.80.10])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B51BB60002;
        Wed,  7 Oct 2020 11:07:53 +0000 (UTC)
Date:   Wed, 7 Oct 2020 16:37:51 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] git-gui: Basic dark mode support
Message-ID: <20201007110751.237kem2mlnb7hbrk@yadavpratyush.com>
References: <20200922110419.ymqj4ol76kg6qshf@yadavpratyush.com>
 <20200926145443.15423-1-serg.partizan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926145443.15423-1-serg.partizan@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Serg,

On 26/09/20 05:54PM, Serg Tereshchenko wrote:
> Hi Pratyush.
> 
> > Wouldn't having the contents of colored.tcl in themed.tcl be a good 
> > idea? The way I see it, colors are part of the theming of the 
> > application.
> 
> You are right, fixed this.
> 
> > You can set that in the function `rmsel_tag` in git-gui.sh on the line
> 
> Thanks, it worked!
> 
> >> I would be happy to move color definitions from git-gui.sh to
> >> themed.tcl, so we can set it once, and not for each ttext call. Do you
> >> think this is a good idea now or in the future?
> >
> >Do you mean to put the `-foreground` and `-background` options in the 
> >function ttext in themed.tcl? If so how can a widget specify if it wants 
> >a dark text or light for example?
> 
> Turns out ttext was always using black/white colors, so i just removed
> it from ttext calls and used `option add` to set default colors.

Ok. Sounds like a good idea.
 
> And if some widget needs to different, it can be implemented like
> existing gold_frame.
> 
> Or like theoretical `ttext_inverse`, which just calls ttext with
> -background -foreground swapped. Or maybe we can come up with something
> better. Main idea is to keep all theme-related code in themed.tcl.
> 
> > Why have `textOnLight`, `textOnDark` and `textColor` separately? My 
> > guess is that it is for when you want to force light colors regardless 
> > of the theme? Am I right?
> 
> Something like that, i was using it for tlabel like this:
> > tlabel ... -background $Color::lightGreen -foreground $Color::textOnLight
> 
> But, it was actually not related to current task, so i just reverted
> that changes and focused only on getting basic dark theme support.

Ok.
 
> > Nitpick: please use snake_case for variable names like the rest of the 
> > code does. Same for the function name below and the namespace name 
> > above.
> 
> Fixed. I was confused by InitTheme and InitEntryFrame.
> 
> --
> Regargs,
> Serg Tereshchenko
> 
> --- 8< ---
> Removed forced colors in ttext widget calls,
> instead using Text.Background/Foreground options.
> This way colors can be configured dependent on current theme, and even
> overriden by user via .Xresources.
> 
> Extracted colors for in_sel/in_diff tags into colors:: namespace,
> where they can be configured from current theme colors.

The commit message could be improved. It should first describe the 
problem it is trying to solve, why it is worth solving, and then tell 
the codebase to fix it. The details of how it is done can be learned 
from the contents of the patch, so they are not as important.

How about the message below?

  The colors of some ttext widgets are hard-coded. These hard-coded 
  colors are okay with a light theme but with a dark theme some widgets 
  are dark colored and the hard-coded ones are still light. This defeats 
  the purpose of applying the theme and makes the UI look very awkward.

  Remove the hard-coded colors in ttext calls and use colors from the 
  theme for those widgets via Text.Background and Text.Foreground from 
  the option database.

  Similarly, the highlighting for the currently selected file(s) in the 
  "Staged Files" and "Unstaged Files" sections is also hard-coded. Pull 
  the colors for that from the current theme to make sure it is in line 
  with the rest of the theme colors.

No need to resend. I'll use this message when applying unless you have 
any suggestions or objections.
 
> Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
> ---
>  git-gui.sh     | 17 +++++++++++------
>  lib/themed.tcl | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 6 deletions(-)

The rest of the patch looks good. Will apply. Thanks.

-- 
Regards,
Pratyush Yadav
