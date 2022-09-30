Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232B5C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 12:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiI3MFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 08:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiI3MFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 08:05:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BB140560
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 05:05:03 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s18so2487841qtx.6
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 05:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=TOH3SFxsq99ryuoBYMG/dgzAWr3bjKjm0pEf89WfH6M=;
        b=ZCciX9tnlRctkuQeMzsGPzjEqUEeYxZB0OLoJC85Q6FlQ5ypHrpAgmubc1oeoOt00H
         /R989zxKWLhJp1WYyilaKTebuYWLkzskRp7d8cc6xcmeyRPqJSJmt6dQyM+Kf7kOTsd3
         ZUehoby4wg636ueCuzd7GVeLKIa3GQjvveNIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TOH3SFxsq99ryuoBYMG/dgzAWr3bjKjm0pEf89WfH6M=;
        b=rRE8kgzUW/87m7v5F+pV2nsCMH9hLBV9nzjclWETnwgzdXCibAls2zmlLJa9QXIrSs
         y4gGGJOPdQsSMRVWQfsGka2E16149ZRjvMNqxPnQ5QCKB52DIy1P8/Uqq0rP1+rG8kDs
         eMGJHGSKA+FBXqRj8EuK9oWRFZLrvND8IwvvCbd+tuBPKZP2XcPEsCQjTiegPn5DyXv4
         ylzNg9B+4chjl+9IwWnbxv7dvZf2ftCaabPlIX0N3yph14yaIl4j5UNbg7j7xg8I/p85
         cZX95Jxm6/2mzgfH5M/GrFIrqZVrGtX9IBGcxAp7QGZKYZzFyM93NFz0YYv5zd9UTOm2
         +7ug==
X-Gm-Message-State: ACrzQf1O3iKXrgkb8JGLenbLe6CyQfbpSGxMLX7d7/87skKtqVhgC7kG
        UMPBg8bQOxoyy/vSVZK6TOOBR5BcJWL1ZLjM/l2Fdc0wRnJSzEUA
X-Google-Smtp-Source: AMsMyM4d9pEAJxBt8EUW584T0kLy2bVJ42mlCJb6Z3EUlUklRWG9DC0z3hrFXJSvKSY4CckRzFFXkeqY3UJXcFFNAYk=
X-Received: by 2002:a05:622a:1904:b0:35c:c657:14e4 with SMTP id
 w4-20020a05622a190400b0035cc65714e4mr6349137qtc.65.1664539502448; Fri, 30 Sep
 2022 05:05:02 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 30 Sep 2022 14:04:50 +0200
Message-ID: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
Subject: icase pathspec magic support in ls-tree
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I just found out today both that icase magic exists (awesome!), and
that it isn't supported in ls-tree (boo).

As far as I can tell, getting it supported would be the only way to
*efficiently* prevent caseless-duplicate files from being created in a
repo, in an "update" hook: I'd want to call ls-tree on the new head
commit for the branch, passing in an icase pathspec for all the files
being added since the previous state - and then sort and uniq.

Of course, for entirely new branches I'd have to do a full check of
the tree, and for very large changes that might be the fastest/best
thing to do anyway, rather than creating a silly-sized pathspec - but
checking the full tree costs me about 1 second, a price that I'm loath
to pay for everyday commit verifications of a handful of files, vs a
200,000-file full tree.

I tried changing ls-tree "naively" to just permit the icase magic,
without any logic changes, and found at least one case where it
doesn't work: when combining wildcards with case-insensitivity, like
an icased "T/*" patchspec in the git repo; ls-files finds all the
tests, and a naively updated ls-tree does not.

I think I see the last person to update this was Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy
in 2013, giving a hint as to what would need to be done to make this
be supported; is this an area anyone else might be looking at at the
moment?

Thanks,
Tao
