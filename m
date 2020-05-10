Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B618C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC9B2080C
	for <git@archiver.kernel.org>; Sun, 10 May 2020 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="JmdhehSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgEJOOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 10:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgEJOOD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 10:14:03 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F1C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=abRROwYgUMEZhd7+zWUbVQz2bgPvNDk3Z28y6nVWlY8=; b=JmdhehSY28jqQ+RtgG25lb3UAb
        fmhP2koUK76rQizIJHr1zhAk+S6Ho1pkgfHqlzEN8wtMFPmxdTlRAPsqKFge+1xchMJtBtoUn3vJm
        m4pCyn3KFGcaplgVc3LZN+VLcupYYAThUueTfxH5p2R9ej40C7zmUSdD6Ev5TmkibaDo=;
Received: from [2001:8b0:14bb:e93b:5435:c2c0:635c:9b55] (helo=ado-tr.home.arpa)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1jXmiO-0008Av-Po; Sun, 10 May 2020 14:14:00 +0000
Date:   Sun, 10 May 2020 15:13:54 +0100
From:   Andrew Oakley <andrew@adoakley.name>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4: recover from inconsistent perforce history
Message-ID: <20200510151354.16ce2ab1@ado-tr.home.arpa>
In-Reply-To: <CAE5ih793qKyOSE-hkOw7+nFmM3XTRxxrXv0FD2+WWXjGbVHkoQ@mail.gmail.com>
References: <20200510101650.50583-1-andrew@adoakley.name>
        <CAE5ih793qKyOSE-hkOw7+nFmM3XTRxxrXv0FD2+WWXjGbVHkoQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 10 May 2020 13:03:11 +0100
Luke Diamand <luke@diamand.org> wrote:
> Perforce changed their server to reject this kind of thing in the
> 2017.1 version:
> 
>     Bugs fixed in 2017.1
>     #1489051 (Job #2170) **
>        Submitting a file with the same name as an existing depot
>        directory path (or vice versa) will now be rejected.
> 
> (Of course people will still have damaged repos even today).
> 
> I tried your test with both the 2015.1 and the 2020.1 versions, and it
> worked in both cases - shouldn't it be impossible to get into the
> state that git-p4 now recovers from with a newer p4d?

Yes, there is an option in perforce (submit.collision.check) that stops
new changelists from introducing this problem, and it is turned on by
default.  Unfortunately this option does *exactly* what the description
says, so you can't delete a directory and replace it with a file in the
same changelist - the delete has to happen first.  It's not clear which
behaviour is least bad.

The test case tries to turn the perforce option off so it works on both
old and new server versions.

Thanks
