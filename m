Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C3401F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfBULTx convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 21 Feb 2019 06:19:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:42028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfBULTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:19:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC5EBACB5;
        Thu, 21 Feb 2019 11:19:51 +0000 (UTC)
Date:   Thu, 21 Feb 2019 12:19:50 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] setup: don't fail if commondir reference is
 deleted.
Message-ID: <20190221121950.12d24e53@naga.suse.cz>
In-Reply-To: <CAPig+cS4vZpyj4Cx=Q89v3xTrCG4WbtX8EhTfOT2RKytjV-HrA@mail.gmail.com>
References: <cover.1550508544.git.msuchanek@suse.de>
        <37df7fd81c3dee990bd7723f18c94713a0d842b6.1550679076.git.msuchanek@suse.de>
        <CAPig+cQZNOWvaa5H2PKOs149KvRtEYRzrdLvzvFRDo4Qxaecaw@mail.gmail.com>
        <20190220181605.60bbc28d@kitsune.suse.cz>
        <CAPig+cS4vZpyj4Cx=Q89v3xTrCG4WbtX8EhTfOT2RKytjV-HrA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Feb 2019 13:35:57 -0500
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Wed, Feb 20, 2019 at 12:16 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > On Wed, 20 Feb 2019 11:55:46 -0500
> > Eric Sunshine <sunshine@sunshineco.com> wrote:  

> > > Following this change, that particular validation no longer takes
> > > place. But, more importantly, what does it mean to fall back to
> > > "default" for this particular worktree? I'm having trouble
> > > understanding how the new behavior can be correct or desirable. (Am I
> > > missing something obvious?)  
> >
> > If the file can be missing altogether and it is not an error how it is
> > incorrect or undesirable to ignore zero size file?  
> 
> Because the _presence_ of that file indicates a linked worktree,
> whereas it's absence indicates the main worktree. If the file is
> present but empty, then that is an abnormal condition, i.e. some form
> of corruption.
> 
> The difference is significant, and that's why I'm asking if the new
> behavior is correct or desirable. If you start interpreting this
> abnormal condition as a non-error, then get_common_dir_noenv() will be
> reporting that this is the main worktree when in fact it is (a somehow
> corrupted) linked worktree. Such false reporting could trigger
> undesirable and outright wrong behavior in callers.

This is not an issue introduced with this patch, however. The worktree
is not initialized atomically. First the worktree directory is created
and then it is populated with content including the commondir reference.

Because there is no big repository lock that everyone takes to access
a repository other running git processes can see the wotktree without
the commondir file. 

The way this is mitigated in users of get_worktrees() is an assumption
that the first worktree is the main worktree.

If this is sufficient is not something this patchset aims to address.
It merely addresses get_worktrees() aborting due to hitting specific
stage in the initialization of a worktree.

Thanks

Michal
