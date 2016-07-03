Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8494920179
	for <e@80x24.org>; Sun,  3 Jul 2016 08:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbcGCH63 (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 03:58:29 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55365 "EHLO
	homiemail-a21.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849AbcGCH62 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2016 03:58:28 -0400
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id 8334C300074;
	Sun,  3 Jul 2016 00:58:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:mime-version:content-type:
	content-transfer-encoding; s=novalis.org; bh=kf9FiYUri7oF18VNTrt
	3LtjelA8=; b=hxG1QAqF5gqwcHyelIbM0S6v6Su9DQ/bk0CapSAjk6K9/J4dDGo
	P3DjnHT6KxHnsk1z/f2w+AZqGgm6MT5fwKNXHtzzUCq7zzPdM/fUGvP65vdXvS8G
	zvIeto/L44GXZ+BJmutRlR/gVH0EnJD715r+CuyDi0OxiSb1BGF1YrII=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id E5912300061;
	Sun,  3 Jul 2016 00:58:26 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <novalis@novalis.org>
Subject: [PATCH v14 00/21] index-helper/watchman
Date:	Sun,  3 Jul 2016 03:57:52 -0400
Message-Id: <1467532693-20017-1-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This addresses comments on v13:
removed unnecessary no_mmap ifdef
add an ifdef in unix-socket
OS X fix for select()
test improvement

Thanks to all for suggestions.

David Turner (10):
  pkt-line: add gentle version of packet_write
  index-helper: log warnings
  unpack-trees: preserve index extensions
  watchman: add a config option to enable the extension
  index-helper: kill mode
  index-helper: don't run if already running
  index-helper: autorun mode
  index-helper: optionally automatically run
  index-helper: indexhelper.exitAfter config
  mailmap: use main email address for dturner

Nguyễn Thái Ngọc Duy (11):
  read-cache: allow to keep mmap'd memory after reading
  unix-socket.c: add stub implementation when unix sockets are not
    supported
  index-helper: new daemon for caching index and related stuff
  index-helper: add --strict
  daemonize(): set a flag before exiting the main process
  index-helper: add --detach
  read-cache: add watchman 'WAMA' extension
  watchman: support watchman to reduce index refresh cost
  index-helper: use watchman to avoid refreshing index with lstat()
  update-index: enable/disable watchman support
  trace: measure where the time is spent in the index-heavy operations

 .gitignore                               |   2 +
 .mailmap                                 |   1 +
 Documentation/config.txt                 |  12 +
 Documentation/git-index-helper.txt       |  86 +++++
 Documentation/git-update-index.txt       |   6 +
 Documentation/technical/index-format.txt |  22 ++
 Makefile                                 |  22 ++
 builtin/gc.c                             |   2 +-
 builtin/update-index.c                   |  15 +
 cache.h                                  |  25 +-
 command-list.txt                         |   1 +
 config.c                                 |   5 +
 configure.ac                             |   8 +
 contrib/completion/git-completion.bash   |   1 +
 daemon.c                                 |   2 +-
 diff-lib.c                               |   4 +
 dir.c                                    |  25 +-
 dir.h                                    |   6 +
 environment.c                            |   2 +
 git-compat-util.h                        |   1 +
 index-helper.c                           | 469 +++++++++++++++++++++++++++
 name-hash.c                              |   2 +
 pkt-line.c                               |  18 ++
 pkt-line.h                               |   2 +
 preload-index.c                          |   2 +
 read-cache.c                             | 531 ++++++++++++++++++++++++++++++-
 refs/files-backend.c                     |   2 +
 setup.c                                  |   4 +-
 t/t1701-watchman-extension.sh            |  37 +++
 t/t7063-status-untracked-cache.sh        |  22 ++
 t/t7900-index-helper.sh                  |  79 +++++
 t/test-lib-functions.sh                  |   4 +
 test-dump-watchman.c                     |  16 +
 unix-socket.h                            |  18 ++
 unpack-trees.c                           |   1 +
 watchman-support.c                       | 135 ++++++++
 watchman-support.h                       |   7 +
 37 files changed, 1578 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100755 t/t1701-watchman-extension.sh
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 test-dump-watchman.c
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

-- 
1.9.1

