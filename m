Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29E981F404
	for <e@80x24.org>; Mon, 17 Sep 2018 20:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIRCVP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 22:21:15 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:43109 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbeIRCVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 22:21:15 -0400
Received: by mail-qt0-f176.google.com with SMTP id g53-v6so16642109qtg.10
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 13:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbXcFj7XwaOedaii4QUl/AWm9uPWoXKpmNnYu5Wp28w=;
        b=qFVqYhtz5ve74RhAtLUeBGlUtSsOUb1uruS1H38E3T6r/di4EB/u7TYk8cMfF0L3iU
         8aA+jVCNqLzBFqweiNo5Epn+4HLvnAjajPgFyw4ATbF0ocjdq5b4iD9rN4EouQ3x6tbE
         rJ7LJwZZq5AQnUtlncUtYsti7wg0sW4wp3ZWRWIRZqL1RHRKu6T1b02gk0Tup6ZI/YbP
         NULPHEiMBVi0uUcc/t2sb2ZElAhajpulJWv1ES1vdRn/fNJeCV/GnvnvODNvOZDm5THE
         yVrw9aQKnQjJHpbxES4DRPCocKTaifqDbAuBFDORjdADrsxdlTQQlim4edCkvm74Kg8I
         Uayg==
X-Gm-Message-State: APzg51Dit5HUke/q+z+ezYw3XSsyndAuvtGy2nriV3gy7hax2h81dYXh
        kBZrpCBJF32dzfMjxroPPsnpBBMogxt/Pwjg4ZY=
X-Google-Smtp-Source: ANB0VdZcOjY6OcJ21hLNki3LjOHe28JNQno2wC7+O4QQlLlLeYEDdmxFzVpyRV5Rz7yvnHfF9eFvSWe/3YSvSfeSs98=
X-Received: by 2002:a0c:e292:: with SMTP id r18-v6mr19322934qvl.62.1537217534780;
 Mon, 17 Sep 2018 13:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180830195546.GA22407@sigill.intra.peff.net> <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-4-sunshine@sunshineco.com> <20180917183258.GC140909@aiede.svl.corp.google.com>
 <xmqq36u77w7y.fsf@gitster-ct.c.googlers.com> <CAPig+cSrvvWn1rd6TcG8H6tGvGDvfNJZE3KnxYazwDTfxAkVeg@mail.gmail.com>
In-Reply-To: <CAPig+cSrvvWn1rd6TcG8H6tGvGDvfNJZE3KnxYazwDTfxAkVeg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 17 Sep 2018 16:52:02 -0400
Message-ID: <CAPig+cTmfnXPX-5Ffy1TYfhVvvGsNe0j6XR3a4N2+z0_L-4aKA@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary
 files on "make clean"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 4:43 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> I did consider this case and felt that it would be reasonable for it
> to error out and ignore the error if git was missing or if the
> directory was not a repository. And, I _thought_ I had prefixed the
> line with "-" to handle just such a case, but apparently I botched it.
> Oh well.

Dredging up from memory, I think the omission of "-" from the Makefile
line was intentional since I specifically handled the case of missing
"git" command in the script itself by ignoring any error from it.
Specifically, this excerpt from doc-diff:

    if test -n "$clean"
    then
        test $# -eq 0 || usage
        git worktree remove --force "$tmp/worktree" 2>/dev/null
        rm -rf "$tmp"
        exit 0
    fi

in which a problem invoking git is explicitly ignored and the script
exits cleanly, so no Makefile "-" is needed.

Unfortunately, I forgot about the:

    . "$(git --exec-path)/git-sh-setup"

which happens earlier in the script.
