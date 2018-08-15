Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017CA1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 20:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeHOX3f (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:29:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42413 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOX3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 19:29:35 -0400
Received: by mail-io0-f195.google.com with SMTP id n18-v6so2070658ioa.9
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9t6O0PO41Q5333jF6PfNZO2FxApDdkuGqR6e/d36SzQ=;
        b=XobsFjN2Cdm3YQ2Qh3wMQOV5Q4mdZpREQo2Ilea6tnizFlC8odjk/DKisYCGefWB00
         JBXkXIDWpuccq1yAKKMJ4on8L0dUaTTA336yJHLoOjANCBZkA9sbtBoOPLJS/JwfFf3g
         424oDjOToBU9dGeWXg/fpOo7se9hOtMXdzxNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9t6O0PO41Q5333jF6PfNZO2FxApDdkuGqR6e/d36SzQ=;
        b=bzHzakHpK9j+ijwiBWtuUC/AiYCs5Z6uSCXQUyW7YEPMzbpasEPcvBkI4IH4Ho1wpW
         gZx0WfyjZ3w0gCPNA4uIt1fzmLbP9ZnL0shUgBWBI0imt2m88DMlu4tvfT1Kfd9lfN02
         0OigYbXAy1IV2yHrAjyemSlwiQZPQghn1d8iMCZryERk72ZlUv1WYA1OC317aXT4+uEM
         YOEbeZHN5BseMfNDUMcbDOKhJgEh1r920b+ZTkKVkkWB5+bhb8MQBK1r5UXhep5Ejn8b
         5/RIrP6BxnqmDSViAbjl7iQMaddyVe2ZQUh3VJkFd6gDJ16NxvoW5lsBQEvRnTkvk254
         dkVQ==
X-Gm-Message-State: AOUpUlGNboJYPTa34rVw4mPD4lqc732SUkoHM+yFa18/vjkANcKmLu9y
        O/JxzPBF8xI3EYWUFhjYbSv6zzNSHJEtJRZvGR1c/vY8
X-Google-Smtp-Source: AA+uWPxEbgON2O04bExR74DWVpJ6FZSHNgF2CjRNoD1sr1ppxtIN/ah+EXn6+3mHZ08jSYGNYGELxo1Rt7JAS9fZ09k=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr6792444ioh.259.1534365351440;
 Wed, 15 Aug 2018 13:35:51 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 13:35:40 -0700
Message-ID: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
Subject: "less -F" is broken
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sadly, as of less-530, the behavior of "less -F" is broken enough that
I think git needs to potentially think about changing the defaults for
the pager, or people should at least be aware of it.

Older versions of less (at least up to less-487 - March 2017) do not
have this bug.  There were apparently 520, 527 and 529 releases in
2017 too, but I couldn't find their sources to verify if they were
already broken - but 530 (February 2018) has the problem.

The breakage is easy to see without git:

        (echo "hello"; sleep 5; echo "bye bye") | less -F

which will result in no output at all for five seconds, and then you
get both lines at once as "less" exits.

It's not always obvious when using git, because when the terminal
fills up, less also starts outputting, but the default options with -F
are really horrible if you are looking for something uncommon, and
"git log" doesn't respond at all.

On the kernel tree, this is easy to see with something like

   git log --oneline --grep="The most important one is the mpt3sas fix"

which takes a bit over 7 seconds before it shows the commit I was looking for.

In contrast, if you do

   LESS=-RX git log --oneline --grep="The most important one is the mpt3sas fix"

that (recent) commit is found and shown immediately. It still takes 7s
for git to go through all history and decide "that was it", but at
least you don't need to wait for the intermediate results.

I've reported it as a bug in less, but I'm not sure what the reaction
will be, the less releases seem to be very random.

             Linus
