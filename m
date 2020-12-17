Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC97EC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 09:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7477923603
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 09:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgLQJpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 04:45:11 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:44326 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgLQJpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 04:45:09 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kpppj-002gmC-Ib; Thu, 17 Dec 2020 02:44:27 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1kpppi-00005e-SD; Thu, 17 Dec 2020 02:44:27 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 8F0765007A8;
        Thu, 17 Dec 2020 02:44:26 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OHZ4UFvsQGlg; Thu, 17 Dec 2020 02:44:26 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 37A105006E3;
        Thu, 17 Dec 2020 02:44:26 -0700 (MST)
Date:   Thu, 17 Dec 2020 02:44:24 -0700
From:   Seth House <seth@eseth.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Message-ID: <20201217094424.GA75257@ellen>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
X-XM-SPF: eid=1kpppi-00005e-SD;;;mid=<20201217094424.GA75257@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 17, 2020 at 08:35:21AM +0100, Johannes Sixt wrote:
> Where's WinMerge in your list?

Added. Thanks for the suggestion; I wasn't familiar with it. Let me know
if I missed anything in my (quick) assessment. The "auto-merge" function
does indeed produce similar results to Felipe's patch.

> I would say that this is a hint that post-processing should
> be moved to the tool drivers, and should not be done at the proposed level.

That was my thought as well and it didn't occur to me to raise
a discussion here. However Felipe made the good point that adding this
functionality in upstream Git would have immediate downstream effects
for most tools. Almost every mergetool I've surveyed so far simply
blindly shows a diff betweeen LOCAL and REMOTE (and sometimes BASE and
sometimes MERGED) and Felipe's patch would have an immediate benefit for
all those tools.

There are a few notable exceptions that have their own, internal
conflict resolution logic -- tkdiff, WinMerge, and (I think) IntelliJ.
And only two tools make direct use of the conflict resolution that Git
already performed to produce MERGED -- Emacs+Magit, and diffconflicts.
Those tools would have to make a decision whether to opt-in to the
autoMerge flag or not.

I did not initially like Felipe's patch because I personally want my
mergetool to use all five of LOCAL, REMOTE, BASE, _and_ the two split
halves of MERGED. However the pragmatism of it is growing on me. Because
so many mergetools do simply diff LOCAL and REMOTE this one, simple
opt-in would positively benefit all of them.

