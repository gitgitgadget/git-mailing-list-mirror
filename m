Return-Path: <SRS0=w8S9=2S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C522C2D0C6
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 07:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2400207E0
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 07:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfL1Hze (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Dec 2019 02:55:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44754 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1Hze (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Dec 2019 02:55:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so28056299wrm.11
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 23:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEHIF71u8W8za0qwo9XTfGtReI/vZH9kLWQYdU6yraY=;
        b=LvKRTl+SEJVlo5+UEQX3BMC+XqeeAJFlGejTEryHYlNuC3u5eSeYo0oFkcKFBUlEoI
         4Up2Kg3+kvY29zoMnZU5Efg3o3o7E9GGm/jpEriC+x46k8P0ny6ryrW2IDup1ZrataTS
         Iis7RdrXJols/dYPKpJvzoouGlckyrt128r1Yy9DxyOqqaVbQqdgVnXF4wspaito4ZKg
         eU8GGIswOJvaz9DIrl5b+l+4ZkEHPUa3Wf6jHlzF0FC4lxs4y6qlvIad0ukwaE0AZ8aF
         675MPbSW9ylQWsD85HdubIndimAWWdpzF4n4tlvXECPuh/25OtZ6IrWau+b9i4nQhLm6
         gMXA==
X-Gm-Message-State: APjAAAVcpXb8MWVPD53Bim9uFTvJbmyzV2fBcIx+xPxTy3PRelelWSD8
        cSeQS4SfN8xO/V/XZ0WJXwMvsyNo9GE0iqou11u6gg==
X-Google-Smtp-Source: APXvYqxg25GTiEYTdQ9caVP6bYpa5Jm9vM81WK3+UHzBbphrcP+hRp4IdOqZG5JYnckrv7Omzl64XzY7F+Ts/E8aDug=
X-Received: by 2002:adf:db84:: with SMTP id u4mr55750060wri.317.1577519731814;
 Fri, 27 Dec 2019 23:55:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577454401.git.liu.denton@gmail.com> <c584c9a52b492db2128846e86afb0aadddd6f2de.1577454401.git.liu.denton@gmail.com>
In-Reply-To: <c584c9a52b492db2128846e86afb0aadddd6f2de.1577454401.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Dec 2019 02:55:20 -0500
Message-ID: <CAPig+cQo1nbRo=n8-XOtycGijj3k1y_Zozu7VW-WTSBB9LncqQ@mail.gmail.com>
Subject: Re: [PATCH 03/16] t2018: use test_must_fail for failing git commands
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 8:47 AM Denton Liu <liu.denton@gmail.com> wrote:
> We had some instances of `test_must_fail test_dirty_{un,}mergable`.
> However, `test_must_fail` should only be used on git commands. Teach
> test_dirty_{un,}mergable() to accept `!` as a potential first argument

s/mergable/mergeable/ twice above.

> which will run the git command without test_must_fail(). This prevents
> the double-negation where we were effectively running
> `test_must_fail test_must_fail git diff ...`.

This change makes the situation even more confusing than it already
is. For instance, you can now say:

    test_dirty_unmergable !

which effectively says "not unmergeable", which is the same as "not
not mergeable". Does that mean it is mergeable? Does that mean it
should be calling test_dirty_mergeable()? Same situation arises with:

    test_dirty_mergeable !

It seems like there are four distinct cases that are being tested
here. If that's so, then rather than changing these functions to
accept "!" as an argument, perhaps there should be four distinct
one-liner functions for testing those cases?
