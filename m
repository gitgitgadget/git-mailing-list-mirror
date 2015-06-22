From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/19] Improve "refs" encapsulation and speed up deletes
Date: Mon, 22 Jun 2015 16:02:51 +0200
Message-ID: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72KJ-0005gX-JA
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370AbbFVODl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:03:41 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42110 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756123AbbFVODW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:22 -0400
X-AuditID: 1207440f-f79df6d000007c0f-62-558815a303e4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 32.99.31759.3A518855; Mon, 22 Jun 2015 10:03:15 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cbw030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:14 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqLtYtCPU4PB+NYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZzT2yRS8Vqq4dH4vawPjPOkuRk4OCQETiVtHPrJB2GISF+6tB7K5OIQELjNKXJh0lxHC
	Ockksfbpb1aQKjYBXYlFPc1MILaIgJrExLZDLCBFzAIdQB3Lt7GDJIQFvCVOn9zGDGKzCKhK
	NDYuAiri4OAVMJc4Mgdqm5zE+eM/mScwci9gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGui
	l5tZopeaUrqJERIg/DsYu9bLHGIU4GBU4uF1sG0PFWJNLCuuzD3EKMnBpCTKe+A1UIgvKT+l
	MiOxOCO+qDQntfgQowQHs5IIb8tZoBxvSmJlVWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFq
	EUxWhoNDSYLXT6QjVEiwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFOjxxcBQB0nx
	AO3NAWnnLS5IzAWKQrSeYtTlODT92lomIZa8/LxUKXHeySBFAiBFGaV5cCtg6eAVozjQx8K8
	e4SBqniAqQRu0iugJUxAS77ktoEsKUlESEk1MM6S9uJdsTdq9qN7sQ/S/lw4YGByTEf0mvVd
	LUMB4xe+6twfDER8pooVbf2UMeeLyqQzxjk/XU4mV8VMTEufUs/yN0Wil2Xyhqi1HV6lp+vD
	ryr8W7UwdavKnd+RMxJXxVqrcz1kjTH8dDglpmV+kHeJe8TUAvOVs9jnRfRPfb71 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272351>

This is v3 of the series. I think I have addressed all of the feedback
from v1 [1] and v2 [2]. Thanks to Stefan, Junio, and Peff for their
feedback about v2.

There are three significant changes since v2:

* Add a patch

      delete_refs(): bail early if the packed-refs file cannot be rewritten

  that changes delete_refs() to bail early if repack_without_refs()
  fails. See the log message for the explanation.

* Add a patch

      prune_refs(): use delete_refs()

  that changes "git fetch --prune" to use delete_refs() as well. This
  is analogous to the existing patch

      prune_remote(): use delete_refs()

  (Both of these changes remove quadratic behavior that can be
  extremely expensive in repositories with many packed refs.)

* Append four more commits that change how delete_ref() interprets its
  `old_sha1` parameter, to make it consistent with
  ref_transaction_delete() and friends:

      check_branch_commit(): make first parameter const
      update_ref(): don't read old reference value before delete
      cmd_update_ref(): make logic more straightforward
      delete_ref(): use the usual convention for old_sha1

  This change was suggested by Junio [3].

The last change is good for consistency, but less important than
expected in the real world. The reason is that the convention of
ref_transaction_delete() is that passing NULL_SHA1 as old_sha1 is a
bug (because why would somebody delete a reference that he knows not
to exist?) So we don't really gain a useful third case, though we do
gain a consistency check that might be useful someday. However, if you
don't like this change, the last four commits can be dropped
(actually, commits N-3 through N-1 are marginally useful cleanups
anyway so probably only the last commit should be dropped in this
case).

Other, minor changes since v2:

* Improve the commit message of "delete_refs(): make error message
  more generic".

* Better explain the change to error output caused by "prune_remote():
  use delete_refs()" in that commit's log message.

* Split the "add names for function parameters" changes into a
  separate patch.

* Fix how die() is invoked in "initial_ref_transaction_commit():
  function for initial ref creation" and remove some superfluous
  braces.

This series is also available from my GitHub account [4] as branch
"init-delete-refs-api".

[1] http://thread.gmane.org/gmane.comp.version-control.git/271017
[2] http://thread.gmane.org/gmane.comp.version-control.git/271552
[3] http://article.gmane.org/gmane.comp.version-control.git/271697
[4] https://github.com/mhagger/git

Michael Haggerty (19):
  delete_ref(): move declaration to refs.h
  remove_branches(): remove temporary
  delete_ref(): handle special case more explicitly
  delete_refs(): new function for the refs API
  delete_refs(): make error message more generic
  delete_refs(): bail early if the packed-refs file cannot be rewritten
  prune_remote(): use delete_refs()
  prune_refs(): use delete_refs()
  repack_without_refs(): make function private
  initial_ref_transaction_commit(): function for initial ref creation
  refs: remove some functions from the module's public interface
  initial_ref_transaction_commit(): check for duplicate refs
  initial_ref_transaction_commit(): check for ref D/F conflicts
  refs: move the remaining ref module declarations to refs.h
  refs.h: add some parameter names to function declarations
  check_branch_commit(): make first parameter const
  update_ref(): don't read old reference value before delete
  cmd_update_ref(): make logic more straightforward
  delete_ref(): use the usual convention for old_sha1

 archive.c               |   1 +
 builtin/blame.c         |   1 +
 builtin/branch.c        |   5 +-
 builtin/clone.c         |  18 ++++-
 builtin/fast-export.c   |   1 +
 builtin/fetch.c         |  25 ++++--
 builtin/fmt-merge-msg.c |   1 +
 builtin/init-db.c       |   1 +
 builtin/log.c           |   1 +
 builtin/remote.c        |  33 +-------
 builtin/update-ref.c    |  21 ++++-
 cache.h                 |  68 ----------------
 fast-import.c           |   6 +-
 refs.c                  | 182 ++++++++++++++++++++++++++++++++++++++---
 refs.h                  | 211 +++++++++++++++++++++++++++++++-----------------
 remote-testsvn.c        |   1 +
 16 files changed, 371 insertions(+), 205 deletions(-)

-- 
2.1.4
