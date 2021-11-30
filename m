Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D3C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241983AbhK3OJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:09:26 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:35808 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbhK3OJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:09:25 -0500
Received: by mail-pg1-f170.google.com with SMTP id j11so9963729pgs.2
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Orjy2ZPJTs71fi5oJuysnFOaIfkpKZhne4xlsBzW03w=;
        b=gqmpV6sqFRAqkif72OTm99GKOCC0iBkn1o7nAna4Kiowdsm+nOsEJdj3Uokrm/hFwO
         sabfkwHfmicFy/KzxbPZZcgaqoXHIUdAzO1HpRi1242pHcm5NmVxpnxZW46GQRycLWg1
         ONoijlJ67irToo/1uMiCHxY1cWs22/FH7HJewwo7adkVuKO45rheAHEvC1LpQdD8GZW5
         z4SJ6vXW9nH7Nq5EliJJPIogUhHiQ+Pd47EbZEUw1pFySpSGPFmWt4DHbu+4oDBuJUmB
         Yq/lzu0GyQ39WhdWtmj32yyizMlYg7K1ofzBa3UmkWoWWAIn9Eel23gKywGdEMHeILZT
         hvdw==
X-Gm-Message-State: AOAM533Mdl4l1PCGyxiqDQf6s3eNEbLz2ymrjrp3O7eBpPsR5yfepQ3M
        JJOwOa+3THnSuRQEP56h63KEg0uytXp6lLhnSM79IXFgeUDJsA==
X-Google-Smtp-Source: ABdhPJw6iX4j18jRQNqhAZgV18OsgU4NL8JybcQTz7+BymIhaCJ3N6t4PTAR3piZ6gKmaHx5pCpNObm3FkonWjdcBk8=
X-Received: by 2002:a63:380e:: with SMTP id f14mr39928576pga.227.1638281165849;
 Tue, 30 Nov 2021 06:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20211130043946.19987-1-sunshine@sunshineco.com> <YaXQ/HinYZH1wL7E@coredump.intra.peff.net>
In-Reply-To: <YaXQ/HinYZH1wL7E@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Nov 2021 09:05:54 -0500
Message-ID: <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 2:21 AM Jeff King <peff@peff.net> wrote:
> On Mon, Nov 29, 2021 at 11:39:46PM -0500, Eric Sunshine wrote:
> > Rather than attempting to address this issue on a case by case basis,
> > address it by making vreportf() -- which is the heart of error-reporting
> > functions die(), error(), warn(), etc. -- flush stdout before emitting
> > the error message to stderr.
>
> I left some thoughts on whether this flush is safe elsewhere in the
> thread. But for this particular case, two things occur to me:
>
>   - shouldn't status messages like this go to stderr anyway? I know some
>     people follow the "unless it is an error, it should not to go
>     stderr" philosophy. But I think in general our approach in Git is
>     more "if it is the main output of the program, it goes to stdout; if
>     it is chatter or progress for the user, it goes to stderr".

I considered this as well and agree that it would be a nicer localized
fix, but...

(1) I don't think the practice is documented anywhere, so people --
including me when I wrote builtin/worktree.c -- might not know about
it. Indeed, we don't seem to be entirely consistent about doing it
this way. Randomly picking submodule-helper.c, for instance, I see
status-like messages going to stdout:

    printf(_("Entering '%s'\n"), displaypath);
    printf(_("Synchronizing submodule url for '%s'\n"), ...);

    if (...)
        format = _("Cleared directory '%s'\n");
    else
        format = _("Could not remove submodule work tree '%s'\n");
    printf(format, displaypath);

(2) With git-worktree being four or five years old, for
backward-compatibility concerns, I worry that "that ship has sailed",
where 'that' is the freedom to relocate those status-like messages
from stdout to stderr. I don't want to break tooling which exists
around git-worktree.

I'd be happy to be wrong on the second point -- indeed, git-worktree
is still marked "experimental" in the man-page, but that may not mean
anything this late in the game -- and submit a patch which places
git-worktree's status-like messages on stderr instead of stdout.
Thoughts?

>   - the reason it works consistently on glibc is that stdout to a
>     terminal is line buffered by default, so the "preparing" line is
>     flushed immediately. If that isn't the case on Windows, should we
>     consider calling setlinebuf() preemptively when isatty(1)?

I'll let the Windows experts chime in on this (Dscho?). For all I
know, that might introduce a bad performance regression on that
platform under whatever terminal-like or pseudo-tty-like emulation
they are using.
