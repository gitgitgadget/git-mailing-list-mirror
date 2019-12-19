Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69EC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6ED222C2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLSCS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:18:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41884 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfLSCSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 21:18:25 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so574955ioo.8
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 18:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvbNHWhZssVevKgtCB2mAwGXDxZcbxD+25RYtzIM1yE=;
        b=eDYsPjHhS4YNXJdq9L7zgjMSEeVHbWok4zpCyO5cct8rgmDeAh+/BnUXXDpGiOwQQ/
         iJ7H9OfT2ZI23YXrK61a5FpSlYZshR4HnBNlegbL0T05WfmOwNFZFbiwwW6xbu5oy5Hi
         hBkjw4VFeMyHkB3QE4PR1/NK6PCzftZDxvBYHZI+r7n5fkR3mdj+TLFbCzxyKU9akNC8
         JRVoMg7+v2pffMokL3GLT+kOQK/Mz+SEd/C1oOVIdSZA9Hc77LoE5UKLaEl/dngUe7b7
         JY1VqUzfHzv8KWkqgOC0Ly5qIXXdrfL9RVxIIw6PH5wo+2xcucH0x9Bl44DdmbWNr/qp
         NOUg==
X-Gm-Message-State: APjAAAWl8vJlc/Wp8gjFG3KYRrNBhRUChyuUL47BTCMPiIWAS5NHj/Ak
        PEcbT+ANkOe49ru+6C+h9BmJHfqivPNmWiyxgnQ=
X-Google-Smtp-Source: APXvYqzInw9m427DI9yE6g2RMa8Nr3hgw2uDCJcaSMCofLkSY6ULPds0NutYEma4JlKM5UrS4zP/UJtWNFQJCZ4An3U=
X-Received: by 2002:a6b:db12:: with SMTP id t18mr3852390ioc.11.1576721904995;
 Wed, 18 Dec 2019 18:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20191219015833.49314-1-emaste@FreeBSD.org> <46d9f9dd-b278-bade-af48-3a3bd2e4aa5e@gmail.com>
In-Reply-To: <46d9f9dd-b278-bade-af48-3a3bd2e4aa5e@gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 18 Dec 2019 21:18:13 -0500
Message-ID: <CAPyFy2BROa9iMWBWf1hioYDaoEXPvyUNGHOZaZiD0TzVVhEtoA@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Dec 2019 at 21:07, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/18/2019 8:58 PM, Ed Maste wrote:
>
> Thanks for the report!
>
> It was a little unclear from the get-go what exactly the issue is.
>
> > On FreeBSD, when executed by root ls enables the '-A' option:
> >
> >   -A  Include directory entries whose names begin with a dot (`.')
> >       except for . and ...  Automatically set for the super-user unless
> >       -I is specified.
>
> It appears that the "ls" commands in the sparse-checkout tests are
> reporting the ".git" directory when executed on FreeBSD as root. Is this
> only as root?

Yes, this is only as root - it seems Cirrus-CI invokes the build and
test scripts as root, which is why I had trouble reproducing it
locally.

> > Pipe ls's output to grep -v .git to remove the undesired entry.  Also
> > pass the -1 option to ensure one entry per line.
>
> What if we instead ran "ls -a" and added .git to our expected output
> (when appropriate)? Would that be simpler (and reduce the process
> count that this solution introduces).

I originally tried that approach and thought it was a bit cumbersome,
but avoiding additional process invocations is a good argument. I'll
send a v2 with that change instead.
