Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A653AC433F5
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 23:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhLSXyK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 19 Dec 2021 18:54:10 -0500
Received: from elephants.elehost.com ([216.66.27.132]:60639 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhLSXyK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 18:54:10 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BJNs509042722
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 19 Dec 2021 18:54:05 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.com>
Cc:     "'Sean Allred'" <allred.sean@gmail.com>,
        "'Git List'" <git@vger.kernel.org>
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com> <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com> <003f01d7f51f$f7bb0860$e7311920$@nexbridge.com> <CABceR4aP8BVr10RYS_0PFG7ExRTJ3tB541JGC4DJ7CUsMg9+Jw@mail.gmail.com> <004001d7f52a$f0367010$d0a35030$@nexbridge.com> <CAPig+cTwmBViAGELF69mkYNoz+S-YW5-dcYuNfGeF-wob-=v9Q@mail.gmail.com>
In-Reply-To: <CAPig+cTwmBViAGELF69mkYNoz+S-YW5-dcYuNfGeF-wob-=v9Q@mail.gmail.com>
Subject: RE: Bug report - Can create worktrees from bare repo / such worktrees can fool is_bare_repository()
Date:   Sun, 19 Dec 2021 18:54:00 -0500
Organization: Nexbridge Inc.
Message-ID: <004301d7f533$b51c0a90$1f541fb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKeYwgHoGmGxJSEPR+fKunQIMLw7wFeNI06AY9dookBwEmhRwFEfZw5Aiu1bekCSeOfEKpaYSMA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 19, 2021 6:30 PM, Eric Sunshine wrote:
> On Sun, Dec 19, 2021 at 5:51 PM <rsbecker@nexbridge.com> wrote:
> > On December 19, 2021 5:23 PM, Sean Allred wrote:
> > > > what about the comparison code where is_bare_repository_cfg is
> > > > compared with 1 (it is a boolean and sometimes set to -1). This
> > > > would not generally pass a code review.
> > >
> > > I'm sorry, I'm afraid I don't completely follow.  Wouldn't the most
> > > straightforward change be to simply follow the documented
> > > recommendation when we create the worktree config in `git sparse-
> > > checkout init`?  Specifically,
> > >
> > >     +    if (is_bare_repository())
> > >     +      git_config_set_in_file_gently(config_path, "core.bare", "false");
> > >     +
> > >
> > > Are we saying the comparison within is_bare_repository() may not be
> > > appropriate in this case?
> >
> > I'm suggesting that:
> >
> >         worktree->is_bare = (is_bare_repository_cfg == 1) ||
> >                 is_bare_repository();
> >
> > the == 1 comparison should not be done for boolean-style variables. It is an
> int, but initialized to -1. Unless -1 and 1 mean different things, but that is not
> really documented.
> 
> `is_bare_repository_cfg` is not exactly a boolean; it's a tristate, with -1
> meaning "not yet determined". I didn't, at the time, closely follow the
> discussion[1] of the particular bit of code you're questioning, but the `== 1`
> was mentioned at least a couple times, once in review by Junio[2], and then
> in the extra patch commentary by "jtan" when he submitted v2[3]. Anyhow,
> if I'm following the original discussion correctly, then the usage, `== 1` (or the
> equivalent `> 0`) is probably correct, and that treating it as a simple boolean
> (where
> -1 is true, too) would be undesirable. (Of course, I haven't traced through the
> init code at all, so I don't even know if it can ever be
> -1 at this point.) Five existing consumers of this global variable use `== 1`, and
> only two use `> 0`, so this usage is at least reasonably consistent with other
> parts of the project.
> 
> [1]: https://lore.kernel.org/git/20190419172128.130170-1-
> jonathantanmy@google.com/T/
> [2]: https://lore.kernel.org/git/xmqqo954gira.fsf@gitster-ct.c.googlers.com/
> [3]: https://lore.kernel.org/git/20190419172128.130170-1-
> jonathantanmy@google.com/

Thanks for the clarification. It helps to understand the code. Could the variable type be changed to a new typedef like ConfigTriState instead of int to be clear about its semantics? Or perhaps an enum with -1, 0, 1 declared explicitly?
-Randall

