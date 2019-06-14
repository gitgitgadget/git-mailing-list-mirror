Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C9B1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 11:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfFNLk3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 07:40:29 -0400
Received: from condef-02.nifty.com ([202.248.20.67]:41759 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfFNLk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 07:40:29 -0400
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-02.nifty.com with ESMTP id x5EBZotd016678
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 20:35:50 +0900
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x5EBZeru026922
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 20:35:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x5EBZeru026922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560512141;
        bh=GNLbdNnt8YjSqnMXjzf3OfBcJHpzP6doL0YnOaW1YLA=;
        h=From:Date:Subject:To:Cc:From;
        b=rJJ0PK12Gr50fpcsXZh4NKSGWJZvfYobfA9GmPAWNbSKnE3Do/fgFL0v+70KgapLJ
         s0MtRg57PsUDH8uiwGJNCLbGYV0oqAxx+MhTLnvg/R4F6kwyQxIWTNQjcJ/7zypITq
         hseb2IVJIvIIESQPKfgGqByT5ylRUR9G5sAJC2gkuAJsuU2kOtaKAI14xnJT/Gt2li
         pOS8147Qjotueb3G8DimO+S0pLu7hBMkghGSHBwMPaRa3NmImdMrTnLYxupXGJTfWJ
         ugjozeTeegE9DXU4gIwmoRtyuGolLE77soaPJoHtJD7bwWP8kxlONPBdx3pZrkauGK
         f5JgIlOzZmv3g==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id j26so1527330vsn.10
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 04:35:41 -0700 (PDT)
X-Gm-Message-State: APjAAAXNG+mUQynxfVi2XwPQPU6zI+RQunzUZgHVHRVrM+5OgZ69j8aj
        WluORoz/C0vOutvgtTP5M1YeeEdX0SHpg8KIx+4=
X-Google-Smtp-Source: APXvYqyrODJ4CKiuOz6ZyLl/4Qa9CDhkR7Wmo8RdOxQfvjOPabCW7aZf1P4f+djarXV2lUL3E4kPNs/nvx2uynOgXw4=
X-Received: by 2002:a67:7fcc:: with SMTP id a195mr33027753vsd.181.1560512140171;
 Fri, 14 Jun 2019 04:35:40 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 14 Jun 2019 20:35:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
Message-ID: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
Subject: 'git interpret-trailers' is tripped by comment characters other than '#'
To:     git@vger.kernel.org
Cc:     masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

When I tried to add ChangeId tag for Gerrit Code Review,
I noticed 'git interpret-trailers' went wrong
if a comment character other than '#' is used.


Quick Test Code
---------------

cat <<EOF | git -c trailer.ifexists=doNothing interpret-trailers \
      --trailer "Change-Id: new tag"
subject: this is commit subject

Blah Blah

Change-Id: old tag
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

; This is a comment line with non-default char

EOF

[result]

subject: this is commit subject

Blah Blah

Change-Id: old tag
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

; This is a comment line with non-default char

Change-Id: new tag



The same trailer 'Change-Id' was appended,
ignoring trailer.ifexists=doNothing



Details
-------

For Gerrit Code Review, we add "Change-Id" tag,
which will identify the patch though the review process.

For details, you can refer:
https://www.gerritcodereview.com/cmd-hook-commit-msg.html


Gerrit provides a shell script "commit-msg",
which is hooked from 'git commit'.

You can see its implementation here:
https://github.com/GerritCodeReview/gerrit/blob/v3.0.0/resources/com/google/gerrit/server/tools/root/hooks/commit-msg


It is implemented by using
'git interpret-trailers'.


I prefer ';' to '#" for commit comment lines.

So, I add the following:

[core]
        commentChar = ";"



With core.commentChar is set,
'git interpret-trailers' is so confused
that accumulate the same tag for every 'git commit --amend'.


I guess this should be fixed on the Git side.

Perhaps, 'git interpret-trailers' should be changed
to recognize core.commentChar ?



-- 
Best Regards
Masahiro Yamada
