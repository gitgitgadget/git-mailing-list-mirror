From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/25] Lockfile correctness and refactoring
Date: Mon, 14 Apr 2014 15:54:30 +0200
Message-ID: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhLu-0008G1-OU
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942AbaDNNzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:07 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49174 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753786AbaDNNzF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:05 -0400
X-AuditID: 12074411-f79ab6d000002f0e-fb-534be8b86241
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 86.A6.12046.8B8EB435; Mon, 14 Apr 2014 09:55:04 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt090010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:02 -0400
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqLvjhXewQec7Q4uuK91MFg29V5gt
	Vv6ssbi9Yj6zxa/DT9gtfrT0MFucedPIaNHZ8ZXRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/F
	D7w8Pm+S87j7fyeTx+1n21gCOKK4bZISS8qCM9Pz9O0SuDPWnFrGWnBRqmLnwwVMDYxdIl2M
	nBwSAiYS636cYoSwxSQu3FvP1sXIxSEkcJlRYmrjCrCEkMBJJom9B9NAbDYBXYlFPc1MILaI
	gJrExLZDLCANzALtTBKHdvQCJTg4hAXsJB7ciQapYRFQlWi7voUdxOYVcJFYsOooG8QyOYmT
	xyazTmDkXsDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWldBMjJLQEdzDOOCl3
	iFGAg1GJh7djjnewEGtiWXFl7iFGSQ4mJVHejBtAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
	rluBcrwpiZVVqUX5MClpDhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCV5jYAwJCRalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMCPb4YGOogKR6gvUnPQfYWFyTmAkUhWk8xKkqJ
	85aAJARAEhmleXBjYQnjFaM40JfCvBIg23mAyQau+xXQYCagwSztYINLEhFSUg2M/ep5bKdv
	Tomu3sNrwnGL6WlCgTm3/ZuH9bt/nVC0dXaV7RDfYxF271xqj9NFgx8dM/Tmsk40jzrltm7n
	zwLdBdI1X2fHJ+00vnd62flcOcuQH/8eq7tc8zIo2bUy4l6aw5wG1f5DU5uPqj6a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246222>

Round v3.  Thanks to Johannes Sixt and Peff for feedback on v2.  This
version addresses all issues raised for v1 [1] and v2 [2].

Changes since v2:

* Instead of keeping track of whether a lock_file object is active via
  a new bit in a flags bitmask, store it in a separate volatile
  sig_atomic_t struct member.  This makes it a little less undefined
  when this field is accessed by the signal handler.

* Add some other "volatile" qualifiers to values used by the signal
  handler.

* Define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN in cache.h and use
  them both inside and outside lockfile.c.  (In v2, only
  LOCK_SUFFIX_LEN was defined and it was only used within lockfile.c,
  because the other potential users in refs.c were rewritten anyway.
  But that rewriting is no longer included in the patch series, so it
  makes sense to define these constants as part of the public lockfile
  API.)

* Swap order of first two patches because the documentation lists
  unable_to_lock_die() under its new name.

* die() (instead of NOP) if commit_lock_file() is called for an
  unlocked lock_file object.

* Rebase to current master (there were no conflicts).

[1] http://thread.gmane.org/gmane.comp.version-control.git/245609
[2] http://thread.gmane.org/gmane.comp.version-control.git/245801

Michael Haggerty (25):
  unable_to_lock_die(): rename function from unable_to_lock_index_die()
  api-lockfile: expand the documentation
  rollback_lock_file(): do not clear filename redundantly
  rollback_lock_file(): set fd to -1
  lockfile: unlock file if lockfile permissions cannot be adjusted
  hold_lock_file_for_append(): release lock on errors
  lock_file(): always add lock_file object to lock_file_list
  lockfile.c: document the various states of lock_file objects
  cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
  delete_ref_loose(): don't muck around in the lock_file's filename
  prepare_index(): declare return value to be (const char *)
  write_packed_entry_fn(): convert cb_data into a (const int *)
  lock_file(): exit early if lockfile cannot be opened
  remove_lock_file(): call rollback_lock_file()
  commit_lock_file(): inline temporary variable
  commit_lock_file(): die() if called for unlocked lockfile object
  lockfile: avoid transitory invalid states
  struct lock_file: declare some fields volatile
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
 cache.h                                  |  15 +-
 config.c                                 |   6 +-
 lockfile.c                               | 275 ++++++++++++++++++-------------
 refs.c                                   |  29 ++--
 shallow.c                                |   6 +-
 10 files changed, 247 insertions(+), 159 deletions(-)

-- 
1.9.1
