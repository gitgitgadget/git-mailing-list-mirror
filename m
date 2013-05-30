From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/7] unpack-trees: plug memory leak for merges
Date: Thu, 30 May 2013 13:34:17 +0200
Message-ID: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 13:34:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui17s-0006cu-DB
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 13:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591Ab3E3Led (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 07:34:33 -0400
Received: from india601.server4you.de ([85.25.151.105]:57591 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab3E3Leb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 07:34:31 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEB6E.dip0.t-ipconnect.de [87.155.235.110])
	by india601.server4you.de (Postfix) with ESMTPSA id D33FA1FF;
	Thu, 30 May 2013 13:34:28 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225958>

This series adds const to cache_entry pointers in a lot of places, in
order to show that we can free them in unpack_nondirectories, which
the last patch finally does.

First three easy patches for adding const and splitting a function in
two:

  cache: mark cache_entry pointers const
  read-cache: mark cache_entry pointers const
  unpack-trees: factor out dup_entry

Then a patch that reduces the side effects of merged_entry:

  unpack-trees: create working copy of merge entry in merged_entry

Another easy const patch:

  diff-lib, read-tree, unpack-trees: mark cache_entry pointers const

And patch that introduces "const struct cache_entry * const *", which
may look a bit scary at first:

  diff-lib, read-tree, unpack-trees: mark cache_entry array paramters const

Final patch that plugs a memory leak in unpack_nondirectories.

  unpack-trees: free cache_entry array members for merges

It's basically the same one that Stephen tested a while ago
(http://thread.gmane.org/gmane.comp.version-control.git/222887).

It's not the only leak that affects cherry-pick; expect more
(independent) patches.

 builtin/read-tree.c |   5 +-
 cache.h             |  10 ++--
 diff-lib.c          |  26 +++++-----
 read-cache.c        |  18 ++++---
 unpack-trees.c      | 146 ++++++++++++++++++++++++++++++++--------------------
 unpack-trees.h      |  14 +++--
 6 files changed, 131 insertions(+), 88 deletions 
1.8.3
