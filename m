Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611A0208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 21:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbdIEVjH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 17:39:07 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33545 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbdIEVjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 17:39:06 -0400
Received: by mail-io0-f175.google.com with SMTP id y123so20209748iod.0
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=ayIT4HGWPWSNeTj8i/ulhmLpiKB8KvK9kVRjXaqqrVY=;
        b=iONdgiV280sXFzOK+HvPp0S9NZCzQadFMCvkrOqwqlGdlXAsPupqWNO3Y05Vg2wIzw
         D0IUfa+PqkUt3ITJBqh0a179tZQyKB3g+Cs5S/Toh+vAvZ6dCAp/L56am7/ql2VH/j+k
         4gojbPWxcskNMbvP5HZz/D1YrN1/d/xi6H7dWHWJgQ1I+/SrbI1ot1OIn8dBCPaVjnUW
         uQnY/Xn4wPrePtXV8fqpmBSxJVJfGjqheomfka6762cPIk4xGIqaYp7siEbW0907lJZc
         8qIITzGgX7+o/crphoibuUDqsZhogBauoasatwXKFTBhVSuvzMBZraypi42FTgj6nt/X
         /RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=ayIT4HGWPWSNeTj8i/ulhmLpiKB8KvK9kVRjXaqqrVY=;
        b=psOZisI/ZscZUhiRtyca6HJ+k8XOQJAYvFO7B1ESetRh7uQ22hyOHjJhl9ACv8DePQ
         0ybNTDeF9qLP8biMEnpW9ae23ClAK9GYSrrq5RUeldA8/wBLDWoIWwMZUTLV+gtIR2H0
         EAZVmtiixbZ4rSc5N32Fukkgz1DuD9r26U/28qODgtr/S9lES6WzSDeiIxxEbeNfVvyO
         FhJXtuhkHe3Fu6GIwd5OnA1ipxDiw1OcsfJMwIZr5ypkmYluK0D4owH6r0m1yEs+b4H0
         lumMC6v55l5fSGcQCplYqXKe3TUIT41905Hcu3DrjiSprS/Sb7yhS15ZJeyI6BmzV3Y8
         soSg==
X-Gm-Message-State: AHPjjUhLz6iNEvwoO0fFZlT4SufwvgWCtB2e/l485KUt4lUCuCFOLklW
        jObOsk/tC9I3fLfWmobYoZJqG+uBjA==
X-Google-Smtp-Source: AOwi7QASXim3CJOHi5+TZfmno92l9G29AhoK6WANyliG7XvrW8tTYHwLvIRPG7zzFHMTw4a8k6vBiqly9q5JiipJLjg=
X-Received: by 10.107.183.23 with SMTP id h23mr571636iof.246.1504647545561;
 Tue, 05 Sep 2017 14:39:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.15.151 with HTTP; Tue, 5 Sep 2017 14:39:05 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Sep 2017 14:39:05 -0700
X-Google-Sender-Auth: EERB5l3bSawJsDb3I9jt3USXD1M
Message-ID: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
Subject: BUG: attempt to trim too many characters
To:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just got this with

   gitk --bisect

while doing some bisection on my current kernel.

It happens with "git rev-parse --bisect" too, but interestingly, "git
log --bisect" works fine.

I have not tried to figure out anything further, except that it was
introduced by commit b9c8e7f2f ("prefix_ref_iterator: don't trim too
much") and it happens with

   iter->iter0->refname = "refs/bisect/bad"
   iter->trim = 15

(where 15 is also the same as the length of that refname).

Not having time to chase this down any more, since I'm busy with the
merge window (and that annoying bisect)

              Linus
