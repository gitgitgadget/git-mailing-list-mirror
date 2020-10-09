Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAD8C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 07:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E63222269
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 07:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbgJIHz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 03:55:58 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46924 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbgJIHz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 03:55:58 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4C70kM3blQz1r6nH;
        Fri,  9 Oct 2020 09:55:55 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4C70kM2RMKz1qtwh;
        Fri,  9 Oct 2020 09:55:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MT2-_zsYJ-eQ; Fri,  9 Oct 2020 09:55:54 +0200 (CEST)
X-Auth-Info: 2MrNJ0ze/5Ew6d4BSa2tb6ZsG6v3e1Mv+cZECG/B56peCG3/kbNgGtABUd4CBY9i
Received: from igel.home (ppp-46-244-168-131.dynamic.mnet-online.de [46.244.168.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  9 Oct 2020 09:55:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id A94AA2C2765; Fri,  9 Oct 2020 09:55:53 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] contrib/git-resurrect.sh: use hash-agnostic OID
 pattern
References: <cover.1602139448.git.liu.denton@gmail.com>
        <6fad1fc7fdad98c3dda1ec334a10a6a9e311fef8.1602139448.git.liu.denton@gmail.com>
        <20201008161345.GD2823778@coredump.intra.peff.net>
        <20201008221101.GO1392312@camp.crustytoothpaste.net>
X-Yow:  I want you to MEMORIZE the collected poems of EDNA ST VINCENT MILLAY..
 BACKWARDS!!
Date:   Fri, 09 Oct 2020 09:55:53 +0200
In-Reply-To: <20201008221101.GO1392312@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 8 Oct 2020 22:11:01 +0000")
Message-ID: <874kn3rfxy.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Okt 08 2020, brian m. carlson wrote:

> On 2020-10-08 at 16:13:45, Jeff King wrote:
>> On Wed, Oct 07, 2020 at 11:44:40PM -0700, Denton Liu wrote:
>> >  search_merges () {
>> >  	git rev-list --all --grep="Merge branch '$1'" \
>> >  		--pretty=tformat:"%P %s" |
>> > -	sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
>> > +	sed -ne "/^$oid_pattern \($oid_pattern\) Merge .*/ {s//\1/p;$early_exit}"
>> >  }
>> >  
>> >  search_merge_targets () {
>> >  	git rev-list --all --grep="Merge branch '[^']*' into $branch\$" \
>> >  		--pretty=tformat:"%H %s" --all |
>> > -	sed -ne "/^\($_x40\) Merge .*/ {s//\1/p;$early_exit} "
>> > +	sed -ne "/^\($oid_pattern\) Merge .*/ {s//\1/p;$early_exit} "
>> >  }
>> 
>> in both cases we are matching output we asked for, so we really matching
>> [0-9a-f]\+ would be correct and sufficient. That's a little simpler. I
>> don't feel too strongly either way, though.
>
> The problem here is that we'd need to write [0-9a-f][0-9a-f]* because
> this is a BRE and a backslashed + here is a GNU extension.

I wonder why --pretty uses %s when it is filtered out again anyway?
(There is also a duplicate --all.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
