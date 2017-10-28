Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB262055E
	for <e@80x24.org>; Sat, 28 Oct 2017 15:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbdJ1Ppx (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 11:45:53 -0400
Received: from li1734-10.members.linode.com ([172.104.124.10]:51946 "EHLO
        jhelom.anthonywong.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdJ1Ppw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 11:45:52 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43])
        by jhelom.anthonywong.net with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <yp@anthonywong.net>)
        id 1e8TJ0-0008Gt-CU
        for git@vger.kernel.org; Sat, 28 Oct 2017 23:45:51 +0800
Received: by mail-vk0-f43.google.com with SMTP id h142so2399427vkf.7
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 08:45:50 -0700 (PDT)
X-Gm-Message-State: AMCzsaXZ4mX0o4Dre5m4REb+2ueYU8KebaIBSO/N57uzkfw9KRNUVCUW
        u0Ze4I0IJq2MGMqcxyAHrHRLo4HEY1xMJXZALWs=
X-Google-Smtp-Source: ABhQp+QFkstfEopzrSXzrPFOQ3EkhtbQJPClpz3jyhNse7aUnVBfcwI8TTiFH1S+sYhterjISU+QMILitnmjlk4z9Jc=
X-Received: by 10.31.189.205 with SMTP id n196mr3180807vkf.140.1509205543757;
 Sat, 28 Oct 2017 08:45:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.55.165 with HTTP; Sat, 28 Oct 2017 08:45:03 -0700 (PDT)
From:   Anthony Wong <yp@anthonywong.net>
Date:   Sat, 28 Oct 2017 23:45:03 +0800
X-Gmail-Original-Message-ID: <CAC=0FnGyYzOReS4-ZA8E99DHpgnn9waFm6-fc=D8_QghSQQ_cQ@mail.gmail.com>
Message-ID: <CAC=0FnGyYzOReS4-ZA8E99DHpgnn9waFm6-fc=D8_QghSQQ_cQ@mail.gmail.com>
Subject: Re: [PATCH] cherry-pick: add --keep-existing-origin option
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 October 2017 at 22:21, Kevin Daudt <me@ikke.info> wrote:
>
> On Sat, Oct 28, 2017 at 08:04:40PM +0800, Anthony Wong wrote:
> > When cherry-picking from a commit whose commit message already
> > contains the "(cherry picked from commit ...)" line, this option will
> > not add another one. This is useful when you are cherry-picking from a
> > bunch of commits, some are cherry-picks and already contains the
> > upstream hash but some do not. Use with -x.
> >
> > Signed-off-by: Anthony Wong <yp@anthonywong.net>
> > ---
> >  Documentation/git-cherry-pick.txt |  8 ++++++++
> >  builtin/revert.c                  |  2 ++
> >  sequencer.c                       | 14 ++++++++------
> >  sequencer.h                       |  1 +
> >  4 files changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> > index d35d771fc..7a074511f 100644
> > --- a/Documentation/git-cherry-pick.txt
> > +++ b/Documentation/git-cherry-pick.txt
> > @@ -71,6 +71,14 @@ OPTIONS
> >       development branch), adding this information can be
> >       useful.
> >
> > +--keep-existing-origin::
> > +     This option has to be used with -x to take effect. When
> > +     cherry-picking from a commit whose commit message already
> > +     contains the "(cherry picked from commit ...)" line, this
> > +     option will not add another one. This is useful when you are
> > +     cherry-picking from a bunch of commits, some are cherry-picks
> > +     and already contains the upstream hash but some do not.
> > +
> >  -r::
> >       It used to be that the command defaulted to do `-x`
> >       described above, and `-r` was to disable it.  Now the
> > diff --git a/builtin/revert.c b/builtin/revert.c
> > index b9d927eb0..a1900cc1d 100644
> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -122,6 +122,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
> >                       OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
> >                       OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
> >                       OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
> > +                     OPT_BOOL(0, "keep-existing-origin", &opts->keep_existing_origin, N_("do not add another hash if one already exists, use with -x")),
> >                       OPT_END(),
> >               };
> >               options = parse_options_concat(options, cp_extra);
> > @@ -157,6 +158,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
> >                               "--ff", opts->allow_ff,
> >                               "--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
> >                               "--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
> > +                             "--keep-existing-origin", opts->keep_existing_origin,
> >                               NULL);
> >       }
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index f2a10cc4f..c96add16e 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1050,12 +1050,14 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
> >                       strbuf_addstr(&msgbuf, p);
> >
> >               if (opts->record_origin) {
> > -                     strbuf_complete_line(&msgbuf);
> > -                     if (!has_conforming_footer(&msgbuf, NULL, 0))
> > -                             strbuf_addch(&msgbuf, '\n');
> > -                     strbuf_addstr(&msgbuf, cherry_picked_prefix);
> > -                     strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> > -                     strbuf_addstr(&msgbuf, ")\n");
> > +                     if (!opts->keep_existing_origin || strstr(msgbuf.buf, cherry_picked_prefix) == NULL) {
> > +                             strbuf_complete_line(&msgbuf);
> > +                             if (!has_conforming_footer(&msgbuf, NULL, 0))
> > +                                     strbuf_addch(&msgbuf, '\n');
> > +                             strbuf_addstr(&msgbuf, cherry_picked_prefix);
> > +                             strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> > +                             strbuf_addstr(&msgbuf, ")\n");
> > +                     }
> >               }
> >       }
> >
> > diff --git a/sequencer.h b/sequencer.h
> > index 6f3d3df82..a907c0947 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -24,6 +24,7 @@ struct replay_opts {
> >       int allow_empty;
> >       int allow_empty_message;
> >       int keep_redundant_commits;
> > +     int keep_existing_origin;
> >       int verbose;
> >
> >       int mainline;
> > --
> > 2.14.1
> >
>
> I'm wondering if it isn't better to detect that there is already an
> origin present and not add another one.
>
> Or are there situations where you do want multiple cherry-pick origins?

I don't. But because that's how git behaves now, I don't know if
anyone is relying on that behaviour so I am reluctant to change that.

Thanks,
Anthony

>
> Kevin
