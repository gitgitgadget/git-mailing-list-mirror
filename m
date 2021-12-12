Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF916C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 18:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhLLSRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 13:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhLLSRI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 13:17:08 -0500
X-Greylist: delayed 1564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Dec 2021 10:17:08 PST
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2465BC061714
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1ciCj7KbKMtTcyqYi9wS6fsC70I9/rDsNagpKXWRXt4=; b=hgKzHpCk/ZGzYVhVUN8Wf5TpaP
        /QXQSfWK0xVA8ARzX1CRmg28zAOZ47b+eBD4MXSOSMH4nEP93f/WQvAry3acBi965U5r3yG9W3dGM
        PU4FWVSLQ3Po8awYE9uV18MqLi0RVKX9152FcvwNClObu+5zyivSkNGBwIVKfYwn4auw=;
Received: from [2001:8b0:14bb:e93a:fd4f:6f72:643:f027] (helo=ado-tr.dyn.home.arpa)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1mwT01-0003AR-8x; Sun, 12 Dec 2021 17:51:01 +0000
Date:   Sun, 12 Dec 2021 17:50:54 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v2 1/3] git-p4: remove support for Python 2
Message-ID: <20211212175054.5d3c11af@ado-tr.dyn.home.arpa>
In-Reply-To: <20211210153101.35433-2-jholdsworth@nvidia.com>
References: <20211210153101.35433-1-jholdsworth@nvidia.com>
        <20211210153101.35433-2-jholdsworth@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Dec 2021 15:30:59 +0000
Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> The motivation for this change is that there is a family of issues
> with git-p4's handling of incoming text data when it contains bytes
> which cannot be decoded into UTF-8 characters. For text files created
> in Windows, CP1252 Smart Quote Characters (0x93 and 0x94) are seen
> fairly frequently. These codes are invalid in UTF-8, so if the script
> encounters any file or file name containing them, on Python 2 the
> symbols will be corrupted, and on Python 3 the script will fail with
> an exception.

As I've pointed out previously, peforce fails to store the encoding of
text like commit messages.  With Windows perforce clients, the encoding
used seems to be based on the current code page on the client which
made the commit.  If you're part of a global organisation with people
in different locales making commits then you will find that there is
not a consistent encoding for commit messages.

Given that you don't know the encoding of the text, what's the best
thing to do with the data?  Options I can see are:

- Feed the raw bytes directly into git.  The i18n.commitEncoding config
  option can be set by the user if they want to attempt to decode the
  commit messages in something other than UTF-8.
- Attempt to detect the encoding somehow, feed the raw bytes directly
  into git and set the encoding on the commit.
- Attempt to dedect the encoding somehow and reencode everything into
  UTF-8.

Right now, if you use python2 then you get the behaviour as described
in the first of these options.  It doesn't "corrupt" anything, it just
transfers the bytes from perforce into git.  If you use python3 then
git-p4 is unusable because it throws exceptions trying to decode things.

It's not clear to me how "attempt to detect the encoding somehow" would
work.  The first option therefore seems like the best choice.

I think that this is the problem which really needs solving.  Dropping
support for python2 doesn't make the issue go away (although it might
make it slightly easier to write the code).  I think that the python2
compatibility should be maintained at least until the encoding problems
have been solved for python3.

I previously wrote some patches which attempt to move in what I think is
the right direction, but unfortunately they never got upstreamed:

https://lore.kernel.org/git/20210412085251.51475-1-andrew@adoakley.name/

Your comments elsewhere that git-p4 could benifit from some clean-up
seem accurate to me, and it would be good to see that kind of change.
