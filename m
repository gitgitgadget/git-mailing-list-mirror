Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3075203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 20:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933931AbcKKU1H (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:27:07 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:38878 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756920AbcKKU1G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:27:06 -0500
Received: from hurricane.home.kaarsemaker.net (unknown [145.132.209.114])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id 868C480574;
        Fri, 11 Nov 2016 21:19:58 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [RFC/PATCH 0/2] git diff <(command1) <(command2)
Date:   Fri, 11 Nov 2016 21:19:56 +0100
Message-Id: <20161111201958.2175-1-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.11.0-rc0-22-gcc0501c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today on #git, a user asked why git diff <(command1) <(command2) gave only some
gibberish about pipes as output. The answer is fairly simple: git diff gets as
arguments /dev/fd/62 and /dev/fd/63, which are symlinks. So git simply
readlink()s them and gets pipe:[123456] as destination of that link which it
then outputs.

Given that 'normal' diff provides arguably better output in this case (a diff
of the output of the two commands), I wanted to look at what it would take for
git to handle this. Surprisingly: not much. 1/2 adds support for
--follow-symlinks to git diff --no-index (and only the --no-index variant) and
2/2 adds support for reading from pipes.

No tests or documentation updates yet, and I'm not sure whether
--follow-symlinks in other modes than --no-index should be supported, ignored
(as it is now) or cause an error, but I'm leaning towards the third option.

Dennis Kaarsemaker (2):
  diff --no-index: add option to follow symlinks
  diff --no-index: support reading from pipes

 diff-no-index.c | 15 ++++++++++++---
 diff.c          | 23 +++++++++++++++++++----
 diff.h          |  2 +-
 3 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.10.1-449-gab0f84c

