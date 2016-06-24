Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E038F1FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbcFXXJj (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:09:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52518 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbcFXXJi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 19:09:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0FD9B2809F;
	Fri, 24 Jun 2016 23:09:35 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466809776;
	bh=9TOj/Llzl2QB+ZaWIbNyP2toklg2v11J0rVzyKLP3ls=;
	h=From:To:Cc:Subject:Date:From;
	b=xYK4y0xMmqsYu9VIhccepaPPs5pWADi6brD+7R4WUkGeJQMJRTX+eqPAbIp1QJpO/
	 CZ7uEJHrnVKKwuRNgPU4JaY+2/Tiqzu77k9qn1beX45B0ItAzFh7Oe91gedeAsoV3q
	 dn5H2M/IQiDh9s3hQHR4m9DQ+hYaeRaoIvpSV9uby0P8S3LEpBKPSjDE/sEIUfV4rj
	 fax2yk7jDG4VyN1t1QZJL+Ihltv3GFTXvG0f15SVIi5uHWoelEyHGGW+k/NVqtNH43
	 Ghm2oFCQW5QdDaJHGNTM7NbXOkqwIR0KCptL8qkK2ouCCQUfNgd0DghxklOdu6YF9o
	 BShfn6ZfDSy2FqaZ9TJE5OI6hMrJJrB+8X4Ky83k6PdHKWbSCgK/oRYecdhxqyz2Cg
	 a0A1UzZiL9aJJesK/fZq+UfGrrUiyxXzmNWcyBUrz1TUK1QGbQWto9+5JveM1yRL7E
	 A4p6wtUqlC90GZmR2n+Cu3fEN78/oVfboYUOvhRdBzO0wyoWvXH
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 00/11] struct object_id, Part 4
Date:	Fri, 24 Jun 2016 23:09:18 +0000
Message-Id: <20160624230929.82222-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This series is part 4 in a series of conversions to replace instances of
unsigned char [20] with struct object_id.  Most of this series touches
the merge-recursive code.

New in this series is the use of Coccinelle (http://coccinelle.lip6.fr/)
semantic patches.  These semantic patches can make automatic
transformations to C source code for cleanup or refactoring reasons.

This series introduces a set of transforms for the struct object_id
transition, cleans up some existing code with them, and applies a small
number of semantic patches to transform parts of the merge-recursive
code.  Some manual refactoring work follows.

Note that in the patches created with the semantic patches, the only
manual change was the definition of the struct member.  Opinions on
whether this is a viable technique for further work to ease both the
creation and review of patches are of course welcomed.

The testsuite continues to pass at each step, and this series rebases
cleanly on next.

I picked up Junio's change from sha_eq to oid_eq, but didn't convert the
calls to oidcmp.  I think the current version (with oid_eq) is actually
more readable than using oidcmp, if slightly less efficient.

Changes from v2:
* Pick up improvements from Junio's version on pu.
* Add oid_to_hex_r.
* Add oid_to_hex_r to object_id.cocci.
* Convert prep_temp_blob as suggested by Junio.
* Converted hashcpy(.*, null_sha1) to hashclr.

Changes from v1:
* Move the object ID transformations to contrib/examples/coccinelle.
* Add a README to that folder explaining what they are.
* Adjust the Coccinelle patches to transform plain structs before
  pointers to structs to avoid misconversions.  This addresses the issue
  that Johannes Sixt caught originally.

brian m. carlson (11):
  hex: add oid_to_hex_r.
  contrib/coccinelle: add basic Coccinelle transforms
  Convert hashcpy with null_sha1 to hashclr.
  coccinelle: apply object_id Coccinelle transformations
  diff: convert struct diff_filespec to struct object_id
  diff: rename struct diff_filespec's sha1_valid member
  merge-recursive: convert struct stage_data to use object_id
  merge-recursive: convert struct merge_file_info to object_id
  merge-recursive: convert leaf functions to use struct object_id
  merge-recursive: convert merge_recursive_generic to object_id
  diff: convert prep_temp_blob to struct object_id.

 bisect.c                           |   2 +-
 builtin/blame.c                    |   6 +-
 builtin/fast-export.c              |  10 +-
 builtin/merge-recursive.c          |  20 +--
 builtin/merge.c                    |  15 +-
 builtin/reset.c                    |   4 +-
 builtin/unpack-objects.c           |   4 +-
 cache.h                            |   1 +
 combine-diff.c                     |  14 +-
 contrib/coccinelle/README          |   2 +
 contrib/coccinelle/object_id.cocci |  95 ++++++++++++
 diff.c                             |  99 ++++++------
 diffcore-break.c                   |   4 +-
 diffcore-rename.c                  |  16 +-
 diffcore.h                         |   4 +-
 hex.c                              |   5 +
 line-log.c                         |  12 +-
 merge-recursive.c                  | 310 +++++++++++++++++++------------------
 merge-recursive.h                  |   6 +-
 notes-merge.c                      |  42 ++---
 refs/files-backend.c               |   4 +-
 submodule-config.c                 |   2 +-
 submodule.c                        |   4 +-
 t/helper/test-submodule-config.c   |   2 +-
 wt-status.c                        |   3 +-
 25 files changed, 403 insertions(+), 283 deletions(-)
 create mode 100644 contrib/coccinelle/README
 create mode 100644 contrib/coccinelle/object_id.cocci

