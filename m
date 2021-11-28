Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA43AC433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 17:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346971AbhK1RQu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 28 Nov 2021 12:16:50 -0500
Received: from elephants.elehost.com ([216.66.27.132]:13785 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345072AbhK1ROt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 12:14:49 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1ASHBMwU051208
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 28 Nov 2021 12:11:23 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Baruch Burstein'" <bmburstein@gmail.com>
Cc:     "'Git List'" <git@vger.kernel.org>
References: <CA+34VNLj6VB1kCkA=MfM7TZR+6HgqNi5-UaziAoCXacSVkch4A@mail.gmail.com> <CAPig+cQ224Tz5iQ5Yt4fMadehLmrJWGzH7kwUSr+UT4hcQf14w@mail.gmail.com> <CA+34VNJbOHYhYgN+p7EsGiRAzf+aAQGeMxCzG1dizFjDRVQVbg@mail.gmail.com> <CAPig+cTGq-10ZTBts2LXRVdPMf2vNMX8HTuhg_+ZHSiLX-brOQ@mail.gmail.com>
In-Reply-To: <CAPig+cTGq-10ZTBts2LXRVdPMf2vNMX8HTuhg_+ZHSiLX-brOQ@mail.gmail.com>
Subject: RE: misleading message printed when worktree add fails
Date:   Sun, 28 Nov 2021 12:11:18 -0500
Organization: Nexbridge Inc.
Message-ID: <010001d7e47a$f8b4cae0$ea1e60a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGqw43VQtMTuqaAqGKkts4m9xy/mAJCfmcgAJ8eJ28B8YyTsqxM1OSQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 28, 2021 12:01 PM, Eric Sunshine wrote:
> On Sun, Nov 28, 2021 at 11:47 AM Baruch Burstein <bmburstein@gmail.com>
> wrote:
> > > When I perform these actions, I see a "fatal error" message which
> > > clearly indicates failure, not success:
> > >
> > >     % git worktree add ../foo bar
> > >     Preparing worktree (checking out 'bar')
> > >     fatal: 'bar' is already checked out at '.../wherever'
> >
> > I see them in the other order:
> >
> >     fatal: 'master' is already checked out at 'C:/Users/bmbur/temp'
> >     Preparing worktree (checking out 'master')
> >
> > which I understood as "there was an error, but we managed to recover
> > somehow and set up the worktree anyway"
> 
> Okay, that's happening because the "Preparing" message is sent to stdout,
> whereas the "fatal" error is sent to stderr, and the streams are being flushed
> on Windows in a different order than what we typically see on Unix
> platforms even though the "Preparing" message is actually output first by the
> code.
> 
> A general fix (not specific to git-worktree) might be to have die() (or maybe
> vreportf()?) flush stdout before reporting the error message on stderr. That
> should make output order more predictable, such that general status
> messages appear before error messages.

This is probably a good idea. There is no guarantee even in Unix regarding stream buffer flushing. If there is a reason to sequence output between stdout and stderr, then fflush is important.

-Randall

