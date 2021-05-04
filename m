Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAC4C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B73D613C3
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhEDVC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 17:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhEDVC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 17:02:57 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017FC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tiOTKr3+VrvE1Kjot9hPfYoD999WKFbpZGb7Yf+SNHc=; b=D5Vtg3t5AGy2l3AZFZH1Fejj+Z
        sjVnfN3sFpgvP1TSqx60fJhpV70oqwKQEBT0FSFTY2+Qozj8QKl7x45ooTNbeD9bPvvhwqBapA+m/
        xlmYN3KPU74TFXJ7jsv07ftMhtHN9ydZxq77GozyYuT7kMnX6romDy+PGJ/pEmygtk2E=;
Received: from [2001:8b0:14bb:e93b:e8df:b9:8698:86f8] (helo=ado-tr)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1le2B4-0004SZ-Ue; Tue, 04 May 2021 21:01:59 +0000
Date:   Tue, 4 May 2021 22:01:53 +0100
From:   Andrew Oakley <andrew@adoakley.name>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>,
        Feiyang Xue <me@feiyangxue.com>
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
Message-ID: <20210504220153.1d9f0cb2@ado-tr>
In-Reply-To: <CAKu1iLWbmPrVjAcgLKP1yisjmVxJr+kKQWJLiqkRzh=aAzETwA@mail.gmail.com>
References: <20210412085251.51475-1-andrew@adoakley.name>
 <20210412085251.51475-3-andrew@adoakley.name>
 <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
 <20210430095342.58134e4e@ado-tr>
 <021c0caf-8e6f-4fbb-6ff7-40bacbe5de38@diamand.org>
 <CAKu1iLWbmPrVjAcgLKP1yisjmVxJr+kKQWJLiqkRzh=aAzETwA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Apr 2021 11:08:57 -0700
Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> wrote:
> My server is not unicode.
> 
> These conversions are happening even with a non-Unicode perforce db.
> I don't think it's the p4d code per se that is doing the conversion,
> but rather an interaction between the OS and the code, which is
> different under Linux vs Windows.

It's not particularly obvious exactly what is happening here.  The
perforce command line client is written in a rather odd way - it uses
the unicode (UTF-16) wWinMainCRTStartup entry point but then calls an
undocumented API to get the "narrow" version of the command line.  The
code is here:

https://swarm.workshop.perforce.com/projects/perforce_software-p4/files/2016-1/client/clientmain.cc

I think that perforce will end up with the data in a code page that
depends on the configuration of the machine.  I don't think the exact
details matter here - just that it's some semi-arbitrary encoding that
isn't recorded in the commit.

The key thing that I'm trying to point out here is that the encoding is
not necessarily consistent between different commits.  The changes that
you have proposed force you to pick one encoding that will be used for
every commit.  If it's wrong then data will be corrupted, and there is
no option provided to avoid that.  The only way I can see to avoid this
issue is to not attempt to re-encode the data - just pass it directly
to git.

I think another way to solve the issue you have is the encoding header
on git commits.  We can pass the bytes through git-p4 unmodified, but
mark the commit message as being encoded using something that isn't
UTF-8.  That avoids any potentially lossy conversions when cloning the
repository, but should allow the data to be displayed correctly in git.

> In any event, if you look at my patch (v6 is the latest...
> https://lore.kernel.org/git/20210429073905.837-1-tzadik.vanderhoof@gmail.com/
> ), you will see I have written tests that pass under both Linux and
> Windows. (If you want to run them yourself, you need to base my patch
> off of "master", not "seen").  The tests make clear what the
> different behavior is and also show that p4d is not set to Unicode
> (since the tests do not change the default setting).

I don't think the tests are doing anything interesting on Linux - you
stick valid UTF-8 in, and valid UTF-8 data comes out.   I suspect the
tests will fail on Windows if the relevant code page is set to a value
that you're not expecting.

For the purposes of writing tests that work the same everywhere we can
use `p4 submit -i`.  The data written on stdin isn't reencoded, even on
Windows.

I can rework my test to use `p4 submit -i` on windows.  It should be
fairly simple to write another change which allows the encoding to be
set on commits created by git-p4.

Does that seem like a reasonable way forward?  I think it gets us:
- sensible handling for repositories with mixed encodings
- sensible handling for repositories with known encodings
- tests that work the same on Linux and Windows
