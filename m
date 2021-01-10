Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A72EC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 07:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2407D23976
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 07:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbhAJH23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 02:28:29 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:45770 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbhAJH22 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 02:28:28 -0500
Received: by mail-ej1-f44.google.com with SMTP id qw4so20140152ejb.12
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 23:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdDKYtApnZL6cSPAqdbZaKadxlRmFo6m4obU+OLUdAU=;
        b=aTp3obrEkd8ZQoejorNJhoK/mA7pSDuxzDQmB/TdIlSvbsBtZd+34MdHTLTBg9WAGF
         rbILoPs5lM65c0VyhyaUYXBWHtLyKOpm8HfVPi0lP+UfJehixuoBriyPNqDn3G8NmOhN
         cn+oUHUeLw6fX6c0jflFwojdWYkumaLdkH/mJwOgv3LGgTfHFBJ5RV2Y186FoxHIa32S
         859/NQu9bBIhRdROayl3I14GgnStNVJ69csxCCJB3kjqozFyeuCCaaXobHeAcwvL6niD
         2BN2RNwKBR2nWcXJcjJGF2FTdTnLGvOiCdv8BRePFPoq3ur1lvBqGbgv6Cz1sInW+wAp
         0kOw==
X-Gm-Message-State: AOAM531IP43nuzpJQy3pv4Gidl3aF6WQyQgzAqBpNsY8DnXC4F/2IaIh
        YpwLSnslJWWbblsBZAEEfGFzGgSm8EOe+iEZwCo=
X-Google-Smtp-Source: ABdhPJy6Nk1q4CO2uWEUaO/lsyAY5X4IiY7UVO2YWcdlpMAAtWlPIWGFVgy0ILoRyp50UF3eN8w2VjtrVI/9Y4e3UQ0=
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr7425057ejb.168.1610263666325;
 Sat, 09 Jan 2021 23:27:46 -0800 (PST)
MIME-Version: 1.0
References: <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com>
 <20210105110219.99610-1-phillip.wood123@gmail.com> <CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com>
 <936f9b7c-6d54-00bc-f136-4cb4c2836eb6@gmail.com>
In-Reply-To: <936f9b7c-6d54-00bc-f136-4cb4c2836eb6@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Jan 2021 02:27:35 -0500
Message-ID: <CAPig+cQq_RnanDQ3jHfNz_L58WyzmsUJBhtdrLxa=H0v_io+WA@mail.gmail.com>
Subject: Re: [PATCH] worktree: add -z option for list subcommand
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 8, 2021 at 5:33 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 07/01/2021 03:34, Eric Sunshine wrote:
> > On Tue, Jan 5, 2021 at 6:02 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >> Add a -z option to be used in conjunction with --porcelain that gives
> >> NUL-terminated output. This enables 'worktree list --porcelain' to
> >> handle worktree paths that contain newlines.
> >
> > Adding a -z mode makes a lot of sense. This, along with a fix to call
> > quote_c_style() on paths in normal (not `-z`) porcelain mode,
>
> I'm concerned that starting to quote paths will break backwards
> compatibility. Even if we restricted the quoting to just those paths
> that contain '\n' there is no way to distinguish between a quoted path
> and one that begins and ends with ".

Backward compatibility is a valid concern, though I haven't managed to
convince myself that it would matter much in this case. In one sense,
the failure of the porcelain format to properly quote/escape paths
when needed can be viewed as an outright bug and, although we value
backward compatibility, we also value correctness, and such bug fixes
have been accepted in the past. Especially in a case such as this, it
seems exceedingly unlikely that fixing the bug would be harmful or
break existing tooling (though, of course that possibility always
exists, even if remotely so).

I can imagine ways in which tooling might be engineered to work around
the shortcoming that `git worktree list --porcelain` doesn't properly
handle newlines embedded in paths, but such tooling would almost
certainly be so fragile anyhow that it would break as we add more keys
to the extensible porcelain format. Coupled with the fact that
newlines embedded in paths are so exceedingly unlikely, it's hard to
imagine that fixing this bug would have a big impact on existing
tooling.

The case you mention about a path which happens to have a double-quote
as its first character does concern me a bit more since existing
tooling wouldn't have had to jump through hoops, or indeed do anything
special, with such paths, unlike the embedded newline case. But then,
too, it's pretty hard to imagine this coming up much, if at all, in
practice. That's not to say that I can't imagine a path, in general,
beginning with a quote, but keeping in mind that we're talking only
about worktree paths, it seems exceedingly unlikely.

My gut feeling (for what it's worth) is that worktree paths containing
embedded newlines (or other special characters) or beginning with a
double-quote is so unlikely to come in in actual practice that viewing
this as a bug fix is probably a reasonable approach, whereas some
other approach -- such as introducing porcelain-v2 or creating a new
porcelain key, say "worktreepath" which supersedes "worktree" (without
retiring "worktree") -- may be overkill.

None of the above is an argument against a complementary `-z` mode,
which I think is a very good idea.

> This is the reason I prefer to add
> `-z` instead of taking Rafael's patch to quote the lock reason as that
> patch still leaves the output of `git worktree list --porcelain`
> ambiguous and it cannot be fixed without breaking existing users. A
> counter argument to all this is that there are thousands of users on
> file systems that cannot have newlines in paths and Rafael's patch is
> definitely a net win for them.

Rafael's patch is quoting only the lock-reason, not the worktree path,
so I think it's orthogonal to this discussion. Also, his patch is
introducing `lock` as a new attribute in porcelain output, not
modifying behavior of an existing `lock` attribute.
