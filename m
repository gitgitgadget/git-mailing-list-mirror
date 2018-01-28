Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8069F1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeA1P5d (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:57:33 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751733AbeA1P5c (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:57:32 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 68F5760402;
        Sun, 28 Jan 2018 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517155051;
        bh=WP3YJkai4lpSka8N+nzG3IdcbD0C2nZsTFXFjEnGCW4=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oC8BWafRBpONnsNcU6Gr1d+Y68TBIGtm0EwU8Fr5POnUpqv7PR6l4ncRcDaKxry6q
         pavQ4iMpbidK0s5L9qkB1ypjfglqqFiUIjlCodtdvgRfVi1qmj0Xd71NNeMWKDUbBY
         nL5DXTbtZlfFCQLybsbEnVXCrvu4f8k5yit+Aq2JWfZmXY33qVoKPGknYcb9PBrynp
         JhwD8tEHR0QSVGjzS+nrCzIWy3LzgmrLIVPWIXQtrfxZR7pnXdYGE6f92mzm3el6CK
         +2GTbnv/bpZaVK2havkaFCyiLNYdvw9f9SDNt3bVTnRcs/6H6Z5FbjeOHGp6N2b9E/
         Zpyl+cSULShDEKT4C4U7TlYNe6iFYK+TyPY69ZxHG7qrpJBGqdZXhvDdhJ8l6Ws711
         wcof2RjAPhwbKwoun5H40n2AuOw1vCMOwkXzTyex5OsASB2zaySLszBIuxcRFATY3x
         NTjW43VD+I1DpO+EjgBpbN7nqz0/qVcDlnMyvMIs1yyZI9qER6B
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 00/12] object_id part 11 (the_hash_algo)
Date:   Sun, 28 Jan 2018 15:57:10 +0000
Message-Id: <20180128155722.880805-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series includes various changes to adopt the use of the_hash_algo
for abstracting hash algorithms away.

The series moves much of the hash-related code to hash.h from cache.h,
drops the ctxsz member in favor of allowing stack-allocated hash
contexts, and switches object-related code to use the_hash_algo for
hashing.

Note that not all instances of calls to git_SHA1_* have been converted.
The diff line code, the push cert code, and patch IDs all have been left
alone for the moment because they are not related to object handling.
Pack checksums, on the other hand, have been converted.

The series is based off master, and has one minor conflict with Patryk
Obara's recent object_id series.

I will also be sending out preliminary test patches on top of this
series that wire up an alternate hash algorithm so that we can see what
tests break as a result.  (Hint: there's a lot of them.)

brian m. carlson (12):
  hash: move SHA-1 macros to hash.h
  hash: create union for hash context allocation
  builtin/index-pack: improve hash function abstraction
  builtin/unpack-objects: switch uses of SHA-1 to the_hash_algo
  sha1_file: switch uses of SHA-1 to the_hash_algo
  fast-import: switch various uses of SHA-1 to the_hash_algo
  pack-check: convert various uses of SHA-1 to abstract forms
  pack-write: switch various SHA-1 values to abstract forms
  read-cache: abstract away uses of SHA-1
  csum-file: rename sha1file to hashfile
  csum-file: abstract uses of SHA-1
  bulk-checkin: abstract SHA-1 usage

 builtin/index-pack.c     | 108 +++++++++++++++++++++++------------------------
 builtin/pack-objects.c   |  52 +++++++++++------------
 builtin/unpack-objects.c |  18 ++++----
 bulk-checkin.c           |  28 ++++++------
 cache.h                  |  25 -----------
 csum-file.c              |  46 ++++++++++----------
 csum-file.h              |  38 ++++++++---------
 fast-import.c            |  68 ++++++++++++++---------------
 hash.h                   |  34 +++++++++++++--
 pack-bitmap-write.c      |  30 ++++++-------
 pack-check.c             |  32 +++++++-------
 pack-write.c             |  77 ++++++++++++++++-----------------
 pack.h                   |   4 +-
 read-cache.c             |  54 ++++++++++++------------
 sha1_file.c              |  54 ++++++++++++------------
 15 files changed, 335 insertions(+), 333 deletions(-)

