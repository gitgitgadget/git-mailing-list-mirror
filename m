Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533DEC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 11:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B9564F72
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 11:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhBCLzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 06:55:42 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41411 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhBCLzk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 06:55:40 -0500
X-Originating-IP: 103.82.80.225
Received: from localhost (unknown [103.82.80.225])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BF6B31BF204;
        Wed,  3 Feb 2021 11:54:56 +0000 (UTC)
Date:   Wed, 3 Feb 2021 17:24:53 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: remove lines starting with the comment character
Message-ID: <20210203115453.5ahqba63kvxtdfyb@yadavpratyush.com>
References: <20210202200301.44282-1-me@yadavpratyush.com>
 <CAPig+cT+n3=o9AVyK6FUQ=88aqdnoCfSAxmAO0Xe9S84a9RBqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cT+n3=o9AVyK6FUQ=88aqdnoCfSAxmAO0Xe9S84a9RBqw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/02/21 05:26PM, Eric Sunshine wrote:
> On Tue, Feb 2, 2021 at 3:07 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > The comment character is specified by the config variable
> > 'core.commentchar'. Any lines starting with this character is considered
> > a comment and should not be included in the final commit message.
> >
> > Teach git-gui to filter out lines in the commit message that start with
> > the comment character. If the config is not set, '#' is taken as the
> > default.
> 
> Thanks. This shortcoming has bugged me for a long time. A few comments below...
> 
> > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> > ---
> > diff --git a/lib/commit.tcl b/lib/commit.tcl
> > @@ -209,6 +209,28 @@ You must stage at least 1 file before you can commit.
> >         set msg [string trim [$ui_comm get 1.0 end]]
> >         regsub -all -line {[ \t\r]+$} $msg {} msg
> > +
> > +       # Remove lines starting with the comment character.
> > +       set comment_char [get_config core.commentchar]
> > +       if {[string length $comment_char] > 1} {
> > +               error_popup [mc "core.commitchar should only be one character."]
> > +               unlock_index
> > +               return
> > +       }
> > +
> > +       if {$comment_char eq {}} {
> > +               set comment_char "#"
> > +       }
> > +
> > +       # If the comment character is not alphabetical, then we need to escape it
> > +       # with a backslash to make sure it is not interpreted as a special character
> > +       # in the regex.
> > +       if {![string is alpha $comment_char]} {
> > +               set comment_char "\\$comment_char"
> > +       }
> > +
> > +       regsub -all -line "$comment_char.*(\\n|\\Z)" $msg {} msg
> 
> This regular expression is too loose. It will incorrectly change:
> 
>     line one
>     line # two
>     # line three
>     line four
> 
> into:
> 
>     line one
>     line
>     line four
> 
> You could fix it by anchoring the start of the match while being
> careful not to lose the newline at the start of line. Perhaps like
> this:
> 
>     regsub -all -line "(^|\\A)$comment_char.*(\\n|\\Z)" $msg {} msg

Good catch!

> 
> However, an even better approach than doing this manipulation manually
> might be to pass the commit message through `git stripspace
> --strip-comments` which will do the exact normalization that Git
> itself does. That way, you don't have to worry about weird corner
> cases. Also, using git-stripspace may allow you to get rid of the
> existing `trim` and `regsub` which precede the new code you added.

This is exactly what I was looking for when I was writing the patch but 
didn't manage to find it. Will re-roll. Thanks.

-- 
Regards,
Pratyush Yadav
