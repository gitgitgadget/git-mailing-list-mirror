Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A74C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCSGxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjCSGxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:53:16 -0400
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C9822DD4
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:53:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 7910916005E
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:44:08 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PmODWsDwvuCx; Sat, 18 Mar 2023 23:44:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id ADD0F160054;
        Sat, 18 Mar 2023 23:44:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 zimbra.cs.ucla.edu ADD0F160054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=78364E5A-2AF3-11ED-87FA-8298ECA2D365; t=1679208247;
        bh=QJ3lcdYb3EVufYGeFknfGeMxnvpeKk1RWfEqSeTOcWo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=XYsA9Ee2kC0K4vb8Ks4p8bIq0eWvlveGRThEFihwJEbpLc6XduxjYKMPpJa6xOJE0
         oSqOJR4MjGwzpouz3i3KjUr7Kbu4elkkBsVw3drUn+QjK/31HykL+SBD1bIMthC7hC
         /UeMA9O+8nglT5cAsPJT9ueHkeowd60UT+edkWVs=
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HZMvIrhPrxWn; Sat, 18 Mar 2023 23:44:07 -0700 (PDT)
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 8B77D160045;
        Sat, 18 Mar 2023 23:44:07 -0700 (PDT)
From:   Paul Eggert <eggert@cs.ucla.edu>
To:     git@vger.kernel.org
Cc:     Paul Eggert <eggert@cs.ucla.edu>
Subject: [PATCH 0/2] use gettimeofday for current time
Date:   Sat, 18 Mar 2023 23:43:51 -0700
Message-Id: <20230319064353.686226-1-eggert@cs.ucla.edu>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In recent GNU/Linux versions on rare occasions the 'time' function
returns a value that is one second less than the seconds component of
the timestamp that would be returned by gettimeofday, clock_gettime
with CLOCK_REALTIME, 'stat' on a recently modified file, etc.

If a program calls both 'time' and any of these other functions, the
system clock will appear to jump backwards by a second temporarily.
This can lead to confusing or inconsistent output.

A simple workaround for Git is to use 'gettimeofday' instead of
'time'.  Although other options are possible (see the commit message
of patch 0002), simplest is probably best.

Paul Eggert (2):
  git-compat-util: time_now for current time
  git-compat-util: use gettimeofday for current time

 archive.c                          | 2 +-
 blame.c                            | 2 +-
 builtin/bugreport.c                | 2 +-
 builtin/credential-cache--daemon.c | 4 ++--
 builtin/diagnose.c                 | 2 +-
 builtin/fast-import.c              | 2 +-
 builtin/fsmonitor--daemon.c        | 4 ++--
 builtin/gc.c                       | 2 +-
 builtin/log.c                      | 2 +-
 builtin/receive-pack.c             | 2 +-
 builtin/reflog.c                   | 2 +-
 commit-graph.c                     | 4 ++--
 compat/nedmalloc/malloc.c.h        | 2 +-
 credential.c                       | 4 ++--
 date.c                             | 6 +++---
 git-compat-util.h                  | 8 ++++++++
 http-backend.c                     | 2 +-
 http-push.c                        | 6 +++---
 rerere.c                           | 2 +-
 run-command.c                      | 4 ++--
 t/helper/test-chmtime.c            | 4 ++--
 t/helper/test-simple-ipc.c         | 4 ++--
 22 files changed, 40 insertions(+), 32 deletions(-)

--
2.39.2

