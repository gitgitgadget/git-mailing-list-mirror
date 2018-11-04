Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8DE51F454
	for <e@80x24.org>; Sun,  4 Nov 2018 06:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeKDPld convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 4 Nov 2018 10:41:33 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36645 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeKDPld (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 10:41:33 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so9767105qkf.3
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 23:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EqoyEDTxSGvkhD60h9eKoE4P1CjndfzBr61dJms3bUg=;
        b=GpxtXv7uIN/gfYHfoxV8KrqKWFbxI82U6gvIcM69wQEG0x36HilQapsFSokMuABzfj
         BAx2YSWTbkUUf8BWQgDBWpYB/QeE0eOqCzmE8VZ53zX7uySGeXY6JXG/CNDUA84XG2Yh
         Bp9xwHqIDsmDVxYVu79EpadYwyLTxhSM9q0vG0SW5EKRa4q4tcrxe2f5CTIGTgiNKcGu
         eF1nOUqeyigJogMCuRnkZIeto/bSUIDia8TXeyTMhP9gd38InliRdEk1YbGQDrXLMs5T
         PQxbjmA6BA+cTTO8hfuB1PbGASI31Hi4kxIrhnCQcDmH+eoBPKKlMtyqFZvYoaLk6A/W
         LSbQ==
X-Gm-Message-State: AGRZ1gIgvCtCJo4rJzoiN3U/DqDPimRgdU/H2ShVWOgPNCnJlpY3quPn
        i+lNi+6YAXYw19aPAwA8eyLEzBAUFr5ypzdZL/E=
X-Google-Smtp-Source: AJdET5fnarWqyB8EncQtXWc57U3DNprnsZj2HW1IlNgxELczuyqbD4mUv4ukl+SUuCiDjFiocUBXcMM/drVafx07IwI=
X-Received: by 2002:a0c:86c1:: with SMTP id 1mr16468173qvg.6.1541312862076;
 Sat, 03 Nov 2018 23:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
 <20181103153049.22850-1-pclouds@gmail.com> <CAPig+cS7b0nenb0+0jyXE=-bDkhapmYE8Yr6VfyAWRq3ydjPOg@mail.gmail.com>
In-Reply-To: <CAPig+cS7b0nenb0+0jyXE=-bDkhapmYE8Yr6VfyAWRq3ydjPOg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Nov 2018 01:27:31 -0500
Message-ID: <CAPig+cQTaG=pTQ_fQp8gv-4+bzJrSGCy8zK_iDeJsFNeX+4Cpg@mail.gmail.com>
Subject: Re: [PATCH] tree-walk.c: fix overoptimistic inclusion in :(exclude) matching
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Christophe Bliard <christophe.bliard@trux.info>,
        Git List <git@vger.kernel.org>,
        Rafael Ascensao <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 3, 2018 at 8:25 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Nov 3, 2018 at 11:31 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > +test_expect_success 't_e_i() exclude case #8' '
> > +       git init case8 &&
> > +       (
> > +               cd case8 &&
> > +               echo file >file1 &&
> > +               echo file >file2 &&
> > +               git add . &&
>
> Won't this loose git-add invocation end up adding all the junk files
> from earlier tests? One might have expected to see the more restricted
> invocation:
>     git add file1 file2 &&
> to make it easier to reason about the test and not worry about someone
> later inserting tests above this one which might interfere with it.

Upon reflection, there shouldn't be any junk files since this test is
creating a new repository and "file1" and "file2" are the only files
present. Apparently, I wasn't paying close enough attention when I
made the earlier observation.

Anyhow, the more restricted git-add invocation you used in the re-roll
is still preferable since it makes the intention obvious. Thanks.
