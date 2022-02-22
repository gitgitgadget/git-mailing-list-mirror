Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B4C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiBVNoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiBVNoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:44:07 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 05:43:41 PST
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C7C11E3ED
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:43:41 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,387,1635199200"; 
   d="scan'208";a="6659582"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 14:42:34 +0100
Date:   Tue, 22 Feb 2022 14:42:33 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] [PATCH] add usage-strings ci check and amend remaining
 usage strings
In-Reply-To: <220222.867d9n83ir.gmgdl@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com> <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com> <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet> <220222.867d9n83ir.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-930122316-1645537354=:2556"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-930122316-1645537354=:2556
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 22 Feb 2022, Ævar Arnfjörð Bjarmason wrote:

>
> On Tue, Feb 22 2022, Johannes Schindelin wrote:
>
> > Hi Julia,
> >
> > I would like to loop you in here because you have helped us with
> > Coccinelle questions in the past.
>
> Thanks. Probably better to CC the relevant ML, adding it.
>
> > On Mon, 21 Feb 2022, Abhradeep Chakraborty wrote:
> >
> >> Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >>
> >> > That should be fairly easy to do though, and if not we could always
> >> > just dump these to stderr or something if a
> >> > git_env_bool("GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP", 0) was true,
> >> > and do the testing itself in t0012-help.sh.
> >>
> >> Okay but if the logic can't be implented in the `parse-options.c` file
> >> (most probably I will be able to implement the logic), would you allow
> >> me to try the `coccinelle script` method you mentioned?
> >
> > The task at hand is to identify calls to the macro `OPT_CMDMODE()` (and
> > other, similar macros) that get a fourth argument of the form
> >
> > 	N_("<some string>")
> >
> > The problem is to identify `<some string>` that ends in a `.` (which we
> > want to avoid) or that starts with some prefix and a colon but follows
> > with an upper-case character.
> >
> > In other words, we want to suggest replacing
> >
> > 	N_("log: Use something")
> >
> > or
> >
> > 	N_("log: use something.")
> >
> > by
> >
> > 	N_("log: use something")
> >
> > Ævar suggested that Coccinelle can do that. Could you give us a hand how
> > this would be possible using `spatch`?

Hello,

I'm not sure to follow all of the following.

Of there are some cases that are useful to do statically, with only local
information, then using Coccinelle could be useful to get the problem out
of the way once and for all.  Coccinelle doesn't support much processing
of strings directly, but you can always write some python code to test the
contents of a string and to create a new one.

Let me know if you want to try this.  You can also check, eg the demo
demos/pythontococci.cocci to see how to create code in a python script and
then use it in a normal SmPL rule.

If some context has to be taken into account and the context in the same
function, then that can also be done with Coccinelle, eg

A
...
B

matches the case where after an A there is a B on all execution paths
(except perhaps those that end in an error exit) and

A
... when exists
B

matches the case where there is a B sometime after executing A, even if
that does not always occur.

If the context that you are interested in is in a called function or is in
the calling context, then Coccinelle might not be the ideal choice.
Coccinelle works on one function at a time, so to do anything
interprocedural, you have to do some hacks.

julia
>
> I probably shouldn't have mentioned that at all, and I think this is
> academic in this context, because as noted we can just add this to
> parse_options_check() (linking it here again for off-git-ml context):
>
>     https://lore.kernel.org/git/220221.86tucsb4oy.gmgdl@evledraar.gmail.com/
>
> We now pay that trivial runtime overhead every time, we could run it
> only during the tests if we ever got worried about it.
>
> And it's a lot less fragile and easy to understand than running
> coccicheck, i.e. as nice as it is it's still takes a while to run, is
> its own mini-language, needs to be kept in sync with code changes etc.
>
> So by doing it at runtime we can adjust messages, code & tests in an
> atomic patch more easily (i.e. not assume that you ran some cocci target
> to validate it).
>
> It also makes it really easy to do things that are really hard (or
> impossible?) with coccinelle. I.e. some of these checks are run as a
> function of what flag gets passed into some function later on, which in
> the general case would require coccinelle to have some runtime emulator
> for C code just to see *what* checks it wants to run.
>
> That being said (and with the caveat that I've only looked at this code,
> not done this myself) if you clone linux.git and browse through:
>
>     git grep -C100 -F coccilib.report '*.cocci'
>
> You can see a lot of examples of using cocci for these sorts of checks.
>
> And the same goes if you clone coccinelle.git and do:
>
>     git grep -C100 @script: -- tests
>
> For linux.git it's documented here:
> https://github.com/torvalds/linux/blob/master/Documentation/dev-tools/coccinelle.rst
>
> I.e. it's basically writing the sort of cocci rules we have in-tree with
> a callback script that complaints about the required change.
>
> For our use it would probably better (in lieu of parse_options_check(),
> which is the right thing here) to just have a normal *.cocci file and
> complain if it applies changes. We already error in the CI if those need
> to apply any changes.
>
> But I don't off-hand know how to do that. E.g. I was trying the other
> day to come up with some coccinelle rule that converted:
>
>     die("BUG: blah blah");
>
> To:
>
>     BUG("blah blah");
>
> And while I'm sure there's some way to do this, couldn't find a way to
> write a rule to "reach in" to a constant string, apply some check or
> search/replacement on it, and to do a subsequent transformation on it.
>
> In this case the OPT_BLAH(1, 2, 3, "string here") has OPT_BLAH() as a
> macro. I can't remember if there's extra caveats around using coccinelle
> for macros v.s. symbols.
>
> Disclaimer: By "couldn't" I mean I grepped the above examples for all of
> a few minutes quickly skimmed the coccinelle docs, didn't find a
> template I could copy, then ended up writing some nasty grep/xargs/perl
> for-loop instead :)
>
--8323329-930122316-1645537354=:2556--
