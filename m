Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02C11F516
	for <e@80x24.org>; Sun, 24 Jun 2018 10:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeFXKgt (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 06:36:49 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34747 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeFXKgs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 06:36:48 -0400
Received: by mail-wm0-f41.google.com with SMTP id l15-v6so9897437wmc.1
        for <git@vger.kernel.org>; Sun, 24 Jun 2018 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2MybSFhbi7/baRMZha7RpVuncs22tVPCCRDfwjF2i5A=;
        b=sKjozhLHzuUt4l+gP+8iGO7iEv5mezOHG92xdBT5fAF4lmGKTePFIdj++rPKRMwWNw
         103ZxsyGw+58UgmZ+Xj4WHak02uMwXQVfhkzZ67CQhaI7ukyUYnmjnAcUolTB8DZ6H5u
         Ob7/LcQ3AXF5HENVvBovVTBHyWLPA2pCjkYP3n2wrDsZjw7DTXTXSIbguGqQQWegSJdd
         iw7XpDrays0vymrWyM8kjqmgC9bvNTyZDS8G7tVQ3Lnt9FQEpuKKS1dK+r3zpFaUTfou
         T5t1DXf5M3SEbOH3yLHKiWxU4vbzLOn+E2wmKQrh4pfcE2DRUJ0rnEsIFqXTc3nX2fIf
         S/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2MybSFhbi7/baRMZha7RpVuncs22tVPCCRDfwjF2i5A=;
        b=NNCzG23AxTJJ5vbzXwRpP4L/U5ucef5ZeqMORS3D39q0uBNW9PiG678WGG66nJUuqB
         mo1udR2hGnkI6PqCD6iCvZeSTkuaEwpch8auqVgK9h4gU3Af//2tQesho/8r1n7HqoaS
         pkJLEnjfeIPEGrT2h/VSVSnWimjsP8lJYgXm3VUqCLyQCb1yvMdKVhc2YoZWbts32Rvg
         akFyhBXOiMUom1QAo6ga7/aQ9vs4wViI3mzVxpSl4f3tS45GsDpdcchpXMErttyr3dvz
         zyFSuD7hR4OyaWx11f/TUamqm97EIlgt4Tfi/sOY4Dr3QsoF3vJKEFbYR/4KfFz4j4dy
         IsGA==
X-Gm-Message-State: APt69E2svm9N8VKUXSm1a3Ou93A5CWGn7N7Tn4HimAfi7ZOIQqalugTr
        p9znZXyh9XB6oe7ULJYs8PMYIjmbD6zXc4ZIkeAIyRTn
X-Google-Smtp-Source: AAOMgpd/hrG+ciS6Qouc1jXtxBef8avmhGQh9zZvpwAUSWGQQcjas7sdKDrgSS5HrZUoFsxhtn2yhbC6NuK7jTluk2w=
X-Received: by 2002:a1c:dcd4:: with SMTP id t203-v6mr5909742wmg.156.1529836607444;
 Sun, 24 Jun 2018 03:36:47 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Penkin <dpenkin@gmail.com>
Date:   Sun, 24 Jun 2018 20:36:36 +1000
Message-ID: <CAL78Jw0mQWxO4xkzFBoG0Oe4wjomUGj=dP5ufdUrE5Ku0GGEtg@mail.gmail.com>
Subject: Incorrect unified diff when run with "--find-copies-harder"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I believe I found a bug in how Git represents a diff when invoked with
"--find-copies-harder" parameter.
Specifically, the unified diff header of a hunk contains an extra
piece of text which appears to be a line from the context (i.e.
unchanged line), something like this:

    > git diff --find-copies-harder d00ca3f 20fb313
    diff --git a/test.txt b/copy.txt
    similarity index 81%
    copy from test.txt
    copy to copy.txt
    index 734156d..43a3f9d 100644
    --- a/test.txt
    +++ b/copy.txt
    @@ -2,6 +2,7 @@ line 1
     line 2
     line 3
     line 4
    +added line
     line 5
     line 6
     line 7

Note "line 1" after the standard unified diff header.

I prepared a sample repository with a minimal file I can reproduce
this problem with:
https://bitbucket.org/dpenkin/find-copies-harder-bug

I'm running Git 2.18.0 on a macOS, but I also tried with Git 2.15.0
and 2.8.6 running on Alpine Linux and was able to reproduce the same
problem.

Please advise whether this is expected output or is indeed a bug.

Thank you.

Kind regards,
Daniil Penkin
