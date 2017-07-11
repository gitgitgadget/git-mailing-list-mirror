Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1CB92035A
	for <e@80x24.org>; Tue, 11 Jul 2017 22:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755963AbdGKWER (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 18:04:17 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35493 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754244AbdGKWEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 18:04:16 -0400
Received: by mail-pg0-f54.google.com with SMTP id j186so2572174pge.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DkShWUc3fNR0G8s9eLUC9BIoxIbuWEM/rxTaJlpDkg0=;
        b=msNN2WKjU9o/u5VsncCdTNhjB22UBQYiMAlIHjUKvVqWFDwMvoPKynP+4Jtl6fqpST
         SaX0BPoSisfWbn3iddLK6oezuKPS0pKY0w1yk3x8KLgO/yt9UPm9X04rJSXa2K9G+kw7
         /W9oPN4ptSsvwJVKsbB0+XjuizqC3bTW4+z9leONf0sMgf/lbVmCVjA40eq7p27X6goU
         /ZsKTk7QPtxrWE9mJcKq39g0Z+sT192mSvSrGxFFg4VGedihcZx1PNysWdtx94vXLWOk
         hMfJdsanAbeg4g4nG9vECj9fKfascwK6GNb6PzyM/dhEgzmPh60CaRfFRZEGuBjAEGWs
         VXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DkShWUc3fNR0G8s9eLUC9BIoxIbuWEM/rxTaJlpDkg0=;
        b=RwCLouJ05+69Cz3TRP6AG021iaY23xd/3R8k/HdMFynWTG0irJtWzNXjsp1YnYccDZ
         rpxoAlj1ZeVTo0yY1MYdPyyGKHXiUn0HR4EH/6taRrOubpwRjfftKXQoAK0aDfgLf5FN
         i+Q7COuf6ewr3hervLKyUMS4OIk7CPn/A0/TieS9t5p+BToKPyV5OXCegmYdMswdhxlt
         5ndQO4LLyGOcVtEE8Fx+VLlNHY7+CfY5PhmBYszNN8NXh6V98yqbAD9htbV9ATQ3mIvE
         AKqEgXTL8ohorSMT8HnckfKos0w/RTFq7IVfKK6OpZHDU3sr7MnTLZE5AgDEHDf9gjUM
         +yUQ==
X-Gm-Message-State: AIVw1129c895xsWFm57ObdDmURJdXVSQwyfQ8n5+bTpxy+EIYs6rTF4f
        Wy7fABKE6qcurm6No/Yqew==
X-Received: by 10.84.176.100 with SMTP id u91mr599238plb.182.1499810654968;
        Tue, 11 Jul 2017 15:04:14 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d18sm542782pgn.27.2017.07.11.15.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 15:04:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/3] Convert grep to recurse in-process
Date:   Tue, 11 Jul 2017 15:04:05 -0700
Message-Id: <20170711220408.173269-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series utilizes the new 'struct repository' in order to convert grep to be
able to recurse into submodules in-process much like how ls-files was converted
to recuse in-process.  The result is a much smaller code footprint due to not
needing to compile an argv array of options to be used when launched a process
for operating on a submodule.

Brandon Williams (3):
  repo_read_index: don't discard the index
  setup: have the_repository use the_index
  grep: recurse in-process using 'struct repository'

 Documentation/git-grep.txt |   7 -
 builtin/grep.c             | 390 +++++++++------------------------------------
 cache.h                    |   1 -
 git.c                      |   2 +-
 grep.c                     |  13 --
 grep.h                     |   1 -
 repository.c               |   2 -
 setup.c                    |  13 +-
 8 files changed, 82 insertions(+), 347 deletions(-)

-- 
2.13.2.932.g7449e964c-goog

