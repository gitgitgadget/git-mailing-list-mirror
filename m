Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28674C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 21:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbiDMVE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbiDMVE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 17:04:56 -0400
X-Greylist: delayed 1278 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Apr 2022 14:02:34 PDT
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026EF7E5B6
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4LSrHpJVm9dD04vqny65LHxcphGGRdoqyYxBe4omPME=; b=ReH566zJT4DCKYFNJVRZza8THv
        kfMiXxRgQEoSZgnVNS2MzLa2k6MWNUimkIHBXJKx0IbQqo4UfDejOaFq3a6p5/4P3QSN+2nakgigP
        hEI07PWk2QA98Q4N0TpAy6mDHS7waTjbro0bp8V4X5OfeON+nPxKUcsFisxtaP81/r/8=;
Received: from [2001:8b0:14bb:e93a:d4e8:4845:ecc6:372c] (helo=ado-tr.dyn.home.arpa)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1nejnc-0003bQ-EK; Wed, 13 Apr 2022 20:41:12 +0000
Date:   Wed, 13 Apr 2022 21:41:09 +0100
From:   Andrew Oakley <andrew@adoakley.name>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2] [RFC] git-p4: improve encoding handling to support
 inconsistent encodings
Message-ID: <20220413214109.48097ac1@ado-tr.dyn.home.arpa>
In-Reply-To: <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com>
References: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
        <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for doing this.  I've been meaning to write some similar code
for years and never quite got around to it.  So maybe my opinion
shouldn't be worth much :/.

On Wed, 13 Apr 2022 06:24:29 +0000
"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> Make the changelist-description- and user-fullname-handling code
> python-runtime-agnostic, introducing three "strategies" selectable via
> config:
> - 'legacy', behaving as previously under python2,
> - 'strict', behaving as previously under python3, and
> - 'fallback', favoring utf-8 but supporting a secondary encoding when
> utf-8 decoding fails, and finally replacing remaining unmappable
> bytes.

I was thinking about making the config option be a list of encodings to
try.  So the options you've given map something like this:
- "legacy" -> "raw"
- "strict" -> "utf8"
- "fallback" -> "utf8 cp1252" (or whatever is configured)

This doesn't handle the case of using a replacement character, but in
reality I suspect that fallback encoding will always be a legacy 8bit
codec anyway.

I think what you've proposed is fine too, I'm not sure what would end
up being easier to understand.

>      * Does it make sense to make "fallback" the default decoding
> strategy in python3? This is definitely a change in behavior, but I
> believe for the better; failing with "we defaulted to strict, but you
> can run again with this other option if you want it to work" seems
> unkind, only making sense if we thought fallback to cp1252 would be
> wrong in a substantial proportion of cases...

The only issue I can see with changing the default is that it might
lead to a surprising loss of data for someone migrating to git.  Maybe
print a warning the first time git-p4 encounters something that can't be
decoded as UTF-8, but then continue with the fallback to cp1252?

>      * Is it OK to duplicate the bulk of the testing code across
>        t9835-git-p4-metadata-encoding-python2.sh and
>        t9836-git-p4-metadata-encoding-python3.sh?
>      * Is it OK to explicitly call "git-p4.py" in tests, rather than
> the build output "git-p4", in order to be able to select the python
>        runtime on a per-test basis? Is there a better approach?

I tried to find a nicer way to do this and failed.

>      * Is the naming of the strategies appropriate? Should the default
>        python2 strategy be called something less opinionated, like
>        "passthrough"?

I think that "passthrough" or "raw" would be more descriptive names.

The changes to git-p4 itself look good to me.  I think that dealing
with bytes more and strings less will be good going forward.
