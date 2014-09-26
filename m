From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 00/39] Lockfile correctness and refactoring
Date: Fri, 26 Sep 2014 12:08:00 +0200
Message-ID: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:08:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSSQ-0003Mn-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbaIZKIy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2014 06:08:54 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61410 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755131AbaIZKIw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:08:52 -0400
X-AuditID: 12074413-f79ed6d000002501-c5-54253b337905
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id EE.B9.09473.33B35245; Fri, 26 Sep 2014 06:08:51 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLj013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:08:48 -0400
X-Mailer: git-send-email 2.1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqGtsrRpisHqOiEXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BmHmiczFszSrpjXfou5gXGhbBcj
	J4eEgInE0u5DLBC2mMSFe+vZuhi5OIQELjNKnDiwiRXC2cQkMff6WVaQKjYBXYlFPc1MILaI
	gJrExDaQbi4OZoHFTBITDm1iA0kIC9hJTDh+m7mLkYODRUBV4sRhOxCTV8BFYt9eU4hlchIb
	dv9nBLF5BQQlTs58wgJSwiygLrF+nhBImFlAXqJ562zmCYx8s5BUzUKomoWkagEj8ypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkDAX3sG466TcIUYBDkYlHt4b61RChFgT
	y4orcw8xSnIwKYnyfrFQDRHiS8pPqcxILM6ILyrNSS0+xCjBwawkwnvHCCjHm5JYWZValA+T
	kuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgvWgJ1ChYlJqeWpGWmVOCkGbi4AQZziUl
	Upyal5JalFhakhEPirr4YmDcgaR4gPZyWYHsLS5IzAWKQrSeYtTlWNf5rZ9JiCUvPy9VSpz3
	CMgOAZCijNI8uBWwpPaKURzoY2HeGyBVPMCECDfpFdASJqAlSkeUQZaUJCKkpBoYU59b/vfY
	bhj35tbPiE2XVE0FzA4U9+3coCfB4vL/ZnvxZZHH74KUEnZ/4hX2uCxRwa8pH/L3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257504>

Next iteration of my lockfile fixes and refactoring. Thanks to
Jonathan Nieder and Torsten B=C3=B6gershausen for their comments about =
v5.

I believe that this series addresses all of the comments from v1 [1],
v2 [2], v3 [3], v4 [4], and v5 [5].

Changes since v4:

* Revise API documentation.

* Split out a separate header file for the lockfile API: lockfile.h.

* Change close_lock_file() to rollback on errors and make it into a
  NOOP if the file is already closed.

* Don't set lk->on_list until the lock_file object is completely on
  the lock_file_list.

* Delete some information from the docstring in lockfile.c (now
  lockfile.h) that is redundant with the API docs in api-lockfile.txt.

* Remove the accidental extra call of git_config_clear() in
  git_config_set_multivar_in_file() when commit_lock_file() fails.

* Adjust some comments, error messages, and commit messages.

* Rebase to current master.

[1] http://thread.gmane.org/gmane.comp.version-control.git/245609
[2] http://thread.gmane.org/gmane.comp.version-control.git/245801
[3] http://thread.gmane.org/gmane.comp.version-control.git/246222
[4] http://thread.gmane.org/gmane.comp.version-control.git/256564
[5] http://thread.gmane.org/gmane.comp.version-control.git/257159

Michael Haggerty (39):
  unable_to_lock_die(): rename function from unable_to_lock_index_die()
  api-lockfile: revise and expand the documentation
  close_lock_file(): exit (successfully) if file is already closed
  rollback_lock_file(): do not clear filename redundantly
  rollback_lock_file(): exit early if lock is not active
  rollback_lock_file(): set fd to -1
  lockfile: unlock file if lockfile permissions cannot be adjusted
  hold_lock_file_for_append(): release lock on errors
  lock_file(): always initialize and register lock_file object
  lockfile.c: document the various states of lock_file objects
  cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
  delete_ref_loose(): don't muck around in the lock_file's filename
  prepare_index(): declare return value to be (const char *)
  write_packed_entry_fn(): convert cb_data into a (const int *)
  lock_file(): exit early if lockfile cannot be opened
  remove_lock_file(): call rollback_lock_file()
  commit_lock_file(): inline temporary variable
  commit_lock_file(): die() if called for unlocked lockfile object
  close_lock_file(): if close fails, roll back
  commit_lock_file(): rollback lock file on failure to rename
  api-lockfile: document edge cases
  dump_marks(): remove a redundant call to rollback_lock_file()
  git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
  lockfile: avoid transitory invalid states
  struct lock_file: declare some fields volatile
  try_merge_strategy(): remove redundant lock_file allocation
  try_merge_strategy(): use a statically-allocated lock_file object
  commit_lock_file(): use a strbuf to manage temporary space
  Change lock_file::filename into a strbuf
  resolve_symlink(): use a strbuf for internal scratch space
  resolve_symlink(): take a strbuf parameter
  trim_last_path_component(): replace last_path_elm()
  Extract a function commit_lock_file_to()
  Rename LOCK_NODEREF to LOCK_NO_DEREF
  lockfile.c: rename static functions
  get_locked_file_path(): new function
  hold_lock_file_for_append(): restore errno before returning
  Move read_index() definition to read-cache.c
  lockfile.h: extract new header file for the functions in lockfile.c

 Documentation/technical/api-lockfile.txt | 220 ++++++++++++++++++-----=
-
 builtin/add.c                            |   1 +
 builtin/apply.c                          |   1 +
 builtin/checkout-index.c                 |   2 +-
 builtin/checkout.c                       |   2 +-
 builtin/clone.c                          |   1 +
 builtin/commit.c                         |  17 +-
 builtin/describe.c                       |   1 +
 builtin/diff.c                           |   1 +
 builtin/gc.c                             |   2 +-
 builtin/merge.c                          |  16 +-
 builtin/mv.c                             |   2 +-
 builtin/read-tree.c                      |   1 +
 builtin/receive-pack.c                   |   1 +
 builtin/reflog.c                         |   4 +-
 builtin/reset.c                          |   1 +
 builtin/rm.c                             |   2 +-
 builtin/update-index.c                   |   3 +-
 bundle.c                                 |   1 +
 cache-tree.c                             |   1 +
 cache.h                                  |  20 +--
 config.c                                 |  16 +-
 credential-store.c                       |   1 +
 fast-import.c                            |   5 +-
 fetch-pack.c                             |   1 +
 lockfile.c                               | 284 +++++++++++++++++------=
--------
 lockfile.h                               |  84 +++++++++
 merge-recursive.c                        |   1 +
 merge.c                                  |   1 +
 read-cache.c                             |  21 ++-
 refs.c                                   |  30 ++--
 rerere.c                                 |   1 +
 sequencer.c                              |   1 +
 sha1_file.c                              |   1 +
 shallow.c                                |   7 +-
 test-scrap-cache-tree.c                  |   1 +
 36 files changed, 492 insertions(+), 263 deletions(-)
 create mode 100644 lockfile.h

--=20
2.1.0
