From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/20] Delete directories left empty after ref deletion
Date: Tue, 16 Feb 2016 14:22:13 +0100
Message-ID: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhZ-0002e8-98
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbcBPN35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:29:57 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58871 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932230AbcBPN3t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:29:49 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2016 08:29:49 EST
X-AuditID: 1207440c-c0bff70000002d40-c1-56c322a5d673
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F5.E5.11584.5A223C65; Tue, 16 Feb 2016 08:22:45 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOM028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:43 -0500
X-Mailer: git-send-email 2.7.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqLtU6XCYwaPTehbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8b/jfeZCraoVDRd6WBvYPwr28XIySEhYCJx+e9j
	pi5GLg4hga2MEovbl7JAOCeYJJbfusYIUsUmoCuxqKeZCcQWEVCTmNh2CKyIWeARo0TX/u1g
	RcIC7hKfT1xgA7FZBFQlNl6eChbnFTCXmPriOjPEOjmJlh+7WScwci1gZFjFKJeYU5qrm5uY
	mVOcmqxbnJyYl5dapGuol5tZopeaUrqJERI0PDsYv62TOcQowMGoxMO7wfVQmBBrYllxZe4h
	RkkOJiVRXh7uw2FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHj/vQIq501JrKxKLcqHSUlzsCiJ
	86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8H5SBBoqWJSanlqRlplTgpBm4uAEGc4lJVKcmpeS
	WpRYWpIRDwrq+GJgWIOkeID2poG08xYXJOYCRSFaTzEqSonz7gdJCIAkMkrz4MbCUsErRnGg
	L4V5A0CqeIBpBK77FdBgJqDBOZdAHiouSURISTUwsm9nbi6RmDT1nMPVRwfklB4tPX79lVnL
	p6+CsdPDFkRkpjh36D6X/zw5Ikidl/HlV647yTOv3eg+Gfyy8g7rh3XXH97/nbPYff983x1i
	rhrnWr9NsYpj6Vlknj6Z899ULt3a6B9+G3Ikmh+kH5yhflNm44G8l/8U9f466jlv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286370>

Previously, we were pretty sloppy about leaving empty directories
behind (under both $GIT_DIR/refs and $GIT_DIR/logs) when deleting
references. Such directories could accumulate essentially forever.
It's true that `pack-refs` deletes directories that it empties, but if
a directory is *already* empty, then `pack-refs` doesn't remove it. It
is also true that if an empty directory gets in the way of the
creation of a *new* reference, then it is deleted. But otherwise there
is no systematic cleanup of empty directories.

Aside from being messy, wasting disk space, and costing extra time
when enumerating references, the proliferation of empty directories
was triggering a libgit2 bug [1] on our servers. (We use temporary,
uniquely-named references for internal purposes, causing a lot of
empty directories to accumulate in some cases.)

This problem was also recently reported by Karl Moskowski [2] to be
the cause of problem on non-case-sensitive filesystems.

This patch series makes the reference update machinery more aggressive
about deleting empty directories under $GIT_DIR/refs and under
$GIT_DIR/logs when deleting references and/or reflogs. This doesn't
eliminate all situations where empty directories can be left behind
[3], but it covers the worst offenders.

As prelude to the main change, there are a number of patches that make
the *creation* of reflog directories more robust against races. Since
we want to delete such directories more aggressively, we have to worry
more about a race between a process that is creating a new reflog, and
another process that might be deleting the containing directory at the
same time. (We already had protection against this sort of race for
reference creation, but not for reflog creation.)

And since I got tired of writing the same code over and over, I
abstracted the code for retrying directory creation into a new
function, raceproof_create_file(). This function replaces similar code
that appeared in two other places and is now also used for creating
reflog files. (Can anybody think of any other code that has to deal
with the same kind of race and could maybe benefit?)

This patch series is also available from my GitHub account [4] as
branch delete-empty-refs-dirs.

As you might imagine, this patch series conflicts with David Turner's
dt/refs-backend-lmdb series [5]. But the conflicts are not too bad [6].
When one or the other of these series is ready to progress, I'd be
happy to help resolve the conflicts with the other.

Michael

[1] https://github.com/libgit2/libgit2/issues/3576

[2] http://thread.gmane.org/gmane.comp.version-control.git/283504

[3] Off the top of my head, one case that is not covered is when a
    reflog is expired: a lock is acquired under $GIT_DIR/refs, but the
    directory that held it is not deleted when the lock is released.

[4] http://github.com/mhagger/git

[5] http://thread.gmane.org/gmane.comp.version-control.git/285604

[6] For a merge of this patch series with dt/refs-backend-lmdb v4, see
    branch merge-delete-empty-refs-dirs-refs-backend-lmdb at my GitHub
    repository [4].

Michael Haggerty (20):
  safe_create_leading_directories_const(): preserve errno
  safe_create_leading_directories(): set errno on SCLD_EXISTS
  raceproof_create_file(): new function
  lock_ref_sha1_basic(): use raceproof_create_file()
  rename_tmp_log(): use raceproof_create_file()
  rename_tmp_log(): improve error reporting
  log_ref_setup(): separate code for create vs non-create
  log_ref_setup(): improve robustness against races
  log_ref_setup(): pass the open file descriptor back to the caller
  log_ref_write_1(): don't depend on logfile
  log_ref_setup(): manage the name of the reflog file internally
  log_ref_write_1(): inline function
  try_remove_empty_parents(): rename parameter "name" -> "refname"
  try_remove_empty_parents(): don't trash argument contents
  try_remove_empty_parents(): don't accommodate consecutive slashes
  t5505: use "for-each-ref" to test for the non-existence of references
  delete_ref_loose(): derive loose reference path from lock
  delete_ref_loose(): inline function
  try_remove_empty_parents(): teach to remove parents of reflogs, too
  ref_transaction_commit(): clean up empty directories

 cache.h               |  26 +++-
 refs/files-backend.c  | 370 ++++++++++++++++++++++++++------------------------
 refs/refs-internal.h  |   9 +-
 sha1_file.c           |  77 ++++++++++-
 t/t1400-update-ref.sh |  27 ++++
 t/t5505-remote.sh     |   2 +-
 6 files changed, 325 insertions(+), 186 deletions(-)

-- 
2.7.0
