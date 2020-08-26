Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F1BC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 14:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35F121741
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 14:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHZOwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:52:36 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38699 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgHZOwY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 10:52:24 -0400
X-Originating-IP: 103.82.80.123
Received: from localhost (unknown [103.82.80.123])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6D657C0002;
        Wed, 26 Aug 2020 14:52:20 +0000 (UTC)
Date:   Wed, 26 Aug 2020 20:22:17 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-gui: accommodate for intent-to-add files
Message-ID: <20200826145217.gx2prxltyoyuoxo3@yadavpratyush.com>
References: <pull.699.git.1597244777943.gitgitgadget@gmail.com>
 <20200826113030.xnutfxxfmdhgoq5o@yadavpratyush.com>
 <nycvar.QRO.7.76.6.2008260936010.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2008260936010.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/08/20 09:36AM, Johannes Schindelin wrote:
> Hi Pratyush,
> 
> On Wed, 26 Aug 2020, Pratyush Yadav wrote:
> 
> > On 12/08/20 03:06PM, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > As of Git v2.28.0, the diff for files staged via `git add -N` marks them
> > > as new files. Git GUI was ill-prepared for that, and this patch teaches
> > > Git GUI about them.
> > >
> > > Please note that this will not even fix things with v2.28.0, as the
> > > `rp/apply-cached-with-i-t-a` patches are required on Git's side, too.
> > >
> > > This fixes https://github.com/git-for-windows/git/issues/2779
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >     git-gui: accommodate for intent-to-add files
> > >
> > >     This fixes the intent-to-add bug reported in
> > >     https://github.com/git-for-windows/git/issues/2779: after a file was
> > >     staged with git add -N, staging hunks/lines would fail silently.
> > >
> > >     On its own, this patch is not enough, as it requires the patches
> > >     provided in rp/apply-cached-with-i-t-a to be applied on Git's side.
> > >
> > >     Please note that this patch might need a bit more help, as I do not
> > >     really know whether showing "new file mode 100644" in the diff view is
> > >     desirable, or whether we should somehow try to retain the
> > >     "intent-to-add" state so that unstaging all hunks would return the file
> > >     to "intent-to-add" state.
> >
> > I built latest Git master (e9b77c84a0) which has
> > `rp/apply-cached-with-i-t-a` and tested this patch. It works... for the
> > most part.
> >
> > I can select a line set of lines and they get staged/unstaged, which is
> > good. The part that is not good though is that a lot of common
> > operations still don't work as they should:
> >
> > - I can't click on the icon in the "Unstaged Changes" pane to stage the
> >   whole file. Nothing happens when I do that.
> >
> > - The file that is marked as intent-to-add shows up in both the "Staged
> >   Changes" and "Unstaged Changes" panes, with the "Staged Changes" part
> >   being empty. Ideally it should only show up in the "Unstaged Changes"
> >   pane.
> >
> > - Selecting the whole file and choosing "Stage Lines for Commit" works
> >   well. But choosing "Stage Hunk for Commit" does not. While the changes
> >   do get staged, the UI is not properly updated and the file is still
> >   listed in the "Unstaged Changes" pane.
> >
> >   I think the difference here is because for
> >   `apply_or_revert_range_or_line`, we call `do_rescan` after it to
> >   update the UI, but for `apply_or_revert_hunk` we update the UI
> >   "manually" in the function after we are done applying or reverting the
> >   changes. So the logic to update the UI needs to be updated to account
> >   for this change. Or we can get rid of all that logic and just run a
> >   rescan.
> >
> > And also, like you mentioned, we don't retain the i-t-a state when
> > unstaging. But with some quick testing, I see that Git command line
> > doesn't either (I tried a plain `git restore --staged`). So IMO we
> > should mimic what the command line UI does and not retain the i-t-a
> > state when unstaging.
> 
> To be quite honest, I had hoped that this might be a good patch to start
> from... for somebody else (you?)

I'll take a stab at this during the weekend :-)

-- 
Regards,
Pratyush Yadav
