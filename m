Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CAAC636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1126D6124B
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 12:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhGQMsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 08:48:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40538 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhGQMsc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 08:48:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4FC6B1F5AE;
        Sat, 17 Jul 2021 12:45:35 +0000 (UTC)
Date:   Sat, 17 Jul 2021 12:45:35 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
Message-ID: <20210717124535.GB16801@dcvr>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
 <87k0m9bpmv.fsf@evledraar.gmail.com>
 <b19f3f2a-049f-acf2-f59e-de705dc54307@jeffhostetler.com>
 <87mtqq2i3r.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161754180.59@tvgsbejvaqbjf.bet>
 <874kcuxkz8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kcuxkz8.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Fri, Jul 16 2021, Johannes Schindelin wrote:
> > Hi Ævar,
> >
> > On Tue, 13 Jul 2021, Ævar Arnfjörð Bjarmason wrote:
> >
> >>
> >> On Tue, Jul 13 2021, Jeff Hostetler wrote:
> >>
> >> > On 7/1/21 7:02 PM, Ævar Arnfjörð Bjarmason wrote:
> >> >> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> >> >>
> >> >>> From: Jeff Hostetler <jeffhost@microsoft.com>
> >> >>>
> >> >>> Teach the win32 backend to register a watch on the working tree
> >> >>> root directory (recursively).  Also watch the <gitdir> if it is
> >> >>> not inside the working tree.  And to collect path change notifications
> >> >>> into batches and publish.
> >> >>>
> >> >>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> >> >>> ---
> >> >>>   compat/fsmonitor/fsmonitor-fs-listen-win32.c | 530 +++++++++++++++++++
> >> >> <bikeshed mode> Spying on the early history of this (looking for the
> >> >> Linux backend) I saw that at some point we had just
> >> >> compat/fsmonitor/linux.c, and presumably some of
> >> >> compat/fsmonitor/{windows,win32,macos,darwin}.c.
> >> >> At some point those filenames became much much longer.
> >> >>
> >> >
> >> > Once upon a time having "foo/bar/win32.c" and "abc/def/win32.c"
> >> > would cause confusion in the debugger (I've long since forgotten
> >> > which).  Breaking at win32.c:30 was no longer unique.
> >> >
> >> > Also, if the Makefile sends all .o's to the root directory or a
> >> > unified OBJS directory rather than to the subdir containing the .c,
> >> > then we have another issue during linking...
> >> >
> >> > So, having been burned too many times, I prefer to make source
> >> > filenames unique when possible.
> >>
> >> A much shorter name like compat/fsmonitor/fsmon-win32.c would achieve
> >> that goal.
> >>
> >> >> I've noticed you tend to prefer really long file and function names,
> >> >> e.g. your borrowed daemonize() became
> >> >> spawn_background_fsmonitor_daemon(), I think aiming for shorter
> >> >> filenames & function names helps, e.g. these long names widen diffstats,
> >> >> and many people who hack on the code stick religiously to 80 character
> >> >> width terminals.

At least "daemon"/"daemonize" already implies "background"; so
even if we have the extra function, "spawn_fsmon_daemon()" would
be enough info.

> >> >>
> >> >
> >> > I prefer self-documenting code.
> >>
> >> Sure, I'm not saying daemonize() is an ideal name, just suggesting that
> >> you can both get uniqueness & self-documentation and not need to split
> >> to multiple lines in some common cases to stay within the "We try to
> >> keep to at most 80 characters per line" in CodingGuidelines in this
> >> series.
> >
> > While you are entitled to have your taste, I have to point out that Jeff
> > is just as entitled to their taste, and I don't think that you can claim
> > that yours is better.
> >
> > So I wonder what the intended outcome of this review is? To make the patch
> > better? Or to pit taste against taste?
> 
> Neither, to address a misunderstanding.
> 
> Sure, if a reviewer points out "maybe change X to Y" and the reply is "I
> like X better than Y", fair enough.
> 
> My reading of Jeff H.'s upthread was that he'd misunderstood my
> suggesting of that Y for a Z.
> 
> I.e. that shortening a name like fsmonitor-fs-listen-win32.c (X)
> necessarily had to mean that we'd have a win32.c (Z), negatively
> impacting some debugging workflows, as opposed to just a
> shorter-but-unique name like fsmon-win32.c (Y).

Short-as-possible-while-being-meaningful is a pretty important
usability thing git.  There's a good reason git supports OID
prefix abbreviations, after all.

Not my area of expertise, but AFAIK git's rename detection is
affected by basename; and I've encountered debugger confusion
with non-unique basenames while debugging other codebases.

My brain works like a naive "strcmp"/"memcmp": long common
prefixes slows down my ability to differentiate filenames.

Having lots of common terms/prefixes on the screen works like
camoflage to me and slows down my ability to process things.
I suppose my eyes and cognitive abilities are below average;
and even worse due to the pandemic numbing my brain.

> Ditto for daemonize() (X/Z) and spawn_background_fsmonitor_daemon() (X).

(what I said above)

> I'm certain that with this reply we're thoroughly into the "respectfully
> disagree" territory as opposed to having a misunderstanding.
> 
> I also take and agree your implied point that there's no point in having
> a yes/no/yes/no/yes argument on-list, and I did not mean to engage in
> such a thing, only to clear up the misunderstanding, if any.
> 
> I'll only say that I don't think that something like long variable/file
> etc. names is *just* a matter of taste, seeing as we have a fairly
> strict "keep to at most 80 characters per line" as the 2nd item in the C
> coding style (after "use tabs, not spaces").
> 
> That matter of taste for one developer objectively makes it harder to
> stay within the bounds of the coding style for furute maintenance.
> 
> We do have active contributors that I understand actually use terminals
> of that size to work on this project (CC'd, but maybe I misrecall that
> for one/both). I'm not one of those people, but I do find that
> maintaining code with needlessly long identifiers in this codebase is
> painful.

Thanks for Cc-ing me.

Yes, I'm one of those developers.  Accessibility matters to me:
my eyesight certainly isn't getting better with age (nor do I
expect anyone elses').  I need giant fonts to reduce eye and
neck strain.

Fwiw, newspaper publishers figured out line width
decades/centuries ago and wrap lines despite having large sheets
to work on.


I mostly work over mosh or ssh to reduce noise and heat locally.
There's no bandwidth for VNC or similar, and graphical stuff
tends to be unstable UI-wise anyways so I stick to the terminal.

Taste does have much to do with it: I favor stable, reliable
tools (e.g. POSIX, Perl5, git) that works well on both old and
new hardware.  I avoid mainstream "desktop" software since they
tend to have unstable UIs which break users' workflows while
requiring more powerful HW.

Complex graphics drivers tend to get unreliable, too, especially
when one is stuck with old HW that gets limited support from
vendors.  It's also difficult to fix complex drivers as a
hobbyist given the one-off HW/vendor-specific knowledge
required.

So we shouldn't expect a developer with old HW can have more
than a standard text terminal.  This is an accessibility problem
for developers lacking in finances.

This is also a problem for developers wishing to backdoors+bugs
found in modern systems (IntelME, AMD-PSP, endless stream of CPU
bugs).


Back to health-related accessibility; I've also had joint
problems for many years so shorter identifiers helps reduce
typing I need to do.  I mostly had that under control
pre-pandemic, but it's been a huge struggle to find adequate
replacements for activities I used to rely on to manage the
pain.
