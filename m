From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/22] Lockfile refactoring and pre-activation
Date: Tue,  1 Apr 2014 17:58:08 +0200
Message-ID: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16o-0004sl-R1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbaDAP6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:58:46 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56291 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751814AbaDAP6h (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:37 -0400
X-AuditID: 12074413-f79076d000002d17-92-533ae22b91c0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 56.58.11543.B22EA335; Tue,  1 Apr 2014 11:58:35 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWb4027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:34 -0400
X-Mailer: git-send-email 1.9.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqKv9yCrYoOeiiUXXlW4mi4beK8wW
	t1fMZ7b4dfgJu8WPlh5mB1aPv+8/MHnsnHWX3eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M6Y+vEFe8EZ2YpJW24xNjCuFeti5OSQEDCReP//BBOELSZx4d56ti5GLg4hgcuMEt/a
	fjJBOMeYJI5vvMwCUsUmoCuxqKcZrENEQE1iYtshsDizQIrEq7+7wGxhATuJzt45rCA2i4Cq
	xPt/u9lBbF4BZ4lXC76xQWyTk5jyewH7BEbuBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0
	zfVyM0v0UlNKNzFCgkR4B+Ouk3KHGAU4GJV4eA+ctwoWYk0sK67MPcQoycGkJMr74y5QiC8p
	P6UyI7E4I76oNCe1+BCjBAezkgjvrJtAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTU
	gtQimKwMB4eSBG/UQ6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCoxxcDgx0k
	xQO0dzpIO29xQWIuUBSi9RSjopQ4bwhIQgAkkVGaBzcWFvuvGMWBvhTmXQxSxQNMG3Ddr4AG
	MwEN5l4HNrgkESEl1cDY0SRREPDAPfxisknMXYlruxl8Rav595SZJjZ2qc/p6DnHtFFKdvmF
	IkZul0mvWX+EPvCNXWF0qEq6PCXrzILCT4fu7NVmaq9pOp8uFPpvI+vSc9X+r5YEZoe4H1n3
	pGi5XG3BSpmaoIrAqMMMl4PPN194WXRZ6dZh+2Yld68VU84lTfad66rEUpyRaKjF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245609>

I've had this patch series kicking around for a long time, along with
some followup patches to fix a race in reference deletion.  I haven't
had the time to get everything done and tested, but let me at least
push this first series out there.  I especially want to submit it in
case we accept a GSoC student for the project "Refactor tempfile
handling", because (1) I don't want me and the student to be stepping
on each others' toes, and (2) there are some cleanups and
documentation improvements here that will hopefully be useful to the
student.

The first patch actually demonstrates the race condition that I hope
to fix someday.  The last patch introduces the lockfile feature that I
think is needed to fix it: the ability to activate a packed-refs file
while still holding the lock to prevent another process from
overwriting it before the accompanying loose reference updates are all
finished.  But the fix itself is not included here, so you might want
to keep the last patch on hold until there is a concrete user of the
feature.

The rest of the patches hopefully make the lockfile API more
consistent and better documented.  There were a lot of situations when
a failure in one step of the lock/commit procedure left a lock in an
ill-defined state.  That's probably not a problem very often in
practice, because we tend to die() soon after any locking problems.
But it is still helpful for lockfile objects to have a well-defined
state diagram (especially if your goal is to add a new feature to
them!)

Several patches are also devoted to making lock filename handling use
strbufs (for the usual reasons), and reducing the need for callers to
reach into the "filename" field and especially for them to use that
field as temporary scratch space.

Michael

Michael Haggerty (22):
  t3204: test deleting references when lock files already exist
  try_merge_strategy(): remove redundant lock_file allocation
  rollback_lock_file(): do not clear filename redundantly
  rollback_lock_file(): set fd to -1
  lockfile: unlock file if lockfile permissions cannot be adjusted
  hold_lock_file_for_append(): release lock on errors
  lock_file(): always add lock_file object to lock_file_list
  struct lock_file: replace on_list field with flags field
  api-lockfile: expand the documentation
  lockfile.c: document the various states of lock_file objects
  lockfile: define a constant LOCK_SUFFIX_LEN
  delete_ref_loose(): don't muck around in the lock_file's filename
  config: change write_error() to take a (struct lock_file *) argument
  lockfile: use strbufs when handling (most) paths
  resolve_symlink(): use a strbuf internally
  commit_lock_file(): don't work with a fixed-length buffer
  lock_file(): exit early if lockfile cannot be opened
  lockfile: also keep track of the filename of the file being locked
  struct lock_file: rename lock_filename field to staging_filename
  remove_lock_file(): call rollback_lock_file()
  lockfile: extract a function reset_lock_file()
  lockfile: allow new file contents to be written while retaining lock

 Documentation/technical/api-lockfile.txt |  90 +++++--
 builtin/commit.c                         |  12 +-
 builtin/merge.c                          |   1 -
 builtin/reflog.c                         |   2 +-
 cache.h                                  |   9 +-
 config.c                                 |  11 +-
 lockfile.c                               | 389 +++++++++++++++++++++----------
 refs.c                                   |   8 +-
 shallow.c                                |   6 +-
 t/t3204-branch-locks.sh                  |  40 ++++
 10 files changed, 403 insertions(+), 165 deletions(-)
 create mode 100755 t/t3204-branch-locks.sh

-- 
1.9.0
