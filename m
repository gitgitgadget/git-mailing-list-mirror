Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3781F405
	for <e@80x24.org>; Sun, 16 Dec 2018 21:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeLPVw0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 16:52:26 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:32861 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeLPVw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 16:52:26 -0500
Received: by mail-it1-f181.google.com with SMTP id m8so3879638itk.0
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wkWDPKzs3h0Dx8dvY9/RZetsDbc5q84iaovqLN8UYm4=;
        b=OCyP6GzSU6hPWTvsvs/a6tFeg1t2sCUpAoTqTd3dRsDtW2ndk2lTSi06k731TBkVEj
         nZwnvx3al7DsScvcNx0HFuWkZTb615UnRTIWkZZjV7IDcv5g5NUMkg789iKFWohGgXdy
         3JdlckC6+4rP8pi4NLVj3zdi33yCvW7H7GvshWKTcWhR6J1ftng8WnWTi6qZyPoO+eFD
         5j9V48uROROpdUtmCIh3X3tyUn/gjVDMAkhHbWu+tinAYTpqeHVs0a+H3n+MgRVZCI7C
         /rT8wQkIKNuEZSBh3jikZ/5zvL5rV5kKqKuD+0maeCe6EbzREes2GOczWy4+Q5S0pb8w
         9wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wkWDPKzs3h0Dx8dvY9/RZetsDbc5q84iaovqLN8UYm4=;
        b=Rj4UwJvYtokKsLAZ5kANs6a9LN3ki+PVqIlN1jIlsyS86Fsd5q6OUtsXl/vYbzhAgq
         fb0y5PTAxpA/ecT4zbjoovSCbS/GItyYtj3mzPLi2FLSNpf1tneEKwt4f/zT/MOBzneL
         21re6zLKuQe6rQI+fvSO8qHSn9RaHcoATtb1zwKlsuKJwe7b0HdSCU2aDUFeBbk8ni9o
         APLsj5ghT21Y/NxnkaceeFp4C9juTQdxmt2Y9qzjBiPcaWLDMgq7Q+eBe7f60K3WdFq/
         Jrx92pJH/CnA59T4VQVLpHZnArTSvJEd7kC1c690lKq+OMyoOOMk57+8a0aNxFdMgTpQ
         2pyA==
X-Gm-Message-State: AA+aEWYVxVXzpug5neklzByvBf0gDqFEz47FNScklBH4IGbpUxsbsvia
        G97ygAFnJsZH11ICqFsFV8k+d4+rCyIGvVAAH4hKWw==
X-Google-Smtp-Source: AFSGD/Wqu5oDw/pjFS8YIJi0un7tH+v5WEijvr3zutJJtKeOLFSPPNoHK5yiJrm6fwoREX/jyh3bKf59TONWNG1M/yU=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr10069432itk.114.1544997145061;
 Sun, 16 Dec 2018 13:52:25 -0800 (PST)
MIME-Version: 1.0
From:   Farhan Khan <khanzf@gmail.com>
Date:   Sun, 16 Dec 2018 16:52:13 -0500
Message-ID: <CAFd4kYCHefqRsiFK=K7MHp=MTwOBXB5979WobEm3w1J5q1bZ0w@mail.gmail.com>
Subject: pack file object size question
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am trying to write an implementation of "git index-pack" and having
a bit of trouble with understanding the ".pack" format. Specifically,
I am having trouble figuring out the boundary between two objects in
the pack file.

It seems that there is a 12 byte header (signature, version, number of
objects), then it immediately jumps into each individual object. The
object consists of the object header, then the zlib deflated object,
followed by a SHA1 of the above. Is this accurate? If so, where is the
size of the entire object size (object header + zlib deflated object +
sha) identified in git source? I tracked it down to what I believe is
builtin/index-pack.c under the function parse_pack_objects, the
for-loop currently in line 1138, but I cannot find where that object
size is calculated for the next iteration of the loop.

I think what I most specifically need is where the size of the
deflated object is identified.

Thanks,
--
Farhan Khan
PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
