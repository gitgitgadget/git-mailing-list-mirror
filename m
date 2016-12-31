Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A78A2070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbcLaDNN (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:13 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56961 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754470AbcLaDNN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:13 -0500
X-AuditID: 12074414-78bff70000004a85-2a-586722451306
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 61.67.19077.54227685; Fri, 30 Dec 2016 22:13:10 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6ts010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:08 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/23] Delete directories left empty after ref deletion
Date:   Sat, 31 Dec 2016 04:12:40 +0100
Message-Id: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsUixO6iqOumlB5hcH2rpUXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Ms5N3MBUsFOmYtX+E4wNjIfEuxg5OSQETCS+/+1kA7GFBC4zSlyayt3FyAVkH2eSOL7r
        LTNIgk1AV2JRTzMTiC0ioCYxse0QC0gRs8BERolpWy6BJYQFvCQeHp8E1sAioCrRtv0dWJxX
        wFxiy6t9rBDb5CQubfvCPIGRawEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU
        0k2MkFAQ2cF45KTcIUYBDkYlHt6Oa2kRQqyJZcWVuYcYJTmYlER5LS1TI4T4kvJTKjMSizPi
        i0pzUosPMUpwMCuJ8C6US48Q4k1JrKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh
        4FCS4FVQBGoULEpNT61Iy8wpQUgzcXCCDOcBGt4LUsNbXJCYW5yZDpE/xagoJc67VgEoIQCS
        yCjNg+uFxeorRnGgV4R5WUHaeYBxDtf9CmgwE9BgtZxkkMEliQgpqQbGGS0J4nLifKkRH7Oe
        158TUvX/fep4/2Wz8xGbV00QfJ6tJJpV7fJbI0zy7Iyy/3G/7tTGJPxanLO3uFG1oVv6VmDI
        5Ju99//IhjkoZ8ZeUyje21mxwnFqyUx9nUXxGyIN5s5ZeNYnSczvy00NEfUPHcwnJ8qJ+IXJ
        HJrvfCbi9N9UHu/KY0VKLMUZiYZazEXFiQBgK2c0sAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of an old patch series. v1 [1] got some feedback,
which I think was all addressed in v2 [2]. But it seems that v2 fell
on the floor, and I didn't bother following up because it was in the
same area of code that was undergoing heavy changes due to the
pluggable reference backend work. Sorry for the long delay before
getting back to it.

It turns out that this patch series is still relevant and didn't even
need all that must adjustment. While rebasing onto the current
`master`, I tidied up a bit, tightened up some code, and improved some
commit messages. But the spirit of the patch series and most of its
code are unchanged.

This patch series is also available from my GitHub account [3] as
branch delete-empty-refs-dirs.

Brief summary (see v1 [1] for more details):

Previously, we were pretty sloppy about leaving empty directories
behind (under both $GIT_DIR/refs and $GIT_DIR/logs) when deleting
references. Such directories could accumulate essentially forever.
It's true that `pack-refs` deletes directories that it empties, but if
a directory is *already* empty, then `pack-refs` doesn't remove it. It
is also true that if an empty directory gets in the way of the
creation of a *new* reference, then it is deleted. But otherwise there
is no systematic cleanup of empty directories.

A reason for the old behavior was that the code paths *creating* new
files in these hierarchies were not always robust against a race with
another process that was cleaning up empty directories. So most of
this patch series is dedicated to hardening up the creation code paths
(via a new function, `raceproof_create_file()`). The last several
patches teach `files_transaction_commit()` to delete empty directories
when deleting references and reflogs.

Michael

[1] http://public-inbox.org/git/cover.1455626201.git.mhagger@alum.mit.edu/T/#u
[2] http://public-inbox.org/git/cover.1456405698.git.mhagger@alum.mit.edu/T/#u
[3] http://github.com/mhagger/git

Michael Haggerty (23):
  files_rename_ref(): tidy up whitespace
  t5505: use "for-each-ref" to test for the non-existence of references
  safe_create_leading_directories_const(): preserve errno
  safe_create_leading_directories(): set errno on SCLD_EXISTS
  raceproof_create_file(): new function
  lock_ref_sha1_basic(): inline constant
  lock_ref_sha1_basic(): use raceproof_create_file()
  rename_tmp_log(): use raceproof_create_file()
  rename_tmp_log(): improve error reporting
  log_ref_write(): inline function
  log_ref_setup(): separate code for create vs non-create
  log_ref_setup(): improve robustness against races
  log_ref_setup(): pass the open file descriptor back to the caller
  log_ref_write_1(): don't depend on logfile argument
  log_ref_setup(): manage the name of the reflog file internally
  log_ref_write_1(): inline function
  delete_ref_loose(): derive loose reference path from lock
  delete_ref_loose(): inline function
  try_remove_empty_parents(): rename parameter "name" -> "refname"
  try_remove_empty_parents(): don't trash argument contents
  try_remove_empty_parents(): don't accommodate consecutive slashes
  try_remove_empty_parents(): teach to remove parents of reflogs, too
  files_transaction_commit(): clean up empty directories

 cache.h               |  48 ++++++-
 refs/files-backend.c  | 375 +++++++++++++++++++++++++-------------------------
 refs/refs-internal.h  |  11 +-
 sha1_file.c           |  76 +++++++++-
 t/t1400-update-ref.sh |  27 ++++
 t/t5505-remote.sh     |   2 +-
 6 files changed, 346 insertions(+), 193 deletions(-)

-- 
2.9.3

