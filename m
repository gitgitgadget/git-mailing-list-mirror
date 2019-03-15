Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F9B20248
	for <e@80x24.org>; Fri, 15 Mar 2019 07:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfCOHr5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Mar 2019 03:47:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37906 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfCOHr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 03:47:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id a188so5008032wmf.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 00:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z35LYg/jBVBN+8KUbsHN4FE4ZenAk7AFxrXr/hEA4I4=;
        b=J7+rKEoZbOS6ga4sNAZw0nA1LOXASvfPfKJw2v15Lxsww405aic2sNE2jKoKTZrkS1
         +/7jLJUyjED11rUsRjpe/h7zGLTQYSAtVH8nyLzhiZSNlt7R5yHes9IuC6/9kbEKfph0
         SP2MCF+YoIOK7oedx4dVCMP5GkicAYg2IArqYmtTExHZl0xjnCsVWAofWcZVNK9IQ0z9
         sAC13i1mtscfm7+ThqPq8XyMlX+Lpha5fHM06GTLt+oZkbQzfPoK7DDagsz6FraINcoC
         9X+JI3fdFOowH4L7DaiQauOH8RQJFjjBBwbyjcOrjkvC0lnE1FU2xaeMZtrxevc0iIjV
         fIeg==
X-Gm-Message-State: APjAAAVHFFK4Q01s8r0Ndd8yWFBwjatDv0mSeXg21STnaqfUGUhWHzh2
        9n8NJCXzohv3qXNXwe1YuizSrH2JWJCtT1FExqM=
X-Google-Smtp-Source: APXvYqwQhMzK9MLLOXX00IgfTFL/Yzp3ujf+sf3vFfRM4/DBKMeiMZdVeTgK7usu1XH35cIsLuNtWpob3yQronvtTno=
X-Received: by 2002:a1c:730d:: with SMTP id d13mr1061463wmb.37.1552636074863;
 Fri, 15 Mar 2019 00:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190221223753.20070-1-avarab@gmail.com> <20190314214740.23360-1-avarab@gmail.com>
In-Reply-To: <20190314214740.23360-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Mar 2019 03:47:42 -0400
Message-ID: <CAPig+cTZAhRekr0Yvmtb-gTEATEX19RO0=Zh-ycCPkyEc0OxxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] commit-graph: segfault & other fixes for broken graphs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 5:47 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> I fixed a test to avoid the pattern a0a630192d
> (t/check-non-portable-shell: detect "FOO=bar shell_func", 2018-07-13)
> tests for. The new pattern is more obvious.
>
> As an aside I don't get how that doesn't work as intended from the
> commit message of that commit & its series.
>
>     $ cat /tmp/x.sh
>     sayit() { echo "saying '$SAY'"; };
>     SAY=hi sayit; sayit;
>     $ sh /tmp/x.sh
>     saying 'hi'
>     saying ''
>
> I get the same thing on bash, dash, NetBSD ksh, Solaris's shell &
> AIX's. I.e. it's explicitly not assigning $SAY for the duration of the
> shell [...]

The shells you tested may all behave "sanely" given that input, but
not all shells do. For instance, on MacOS, the factory-supplied bash
3.2.57 behaves in the "broken" way in 'sh' compatibility mode:

$ cat /tmp/x.sh
sayit() { echo "saying '$SAY'"; };
SAY=hi sayit; sayit;

$ /bin/sh /tmp/x.sh
saying 'hi'
saying 'hi'

$ /bin/bash /tmp/x.sh
saying 'hi'
saying ''
