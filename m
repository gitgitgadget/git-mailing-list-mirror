Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A6CC678D4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 13:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCGNSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 08:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCGNRr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 08:17:47 -0500
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9976B193D1
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 05:16:53 -0800 (PST)
Received: from [192.168.42.163] (228-48-142-46.pool.kielnet.net [46.142.48.228])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 4260C3C0939;
        Tue,  7 Mar 2023 14:16:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1678195009;
        bh=Z114P+h9ORFfujshDlLFY6ZEaOwClkaL7q+fZ535pKo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=yQKFGmv4Yl1EiQgC2tzaB531Apd+iHldvC/HVLKE4Ws5m978uPKr8jbHWyvJ2JXm3
         tYRbF1ROxjPIYIuRyMMawkQRGdlwbg/nj/JS/ezgQ2KzJc8Ayg8mzaL82cl2JnCsY0
         ReOHogecMZ2KaRiUNYbPed4UI3fEVUWp3LmpgS69AdQ2IM9Vwz94fXOsIvuCSLLt/W
         MYyKw++6dzmF6EoXvGfL2rGnv+WNyKthBK3d3mLcX4/ZUZZ5SJkVWmu4mO8VsCZ+ev
         jSp48jCGEKBdTplq86wNVWpmYp2LnZ+nlLv1it9V2HuvRXLNjBrEgFF845L45nVT72
         v1K0hIyMEi8JA==
Message-ID: <48f58b30-13d7-cd1d-6f7d-6cc63d2c9178@haller-berlin.de>
Date:   Tue, 7 Mar 2023 14:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: de-DE, en-US
To:     Chris Torek <chris.torek@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <c237c1e3-5cd0-503d-ff4b-96f645a659f3@haller-berlin.de>
 <CAPx1Gvdik+QhTw8U1vd0cW1yZ9GbgDpmW7apxnXdY=E0okLpTQ@mail.gmail.com>
 <347052f1-dd7d-dc72-6171-a858eea94747@haller-berlin.de>
 <CAPx1Gvc+rBMe1bsg8XW_DyPUN9aJu9tQyhMLP0Zu-aeWCkzSGw@mail.gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <CAPx1Gvc+rBMe1bsg8XW_DyPUN9aJu9tQyhMLP0Zu-aeWCkzSGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.03.23 04:31, Chris Torek wrote:
> On Sat, Mar 4, 2023 at 12:36 AM Stefan Haller <lists@haller-berlin.de> wrote:
>> I'm surprised to hear that worktrees play a role in this. Do you have
>> more details about this?
> 
> $ git worktree add foo
> $ cd ../foo
> $ git rebase -i HEAD~2
> 
> puts the rebase-todo file into
> `.git/worktrees/foo/rebase-merge/git-rebase-todo`;
> all the status files will likewise be in the `.git/worktrees/foo/`
> directory.

I see. That should be taken care of by not hard-coding ".git/...", but
using something like "git rev-parse --git-path ...". We are doing that
already, otherwise most of lazygit's other rebase commands wouldn't work
in worktrees.

>>> It would be best if `git status`
>>> reported all of this information directly ...
> 
>> Yes, that would be nice, but based on what state would it provide this
>> information? Are you suggesting that some new file should be added to
>> .git/rebase-merge/ to keep track of it (more reliably than the amend
>> file does today), or could the information be derived somehow from what
>> exists already?
> 
> I don't know which parts are reliably derive-able today, but to
> the extent that `git status` *can't* provide the necessary information,
> I'd call that a bug in `gitt status`, to be fixed by saving that information
> somewhere. Until it exists, there's nothing you can do, but if and when
> (a) it does exist and (b) `git status` provides it, it won't matter
> whether it's in some added worktree, or moves around or changes
> form: you'll get it in a reliable fashion.
> 
> In other words, this is not helpful *yet*. :-)

I see, thanks for the explanation. I agree. Trouble is, I don't have the
capacity to drive such an addition to git status, and I doubt anybody
else would be interested in doing it for me (are you? :-), so...

-Stefan
