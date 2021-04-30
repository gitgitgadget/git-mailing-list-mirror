Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C91BC433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 08:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB366143B
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 08:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhD3Iyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 04:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3Iyh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 04:54:37 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B09C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=th4ogBdNWUwGeOtyLYdt8H3uGeQmX+URZZi00KYD0gA=; b=ZQqpZoVOvybfRBjFAlgwYKV2yz
        ptMCQrOeD6Il9M+c2nR7Y1zobJMsWYiY3P8RB0VQTp+p3cEQv5dtEvkowTuIJiz2S+TNFX2QZP1OK
        Q5CKRm7vnntAKZx0iBOqh7PasiEDqF7AB/BCnZjTXAEiWZveqXx7FcaviSCYL25wMgpc=;
Received: from [2001:8b0:14bb:e93b:e8df:b9:8698:86f8] (helo=ado-tr)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1lcOuB-00029j-0V; Fri, 30 Apr 2021 08:53:47 +0000
Date:   Fri, 30 Apr 2021 09:53:42 +0100
From:   Andrew Oakley <andrew@adoakley.name>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Feiyang Xue <me@feiyangxue.com>
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
Message-ID: <20210430095342.58134e4e@ado-tr>
In-Reply-To: <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
References: <20210412085251.51475-1-andrew@adoakley.name>
        <20210412085251.51475-3-andrew@adoakley.name>
        <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Apr 2021 03:00:06 -0700
Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> wrote:
> However, on Windows, UTF-8 strings passed to "p4 submit -d" are
> somehow converted to the default Windows code page by the time they
> are stored in the Perforce database, probably as part of the process
> of passing the command line arguments to the Windows p4 executable.
> However, the "code page" data is *not* converted to UTF-8 on the way
> back from p4 to git-p4.py.  The only way to get it into UTF-8 is to
> call string.decode().  As a result, this patch, which takes out the
> call to string.decode() will not work on Windows.

Thanks for that explanation, the reencoding of the data on Windows is
not something I was expecting.  Given the behaviour you've described, I
suspect that there might be two different problems that we are trying
to solve.

The perforce depot I'm working with has a mixture of encodings, and
commits are created from a variety of different environments. The
majority of commits are ASCII or UTF-8, there are a small number that
are in some other encoding.  Any attempt to reencode the data is likely
to make the problem worse in at least some cases.

I suspect that other perforce depots are used primarily from Windows
machines, and have data that is encoded in a mostly consistent way but
the encoding is not UTF-8.  Re-encoding the data for git makes sense in
that case.  Is this the kind of repository you have?

If there are these two different cases then we probably need to come up
with a patch that solves both issues.

For my cases where we've got a repository containing all sorts of junk,
it sounds like it might be awkward to create a test case that works on
Windows.
