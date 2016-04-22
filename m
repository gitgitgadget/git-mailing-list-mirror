From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/6] object_id Part 3
Date: Fri, 22 Apr 2016 22:02:47 +0000
Message-ID: <20160422220253.839970-1-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:03:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjAk-0000rb-7a
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbcDVWDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:03:23 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56118 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751470AbcDVWDV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 18:03:21 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E4C33282A8;
	Fri, 22 Apr 2016 22:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1461362598;
	bh=USL1FWAVGwW6mVP2zkMIDy3/WW0liiEct8/5WB4Sl4o=;
	h=From:To:Cc:Subject:Date:From;
	b=Hh4gl5hoB6WOWr0JQaYjRFzuY7rIW/bOhfJZEcWVcCuzJvPFp3lqf+klFATFkBfL8
	 wwoklHsJB9hihUnjl4+JkVSvoCksNZ69jicNLxnNtt0xvcmy3PSYL+fxXp/DMGChLS
	 VgQlbZr18SJGiYRnMR9rgfGghN25Mrgp9YjZCqS4qSA9e5MHLeSH1CoH0b+tCJjIkQ
	 66wnaNTCtw+6+QvOJh1epYEmSmeiEge9d612eLz99fFkEsvRjBCCwnfI+drMqfWTPZ
	 q5Im7nblEqT5aM58GXQoLPIXp/rHWcyJeIRfeOwJr0eZxhbMIOH4m1LsSZYX9IH59h
	 SPB7qrQnT/jl08jl2iB/H063bxq6CFF088Z8Kqy/KUchYo/kcmWC21wmZdhI8Kq8or
	 EyhM9MPzWv4ZOOx7nvQHv/VN+07Ss+KAceabruxRXUV6kx/R+qIIPxGd7D8PQjMHF0
	 7UCOCHIF6lI7+V+rBJDBC6WXua/jMKfq1UOUIpjlGPyEJvIco6A
X-Mailer: git-send-email 2.8.1.369.geae769a
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292277>

This is the third of a series of patches to convert instances of
unsigned char[20] to struct object_id.  The focus in this series was to
convert test-match-trees, related functions, and some dependencies.
struct name_entry was converted as part of these dependencies.

The riskiest part of this series is the conversion of struct name_entry.
Compatibility with unconverted code requires dereferencing the new oid
member, but there are at least some places where we explicitly check
that it is not NULL.  Most of these are protected by a check for a
nonzero mode.

This series rebases onto next cleanly and is not likely to conflict with
other topics in flight.  My intention is to send smaller series more
frequently, with the goal of avoiding or minimizing conflicts where
possible.

Changes from v1:
* Remove dereference of object_id pointer in boolean context.

brian m. carlson (6):
  Introduce a get_oid function.
  test-match-trees: convert to use struct object_id
  match-trees: convert shift_tree and shift_tree_by to object_id
  Convert struct name_entry to use struct object_id.
  tree-walk: convert tree_entry_extract to struct object_id
  match-trees: convert several leaf functions to struct object_id

 builtin/grep.c         |  6 ++---
 builtin/merge-tree.c   | 18 +++++++--------
 builtin/pack-objects.c |  4 ++--
 builtin/reflog.c       |  4 ++--
 cache-tree.c           |  4 ++--
 cache.h                |  6 +++--
 fsck.c                 | 10 ++++-----
 http-push.c            |  4 ++--
 list-objects.c         |  6 ++---
 match-trees.c          | 60 +++++++++++++++++++++++++-------------------------
 merge-recursive.c      |  4 ++--
 notes.c                |  4 ++--
 revision.c             |  4 ++--
 sha1_name.c            |  9 ++++++++
 test-match-trees.c     | 14 ++++++------
 tree-diff.c            |  8 +++----
 tree-walk.c            | 16 +++++++-------
 tree-walk.h            |  8 +++----
 tree.c                 | 10 ++++-----
 unpack-trees.c         |  4 ++--
 walker.c               |  4 ++--
 21 files changed, 109 insertions(+), 98 deletions(-)

-- 
2.8.1.369.geae769a
