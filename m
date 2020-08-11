Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3650DC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C91F20774
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgHKSSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:18:51 -0400
Received: from aibo.runbox.com ([91.220.196.211]:52608 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgHKSSu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:18:50 -0400
Received: from [10.9.9.72] (helo=submission01.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <antti@keraset.fi>)
        id 1k5YjI-00010J-BO; Tue, 11 Aug 2020 20:10:32 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated alias (932218)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1k5Yj4-0006xn-7c; Tue, 11 Aug 2020 20:10:18 +0200
Date:   Tue, 11 Aug 2020 21:10:17 +0300
From:   Antti =?utf-8?Q?Ker=C3=A4nen?= <antti@keraset.fi>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>,
        git@vger.kernel.org,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
Message-ID: <20200811181017.jjbryeiepcsutnki@haukka.localdomain>
References: <20200811131313.3349582-1-detegr@rbx.email>
 <20200811152832.GC19871@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811152832.GC19871@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Tue, Aug 11, 2020 at 11:28:32AM -0400, Taylor Blau wrote:
> Hi Antti,
> 
> Thanks for working on this. I have a few thoughts below, but I think
> that this is on the right track.
> 
> On Tue, Aug 10, 2020 at 04:13:15PM +0300, Antti Keränen wrote:
> > 'todo_list_write_to_file' may overwrite the static buffer, originating
> > from 'find_unique_abbrev', that was used to store the short commit hash
> > 'c' for "# Rebase a..b onto c" message in the todo editor.
> 
> It would be great to know the commit that regressed, or if this has
> always been the case. I'm not sure if you'll have a ton of luck
> bisecting, since you indicate that this overwrite *may* occur (that
> makes me think that it doesn't always happen, so your efforts to bisect
> the change may be noisy).

This was introduced when interactive rebase was refactored. The first
commit is 94bcad797966b6a3490bc6806d3ee3eed54da9d9. Would you like to
have this information in the commit message also?

The reason I stated it may occur is that the buffer find_unique_abbrev
returns is valid for 4 more calls. So the rebase must have 4 commits in
it before this happens.

> > Fix by duplicating the string before usage, so subsequent calls to
> > 'find_unique_abbrev' or other functions calling 'hash_to_hex_algop_r'
> > can't overwrite the buffer.
> >
> > Found-by: Jussi Keränen <jussike@gmail.com>
> > Signed-off-by: Antti Keränen <detegr@rbx.email>
> 
> > ---
> >  sequencer.c                   |  7 ++++---
> >  t/t3404-rebase-interactive.sh | 13 +++++++++++++
> >  2 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index fd7701c88a..0679adb639 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -5178,13 +5178,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
> >  		    struct string_list *commands, unsigned autosquash,
> >  		    struct todo_list *todo_list)
> >  {
> > -	const char *shortonto, *todo_file = rebase_path_todo();
> > +	const char *todo_file = rebase_path_todo();
> >  	struct todo_list new_todo = TODO_LIST_INIT;
> >  	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
> >  	struct object_id oid = onto->object.oid;
> >  	int res;
> > -
> > -	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
> > +	char *shortonto;
> 
> A minor nit is that you could probably move this line up to below the
> 'const char *' declaration (it makes sense why you have to drop the
> const qualifier, though).

Ack.

> > +	shortonto = xstrdup(find_unique_abbrev(&oid, DEFAULT_ABBREV));
> >  	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
> >  			     shortonto, flags);
> > +	free(shortonto);
> 
> OK. I think of two things here:
> 
>   1. Why are we calling 'find_unique_abbrev()' instead of
>      'short_commit_name()'? We already have a commit pointer, so I don't
>      see any reason that we should be reimplementing that function (even
>      though it is a one-liner).
> 
>   2. If we should indeed be calling 'short_commit_name()', are there
>      other callers that need to do the same duplication? In other words:
>      could you say a little bit more about what makes
>      'complete_action()' special in this regard?

Good question. The code used find_unique_abbrev and as I'm new to the
code base I did not notice that short_commit_name essentially does the
same thing.

The reason what makes this special is that this code first calls
find_unique_abbrev which, as we know, stores its information to a static
buffer. The pointer is stored in a variable and it is assumed it does
not change.
Afterwards, it calls edit_todo_list that reuses the buffer before it
accesses the shortonto string, meaning that if we have enough commits in
the rebase, the shortonto string is overwritten.

Actually, now that you asked, I noticed that orig_head in
complete_action (actually comes from get_revision_ranges in
builtin/rebase.c) may be affected as well. Though, I'm not sure whether
there are enough calls to find_unique_abbrev in the execution path when
it is being used to actually cause a rewritten buffer. It wouldn't hurt
to duplicate it too just in case.

-- 
Antti
