Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B0AC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3371920786
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgDPSec (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:34:32 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59400 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgDPSeb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 14:34:31 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4937DP0l2bz5tlB;
        Thu, 16 Apr 2020 20:34:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0616741B5;
        Thu, 16 Apr 2020 20:34:28 +0200 (CEST)
Subject: Re: Order of operations at the end of fast-import?
To:     Jeff King <peff@peff.net>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
References: <20200416042449.ztgyrdunsrzt7avp@glandium.org>
 <20200416050909.GB21547@coredump.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4b3493c9-8a4b-c55e-6749-cccc9dee87b6@kdbg.org>
Date:   Thu, 16 Apr 2020 20:34:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416050909.GB21547@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.04.20 um 07:09 schrieb Jeff King:
> We do add a ".keep" between writing the pack and updating the refs, but
> it doesn't look like it's done atomically (i.e., we write the .idx file
> and _then_ add the .keep). So there's a small race there.
> 
> But all of this is also true of any operation, like git-commit. It's
> creating new loose objects, and then will try to reference them. In
> between, a simultaneous gc will think they're unreachable. Likewise,
> receiving a push may write a pack (with a .keep, though in the correct
> order) or even loose objects.
> 
> This is usually handled by the gc expiration time, which is compared
> against the file mtime. The default is 2 weeks, but even something short
> like 5 minutes would be plenty to avoid this race (even for a long
> import, we should be updating the mtime every time we call write()).

Except that on Windows the times are only updated reliably when all file
handles refering to the file are closed. Would that poke a hole in your
argument? (I don't think  so, as long as expiration times are not
ridiculously short; and people who do gc --prune=now should know what
they are doing -- and when.)

> In fact, gc will use the same expiration for clearing out tempfiles. So
> even before we write the final pack and its .keep, any temporary files
> we're writing into would be at risk. But again, if we're actively
> writing, their mtimes should save them.

-- Hannes
