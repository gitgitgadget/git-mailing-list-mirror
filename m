Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DECA2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933752AbcKOXG5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:06:57 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33410 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbcKOXG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:06:56 -0500
Received: by mail-pg0-f41.google.com with SMTP id 3so71682448pgd.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jNzaQLh5IhN6c73D7TLASsFWgXLumaaToczSgB2P4CQ=;
        b=Vj5i/TUdUHEgwz5ljEGFUYTetwRuTtXDZHsOzU0C5s83hWodSq2mksKetYj/rIT3Jj
         mc9xhaBBjDgIzqAIb6jDYqmsw201OWz0MT3rsO6LekCmCJEWYZdH+/l7/EdhKEWb+NrW
         UhKNITS5ctwoohmbhTc9tRKBi2qpML3tGU+3hCuLUX9qNhN/rPKokpKkoFFqXgmASvnn
         PH0anGSubrKEKIZyo3Mfx7l3LczlV4vbvCJz3KHNH3ogVrLGYDSGX/+OqSEL/JluPQvK
         hByKLBNbtqt9iU0APmKi+7BqhzprEN2M8woW9vUQwy8Du6D/tNbXyQG3jfKDRjXsmm9T
         GH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jNzaQLh5IhN6c73D7TLASsFWgXLumaaToczSgB2P4CQ=;
        b=fMSXnqMXcei9NtPpB22dpY3ugqurMVj1aLXPi532vqxnvXvZKdqOK21EJ09hD1fBsI
         0u3ylq/xw+AlwnL/R1yU46PhMcHwG7iVpg4Qf5Yxa7FykStXkP7fUebCao/Tsdilewub
         Nuos37V/f5ojegDXRdzzYOFMjNLQivF+QqXinZU9uKZYOT4jtAp8jBCqCRCFKeUMkNmW
         cMwkxUlmQHJPMuxqH5zzEPQVIo1iollMLriGY84B2tKtecthROrWcJQEX6ml4rF96+89
         b7H8OZ8KM6RGw7itlnaJwhdaigqcjOaTzR+J0GE+SbvaYy/3R8Mt4CZRvbcqT2sU9dBD
         +Ohg==
X-Gm-Message-State: ABUngvde07qQr5VUfNiavUKowHcEYAuNPGZrJPXOkFeFd//krhaAg8uxM3GkWYFM0oEAZ/rc
X-Received: by 10.99.56.82 with SMTP id h18mr1125095pgn.55.1479251215396;
        Tue, 15 Nov 2016 15:06:55 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id y29sm46312616pfd.63.2016.11.15.15.06.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:06:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 00/16] Checkout aware of Submodules!
Date:   Tue, 15 Nov 2016 15:06:35 -0800
Message-Id: <20161115230651.23953-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working with submodules, nearly anytime after checking out 
a different state of the projects, that has submodules changed
you'd run "git submodule update" with a current version of Git.

There are two problems with this approach:

* The "submodule update" command is dangerous as it
  doesn't check for work that may be lost in the submodule
  (e.g. a dangling commit).
* you may forget to run the command as checkout is supposed
  to do all the work for you.

Integrate updating the submodules into git checkout, with the same
safety promises that git-checkout has, i.e. not throw away data unless
asked to. This is done by first checking if the submodule is at the same
sha1 as it is recorded in the superproject. If there are changes we stop
proceeding the checkout just like it is when checking out a file that
has local changes.

The integration happens in the code that is also used in other commands
such that it will be easier in the future to make other commands aware
of submodule.

This also solves d/f conflicts in case you replace a file/directory
with a submodule or vice versa.

The patches are still a bit rough, but the overall series seems
promising enough to me that I want to put it out here.

Any review, specifically on the design level welcome!

Thanks,
Stefan

Stefan Beller (16):
  submodule.h: add extern keyword to functions, break line before 80
  submodule: modernize ok_to_remove_submodule to use argv_array
  submodule: use absolute path for computing relative path connecting
  update submodules: add is_submodule_populated
  update submodules: add submodule config parsing
  update submodules: add a config option to determine if submodules are
    updated
  update submodules: introduce submodule_is_interesting
  update submodules: add depopulate_submodule
  update submodules: add scheduling to update submodules
  update submodules: is_submodule_checkout_safe
  teach unpack_trees() to remove submodule contents
  entry: write_entry to write populate submodules
  submodule: teach unpack_trees() to update submodules
  checkout: recurse into submodules if asked to
  completion: add '--recurse-submodules' to checkout
  checkout: add config option to recurse into submodules by default

 Documentation/config.txt               |   6 +
 Documentation/git-checkout.txt         |   8 +
 builtin/checkout.c                     |  31 ++-
 cache.h                                |   2 +
 contrib/completion/git-completion.bash |   2 +-
 entry.c                                |  17 +-
 submodule-config.c                     |  22 +++
 submodule-config.h                     |  17 +-
 submodule.c                            | 246 +++++++++++++++++++++--
 submodule.h                            |  77 +++++---
 t/lib-submodule-update.sh              |  10 +-
 t/t2013-checkout-submodule.sh          | 344 ++++++++++++++++++++++++++++++++-
 t/t9902-completion.sh                  |   1 +
 unpack-trees.c                         | 103 ++++++++--
 unpack-trees.h                         |   1 +
 wrapper.c                              |   4 +
 16 files changed, 806 insertions(+), 85 deletions(-)

-- 
2.10.1.469.g00a8914

