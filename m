Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7728AC77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 16:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbjEKQ27 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 11 May 2023 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbjEKQ26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 12:28:58 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258D180
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:28:57 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-757720be6abso297057785a.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822536; x=1686414536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNAIoWHQFZZwwElV7HV8hbXtr1v9qMgqjdZKUPkDDv8=;
        b=LjbafppMzB783H2DhvwxNTTCtaWLvbId08hC9RTRFtWyq5PISEUR+Bi0CHst9rFsJG
         ZVc/dT+CZCQivUoE7OgVjg6J0YDEQTTLU/yw35WNQSyAvewbETYora9M1OSye+j8NHnS
         tLISLmSelazTKABDoOApTM+ixLNdsdBY6gAOJDFSfr9A4A7pGENER1ZxpXqYUQ22QF0w
         P1EIM/h6sB8mwjN7wmugsCB0O39/GwIszjf+JMCCwVpMEWk6DC+3keuxCNKtHa59DCOF
         HOPDZ3XNPM3lf6b8cKsrfwsA7uoERyRJJHu67FU+79QMes+Khj1ghIh9YDkyR7nkWCPh
         IfBQ==
X-Gm-Message-State: AC+VfDwAxY7gTBWpClEUWZDRXXKzhM6VS6TeyZxwjD1llOipK9j89luO
        IBwAmjFfP+gFzJSXsGLpd5lLWTPdfNv6/St3M0cz/FKl
X-Google-Smtp-Source: ACHHUZ72hhv14xxQ5iz9MvD9FowPNSJ+xgmysmpodkFBdFCsFXgvf4z8TH9FGIzAtFuE7ztT6xkEoxGFDM78bQCLH+Y=
X-Received: by 2002:ad4:5dec:0:b0:5a1:6212:93be with SMTP id
 jn12-20020ad45dec000000b005a1621293bemr32943476qvb.29.1683822536188; Thu, 11
 May 2023 09:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net> <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
 <305ccc55-25e3-6b01-cd86-9a9035839d06@sunshineco.com> <20230511161757.GA1973344@coredump.intra.peff.net>
In-Reply-To: <20230511161757.GA1973344@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 May 2023 12:28:45 -0400
Message-ID: <CAPig+cQP736+944k40wgE8Vybk=ajD-kLTDHM6Y92dKEeWMB8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] fsck: mention file path for index errors
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 12:17 PM Jeff King <peff@peff.net> wrote:
> On Thu, May 11, 2023 at 02:39:59AM -0400, Eric Sunshine wrote:
> > > +static void fsck_index(struct index_state *istate, const char *index_path,
> > > +                  int is_main_index)
> >
> > This adds an `is_main_index` flag, but...
> >
> > > @@ -993,12 +998,19 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
> > > +                           fsck_index(&istate, path, wt->is_current);
> >
> > ...this accesses `is_current`, the value of which is "true" only for the
> > worktree in which the Git command was run, which is not necessarily the main
> > worktree. The main worktree, on the other hand, is guaranteed to be the
> > first entry returned by get_worktrees(), so shouldn't this instead be:
> >
> >     for (p = worktrees; *p; p++) {
> >         fsck_index(&istate, path, p == worktrees);
>
> I think "current" is what we want here, since the point was to return
> the short-but-syntactically-correct ":path-in-index" for the current
> worktree, which is where "rev-parse :path-in-index", etc, would look
> when resolving that name.

Okay, that makes sense.

> So the code is working as intended, but I may have misused the term
> "main" with respect to other worktree code. I didn't even know that was
> a concept, not having dealt much with worktrees.
>
> Maybe it's worth s/main/current/ here (and I guess in t1450)?

Yes, s/main/current/ probably would be helpful for future readers of
the code. It's unfortunate that the term "current" can ambiguously
also be read as meaning "the up-to-date index" or "the present-time
index" as opposed to "the index in this directory/worktree", which is
the intention here. But "current" is consistent with the existing
`struct worktree.is_current`, so hopefully should not be too
confusing.
