Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD99CC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 22:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiHTWkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 18:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTWkI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 18:40:08 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF15326AC4
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 15:40:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q74so5755841iod.9
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=kKEwPcUQ6lNdL6FMFvPXh37OZEJ7mjbV7ls/4ApN4fU=;
        b=nLI5ug8g2FhzGn/0oCeIPu1WVpREb2oWXpJNUErdS0te1jUhDuhysQRF88EJb6VuCc
         kdCzlBmOGkBhwchB9+9Y46Tl4UYTRqCvqNvTZbudcd3JyQSeIQllz54FglJQkoU3XAzJ
         TnBkmgSabmbzmdWzJuukZhZscFA6pcdh389R69TAeTpU/dGqdJ7LFrUZL+xkXIwltjxK
         vW/UD2nj4PoMWWEKgLdKVxLVc5Z9TozSrzdOJ1QaeusZ8gJzBNOHQsTLBL0p/ahag+mn
         UIvC3xVcPUSTGrhrw+/GskrmH9LElgT3i24vMeNX0/Bf12KuDCKVrs8zY9YAntk56up0
         vczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=kKEwPcUQ6lNdL6FMFvPXh37OZEJ7mjbV7ls/4ApN4fU=;
        b=YSJMQW9mYIU3a+egVShMqdQQvhYkrLsLgCY1OmqKmqALtJMEFmaYGUx2/K+G6TTLec
         4yxYdv4l/PF323uN4BbgplLPlsThRTQRqCQiIRFsTP2e8SmD/pK/nZzTRn0mdAlgabQH
         28BhEQZpMbHNes3gJOe3NBy6KL/zQnsxF4zFVtYRxs6OpZLJl1tLub5VT7S6gOMefUTH
         DXMIvwvsDwJIlaEGVIzsnpzdBRE0ojQWYeeIXpbk0lfGy5aI1UT8inQ9Y+xqwfy211re
         FZgyCcH/9XnU8bqctuuDGk/LDdQZAa3fWbiDlsYPCGBt8ICIbWyH9D0oBJTiu3ZXCSn6
         vhGw==
X-Gm-Message-State: ACgBeo0Ksk/XZMLV69M1pYPVA0PQNjjN6TKrMUw9UjJ0TrHA1f1Yka1S
        7aNxXDQZ9wEEDmmPXeoQEwK16+78b5PEnMIvnD1KQlEH6xAL
X-Google-Smtp-Source: AA6agR6HlweMtZzejVcCj1+EM8tu63GTCVcWfLaYIWHOZZQgCaUoUeUt0C2/s2pMlibjk2fnydMKMUfm0NoNEH625D8=
X-Received: by 2002:a05:6638:3804:b0:349:881b:a4bc with SMTP id
 i4-20020a056638380400b00349881ba4bcmr3227307jav.313.1661035206587; Sat, 20
 Aug 2022 15:40:06 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Hockin <thockin@google.com>
Date:   Sat, 20 Aug 2022 15:39:54 -0700
Message-ID: <CAO_RewbD+BJd1hPKCmCNM8wYBSUmZ2TuOoy6t1up1CT-rbn4DA@mail.gmail.com>
Subject: rev-parse: -- is sometimes a flag and sometimes an arg?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

```
$ git rev-parse unknown-tag
unknown-tag
fatal: ambiguous argument 'unknown-tag': unknown revision or path not
in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
```

OK

```
$ git rev-parse unknown-tag --
fatal: bad revision 'unknown-tag'
```

Much nicer error.  But:

```
$ git rev-parse HEAD --
113a928239196d0d9f70671517ce917071ceecf6
--
```

That's not very nice.  Why is "--" treated as an arg?

```
$ git rev-parse HEAD
113a928239196d0d9f70671517ce917071ceecf6
```

Looking at rev-parse code it SEEMS to be intentional, but I can't
comprehend why.

Tim
