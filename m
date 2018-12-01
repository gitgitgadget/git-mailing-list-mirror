Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF2F211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 01:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeLAMRA (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 07:17:00 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:39077 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeLAMRA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 07:17:00 -0500
Received: by mail-it1-f180.google.com with SMTP id a6so1157220itl.4
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 17:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pYeZ9Ufi+oWQX/O3C8cOQnBvJaWwmXxiLw6urcGd/Tc=;
        b=iYH1QUf63QgvFMtrSmS8BNNr6rZKZeNJb7vWeD3Rt60t5csbJIrHFKYfFGTdJUD0Py
         L3RnBlfk37yncyUqY6gEAw9toJ4S2yIlDpVeANkO8hcoMLExe0eT/O5I3c1VuLiua4RH
         gjb/x3YQlWZaMjRRwN9YXTMjpCflvUGRFRW2CLlJpdQH7VEIhz+nIuC42M2J/iThStC9
         BOsgNBNMb6bfwerHQfmB5H+yIQE5FttCuvymPTJnyaYbc6tEcEa0IBiqtM5IpFpO24hp
         simE9qAuWU7ddCNEkxWHsuAELrd7yT2ilp5sd32PnEVH2UNAqcGcbtOQmJCudsELnqqh
         dhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pYeZ9Ufi+oWQX/O3C8cOQnBvJaWwmXxiLw6urcGd/Tc=;
        b=l2M7UnqDwS+78JEJM3hCT3sFhvLhRdNdclgYkTOBjIS9PHLW4bat/BYFvFiQan2Omu
         /asFHfAiZZvNgJpnKzXnmYUISfufOH92BOlkyfyObCXNsFby5r9g0sI0Web7tNWKixOv
         bZirAvYmpMMviPz8ZT5Z3ItavQ8xDj+N4XlKrdtdBLfhjHzUAZ9LagVMP+WTiJ/mYxu1
         MtdRYoZbbWMVMcQZEyCADTbm0e6ooyhQfTwhnc57YGv4w6QF11SJZ3rg7Pnz7m3irUpu
         oO22VrGG6IjuIIv1NP7JnYEc5ZEQhWOjDGVBOe+Oy6fNmHt7v9DMxm1vIf0yL49ndpXz
         i7KQ==
X-Gm-Message-State: AA+aEWYrqtnE2EbYJzm+jEzuNTFEJKaQxRgWtHvIw4GGWA21DeaLKM7s
        Rq7pYYrnhkun4fRfu6fqGo4F52uzM+1BN7aq71ktXAQF
X-Google-Smtp-Source: AFSGD/WlMPUxF0helWwjFLc2cVa3qjSVfsrxYNDFk1O9NLzdVqkb5GX2GN7iu8Wa5jBwBMpUfCY9IBRe0TY7/IoQgSM=
X-Received: by 2002:a24:5f4d:: with SMTP id r74mr954155itb.170.1543626345644;
 Fri, 30 Nov 2018 17:05:45 -0800 (PST)
MIME-Version: 1.0
From:   Farhan Khan <khanzf@gmail.com>
Date:   Fri, 30 Nov 2018 20:05:34 -0500
Message-ID: <CAFd4kYAzOd8qwEDgVf-W+1S3NoZFUa_vZsUfuNNjL_XsuesO5w@mail.gmail.com>
Subject: Parsing a git HTTP protocol response
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am writing an implementation of the git HTTP pack protocol in C. It
just does a request to clone a repository. It works pretty well for
small repositories, but seems to fail on larger repositories and I do
not understand why.

All that my code does is send a hard-coded "want" request. As I
understand it, responses come with a four-byte size prefix, then the
data of the size - 4. The first four bytes are the size of the object
in ASCII and after that size, a new object should begin by specifying
its size. The final "0000" string should signify the end.

On small repositories my code works fine. But when use a large git
repository, I hit an object size that cannot be interpreted by ASCII
into a number. In particular, right before the crash I am pretty
consistently getting a size starting with 0x32,0x00 or 0x32,0x30,0x00
(note, it starts with 0x32 and has 0x00 in there). This is not a
readable four byte ascii value, likely an erroneous size value, which
causes the next object size calculation to land incorrectly and
subsequently the program to malfunction.

My questions:
1. Am I misunderstanding the protocol?
2. Does 0x32 signify something?
3. Also, where can I see in the source code git parses the data it
receives from a "want" request?

If you would like to see my code, it is located here:
http://git.farhan.codes/farhan/post
To compile to Linux run: gcc post.c main.c -lcurl -o post
To compile on FreeBSD you can use the Makefile or: cc -L
/usr/local/lib -I /usr/local/include -lcurl main.c post.c -o post
In both cases you need to have libcurl installed.

To run do: ./post [a git http url] [a commit value]
ie: ./post http://git.farhan.codes/farhan/openbsd
373dd5ba116d42cddf1fdcb58b578a4274f6d589

I have a lot of debugging printf() messages, but it eventually hits a
point where you see this:

========Start=========
Current stats: Current state: 999 Received: 1448
We have enough bytes, moving forward
== New Object
No Error, object is 32 bytes
Size bytes: 32 30 00 00

The program interprets the size of {0x32,0x30,0x00,0x00} to be "20"
which in decimal is 32, causing the next read to fail.
This problem repeats on a few different repositories.

Any assistance is welcome, I am very stuck on how the HTTP git protocol works.
Thanks,
--
Farhan Khan
PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
