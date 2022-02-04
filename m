Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1EBC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378316AbiBDXxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiBDXxM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E006AC103DF8
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:53:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r19so3255087wrg.10
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n4dg6fWxrfv0qI6sS48jWZZk9Jpib21rIqJKBYuyHZw=;
        b=cfoyQSMyh2lbDKcgUXYf1kBxZWUJJSQtgrEMmXJxOiNfJ/27U/bp1se2gFvRv4p1Qr
         uAnCWK4Y6+fb3ghVR40R7G+6ehyUPaxYNjIukhcTqds6EikhlTKANpOOe9A/w8EOCvBr
         ldYn5/r3ohDOhMggEuuVNZG8nTwpxAqe5n4zjHAIjzk14tkToY3LwxA6SUCEa6qwDsLz
         SQVIq+JIpi/MBPJuZ4rzd0zKOVBiRJVYa2ifS1fLRasJzGuPfkW0TuilNtGiSHaPCav0
         Id+3PHKqUiVS+SUtEVFDMajbjFe2x2bLNuMcXrbhDzK+z9pXIWdtX7sO6LpkkrLHWOiX
         ueyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n4dg6fWxrfv0qI6sS48jWZZk9Jpib21rIqJKBYuyHZw=;
        b=jDs8nLBvysI2gegWrcp2C25lixfCmKbsPSJ5G4+fnmrsejNCY1E6gcUDTGGUJL3Slg
         sYjreUcR1rjto8OnTBy8ezDeNhiwCKaT3yJ5scXUUnKcmq7MdRsI1+UM7Ri5rWVwqBxh
         OqA63Kkqznne1i0XLpDdSccn9fTaVZtAU5uMKkWKJcHUcwEOUjI9qlG50AJM945oJfWh
         1Idw8hYdGA92QwrJRVxuVRtVdgCcLmKjFB3u232PdgZkWOE3LyhBdU/n1V0b5jajXTnu
         9UXGC1OBf1zGQLfgSMYk79sCh3bk7F82N58JhLP9PTawKTTv52/oAVsyLaBryhzSOnGh
         Lt+g==
X-Gm-Message-State: AOAM533oBAD2E8ZRKOferTkHAlzObdnTek1j1PRuTyEtAiK7dqIvIPHD
        qk75R2I0K/c1oFM0DbqxZD8rKgJzUPFePQ==
X-Google-Smtp-Source: ABdhPJya2W44+B8wieMqwOOf8ZN89AHnQ5l3X14pwEyYt3YOcmsYLK/LpPX487U0xN73IcXZ5Tcg0Q==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr967973wrt.495.1644018789190;
        Fri, 04 Feb 2022 15:53:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm3304507wrw.5.2022.02.04.15.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:53:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] date.[ch] API: split from cache.h, add API docs, stop leaking memory
Date:   Sat,  5 Feb 2022 00:53:01 +0100
Message-Id: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in the date.[ch] API, in preparation for larger
changes to make the revision walking API stop leaking memory.

This is a trivial re-roll to v1, to fix an issue that "make hdr-check"
spotted. For v1 see:
https://lore.kernel.org/git/cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com/

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
 date.h                | 73 +++++++++++++++++++++++++++++++++++++++++++
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
 20 files changed, 111 insertions(+), 54 deletions(-)
 create mode 100644 date.h

Range-diff against v1:
1:  fb21bd7b2c5 = 1:  fb21bd7b2c5 cache.h: remove always unused show_date_human() declaration
2:  7de62956db4 ! 2:  96c904d0b9a date API: create a date.h, split from cache.h
    @@ pretty.h: int format_set_trailers_options(struct process_trailer_options *opts,
     +
      #endif /* PRETTY_H */
     
    + ## reflog-walk.h ##
    +@@
    + 
    + struct commit;
    + struct reflog_walk_info;
    ++struct date_mode;
    + 
    + void init_reflog_walk(struct reflog_walk_info **info);
    + int add_reflog_for_walk(struct reflog_walk_info *info,
    +
      ## refs.c ##
     @@
      #include "strvec.h"
3:  2d5210f9421 = 3:  9ef003a83bd date API: provide and use a DATE_MODE_INIT
4:  aab2ae9cc72 = 4:  3f70b1aa4c5 date API: add basic API docs
5:  b67e23549ed = 5:  60dbadacb16 date API: add and use a date_mode_release()
-- 
2.35.1.940.ge7a5b4b05f2

