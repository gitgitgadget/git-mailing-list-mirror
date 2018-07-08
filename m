Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F5D1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 14:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeGHOnx (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 10:43:53 -0400
Received: from s019.cyon.net ([149.126.4.28]:51434 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754014AbeGHOnw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 10:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4Tah/Gy0cw21htJa9h1iD3vmiBz/8on9pwyIXMEKUHo=; b=CS2dcXGraQ6fOyI0QVq2WkwKIs
        qyphQYm6KL8ins1lqwyL5oGJOv3dNHo76nAcoyjuzqPK5a9YraLkjm5jTBHRnrA8cfzAUyCnsMSuo
        PqrXMZzeG8vCs9Vl6oGmmb50fMrmWPYy3+04Te5uyHPKQp46SMqa4bqO94xr/k8/l6paMAQBh3yfD
        MetnoERs90VL0cxCLPgpIyP/gEpqKDqgHJwnOJnWYiTI6ufBpfvkmc/lF1fTVValpx8E0dkTdJETE
        rd53fnbb12NugfkKmIBv9Tme5gOfVYdvLbAOc7L1QqU4+xOGFy4sr8B3dRHL9NJ/pL0qaZc5feHdI
        n1RRw2VA==;
Received: from [10.20.10.231] (port=62212 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcAui-004hSV-H0; Sun, 08 Jul 2018 16:43:50 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 44CE22019A; Sun,  8 Jul 2018 16:43:48 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [RFC PATCH 0/6] Compile cleanly in pedantic mode
Date:   Sun,  8 Jul 2018 16:43:36 +0200
Message-Id: <20180708144342.11922-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While developing 6aaded550 ("builtin/config: work around an unsized
array forward declaration", 2018-07-05), I have compiled Git with
CFLAGS="-std=c99 -pedantic".

This is an RFC patch series that fixes a few compiler warnings when
compiling with these options, always assuming that this is a worthwile
goal.

Note that all warnings were produced by -pedantic; the C99 standard
option by itself didn't cause any of them.

The warnings were:

1) Char arrays initialized from a parenthesized string.

        Suppressed by defining USE_PARENS_AROUND_GETTEXT_N to 0
        globally. This was done just to keep the amount of warnings
        manageable; this series leaves that knob alone. The advantage of
        not mistakenly concatenating two translated strings is greater.

2) connect.h, refs/refs-internal.h: Forward reference to an enum.

        Added two #includes that define the enums. This was already
        (inconclusively) talked about in [0].

3) convert.c: Invalid escape sequence "\e".

        Replaced with "\033".

4) seqencer.c: Empty statements at top level.

        Removed the extra semicolons.

5) string-list.c: Forbidden to cast from void * to a function pointer and
   vice versa.

        Encapsulated the function pointer in a context struct. This is
        controversial because it has a performance impact, namely one
        additional pointer dereference per string comparison. An
        alternative might be to use multiple casts via intptr_t. But
        I'm not sure if this is worth the trouble.

6) utf8.c: overflow of char values.

        Use unsigned char for the BOM constants.

This series has patches for 2) to 6).

Regards,
Beat

[0] https://public-inbox.org/git/53ab8626-f862-a732-b369-abeab69a468f@ramsayjones.plus.com/T/
