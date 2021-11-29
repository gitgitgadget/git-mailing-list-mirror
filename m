Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB0FC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhK2W3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhK2W2W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:22 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A0CC09677A
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:04 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z18so23576880iof.5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wgKfm7q+mrQNxYPZmtuLFD5A27/4819Cv2+ibx07Tg8=;
        b=nnrk/W2bnzTVmBMg2zkTZgugFBXCegfk60EEEFlMRin1ixAQfsADhEGzr9xwWcslO6
         FFcjy2U9isVCkGtf7t6TpeVC14y/bNfskw/GQ98koNTzhtphiCXA66D4t3iYYmw45wjE
         Yvt5Icn8NkyNRhKcqt1NSjJJAFRJj8voANZcDj6734IOyXG0CybYw0rLAze8SpEd9IxC
         KgQOKzC0t3dL1gFp7VNZxTeczlYu4Bb6MshxygVTeyZRmmzJBhu0Z8gQYA9tvYM13vid
         4IS51xFaqWpTGS7SlbM0nUavu7D8NHknSPeZ1tM187a3fGBUiwOEChsVxkenW2R2Jp+g
         Sv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wgKfm7q+mrQNxYPZmtuLFD5A27/4819Cv2+ibx07Tg8=;
        b=pYYjJTS+aQ9tOdEY/HIFo2ryuvr64A7oM7467dHFUG0y6Rdg7zahPAFWYYoArJW0Zy
         LJuOGIc+87LQ7ZA/g0GtcL2B2toBfhuZ2GGwLZNvTEb4spbnAJpZPPQ4ARxnMsmGXuH2
         SE0czzNeoFa99QcI3UsV1R9Eob/Ipx3hHsWOpWYSXJrcMYhf7q2s1i8ozFdxZZJwbpqY
         rozzC7y4LATQjhrq5cpHaads/K5vsz6jOa8I8oWNV3xHlh91pjxNvvQ367KE7amUWUmW
         sy5/52G6v7JqDU8lLElIMNoi/El71zyBkTgNCmO3uS9trgjF3ZeCbu539691fT3heJnK
         Kvig==
X-Gm-Message-State: AOAM531wkLvhZdE6Qtrm4ywvnLXDZBLWi/636MxRLTVTR6PsuABXgNhW
        nI2XeuGdVEstOsQLoJjjz7I/kTFYZspoadO1
X-Google-Smtp-Source: ABdhPJymFXYbmEOffGVI1jNse8PJKkdCQyFsuTQBUvNJSjGIWyXiQAENH3NhDhAsojqApkDCQg6KMQ==
X-Received: by 2002:a5e:840f:: with SMTP id h15mr59756469ioj.48.1638224703782;
        Mon, 29 Nov 2021 14:25:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q12sm9602227ile.77.2021.11.29.14.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:03 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 00/17] cruft packs
Message-ID: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series implements "cruft packs", a pack which stores accumulated
unreachable objects, along with a new ".mtimes" file which tracks each
object's last known modification time.

This idea was discussed recently-ish in [1], but the most thorough
discussion I could find is in [2]. The approach settled on in this
series is laid out in detail by the first patch.

For the uninitiated, cruft packs enable repositories to safely run
`git repack -Ad` by storing unreachable objects which have not yet
"aged out" in a separate pack. This prevents repositories from storing
a potentially large number of these such objects as loose.

This series is structured as follows:

  - The first patch describes the technical details of cruft packs.
  - The next five patches implement reading and writing the new
    `.mtimes` format.
  - The next six patches implement `git pack-objects --cruft`. The
    first five implement this mode when no grace period is specified,
    and the six patch adds support for the grace period.
  - The next five patches integrate cruft packs with `git repack`,
    including the new-ish `--geometric` mode.
  - The final patch handles object freshening for objects stored in a
    cruft pack.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net/
[2]: https://lore.kernel.org/git/E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com/

Taylor Blau (17):
  Documentation/technical: add cruft-packs.txt
  pack-mtimes: support reading .mtimes files
  pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
  chunk-format.h: extract oid_version()
  pack-mtimes: support writing pack .mtimes files
  t/helper: add 'pack-mtimes' test-tool
  builtin/pack-objects.c: return from create_object_entry()
  builtin/pack-objects.c: --cruft without expiration
  reachable: add options to add_unseen_recent_objects_to_traversal
  reachable: report precise timestamps from objects in cruft packs
  builtin/pack-objects.c: --cruft with expiration
  builtin/repack.c: support generating a cruft pack
  builtin/repack.c: allow configuring cruft pack generation
  builtin/repack.c: use named flags for existing_packs
  builtin/repack.c: add cruft packs to MIDX during geometric repack
  builtin/gc.c: conditionally avoid pruning objects via loose
  sha1-file.c: don't freshen cruft packs

 Documentation/Makefile                  |   1 +
 Documentation/config/gc.txt             |  21 +-
 Documentation/config/repack.txt         |   9 +
 Documentation/git-gc.txt                |   5 +
 Documentation/git-pack-objects.txt      |  23 +
 Documentation/git-repack.txt            |  11 +
 Documentation/technical/cruft-packs.txt |  95 ++++
 Documentation/technical/pack-format.txt |  22 +
 Makefile                                |   2 +
 builtin/gc.c                            |  10 +-
 builtin/pack-objects.c                  | 306 ++++++++++-
 builtin/repack.c                        | 189 ++++++-
 bulk-checkin.c                          |   2 +-
 chunk-format.c                          |  12 +
 chunk-format.h                          |   3 +
 commit-graph.c                          |  18 +-
 midx.c                                  |  18 +-
 object-file.c                           |   4 +-
 object-store.h                          |   7 +-
 pack-mtimes.c                           | 139 +++++
 pack-mtimes.h                           |  16 +
 pack-objects.c                          |   6 +
 pack-objects.h                          |  20 +
 pack-write.c                            |  90 +++-
 pack.h                                  |   4 +
 packfile.c                              |  18 +-
 packfile.h                              |   1 +
 reachable.c                             |  58 +-
 reachable.h                             |   9 +-
 t/helper/test-pack-mtimes.c             |  53 ++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t5327-pack-objects-cruft.sh           | 685 ++++++++++++++++++++++++
 33 files changed, 1757 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/technical/cruft-packs.txt
 create mode 100644 pack-mtimes.c
 create mode 100644 pack-mtimes.h
 create mode 100644 t/helper/test-pack-mtimes.c
 create mode 100755 t/t5327-pack-objects-cruft.sh

-- 
2.34.1.25.gb3157a20e6
