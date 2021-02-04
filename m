Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F70C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A351864DF0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbhBDTSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbhBDTQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:16:27 -0500
X-Greylist: delayed 1803 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Feb 2021 11:15:47 PST
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51341C061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XugvtnnAw93uvrMnx9insaS8RvsoQ9DpHnSk9p46vV0=; b=mtrGMcOC0xShFRjDCG7MVpKebo
        se/Z9nhoDNSzO6/Zh1e6X8Q0N63DOQJFjx14yUxErQqPz78RsGIWwecS+Xo0DajbKUQJfWF8olsv5
        85tl7yxYjZ1S4YJJgTEZw6i5bPwr86rfwDCD4JfjuNXrWAZ3moSxHruhvUVR9RYIs9SA=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.home.arpa)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1l7jdN-0003PK-Vu; Thu, 04 Feb 2021 18:45:42 +0000
Date:   Thu, 4 Feb 2021 18:45:34 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     "Feiyang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Feiyang <github@feiyangxue.com>,
        Feiynag Xue <fxue@roku.com>
Subject: Re: [PATCH] git-p4: handle non-unicode characters in p4 cl
Message-ID: <20210204184534.30107dd7@ado-tr.home.arpa>
In-Reply-To: <pull.864.git.1612371600332.gitgitgadget@gmail.com>
References: <pull.864.git.1612371600332.gitgitgadget@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 03 Feb 2021 16:59:59 +0000
"Feiyang via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> From: Feiynag Xue <fxue@roku.com>
> 
> P4 allows non-unicode characters in changelist description body,
> so git-p4 needs to be character encoding aware when reading p4 cl
> 
> This change adds 2 config options, one specifies encoding,
> the other specifies erro handling upon unrecognized character.
> Those configs  apply when it reads p4 description text, mostly
> from commands "p4 describe" and "p4 changes".

...

>     It seems to make sense to default to replace so that it gets rid
> of non-unicode chars while trying to retain information. However, i am
>     uncertain on if we have use cases where it relies on the
>     stop-on-non-unicode behavior. (Hypothetically say an automation
> that's expected to return error on non-unicode char in order to stop
> them from propagating further?)

I suspect these options will be insufficient for real repositories.

There are two ways a perforce server is configured:
- unicode mode where the metadata is valid UTF-8, and you can request
  conversion to different character sets
- not in unicode mode where the metadata can be pretty much any random
  bytes (but not '\0'), and the encoding is not stored anywhere

There isn't any way to recover the encoding information from perforce,
and it's likely that a server that's not in unicode mode will end up
with both UTF-8 commits, and commits that contain other things (which
we have no way to work out what they are).

Until recently git-p4 was written in python2 and it just moved the
bytes from perforce into git without trying to interpret them in any
way.  This has the advantage that the git repository will accurately
reflect what was in perforce, even if it's complete garbage.

The other useful option I can think of would be to attempt to decode
the data as UTF-8, but fall back to some other encoding if the data
isn't valid (probably Windows-1252, but a config option would make
sense here).
