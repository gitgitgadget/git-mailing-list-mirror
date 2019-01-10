Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4529C1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 04:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfAJE0H (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 23:26:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58352 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbfAJE0H (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jan 2019 23:26:07 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 03DA160FE2;
        Thu, 10 Jan 2019 04:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547094363;
        bh=BEyKCYiigQPomc1qegeMoIwihd85wdy0FaLBx1c4QDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qflAPQQt1dvCaLC294Ue7rWbdOUsXb1krwpIr4rEQqURJnx7lcsHjb1YMjNs6lK9F
         nu9ia5i7/M7dz4zu7MJ6sdmLeIZaMfixg5cegziDUp/+wJk+AIOFsjRVVvjRyaUN9G
         hHWBjm+/Eq5FLoB3yK+6TYEkysl6m7LFz4vS0jgBV3hbnXQQfiQmyNF8JfUGs18t8c
         8SEWAucJX9GDwzagWFGIRrrwg66lrOH/19/mVOk7DkdhGT4ObKkKguI09lczc+RE1g
         s/F9a7TSS2v1BtaBx7QWf+oOlbVYIbVi/h6Z3JM99zqpF8djm4G+86xQKqFtJPLg0K
         eGWx+1zZlaJ6Ia7U4vWYaEwTScT4MC0ilbW31kdUDwPMPz8DfObm5DOO+52CXerGRT
         l9JEgg/U2OLWEy+YzXAot26j5OKbAfAiZtxaKkyqLk9AYIFDQKtOe91BY2u5pJby7n
         VNA17F3Wohv9xY0DUWkHvgVcpdaEk+dB0+EeuZvqUwGb96Haf5x
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] tree-walk object_id refactor
Date:   Thu, 10 Jan 2019 04:25:46 +0000
Message-Id: <20190110042551.915769-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3
In-Reply-To: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a small number of places in our codebase where we cast a
buffer of unsigned char to a struct object_id pointer. When we have
GIT_MAX_RAWSZ set to 32 (because we have SHA-256), one of these places
(the buffer for tree objects) can lead to us copying too much data when
using SHA-1 as the hash, since there are only 20 bytes to read.

This was not expected to be a problem before future code was introduced,
but due to a combination of series the issue became noticeable.

This series introduces a refactor to avoid referencing the struct
object_id directly from a buffer and instead storing an additional
struct object_id (and an int) in struct name_entry and referring to
that.

This series, while based on master, addresses the interactions seen on
pu between the SHA-256 series and the oidset series. There are a small
number of conflicts, both textual and logical, when merging this series
and pu, but they should be easily resolved.

This series contains a final patch which will become necessary at some
point for hygienic code, but which could be deferred until later if
desired.

The testsuite passes with AddressSanitizer at each stage and when merged
into pu.

brian m. carlson (5):
  tree-walk: copy object ID before use
  match-trees: compute buffer offset correctly when splicing
  match-trees: use hashcpy to splice trees
  tree-walk: store object_id in a separate member
  cache: make oidcpy always copy GIT_MAX_RAWSZ bytes

 builtin/grep.c                     |  8 ++++----
 builtin/merge-tree.c               | 20 ++++++++++----------
 builtin/pack-objects.c             |  4 ++--
 builtin/reflog.c                   |  4 ++--
 cache-tree.c                       |  4 ++--
 cache.h                            |  2 +-
 contrib/coccinelle/object_id.cocci | 30 ------------------------------
 delta-islands.c                    |  2 +-
 fsck.c                             |  4 ++--
 http-push.c                        |  4 ++--
 list-objects.c                     |  6 +++---
 match-trees.c                      | 11 ++++++-----
 notes.c                            |  4 ++--
 packfile.c                         |  2 +-
 revision.c                         |  4 ++--
 tree-diff.c                        |  6 +++---
 tree-walk.c                        | 21 ++++++++++++---------
 tree-walk.h                        |  9 ++++++---
 tree.c                             | 10 +++++-----
 unpack-trees.c                     |  6 +++---
 walker.c                           |  4 ++--
 21 files changed, 71 insertions(+), 94 deletions(-)

