Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39291F453
	for <e@80x24.org>; Thu, 20 Sep 2018 17:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbeITXHI (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 19:07:08 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:34193 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeITXHI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 19:07:08 -0400
Received: by mail-ed1-f48.google.com with SMTP id e25so58060edv.1
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QYRu4Z9+V9w67BuzeIDWLIqnqhyG4T+bGEE/Cvcr4rA=;
        b=iyc29se85r65CmpUOjtKyWe2j1cN+QHtVwCaiXIR3cBlIHDbUTQwaQrh+Ola1/mvz3
         ekBCbwTqox2w/iVrwk0RU3pwP9RCsX+0ut5l1x3f7rg2JLasOysIRzLj5yiOhx1ozfvI
         yhU7Yd7FPDuBHKJuMT6kItvvGd3TYza4KqpvMjpp8mpLHGU17UgZTVJNg4/oLSKkG/KY
         ocI9AWhDqb3IxsGjW3Ba8SzkIjOul+RxPIRJgaD48STvMCw1HbjwqcEOBAdFBDjwPGr7
         fEJYLeK06J5onWDDcWpvFJk+LQLPlZ17EViaZM1OrtvfXBE61ufToQastKQ0ou5wdTbX
         jkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QYRu4Z9+V9w67BuzeIDWLIqnqhyG4T+bGEE/Cvcr4rA=;
        b=QpmZcZctt4ZS+fgANuRa3KZhuiFv6WRrq4cyTbtIQMzAgxqw75KcxBoOl5fdnOKoBd
         WwyTczezbu3o+Cz1M360/iW87MGrgA+N9aG/kp0ui2AwZPy1HJK/ltpxu6DaQHIm5WEs
         MOMdhOg8z2biCxYVaeWcMw3bAUxWhCBslt64N+1bv6a5MYTa3JSdEW5Rs+eytb2zSqwC
         k4y9RBuB4EWwiDQlKHn9xd5rgcRR5cPENVIjdUEzSQH3XxypIgn213km/qnTguB+rQTF
         aA/L+mVZG6R9rRGM0eQAhZ5OFp4PT3dJ3julH+YPBaTnk5rwrbmg7SUqNN7Xotrb0RSa
         ydaw==
X-Gm-Message-State: APzg51Ac/lZOMsKVO35dmarqWBaKMW12jobWNrACcy3Z24bI2PjjL4/p
        l0gG+3+xmsEN2IHskZG7ani6gVHfmAG+TKLZP+mLdJ5L
X-Google-Smtp-Source: ANB0Vdaloe4VpZbwn4gXER+cSYvUetDApN6mDc5DCRPU0goGSVp3px2lEK0YuAfEq9C/nanYbVJ2J+pW9/MKM9j85nc=
X-Received: by 2002:a50:91ab:: with SMTP id g40-v6mr5830075eda.50.1537464156478;
 Thu, 20 Sep 2018 10:22:36 -0700 (PDT)
MIME-Version: 1.0
From:   David Alphus <david.alphus@gmail.com>
Date:   Thu, 20 Sep 2018 13:22:25 -0400
Message-ID: <CAB=bJ9Mjw2keJ3aspLWcreLBcB15Eq-WjtBO0XS8B=C3XJmx9A@mail.gmail.com>
Subject: git check-ignore ignores negated entries
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a .gitignore contains a ! entry, git check-ignore will still say
the matching file is ignored if the file is not in the index.

Simple case to reproduce:

$ git init .
$ echo "*.c" > .gitignore
$ echo '!a.c' >> .gitignore
$ touch a.c b.c
$ git check-ignore a.c b.c
a.c
b.c
$ git add *.c
The following paths are ignored by one of your .gitignore files:
b.c
Use -f if you really want to add them.
$ git check-ignore a.c b.c
b.c
$ git check-ignore --no-index a.c b.c
a.c
b.c
$ git check-ignore --no-index --verbose a.c b.c
.gitignore:2:!a.c       a.c
.gitignore:1:*.c        b.c

In looking through check-ignore.c, it appears that we check that
last_exclude_matching() returns an exclude object. It should be noted
that we do not consider that exclude struct can be set with the
EXC_FLAG_NEGATIVE flag. This flag says that the final matching rule
should not be ignored.
check_ignore needs to consider this condition in order to work properly.
