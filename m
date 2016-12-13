Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70578209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 20:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941129AbcLMU4e (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:56:34 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35497 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940711AbcLMU4c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:56:32 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so51340698pga.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 12:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=i8YhM84aRh2DnYJz5R/HcPYOvQy2rZzHOC990HwB+tI=;
        b=LAisoUNBdqsz4Ql69k52VdgJatc32/ANF1w5tX1ycqAAI0cc7+nxt7FTUBTxZ1WtJf
         ysAYyvnGLRbfiqMqbr0XetceYEZ9MR6zSPoU4heOM9N6K5EjMuvZSNo//cWp/h+2eMta
         62zMnLwqUqNUwkl3qbAD9uWtutc7eHZ84un6bvSJVDfVXlXTzJYRtaTIosauv0yJD7RU
         6h/IAESKeFtHR4ulNk0BS/jrXjqrxFLh21sd8NksMERFrXpt4MKQCgcr6Es0WpbrKzOv
         2ljxRM9BkdzczJxhV+kU2e7gcYPLeE3xSh2fkU8+envtXg9F85rwkmEMPvvtbeGeU8/f
         OO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i8YhM84aRh2DnYJz5R/HcPYOvQy2rZzHOC990HwB+tI=;
        b=bY7C7AYL6x0bX0XawdwxsmCiKHUJXNxMuJboIO9iA8Hca5LPqP/xIhnn9dOmdNTpMQ
         ipupTnrKbkaMeXk283oBAI/HhjbOeIfZe/Oq0Gn8wo0e4QUU+XCf2tZzT57d/4fgfWD2
         oEtVfA4OLcLOJqQwHLfLfyb7hB/nDxanNSVi3mQ3ZWv7fF6SRCZ+5WgWmrl3lxZaWBf1
         DBXqhE8jCELMtm6xZ5WuLqKSNPNX0aZ0D4o3xJJ4fu+YgAFErct0UZkp6HTy/ahXj/iP
         II8tvxz8aQeW3T4oQt11vCyve1W6qPqYgsZ66c/PhqH5rzii0z1/wIhIMnrohJdWqO4J
         gpQA==
X-Gm-Message-State: AKaTC01u6ppyTskxWnFSxDo5ZJbZ0v/G69eOABMfnz89Qfy/b/5i443UppduwjgClhb4kWwI
X-Received: by 10.99.50.67 with SMTP id y64mr180078655pgy.146.1481662590304;
        Tue, 13 Dec 2016 12:56:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:5b5:8785:ab45:d22f])
        by smtp.gmail.com with ESMTPSA id f81sm81967707pfd.71.2016.12.13.12.56.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 12:56:29 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/5] git-rm absorbs submodule git directory before deletion
Date:   Tue, 13 Dec 2016 12:56:17 -0800
Message-Id: <20161213205622.841-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* new base where to apply the patch:
  sb/submodule-embed-gitdir merged with sb/t3600-cleanup.
  I got merge conflicts and resolved them this way:
#@@@ -709,9 -687,10 +687,9 @@@ test_expect_success 'checking out a com
#          git commit -m "submodule removal" submod &&
#          git checkout HEAD^ &&
#          git submodule update &&
#-         git checkout -q HEAD^ 2>actual &&
#+         git checkout -q HEAD^ &&
#          git checkout -q master 2>actual &&
# -        echo "warning: unable to rmdir submod: Directory not empty" >expected &&
# -        test_i18ncmp expected actual &&
# +        test_i18ngrep "^warning: unable to rmdir submod:" actual &&
#          git status -s submod >actual &&
#          echo "?? submod/" >expected &&
#          test_cmp expected actual &&
#

* improved commit message in "ok_to_remove_submodule: absorb the submodule git dir"
  (David Turner offered me some advice on how to write better English off list)
* simplified code in last patch:
  -> dropped wrong comment for fallthrough
  -> moved redundant code out of both bodies of an if-clause.
* Fixed last patchs commit message to have "or_die" instead of or_dir.

v1:
The "checkout --recurse-submodules" series got too large to comfortably send
it out for review, so I had to break it up into smaller series'; this is the
first subseries, but it makes sense on its own.

This series teaches git-rm to absorb the git directory of a submodule instead
of failing and complaining about the git directory preventing deletion.

It applies on origin/sb/submodule-embed-gitdir.

Any feedback welcome!

Thanks,
Stefan

Stefan Beller (5):
  submodule.h: add extern keyword to functions
  submodule: modernize ok_to_remove_submodule to use argv_array
  submodule: add flags to ok_to_remove_submodule
  ok_to_remove_submodule: absorb the submodule git dir
  rm: add absorb a submodules git dir before deletion

 builtin/rm.c  | 33 ++++++++-----------------
 cache.h       |  2 ++
 entry.c       |  5 ++++
 submodule.c   | 77 +++++++++++++++++++++++++++++++++++++++++++++++++----------
 submodule.h   | 64 ++++++++++++++++++++++++++++++-------------------
 t/t3600-rm.sh | 39 ++++++++++++------------------
 6 files changed, 135 insertions(+), 85 deletions(-)

-- 
2.11.0.rc2.35.g26e18c9

