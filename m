Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5F71F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 13:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948070AbcHRNQ0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 09:16:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36458 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947139AbcHRNQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 09:16:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so5538805wmf.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 06:16:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GK8lhP1GEo95wYuc7xLYPCUqlIyIycmKqcv1CIluM1M=;
        b=sCsqozd5F3eBL/UXFo/AZy7h9SJbVKhontRaYXRI03PnuJ3sTgIwsoV9uOR3GW7gbG
         57AZyk/iJDC1XLwUP0y4U0mP86xYlXUaiKIafKVsZ8PcOBzKC4yzuwuSpNIy5Lq7QavW
         PBkjtd0FnwH+cI+GMkBuaTpLLUKdBxyhx2HLrfwJtCUpZSD6hN6XvQ7eOebu1MA95Mh0
         MXnMcjt/gOqcufIVTob3qvIlk6WqcXm/m/8vjmEowgAz+yUZWYcUVIt84L/0yZ+jBswn
         mG2loxoJcTgN1jQ1rPeAnpoV+3nmF1DVTWeFIbWL5BFGneSyFDCcc6WD8PhW0LsRlDbU
         PDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GK8lhP1GEo95wYuc7xLYPCUqlIyIycmKqcv1CIluM1M=;
        b=ScD7COXX4TO460Qt6FEMmhXjdgJw+9GiFM5eBnYYZuOk/07hME7c5vmXvvWJDBLhqa
         q0y8/c1nUjNCrzi18Mc7vSejln6HoHGiPGjyocpb2t5tLISObZl+W13NWN0XWHgPXMAu
         PZgNlAGYiF/N0kWmZ4wwt7EW4jR/psAsKhN8u35nlS2Z8MI9gG/4vioO9PsrJbEv8LM5
         DcsQDQYzF2o/0dka9zZ7y8reOdbWCMaJQlNg0ysL38bZ0BPB9//JHRARRdeELRl0G7/x
         Y5MZSMfLTrEvTw6T0n02PxWepn5t8m1/V5PbEUEvMpoCfWII56OtqLo9zEFcG3e1Qv2X
         wk5g==
X-Gm-Message-State: AEkooutjk6l2FtENXjUWaMd6RLTzAbpgyz7FLdzCJt7hvtALjVuBDCG5JARV3mtSU0kpcQ==
X-Received: by 10.28.16.3 with SMTP id 3mr32394235wmq.58.1471526181346;
        Thu, 18 Aug 2016 06:16:21 -0700 (PDT)
Received: from localhost.localdomain ([80.215.38.200])
        by smtp.gmail.com with ESMTPSA id s6sm2225856wjm.25.2016.08.18.06.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Aug 2016 06:16:20 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/3] limit the size of the packs we receive
Date:	Thu, 18 Aug 2016 15:15:50 +0200
Message-Id: <20160818131553.22580-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.3.geb1f4c9.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Goal
~~~~

In https://public-inbox.org/git/20150612182045.GA23698%40peff.net/,
Peff sent a patch that is used by GitHub to abort `git receive-pack`
when the size of the pack we receive is bigger than a configured
limit.

GitLab is interested in using the same approach and in standardizing
the error messages the user could get back.

Comments
~~~~~~~~

I kept Peff as the author of the patches that are made mostly from his
patch, but I added my Signed-off-by to them.

Changes from previous v1 version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - removed last sentences of the commit message in patch 3/3, as
    suggested by Peff,

  - improved the tests in the last patch, as suggested by Peff

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/max-receive

The previous versions are here on GitHub:

RFC: https://github.com/chriscool/git/commits/max-receive2
v1: https://github.com/chriscool/git/commits/max-receive6

and here on the list:

RFC: https://public-inbox.org/git/20160815195729.16826-1-chriscool@tuxfamily.org/
v1: https://public-inbox.org/git/20160816081701.29949-1-chriscool@tuxfamily.org/

Peff's initial patch is:

https://public-inbox.org/git/20150612182045.GA23698%40peff.net/

Diff with previous v1 version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

diff --git a/t/t5546-push-limits.sh b/t/t5546-push-limits.sh
index b38d508..09e958f 100755
--- a/t/t5546-push-limits.sh
+++ b/t/t5546-push-limits.sh
@@ -11,11 +11,11 @@ test_expect_success 'create remote repository' '
 # When the limit is 1, `git receive-pack` will call `git index-pack`.
 # When the limit is 10, `git receive-pack` will call `git unpack-objects`.
 
-while read unpacklimit filesize filename
+while read unpacklimit filesize filename seed
 do
 
 	test_expect_success "create known-size ($filesize bytes) commit '$filename'" '
-		test-genrandom foo "$filesize" >"$filename" &&
+		test-genrandom "$seed" "$filesize" >"$filename" &&
 		git add "$filename" &&
 		test_commit "$filename"
 	'
@@ -35,8 +35,8 @@ do
 	'
 
 done <<\EOF
-1 1024 one-k-file
-10 2048 two-k-file
+1 1024 one-k-file foo
+10 1024 other-one-k-file bar
 EOF
 
 test_done
---

Christian Couder (1):
  unpack-objects: add --max-input-size=<size> option

Jeff King (2):
  index-pack: add --max-input-size=<size> option
  receive-pack: allow a maximum input size to be specified

 Documentation/config.txt             |  5 +++++
 Documentation/git-index-pack.txt     |  2 ++
 Documentation/git-receive-pack.txt   |  3 +++
 Documentation/git-unpack-objects.txt |  3 +++
 builtin/index-pack.c                 |  5 +++++
 builtin/receive-pack.c               | 12 +++++++++++
 builtin/unpack-objects.c             |  7 ++++++
 t/t5546-push-limits.sh               | 42 ++++++++++++++++++++++++++++++++++++
 8 files changed, 79 insertions(+)
 create mode 100755 t/t5546-push-limits.sh

-- 
2.10.0.rc0.3.geb1f4c9.dirty

