Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D75C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjDCW7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjDCW7s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:59:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1511FD2
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:59:45 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id CFAEE20002;
        Mon,  3 Apr 2023 22:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1680562784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5u6YDjia06p9gs5wVHiBjhx3EYvqiglz00CiHb5gXgY=;
        b=R31Lth4mrPyizHqFpLgkw6KawYjmWJbxmnPftZd2nMEkczVUm9AFxRiz9az2sA3ezkNE3f
        7Q20T34lFXOgI0cIMsDnDZXdf7PD9M4EINf/bPOm7pG0RWjVJO3mhJXTUQSjhy/JxFNH2x
        qUKv1eampXovw6RYawXt9P8a2zZp1C0IzBodVu67QsrvYMXPWzSQ3j1NGx7uxMu83wxZrO
        hh6VAgr8dOsSdUb9NiqTKTZmyBaZNahSBP8TN1Ig3fNHhCFHwez4xxQdeITJahRe2FGR/k
        7qQhvl37HHS+fV7b+b7uqiXd4Qef/L9QqIIcLAVunuKYMpqCnJBV5Q7Y35mytg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 04 Apr 2023 00:59:42 +0200
Message-Id: <CRNHSC3H2B6C.UCSDE4Y6ET4A@ringo>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
From:   "Robin Jarry" <robin@jarry.cc>
X-Mailer: aerc/0.14.0-145-gedb59e6a06c0
References: <20230402185635.302653-1-robin@jarry.cc>
 <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
 <CRNH5FOB91JE.14CZEA494X002@ringo> <xmqq7cus4m0b.fsf@gitster.g>
In-Reply-To: <xmqq7cus4m0b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Apr 04, 2023 at 00:52:
> Close to zero is very different from absolutely zero, and in the
> case of format-patch generated patches, I think it is absolutely
> zero.  At least, that was the case back when I designed and
> implemented it, and I do not think I accepted a patch to break it
> over the years.
>
> But "git send-email" can be fed a list of files and even a directory
> (and enumerate files in it).  The filenames are under end-users'
> control in this case, so "close to zero" has absolutely no relevance.
> If the end user means to feed you such a file, they can do so 100%
> of the time.

Ok that's a fair point. Even though I am having a hard time believing
someone would do such a thing :D

> If we support such a file is a different issue.  A good rule of
> thumb to decide if it is reasonable is to see if the main command
> already works with such filenames, e.g.
>
>     $ git format-patch -2
>     0001-foo.txt
>     0002-bar.txt
>     $ mv 0001-foo.txt '0001-fo
>     > o.txt'
>     $ mkdir dir
>     $ mv 000[12]*.txt dir/.
>
> may prepare two patch files that can be sent via send-email.  One
> file (the first one) is deliberately given a filename with LF in
> it.  Does send-email work on it correctly if you did e.g.
>
>     $ git send-email dir/000[12]*.txt
>
> or something silly like
>
>     $ git send-email dir
>
> or does it already choke on the first file because of the filename?

It seems to work with both. I guess, NUL bytes separation it is then...
