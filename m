Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B6B1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 20:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeHYAR5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 24 Aug 2018 20:17:57 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36557 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeHYAR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 20:17:57 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so11622876qtn.3
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 13:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xmDGL8eFblK9grh1/dCnCQq4gmrk4FhJLUaKzlbzCbY=;
        b=mjmSTpKwajmfdk/Ce1M9iONjO0Mbyx+1ZX79oJuHLFZCvJnWRm7aGtU/5/43gij41r
         xroHDlRU80aBVIriRN88FKyWxQuFZx+R8ys7tXe6i1aS5MKdPlx8DNa8zeob8Y8gWKq1
         wb6F5U8h26fBa99roOebqDpHlh+dhnag83Sxlb2F9aEJjEKdVqEUZRqRVTv+opOiBB8R
         XhgWdTBXsKe2lkpeVvDWh1zy3bI+vqcwuRzOKxYO1TjHTdHMjgPVKimivvpxCVmJaM4k
         RJbs4JMj3hOYolBUWaP+rl7/5gfRxorVM72IW5pE5HeA6cUt5xjYCz5Xvj0bIKKpMEH/
         XxjQ==
X-Gm-Message-State: APzg51A9cJy9xzUpp8JruzGnWSOOTUkmHuCMG2rhjyROdSfICnk0IeMZ
        Az5vkc1NSWQdJqmKlDR6760CPwRmmD12S4Xwslk=
X-Google-Smtp-Source: ANB0VdYjRfONSkDW/8DTLubaVhW42ILw1nsEYo0JkbJLVgQ5iDuQbOlqc9eUSKFDARRrtfpE6fQkQszm8eJeJQMq+10=
X-Received: by 2002:aed:3baf:: with SMTP id r44-v6mr3549982qte.77.1535143303517;
 Fri, 24 Aug 2018 13:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
 <20180824152016.20286-6-avarab@gmail.com>
In-Reply-To: <20180824152016.20286-6-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 24 Aug 2018 16:41:32 -0400
Message-ID: <CAPig+cTGPaHTecvjqBtFOrTsb9+X=ifQYcqss634Bt2cAFNdeg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] tests: fix version-specific portability issue in
 Perl JSON
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, benoit@openbsd.org, kn@openbsd.org,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 11:20 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> The test guarded by PERLJSON added in 75459410ed ("json_writer: new
> routines to create JSON data", 2018-07-13) assumed that a JSON boolean
> value like "true" or "false" would be represented as "1" or "0" in
> Perl.
>
> This behavior can't be relied upon, e.g. with JSON.pm 2.50 and
> JSON::PP A JSON::PP::Boolean object will be represented as "true" or

s/PP A/PP. A/

(Not worth a re-roll.)

> "false". To work around this let's check if we have any refs left
> after we check for hashes and arrays, assume those are JSON objects,
> and coerce them to a known boolean value.
>
> The behavior of this test still looks odd to me. Why implement our own
> ad-hoc encoder just for some one-off test, as opposed to say Perl's
> own Data::Dumper with Sortkeys et al? But with this change it works,
> so let's leave it be.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
