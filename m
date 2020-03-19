Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282D2C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AC520775
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgCSQOW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 19 Mar 2020 12:14:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41350 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbgCSQOW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:14:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so3782781wrc.8
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 09:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ms5HTRBPJXz7pX9DRsqZCOGALMYAkiiGTo+Zsu68tZE=;
        b=MuzsSsaQcgyoL3LABvs+cBPl31ohLGDCOSTX7bKonfdjBTS34TulRxfyVX5vrrrB9d
         I67/4I9vvZufTHJhkrkZbidYtliDRO02j5u+f4s4pDhJSS5yF2JTNCAF+1ZhE0M4VJAJ
         RGS/NjVMZsAGbUEh6TM5ow1R5b9tjrpxqQ6h7Ogl/S9GkcFWqTL6dKM7gVPdIxiwSztN
         EzDTX9kH4NPBZc5kNmbxbJQzRzKG6TaUpmzhzfPdcoWHiPDHz3vfq1rXdSKVQgh7rUbx
         8rfA2BLw4VHjxMH+L0Wv7r5HFHu2OumtHnVKbzFyulAQiZx7NoLWKWhEezQ7j8zTnCO9
         HLaA==
X-Gm-Message-State: ANhLgQ1M1CQcvemi2jfUxrojXSFTSnzR+OhiAK0Vi5TsOm526ae+XIkm
        ZtjBPeaI3vJC8QfzFv6bfmQBKvnBqguotcF1JyU=
X-Google-Smtp-Source: ADFU+vtXHXVUz1qgirxkxOxSPCrlotGKkrmsDD/06xIQPUj74tBLNpChW8a5IQil0bF1cwzC9J8/xelgn41huEU+Q4o=
X-Received: by 2002:a5d:444b:: with SMTP id x11mr5495545wrr.226.1584634460356;
 Thu, 19 Mar 2020 09:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584625896.git.congdanhqx@gmail.com> <7e184d97df8c673b0edfb6223c82385579777b19.1584625896.git.congdanhqx@gmail.com>
 <20200319160211.GC3513282@coredump.intra.peff.net>
In-Reply-To: <20200319160211.GC3513282@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Mar 2020 12:14:09 -0400
Message-ID: <CAPig+cSZvhb4H54QZ=m+A+WF5vg6h014cn5JxiB5N4Om-m2tbw@mail.gmail.com>
Subject: Re: [PATCH 2/6] test-lib-functions: test_cmp: eval $GIT_TEST_CMP
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 12:02 PM Jeff King <peff@peff.net> wrote:
> On Thu, Mar 19, 2020 at 09:00:03PM +0700, Đoàn Trần Công Danh wrote:
> > > test_cmp:1: command not found: diff -u
> >
> > Using `eval` to unquote $GIT_TEST_CMP as same as precedence in `git_editor`.
>
> I do worry that this whitespace splitting behavior could bite us in
> other scripts. Curiously, my version of busybox (1.30.1) doesn't seem to
> have any problem with it, though.

I had the same reaction upon reading the patch. It's not just other
scripts in which the problem might manifest, but a change to the value
of some variable which is used as a command invocation. Providing a
"fix" for this one particular case may help get past test a failure on
Alpine under busybox, but it is not a good general solution. (Some
sort of helper function which smooths away differences like this --
say git_indirect_cmd() or something -- which can be used wherever a
$VARIABLE is invoked as a command might be a better approach, but I
haven't really thought it through.)
