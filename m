From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/25] Lockfile correctness and refactoring
Date: Mon,  7 Apr 2014 01:33:42 +0200
Message-ID: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWway-000602-W8
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbaDFXeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:34:44 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60763 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754135AbaDFXem (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:34:42 -0400
X-AuditID: 1207440f-f79326d000003c9f-76-5341e491d8eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D3.60.15519.194E1435; Sun,  6 Apr 2014 19:34:41 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWl011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:39 -0400
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqDvxiWOwwdmnhhZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PzzEtsBaskK9a9vcjYwNgj3MXIySEhYCKxtuEk
	C4QtJnHh3nq2LkYuDiGBy4wStx/tZIJwjjNJHL1/FKyKTUBXYlFPMxOILSKgJjGx7RALSBGz
	wA1GiXf7DoMVCQvYSZxc9hPMZhFQlTh58hU7iM0r4CJx7WMzI8Q6OYmTxyazTmDkXsDIsIpR
	LjGnNFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJJj4dzB2rZc5xCjAwajEw7vikGOw
	EGtiWXFl7iFGSQ4mJVFey3tAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8B24A5XhTEiurUovy
	YVLSHCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErx9j4EaBYtS01Mr0jJzShDSTBycIMO5
	pESKU/NSUosSS0sy4kHBHl8MDHeQFA/Q3osg7bzFBYm5QFGI1lOMilLivDMfASUEQBIZpXlw
	Y2Ep4hWjONCXwrzLQNp5gOkFrvsV0GAmoMENYXYgg0sSEVJSDYzujhXf6/Yned9abJbjv932
	9pO3PssEth8+HtbmljyxhV9YO2dva2me7aJr707Yr38sc/vtpcKnQucur3L+fvECaySD5+0C
	x8XivgWLeyPUn8ierJ8YwRB78/0hQRG/hae0Yi/WtK/6ynu5yiso/vdBvkP3NP7u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245801>

This is a second attempt at renovating the lock file code.  Thanks to
Peff, Junio, Torsten, and Eric for their helpful reviews of v1.

v1 of this patch series [1] did some refactoring and then added a new
feature to the lock_file API: the ability to activate a new version of
a locked file while retaining the lock.

But the review of v1 turned up even more correctness issues in the
existing implementation of lock files.  So this v2 dials back the
scope of the changes (it omits the new feature) but does more work to
fix problems with the current lock file implementation.

The main theme of this patch series is to better define the state
diagram for lock_file objects and to fix code that left them in
incorrect, indeterminate, or unexpected states.  There are also a few
patches that convert several functions to use strbufs instead of
limiting pathnames to a maximum length.

I hope that submitting these patches separately will make it easier
for them to be accepted without first having to decide wither the
activate-file-while-retaining-lock feature is a good one.

[1] http://thread.gmane.org/gmane.comp.version-control.git/245609

Michael Haggerty (25):
  api-lockfile: expand the documentation
  unable_to_lock_die(): rename function from unable_to_lock_index_die()
  rollback_lock_file(): do not clear filename redundantly
  rollback_lock_file(): set fd to -1
  lockfile: unlock file if lockfile permissions cannot be adjusted
  hold_lock_file_for_append(): release lock on errors
  lock_file(): always add lock_file object to lock_file_list
  struct lock_file: replace on_list field with flags field
  lockfile.c: document the various states of lock_file objects
  lockfile: define a constant LOCK_SUFFIX_LEN
  delete_ref_loose(): don't muck around in the lock_file's filename
  prepare_index(): declare return value to be (const char *)
  write_packed_entry_fn(): convert cb_data into a (const int *)
  lock_file(): exit early if lockfile cannot be opened
  remove_lock_file(): call rollback_lock_file()
  commit_lock_file(): inline temporary variable
  commit_lock_file(): make committing an unlocked lockfile a NOP
  lockfile: avoid transitory invalid states
  try_merge_strategy(): remove redundant lock_file allocation
  try_merge_strategy(): use a statically-allocated lock_file object
  commit_lock_file(): use a strbuf to manage temporary space
  Change lock_file::filename into a strbuf
  resolve_symlink(): use a strbuf for internal scratch space
  resolve_symlink(): take a strbuf parameter
  trim_last_path_elm(): replace last_path_elm()

 Documentation/technical/api-lockfile.txt |  40 ++++-
 builtin/commit.c                         |  16 +-
 builtin/merge.c                          |  15 +-
 builtin/reflog.c                         |   2 +-
 builtin/update-index.c                   |   2 +-
 cache.h                                  |   6 +-
 config.c                                 |   6 +-
 lockfile.c                               | 282 +++++++++++++++++++------------
 refs.c                                   |  20 ++-
 shallow.c                                |   6 +-
 10 files changed, 243 insertions(+), 152 deletions(-)

-- 
1.9.1
