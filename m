From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH v2 0/5] branch: fix branch operations with multiple working trees
Date: Sat, 26 Mar 2016 03:28:18 +0900
Message-ID: <cover.1458927521.git.k@rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 19:29:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWU4-00089o-MY
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbcCYS3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:29:16 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:51586 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190AbcCYS3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:29:15 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 4B1B55AFE6;
	Fri, 25 Mar 2016 18:29:12 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.21.g05df949
In-Reply-To: <1458553816-29091-1-git-send-email-k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289930>

[1/5]
Adds RESOLVE_REF_COMMON_DIR to resolve_ref_unsafe(). The second - fourth
patch depend on this. At the same time, this allows us to remove
reimplementation of resolve_ref_unsafe() in worktree.c: parse_ref().

[2/5]
Adds REF_COMMON_DIR flag to lock_ref_sha1_basic().

[3/5]
Adds create_symref_common_dir(). Same as create_symref() except it
doesn't consider $GIT_DIR. create_symref_common_dir("HEAD", some) always
updates .git/HEAD. The next patch uses this.

[4/5]
Fixes the issue of git branch -m.
The behavior when one failed has changed from v1: print an error and
continue.

  % git branch -m oldname newname
  error: Unable to create '/path/to/.git/worktrees/wt/HEAD.lock': Permission denied
  error: HEAD of working tree /path/to/wt is not updated.
  error: Unable to create '/path/to/.git/worktrees/wt2/HEAD.lock': Permission denied
  error: HEAD of working tree /path/to/wt2 is not updated.
  fatal: Branch renamed to newname, but HEAD is not updated!

[5/5]
Fixes an issue of git branch -d, v1 didn't include this.
I noticed git branch -d has same issue and this is for it.
This patch is unrelated to the above 4 patches, but the cause is same.
This can be applied separately.


Kazuki Yamaguchi (5):
  refs: add new flag RESOLVE_REF_COMMON_DIR to resolve_ref_unsafe
  refs: add REF_COMMON_DIR flag
  refs: add create_symref_common_dir as a variation of create_symref
  branch -m: update all per-worktree HEADs
  branch -d: refuse deleting a branch which is currently checked out

 branch.c             |  32 ++++++++++++++++
 branch.h             |   7 ++++
 builtin/branch.c     |  15 ++++----
 refs.h               |  11 ++++++
 refs/files-backend.c |  34 ++++++++++++++---
 t/t3200-branch.sh    |  29 +++++++++++++-
 worktree.c           | 105 ++++++++++++++++-----------------------------------
 7 files changed, 147 insertions(+), 86 deletions(-)

-- 
2.8.0.rc4.21.g05df949
