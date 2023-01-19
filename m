Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D2EC678D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjASXAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjASW7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:59:30 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1776D4CE61
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:49:10 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8CF2D421;
        Thu, 19 Jan 2023 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1674167947;
        bh=Yu92jo+4KD0jGTM3jMdV7cXVvEU1zQKwFdJ8rJXSJxI=;
        h=From:To:Cc:Subject:Date:From;
        b=KkRgfSdiLS8xz1wrcJY95lUuEqZmtH4w8JctjvpJCRWS7dG8g2XGBYbrQ5zwQqq82
         AXAyURMpHNBVWjfzsLGJ0xBHaq2zYRJiNpCPc33J2mDErYKQWCitRLv3jtFMKNaU2k
         UUwhCzlmyqhHc9eZMv4Va0MGjKI33A/vCAQC28ao=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     git@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Patrick Hemmer <git@stormcloud9.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Denton Liu <liu.denton@gmail.com>,
        Emma Brooks <me@pluvano.com>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH 0/5] format-patch: Add --{to,cc}-cmd support
Date:   Thu, 19 Jan 2023 14:38:53 -0800
Message-Id: <20230119223858.29262-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On more than one occasion I've found myself wishing that git's
format-patch command supported the --to-cmd/--cc-cmd flags that
send-email does; this patch series is my attempt at implementing it.

This is my first foray into the git codebase, so odds are good I've
bungled something or missed the existence of some useful API, but it
passes the existing test suite (and the tests added for the new
feature), and I'm giving it its inaugural dogfooding on this very
series with `contrib/contacts/git-contacts`.

The first patch adds a test I found myself wanting when I realized I
had accidentally broken something that wasn't covered by the existing
tests.  The next two do a bit of refactoring and rearrangement, the
fourth adds a bit of library infrastructure to pretty.c, and the final
patch implements the feature itself.

There are a few points where I wasn't sure if the approach I chose was
really the best:

 - The 'name_and_address_only' pretty_print_context flag added in the
   fourth patch is kind of clunky, but I didn't see any other obvious
   great way to reuse the bits of pp_user_info() that I wanted.

 - Fork/exec-ing another internal format-patch command to generate the
   temporary patch file to run the commands on -- my attempts to
   recurse back into show_log() to do it more directly didn't go well.

 - As currently written any commands specified are only run on the
   patches themselves, not on the cover letter.  The slight
   inconsistency with git-send-email is a bit unfortunate, but I
   figure it's probably not often all that useful in that context
   anyway (and the implementation looked like it would be just
   non-trivial enough that laziness may have played a role as well).

Suggestions on better alternatives there (or elsewhere) are of course
welcome.


Thanks,
Zev Weiss

Zev Weiss (5):
  t4014: Add test checking cover-letter To header
  log: Refactor duplicated code to headerize recipient lists
  log: Push to/cc handling down into show_log()
  pretty: Add name_and_address_only parameter
  format-patch: Add support for --{to,cc}-cmd flags

 builtin/log.c           |  31 +++---
 log-tree.c              | 208 +++++++++++++++++++++++++++++++++++++++-
 log-tree.h              |   1 +
 pretty.c                |  15 ++-
 pretty.h                |   1 +
 revision.h              |   4 +
 t/t4014-format-patch.sh |  26 +++++
 7 files changed, 262 insertions(+), 24 deletions(-)

-- 
2.39.1.236.ga8a28b9eace8

