Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5491F453
	for <e@80x24.org>; Wed, 20 Feb 2019 17:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfBTRQK (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 12:16:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:47774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbfBTRQK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 12:16:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4ACD8B007;
        Wed, 20 Feb 2019 17:16:08 +0000 (UTC)
Date:   Wed, 20 Feb 2019 18:16:05 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] setup: don't fail if commondir reference is
 deleted.
Message-ID: <20190220181605.60bbc28d@kitsune.suse.cz>
In-Reply-To: <CAPig+cQZNOWvaa5H2PKOs149KvRtEYRzrdLvzvFRDo4Qxaecaw@mail.gmail.com>
References: <cover.1550508544.git.msuchanek@suse.de>
        <37df7fd81c3dee990bd7723f18c94713a0d842b6.1550679076.git.msuchanek@suse.de>
        <CAPig+cQZNOWvaa5H2PKOs149KvRtEYRzrdLvzvFRDo4Qxaecaw@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Feb 2019 11:55:46 -0500
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Wed, Feb 20, 2019 at 11:17 AM Michal Suchanek <msuchanek@suse.de> wrote:
> > Apparently it can happen that stat() claims there is a commondir file but when
> > trying to open the file it is missing.  
> 
> Under what circumstances?

I would like to know that as well. The only command tested was worktree
add which should not remove the file. Nonetheless running many woktree
add commands in parallel can cause the file to go away for some of
them. For many commands git calls itself recursively so there is
probably much more going on than the single function that creates the
worktree.

> 
> > Another even rarer issue is that the file might be zero size because another
> > process initializing a worktree opened the file but has not written is content
> > yet.  
> 
> Based upon the explanation thus far, I'm having trouble understanding
> under what circumstances these race conditions can arise. Are you
> trying to invoke Git commands in a particular worktree even as the
> worktree itself is being created?

It's explained in the following paragraph. If you have multiple
worktrees some *other* worktreee may be uninitialized.

> 
> Without this information being spelled out clearly, it is going to be
> difficult for someone in the future to reason about why the code is
> the way it is following this change.
> 
> > When any of this happnes git aborts failing to perform perfectly valid
> > command because unrelated worktree is not yet fully initialized.  
> 
> s/happnes/happens/
> 
> > Rather than testing if the file exists before reading it handle ENOENT
> > and ENOTDIR.  
> 
> One more comment below...
> 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > diff --git a/setup.c b/setup.c
> > @@ -270,12 +270,20 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
> >  {
> >         strbuf_addf(&path, "%s/commondir", gitdir);
> > -       if (file_exists(path.buf)) {
> > -               if (strbuf_read_file(&data, path.buf, 0) <= 0)
> > +       ret = strbuf_read_file(&data, path.buf, 0);
> > +       if (ret <= 0) {
> > +               /*
> > +                * if file is missing or zero size (just being written)
> > +                * assume default, bail otherwise
> > +                */
> > +               if (ret && errno != ENOENT && errno != ENOTDIR)
> >                         die_errno(_("failed to read %s"), path.buf);  
> 
> It's not clear from the explanation given in the commit message if the
> new behavior is indeed sensible. The original intent of the code, as I
> understand it, is to validate "commondir", to ensure that it is not
> somehow corrupt (such as the user editing it and making it empty).

How is it validated in the code below when it is non-zero size?

There is *no* validation whatsoever. Yet zero size is somehow totally
unacceptable and requires that git working in *any* worktree aborts if
commondir file in *any* worktree is zero size.

> Following this change, that particular validation no longer takes
> place. But, more importantly, what does it mean to fall back to
> "default" for this particular worktree? I'm having trouble
> understanding how the new behavior can be correct or desirable. (Am I
> missing something obvious?)

If the file can be missing altogether and it is not an error how it is
incorrect or undesirable to ignore zero size file?

Thanks

Michal
