Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C01DC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiBPIO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:14:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiBPIO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:14:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618C224CDFC
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u2so950822wrw.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olcykHg3QImrpg40YK7DYeAOOkGJQoZqYr8QVXVSpKg=;
        b=GC/OwdQS9mwhLeuIlxdNCwoO0nYEJBqWKJ0G/kU4BW35BSfczFN/eRmyehbhq5o8TE
         Se5orPXyag9B5gPDeSCO1PJGQT2v1QI7Jkj1utwgU00EuhGQW/PxLMbRkwV6dbeX8DXy
         V93VIgP4WgdUjc7B4piVMJODA10YZceW5tn+JBtybEmFYo7MG5iErZXyFcnYvWmFEKQj
         RCHvhlYKExD+qKfmrsbus6f6E0bBcJPuK5t/Wd/berpl5qaNNBAJONTaFt+DKYBko4iO
         8hmy7RSxZZRf+u8HM3nItGgP6RUcO4uFjAAlwUgQtoIhTf8btNSsgKaI9EQF/cZqEbwA
         tdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olcykHg3QImrpg40YK7DYeAOOkGJQoZqYr8QVXVSpKg=;
        b=Dg4UJZkql3P4hDP8AE8hQD/ly/RHs7sRgdvEEFmP0d+q2fGyzFZZfR14bkiMXJx5N/
         1stmReWTDyk5FVIUP4h4U0exIEyhs4Za9McH5SdQjsEx0AMQcDU4ipLY3rL/O1UAWx+P
         zO3sHJ/9N+yNpTeFKwhkRtTgm4zBCX2X7uhHmQfNozGqNUH6+0qhyCxpggVJtxc15xD2
         Mt/Buhy+QMXMMsHgMk3nyvEqdjihdqrX9V3AACg8jYvUu/DEwcIqVH0eQVXtJ9fK9Hzw
         F1h+q75y+bm2W2XAjJ4zj9AEhl+xSegc7sGIMiWuig8+OowxPFGsyXpnFHNJUymN/M6B
         IJFw==
X-Gm-Message-State: AOAM5310T7zvgsibu+MlX1CiFBI+ljUYSWzky+VnIA0ZVqIRwMyvuuuK
        E+21daCwzoxUWjhhflrV/tAfBf042S+8fQ==
X-Google-Smtp-Source: ABdhPJxVWBj/0BJdHuxmtAIRlYnwQ75VmqGvM7OnLkHH/7u6T6W8zPDHe8h+la1+PjUSWIAmIk5cWA==
X-Received: by 2002:a05:6000:1d8f:b0:1e3:319d:519e with SMTP id bk15-20020a0560001d8f00b001e3319d519emr1363164wrb.548.1644999252581;
        Wed, 16 Feb 2022 00:14:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b16sm26173443wrj.26.2022.02.16.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:14:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] date.[ch] API: split from cache.h, add API docs, stop leaking memory
Date:   Wed, 16 Feb 2022 09:14:00 +0100
Message-Id: <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in the date.[ch] API, in preparation for larger
changes to make the revision walking API stop leaking memory.

This is small re-roll of v2 to address Junio's feedback on that
version. For v2 see:
https://lore.kernel.org/git/cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com/

This is a documentation and commit-message only update. As explained
below I think it makes sense to punt on the "builtin/blame.c" leak,
and to keep 2/5 as-is with date.h not included in cache.h, but those
things are now all rationalized in the commit message. Thanks for the
review Junio!

Ævar Arnfjörð Bjarmason (5):
  cache.h: remove always unused show_date_human() declaration
  date API: create a date.h, split from cache.h
  date API: provide and use a DATE_MODE_INIT
  date API: add basic API docs
  date API: add and use a date_mode_release()

 archive-zip.c         |  1 +
 builtin/am.c          |  1 +
 builtin/commit.c      |  1 +
 builtin/fast-import.c |  1 +
 builtin/show-branch.c |  1 +
 builtin/tag.c         |  1 +
 cache.h               | 50 -----------------------------
 config.c              |  1 +
 date.c                |  9 ++++--
 date.h                | 74 +++++++++++++++++++++++++++++++++++++++++++
 http-backend.c        |  1 +
 ident.c               |  1 +
 object-name.c         |  1 +
 pretty.h              | 10 ++++++
 ref-filter.c          |  3 +-
 reflog-walk.h         |  1 +
 refs.c                |  1 +
 strbuf.c              |  1 +
 t/helper/test-date.c  |  5 ++-
 t/t0006-date.sh       |  2 ++
 20 files changed, 112 insertions(+), 54 deletions(-)
 create mode 100644 date.h

Range-diff against v2:
1:  fb21bd7b2c5 = 1:  97746d97810 cache.h: remove always unused show_date_human() declaration
2:  96c904d0b9a ! 2:  f73aa601e95 date API: create a date.h, split from cache.h
    @@ Commit message
         use the "DATE_MODE()" macro we now define in date.h, let's have them
         include it.
     
    +    We could simply include this new header in "cache.h", but as this
    +    change shows these functions weren't common enough to warrant
    +    including in it in the first place. By moving them out of cache.h
    +    changes to this API will no longer cause a (mostly) full re-build of
    +    the project when "make" is run.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## archive-zip.c ##
3:  9ef003a83bd = 3:  764147e90e1 date API: provide and use a DATE_MODE_INIT
4:  3f70b1aa4c5 ! 4:  5c244960133 date API: add basic API docs
    @@ date.h: struct date_mode {
      struct date_mode *date_mode_from_type(enum date_mode_type type);
      
     +/**
    -+ * Show the date given an initialized "struct date_mode" (usually from
    -+ * the DATE_MODE() macro).
    ++ * Format <'time', 'timezone'> into static memory according to 'mode'
    ++ * and return it. The mode is an initialized "struct date_mode"
    ++ * (usually from the DATE_MODE() macro).
     + */
      const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
     +
5:  60dbadacb16 ! 5:  b1ee9a30913 date API: add and use a date_mode_release()
    @@ Commit message
         release_revisions() in "revision.c", as they have to do with leaks via
         "struct rev_info".
     
    +    There is also a leak in "builtin/blame.c" due to its call to
    +    parse_date_format() to parse the "blame.date" configuration. However
    +    as it declares a file-level "static struct date_mode blame_date_mode"
    +    to track the data, LSAN will not report it as a leak. It's possible to
    +    get valgrind(1) to complain about it with e.g.:
    +
    +        valgrind --leak-check=full --show-leak-kinds=all ./git -P -c blame.date=format:%Y blame README.md
    +
    +    But let's focus on things LSAN complains about, and are thus
    +    observable with "TEST_PASSES_SANITIZE_LEAK=true". We should get to
    +    fixing memory leaks in "builtin/blame.c", but as doing so would
    +    require some re-arrangement of cmd_blame() let's leave it for some
    +    other time.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## date.c ##
-- 
2.35.1.1028.g2d2d4be19de

