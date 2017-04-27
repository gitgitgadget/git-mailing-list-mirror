Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBEA1207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 16:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936068AbdD0Qg5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 12:36:57 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34141 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdD0Qgz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 12:36:55 -0400
Received: by mail-qk0-f180.google.com with SMTP id y63so32288942qkd.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 09:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4kmIOtVMLbApQrzvmgU4/3FzPAHCUhpUscFOCEbLi/U=;
        b=sW9jaZan7Wc9BicaX7r48srEuhlWVTevKdsNH3N8SE74d3FxjkhX+9MTpL2QfLUzh6
         9kUJUDC2b0LRe3t37eQB2I1L0cr/Gg/KeuFrW002BAa4vhn0HKclWcKopQahRnIenIpL
         BoUdW9urz1A/662MdxQSEKFnYLkEyEOji7bAn+UcBNGP5G55drcl5fKqKQGLa4sc4DQy
         EaHlZwHqtnKQ+Xxn2HwXMSs76fo5CcMgly14VSY8I/bkS7fX8+Li2eKOoakRpEg/YICN
         MnOvs025eRuubpLpbJBaqUb7hMuuDez9QK+mQDrr6f2JGkHnsfkzEZ9+XGR9nq/TrrIz
         gncQ==
X-Gm-Message-State: AN3rC/58CwZdDKeDD4TuO8UDi9UlfSnjkd3y9L3hktk5YIF3+xNX8X1o
        BntGLD7e1a7Slbzpf5so/TmLISQ4nASEmRA=
X-Received: by 10.55.21.154 with SMTP id 26mr5542827qkv.287.1493311014430;
 Thu, 27 Apr 2017 09:36:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.103.245 with HTTP; Thu, 27 Apr 2017 09:36:54 -0700 (PDT)
From:   Robert Stryker <rstryker@redhat.com>
Date:   Thu, 27 Apr 2017 12:36:54 -0400
Message-ID: <CA+Up40iusByn-R55=2=2Ae8KH1mkj4hGF_E9dX3vn1vboyMwMw@mail.gmail.com>
Subject: 30min Script in git 2.7.4 takes 22+ hrs in git 2.9.3
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all:

The following script attempts to merge 4 git repos into one,
maintaining tag and branch content (but not SHAs). Each original repo
basically gets its own subfolder in the new one. Original repos are
first rewritten to have their history think they always belonged in
the target subfolder.

The problem:  the script takes 30 minutes for one environment
including git 2.7.4, and generates a repo of about 30mb.   When run by
a coworker using git 2.9.3, it takes 22+ hours and generates a 10gb
repo.

Clearly something here is very wrong. Either there's a pretty horrible
regression or my idea is a pretty bad one ;)

General process for the script:
  - check out 4 repos
  - rewrite their history so they always thought they were in a subfolder
  - copy these 4 rewritten folders to a temporary location
  - get a list of branches and tags for each of the 4 repos
  - initialize a new repo with a readme.md
  - for each unique tag
       - check the 4 rewritten / backed up repos for the tag
       - for each of the 4 rewritten repos:
            - if the tag exists in that repo, merge it into the new
repo in a test branch
           -  git pull --no-edit ../intermediate/oneRewrittenRepo    (SLOW PART)
        - save the tag
   - for each unique branch (same logic)

So... yeah... 30mb + 30 minutes -> 11gb + 22 hours somewhere between
these two versions of git?

According to coworker:

during each pass of the Tags' loop it's sitting for a long time on:

 git pull --no-edit ../intermediate/webtools.common

which runs in its turn

git fetch --update-head-ok ../intermediate/webtools.common

which in its turn runs

git-upload-pack ../intermediate/webtools.common


Any ideas here are much appreciated =/

The Script in question is here:
   https://gist.github.com/robstryker/4854fc86ab3714a5e1af353b98cbc768
