Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CAD71F954
	for <e@80x24.org>; Tue, 21 Aug 2018 20:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeHVASx (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:18:53 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:39089 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVASx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:18:53 -0400
Received: by mail-wm0-f51.google.com with SMTP id q8-v6so120719wmq.4
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/kl1WUcDZpEx/WJL+ojGWCRHXhkUwE3v0pN6cNZxIy4=;
        b=f4CjvqBZOS72OqP+awH9o8TSyI9NJzK2eIpIadsgbyvP+xEnv9FCFoD/Kpeuyk3n+h
         l04aLakbHT2YiKnUrAE8zldgh8m5EssGxQUBKiW2xI65+7fHWQxJ91ZQXWeRQDs8TCf1
         +NXxX8GNswe9/XQps/jP2fnNC4k3Ews6Y45AWXSHpv1AFdbfX/4hOU8cgbxJ129dofG1
         VWg4GVJzyFrmoTYNdiGWO/hXijt41/k4yoy+8puceiEKXxiK4dtp1UfRqAgCGKByABoo
         fC5Rv+GGH5SXJUlMAnjV+hAGtopU8hy5vCqb4lVt+OaOWhDO1ZRA6io8KtEop2c5JxSg
         bJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/kl1WUcDZpEx/WJL+ojGWCRHXhkUwE3v0pN6cNZxIy4=;
        b=W0u0swRIY5pSghK9whKP0Q9p4cvbDIm60UO3JI37/da0aco51+NRkMfB2nIE9Wq4jg
         5lEWqGMVzqdcAVvW7SHoP9KuqKjYkeKkY0S9wcPDJbwJ9RSTnkKD4C8FeOAhoNac1PEQ
         fijvH4L4RjMqHD3G7neBV5r1E2GAdrUc/mxcnQO0hzvBsm5TNnfDULjB2O2qSCALI212
         hLi+4VW8rzBWE3jjYQzITFAmGNpskRLEh9MqpZYiUYG3xyZRU7CIPKX4UhmjttdfBzAU
         hsOss1TJanHZVIA2xLQuYWpSRicsYADS8I64JQrbwYXsLbTGGUY8EVet0BbHMIFWoWTJ
         5CiQ==
X-Gm-Message-State: APzg51AtHzIF8F9w0lQdp5Mg5HxH9U216bWffB6QTkaQxSejZ7KKfZkO
        K2nkWn71or3amyGYD4lXl9o=
X-Google-Smtp-Source: ANB0VdZSRfgvBnud758tazXYIgVv/aBk0grsX81wMJj0I38PxYqJ5rEbCmI2X43IhFn2dvFwxwoi6g==
X-Received: by 2002:a1c:9215:: with SMTP id u21-v6mr610318wmd.106.1534885027998;
        Tue, 21 Aug 2018 13:57:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x24-v6sm15114657wrd.13.2018.08.21.13.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 13:57:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have" objects
References: <20180821184140.GA24165@sigill.intra.peff.net>
        <20180821190705.GF30764@sigill.intra.peff.net>
        <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
        <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
        <20180821200747.GA21955@sigill.intra.peff.net>
Date:   Tue, 21 Aug 2018 13:57:07 -0700
In-Reply-To: <20180821200747.GA21955@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 21 Aug 2018 16:07:47 -0400")
Message-ID: <xmqq36v78ml8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Ah, yeah, I think you're right. We call find_patch_start(), which thinks
> the "---" line is the end of the commit message. That makes sense when
> parsing trailers out of "format-patch" output, but not when we know we
> have just the commit message.

Yes, but that does not explain what we are seeing.  If the code
mistakenly thinks that the log message ends before that table, then
it should have inserted the S-o-b: _before_ that table, but that is
not happening.

So there are three issues; (1) find-patch-start uses too weak a
logic to find the beginning of a patch section (2) even if it found
the right place, its caller does not tell "commit --amend -s" where
the log message ends correctly and (3) some callchains that get
there know they only have a log message but there is no way to take
advantage of that information and skip the call to find-patch-start.
