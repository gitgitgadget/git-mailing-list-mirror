From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/6] object_id Part 3
Date: Sun, 17 Apr 2016 23:10:35 +0000
Message-ID: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:20:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arynJ-00049B-OK
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 04:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbcDRCUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 22:20:03 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52830 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751306AbcDRCT5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2016 22:19:57 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EA79C282AA;
	Sun, 17 Apr 2016 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1460934671;
	bh=LdGF/5Rv6+zoodlB7ur5n0bKm99pYmF9GhQz9nAo2H4=;
	h=From:To:Cc:Subject:Date:From;
	b=c7vuHh3xLyVyFsOitEgCqNMjXmKL04bE48r+W3Ss1bOGV910nDcJ3x8HdSlo3VUrW
	 uU8QSCdJGnjvddr/DObt+ZP9ncnjUIffLpIJ0q71yfy3N7X1jTC7mTef06e0JazWlm
	 sQ7c+7nH4wEzWiK4qUejq9p51HJQFvsPdMEtlBlXoX3fo/J8NaDVgUxjAIjdJXIc3Z
	 1t2mzmYjcTQdYi9jTnFJHVDakyBOfvj8tu9gMyVOV4RQ5bbTkPDhXa/oQoMNjYNGjv
	 Mxe9fCx74T8PX1Si+Nzv6ymEqVtsXpCoHJw9vys9tCv/0ZRy1oD5i3ge/roUl7wvXL
	 5feeMjALsM91pQGYyTtQf1Trye2uzol9eeOV8aKgsN3dHS74vDLhNrbq35W9ovdVMJ
	 6yvYzgAak8tO3ZWNX+JI3jPyPVAIP/clrMDwPYVTZgN+GZxwluM48Ijn29OpCxnLxo
	 buaz4UDdODvZ2nz72Pamx260HUZq6XB3AtI2hlXvrEvq+sdP4xG
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291789>

This is the third of a series of patches to convert instances of
unsigned char[20] to struct object_id.  The focus in this series was to
convert test-match-trees, related functions, and some dependencies.
struct name_entry was converted as part of these dependencies.

The riskiest part of this series is the conversion of struct name_entry.
Compatibility with unconverted code requires dereferencing the new oid
member, but there are at least some places where we explicitly check
that it is not NULL.  These seem to be limited to empty entries in
merge-tree.c, and it doesn't appear that we ever pass an empty entry to
a function which might dereference it.

This series rebases onto next cleanly and is not likely to conflict with
other topics in flight.  My intention is to send smaller series more
frequently, with the goal of avoiding or minimizing conflicts where
possible.

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
2.8.0.rc3.226.g39d4020
