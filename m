Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5106F1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 19:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966238AbeFOT50 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 15:57:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:42586 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966065AbeFOT5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 15:57:25 -0400
Received: by mail-yw0-f193.google.com with SMTP id q7-v6so3734333ywd.9
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 12:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpZBhbdVHiXiG6Gq84ONE0OyROArF/VfL2k/ZbgbFsQ=;
        b=D2WTUucqPIWc63sZoYwIEiyJX7ef9sM+felDY0Oa+IT/aM529jDy98fo3ZqtoyNmtV
         c99fNFhXW3cTXwN/C0+qiHHD9hjo3/nQgImKDJRj2tBS6DGYg3BT3PO0eHgxwdROY/PP
         +GRfA3SXMwPLEfSIeOr/B2nhfxLn8DzwJOtTEDePgfXAkwaAs108Rak+oTA8LwuJbDNy
         VKsJG102Wu4jycs6HRruPMjyG0EuA/NbMbp7r11jkZivPiZx2DhGZ3mbfQjXTcTtC6Xq
         eTE9PSnE1cbT5ydFvheJLEV28E6mm99T0uWucxvlKxWyOdBQLi1XuopX0dxtQTo6rxRD
         rZvA==
X-Gm-Message-State: APt69E03DYagZ+qxlpLnKjPsJF7GqzqUOaGC6HMftnVYNQMFaexwA4LT
        Is8bUjLy50CNz2Ahnfd3M4J0yoXs7SmZWFua12uZEg==
X-Google-Smtp-Source: ADUXVKIdAUBBgd8zsdARwyXl+suVS9iQCvAqYEeY3h9JJf6OWS5h2SHGIe8mRcCJGknrAWpr3ZmpmrGFQRwi4C2x+aU=
X-Received: by 2002:a81:7b0a:: with SMTP id w10-v6mr1623238ywc.70.1529092644964;
 Fri, 15 Jun 2018 12:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa7rv297r.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7rv297r.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Jun 2018 15:57:13 -0400
Message-ID: <CAPig+cQQEKjM43OqX9bT2=_yFjkiUMqjbZag5TWpsh6d_Hwn_g@mail.gmail.com>
Subject: Re: [PATCH] tests: clean after SANITY tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 2:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> Some of our tests try to make sure Git behaves sensibly in a
> read-only directory, by dropping 'w' permission bit before doing a
> test and then restoring it after it is done.  The latter is needed
> for the test framework to clean after itself without leaving a
> leftover directory that cannot be removed.
> [...]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> @@ -287,6 +287,7 @@ test_expect_success 'init notices EEXIST (2)' '
>  test_expect_success POSIXPERM,SANITY 'init notices EPERM' '
> +       test_when_finished "chmod +w newdir" &&
>         rm -fr newdir &&
>         mkdir newdir &&
>         chmod -w newdir &&

When reading this, I was wondering if there was a "rm -fr newdir" at
the end of the test which could be removed now that it uses
test_when_finished(). Checking beyond the shown context, I see that it
doesn't bother with removal since the next test removes the directory
as a preparatory step. Even before the addition of
test_when_finished() to restore write permission, the subsequent
test's removal of the directory worked because this is test is only
run when POSIXPERM is met, and POSIX allows for such an operation.
Okay, looks good.
