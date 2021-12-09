Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9CCC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhLITXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLITXG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F17C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o29so5097814wms.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlueLeHgmHmf1dlIbEtNlK7TZC3Kluzf1N8dUTgZ0+4=;
        b=SyBZoQAvsNTD+rvn9dy3z/oNFpL1jWd6KLzJ84eTmLGmFaiO9dOMAASoxmNTONzJuB
         yQjWYD3/LXh4lOE6EpYQ5713k8ez6qrvAcws60uwzjbbsrCwl9C6qFjoEiBico1rwceU
         NGkunmvkrwkujyfie87hlBLw/7mvz3OlDkts5iixY7S4j+srGPTABNIeD8lUaMZ+BA02
         f5mCyhstFcHnQ5g5VoasRoD/XPwqnt5zlFCq05Hk4xAY8F7+Q+4OSYOGujHni/tHrS47
         1vuYzr8DMP12l/Y3FhRB/FWkYq/RGfsE8CpI7Ro+OqHEa3AbeDj8Q17NBJFzp+2ihDj8
         oJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlueLeHgmHmf1dlIbEtNlK7TZC3Kluzf1N8dUTgZ0+4=;
        b=EIyX2TjIobK4B3XfPQajKdzAd7bLLNOn+dOXQQzG75XsQ0mUXWrw7YpXoDxngzCHWj
         PpZexEJ3Qy5RWoPiFyIo3Cc6rzUgSvog311gLT8EMDXRUUVXq593sGH5zAkF09Vd70OJ
         wqRF8pCEeKvypJ+S+j5j+Far8/W3xzDkBp/2NSJp7Rl/4e77kTm5TLQtyf+/y8/m7g8z
         1podIN2lrOI3hFpvgtTyyc98nL49Ra9hTbax3OPlORMmS1JXtw61o6PYNfinb81EcPpH
         uJdxc9PMxgdbF0GWQg6OAXXEwdvLoYqMWe5BT3TxGy3ejJ5hezPFIDwH+uVnZhysoKHg
         VaWA==
X-Gm-Message-State: AOAM533eM+B4HtOhaKJw0eLhDH7wnrrMDZ86/7lQVvUShEgESqR0TJGK
        UI8lLDElc3VdkWwWF6fCqpnnZrEl66om7w==
X-Google-Smtp-Source: ABdhPJzbhcBobL2c6MXRhdxyHqovlkSh4a1dLRzSxpfSqsP7196f0P3JMEnMaTOuFynFfD2qCdOffg==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr9605192wmq.79.1639077570786;
        Thu, 09 Dec 2021 11:19:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 00/10] range-diff: fix segfault due to integer overflow
Date:   Thu,  9 Dec 2021 20:19:17 +0100
Message-Id: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The difference between "master" and "git-for-windows/main" is large
enough that comparing the two will segfault on my system. This is
because the range-diff code does some expensive calculations and will
overflow the "int" type.

Fixing this wasn't trivial, our st_*() macros only work for unsigned
types, but as signed overflow is undefined in C detecting it is a lot
more painful. The range-diff code needs to store -1 in various places
(not inherently, but changing that looked a lot more painful).

Furthermore even if the range-diff.c and linear-assignment.c code were
fixed we'd still segfault due to the used string-list.c code using an
"int" type. Or rather, we tracked its "unsigned int" with an "int". If
we used "unsigned" we won't segfault on master..git-for-windows/main,
but we would soon enough on slightly larger divergent history.

This series changes the relevant APIs to use size_t where possible,
but as noted we need to use a signed type for range-diff.c. That's now
intmax_t.

We detect signed overflow first 8/10 with a GCC and Clang-specific
__builtin*() function, and then in the subsequent commit portably by
importing intprops.h from Gnulib.

Perhaps there's an easier way to do this, but this works for me, and
using the portable intprops.h (see its source for all the hard-won
lessons encdoded therein) seems like a good way forward. It *is*
slightly slower than our current unsigned-only detection, but as
discussed in 09/10 we should probably just switch to it anyway. This
series does not make that switch.

We still have various st_*() calls in the codebase where we use signed
types, presumably this is as broken as the not-really-working
detection discussed in 02/10, but I didn't looki into those in any
detail.

This is an RFC because there's some rather painful merge conflicts
in-flight due to the changeover from "unsigned int nr" to "size_t nr"
in the string-list.h API. There's also a CI failure on 32 bit linux
due to a format in 03/10, but it's an easily fixable bug.

And more generally it's an RFC perhaps this direction is a good one
for fixing that and any similar segfauls we have, and maybe it
isn't. I'm not all that sure about it, but this seems to work, and
certainly beats segfaulting...

Ævar Arnfjörð Bjarmason (10):
  string-list API: change "nr" and "alloc" to "size_t"
  range-diff.c: don't use st_mult() for signed "int"
  range-diff.c: use "size_t" to refer to "struct string_list"'s "nr"
  range-diff: zero out elements in "cost" first
  linear-assignment.c: split up compute_assignment() function
  linear-assignment.c: take "size_t", not "int" for *_count
  linear-assignment.c: convert a macro to a "static inline" function
  linear-assignment.c: detect signed add/mul on GCC and Clang
  linear-assignment.c: add and use intprops.h from Gnulib
  linear-assignment.c: use "intmax_t" instead of "int"

 builtin/receive-pack.c       |   6 +-
 builtin/shortlog.c           |   8 +-
 bundle.c                     |   4 +-
 commit-graph.c               |   4 +-
 compat/gnulib/.gitattributes |   1 +
 compat/gnulib/intprops.h     | 637 +++++++++++++++++++++++++++++++++++
 linear-assignment.c          | 149 +++++---
 linear-assignment.h          |   9 +-
 mailmap.c                    |   4 +-
 merge-ort.c                  |   2 +-
 range-diff.c                 |  32 +-
 string-list.h                |   2 +-
 t/helper/test-run-command.c  |   4 +-
 wt-status.c                  |   8 +-
 14 files changed, 781 insertions(+), 89 deletions(-)
 create mode 100644 compat/gnulib/.gitattributes
 create mode 100644 compat/gnulib/intprops.h

-- 
2.34.1.930.g0f9292b224d

