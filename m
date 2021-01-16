Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE3FC433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 04:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F6E23A5E
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 04:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbhAPEZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 23:25:43 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:42018 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhAPEZm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 23:25:42 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l0d92-0007Bj-Mv; Fri, 15 Jan 2021 21:25:00 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l0d91-006YBQ-JU; Fri, 15 Jan 2021 21:25:00 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 161665012C4;
        Fri, 15 Jan 2021 21:24:59 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 43wHyg-mvjXM; Fri, 15 Jan 2021 21:24:59 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id AD28550120A;
        Fri, 15 Jan 2021 21:24:57 -0700 (MST)
Date:   Fri, 15 Jan 2021 21:24:54 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Message-ID: <20210116042454.GA4913@ellen>
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
 <20210109224236.50363-1-davvid@gmail.com>
 <20210109225400.GA156779@ellen>
 <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
 <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
 <20210110072902.GA247325@ellen>
 <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
X-XM-SPF: eid=1l0d91-006YBQ-JU;;;mid=<20210116042454.GA4913@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 10, 2021 at 03:24:48AM -0800, Junio C Hamano wrote:
> Note that with t7800 fixed with the patch, non Windows jobs all seem
> to pass, but t7610 seems to have problem(s) on Windows.

The autocrlf test is breaking because the sed that ships with some mingw
versions (and also some minsys and cygwin versions) will *automatically*
remove carriage returns:

$ printf 'foo\r\nbar\r\n' | sed -e '/bar/d' | cat -A
foo$

$ printf 'foo\r\nbar\r\n' | sed -b -e '/bar/d' | cat -A
foo^M$

(Note: the -b flag above is just for comparison. We can't use it here.
It's not in POSIX and is not present in sed for busybox or OSX.)

I haven't found official docs that describe this behavior yet but
I found a few discussions about it across a few lists. E.g.:
https://cygwin.com/pipermail/cygwin/2017-June/233121.html

Suggestions welcome.

Obviously we could try to detect crlf's before the sed and then try to
re-add them back in after sed but that strikes me as error-prone.

I recall someone mentioning calling merge-file twice, once with --ours
and once with --theirs, to independently generate each "side" of the
conflict instead of using sed to split MERGED. Is that a viable
approach?

