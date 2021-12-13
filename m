Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC7AC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 14:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbhLMO2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 09:28:01 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:42651 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbhLMO2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 09:28:00 -0500
Received: by mail-pf1-f176.google.com with SMTP id u80so15064913pfc.9
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 06:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Q59U033dU1U+MG5se3ClRPRu6WXOGAXp79U1rxO/Ss=;
        b=6pNWM+l+86pZCkllCJO9p06sKs4TLLcvyvS2VYLu+W+s0YxhGsauogwWYNqkXPjnTb
         5unRDuRqEe7z5nNCzXO4T5xsdDrw4nimY8WfLU6KV/8GqYFNOvvwDl2Gp5lqM/LWGMD5
         3YxqbIvSV1vFZLc7WpO0JJCumdaKitJCaDBBzP0aErBwa6vKbsOIqKdFVvTz0v6IOXio
         4m1ZzMoEASEcfGsIGNXtSJlxk+xZ9JF3v2nxOVzRwNy5ZMfSOTomWIn1NaWtbEz1F32a
         ItE0hl8gGg4OJHgy2yFg5m3eoTf8HG63KSisV6oQ7UojldtqtGYpXSyw+qjV68FTJ6H5
         X3eQ==
X-Gm-Message-State: AOAM532Ke02SIozMakNbueNfITpywqS3/hCjrnclAW66BsHheH70gLOQ
        ZmgtMixsh8kWCRku2AeA/8HQy7A2MwPDOa2kDU4=
X-Google-Smtp-Source: ABdhPJwLYGiNoV/7P90UgEYcPipmxd8zvU7HCoAc3W/E6WVTCpGTtdPJvl3HB6l54Iz60A1xjR1NRkFHV3g43y/Ukq0=
X-Received: by 2002:a05:6a00:230b:b0:4ae:d8b2:dc0c with SMTP id
 h11-20020a056a00230b00b004aed8b2dc0cmr33962698pfh.67.1639405679306; Mon, 13
 Dec 2021 06:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com> <20211213102224.y5psbojmivlxe5px@fs>
In-Reply-To: <20211213102224.y5psbojmivlxe5px@fs>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Dec 2021 09:27:48 -0500
Message-ID: <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 5:22 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> On 13.12.2021 01:30, Eric Sunshine wrote:
> > check-chainlint:
> >+      sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/tests && \
> >+      cat $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/expect && \
> >+      $(CHAINLINT) '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/actual && \
> >+      diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
>
> If I read this right you are relying on the order of the .test & .expect
> files to match. I did something similar in a test prereq which resulted in a
> bug when setting the test_output_dir to something residing in /dev/shm,
> since the order of files in /dev/shm is reversed (at least on some
> platforms). Even though this should work as is I could see this leading to a
> similar bug in the future.

It's not seen in the patch context, but earlier in the file we have:

    CHAINLINTTESTS = $(sort $(...,$(wildcard chainlint/*.test)))

which provides stability via `sort`, thus ensures that the order of
the ".test" and ".expect" match.

I think that addresses your concern (unless I misunderstand your observation).
