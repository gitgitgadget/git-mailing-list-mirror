From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/17] Fix some mkdir/rmdir races
Date: Mon,  6 Jan 2014 14:45:18 +0100
Message-ID: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AVU-0005bh-SG
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbaAFNqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:12 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45645 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482AbaAFNqK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:10 -0500
X-AuditID: 1207440f-b7f306d000006d99-a5-52cab3a181d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.D2.28057.1A3BAC25; Mon,  6 Jan 2014 08:46:09 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfP1021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:07 -0500
X-Mailer: git-send-email 1.8.5.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqLtw86kgg6mP5C26rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzNs6ex1Sw1qLi9eavLA2MP7W6GDk5JARMJHq2LWeCsMUkLtxbz9bFyMUhJHCZUeLz
	/GZ2COcYk0TX2T+sIFVsAroSi3qawTpEBNQkJrYdYgEpYhZYzCjRNe0bYxcjB4cw0NhDCzhA
	TBYBVYm7R7JAynkFXCS+H+piBQlLCChIrL4uNIGRewEjwypGucSc0lzd3MTMnOLUZN3i5MS8
	vNQiXRO93MwSvdSU0k2MkADh38HYtV7mEKMAB6MSD6/ns5NBQqyJZcWVuYcYJTmYlER5OVef
	ChLiS8pPqcxILM6ILyrNSS0+xCjBwawkwsu1ACjHm5JYWZValA+TkuZgURLnVV+i7ickkJ5Y
	kpqdmlqQWgSTleHgUJLgfbkJqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFObx
	xcBAB0nxAO29AtLOW1yQmAsUhWg9xajL0ffv0zdGIZa8/LxUKXFeQWBECwmAFGWU5sGtgKWD
	V4ziQB8L824BGcUDTCVwk14BLWECWhIaB7akJBEhJdXAODF1t7F7gmXM1KRncw3cZX9J2yY+
	9rTc9VZnZXBBuquOn92fc/N9XY28p0np+fy6O4vvaqPk9v6bGW0JJgdr4s/4cil7OUyV5Ssp
	er/wR2dKxua/1d89bFTc1uou2evgZG7FKbZ/bkLo7vjmosx/P5t1nNxZnTb9Wh34 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239992>

This is v2 of changes [1] to remove some mkdir/rmdir races around
safe_create_leading_directories() and a couple of its callers.  Thanks
to Jonathan Nieder for his thorough review of v1 and to Ramsay Jones
for pointing out a typo.  I think I have addressed all of their
suggestions.

This patch series has a bigger scope than v1.  The main differences is
that I took Jonathan's (implicit?) suggestion to move the retrying to
a level higher, where files are actually created in the directories
and therefore the directories are definitely no longer subject to
pruning.

Differences from v1:

* Improve some commit messages

* Break up some changes to safe_create_leading_directories() into
  smaller steps.

* Fix a problem in safe_create_leading_directories() when handling
  paths with multiple slashes (e.g., "foo//bar").  (I noticed this
  pre-existing problem while making the other changes.)

* Change how retrying is done:

  * safe_create_leading_directories() doesn't retry internally;
    instead, its return value is turned into an enum with a new value,
    SCLD_VANISHED, that indicates that a directory along the path
    vanished while it was working.  This return value is an indication
    that its caller might want to try calling the function again.

  * Change rename_ref() to retry if either
    safe_create_leading_directories() returns SCLD_VANISHED or if its
    own call to rename() returns ENOENT.

* Fix a similar mkdir/rmdir race in lock_ref_sha1_basic().  This one
  is actually more interesting than the one in rename_ref() because it
  can be triggered internal to git.

* Fix a race in remove_dir_recurse(): if somebody else deletes a file
  or directory that the function wanted to delete anyway, don't treat
  it as an error.

The main git-internal race that I know to be fixed by these changes is
when pack-refs is trying to delete empty directories at the same time
as another process is trying to create a new reference.  It can be
reproduced by this script:

    BRANCHES="foo/bar/xyzzy foo/bar/plugh"
    HEADS="h1 h2"

    rm -rf test-repo
    $GIT init test-repo
    cd test-repo
    $GIT config user.name 'Lou User'
    $GIT config user.email 'luser@example.com'

    for h in $HEADS
    do
        $GIT commit --allow-empty -m $h
        $GIT branch $h
    done

    (
        while true
        do
    	for b in $BRANCHES
    	do
    	    for h in $HEADS
    	    do
    		$GIT update-ref refs/heads/$b $h
    	    done
    	done
        done
    ) &
    pid1=$!

    (
        while true
        do
    	$GIT pack-refs --all
        done
    ) &
    pid2=$!

The script has to fail if update-ref and pack-refs try to lock the
same reference at the same time, because we don't handle lock
contention:

    fatal: Unable to create '/home/mhagger/tmp/test-repo/.git/refs/heads/foo/bar/plugh.lock': File exists.

    If no other git process is currently running, this probably means a
    git process crashed in this repository earlier. Make sure no other git
    process is running and remove the file manually to continue.

Also, if update-ref changes the value of a reference while pack-refs
is running, then pack-refs emits a warning and leaves the new value of
the loose reference in place:

    error: Ref refs/heads/foo/bar/xyzzy is at 003a9cedc3ec79b8f589b158ffe91177f0a611b3 but expected 34bf1e34d27a639732a01fef0a791e58c2c0882f

But it used to have other unnecessary failures, too, related to
mkdir/rmdir races between the two programs:

    error: unable to create directory for .git/refs/heads/foo/bar/plugh

and

    fatal: Unable to create '/home/mhagger/tmp/test-repo/.git/refs/heads/foo/bar/plugh.lock': No such file or directory

This patch series eliminates the last two types of failures.  Here are
tallies of failures from running the above script for 60 seconds
before and after this change.  Before:

    Total updates: 46900
    Unable to create '*.lock': File exists: 1992
    * is at * but expected *: 940
    unable to create directory: 187
    Unable to create '*.lock': No such file or directory: 197

After:

    Total updates: 47892
    Unable to create '*.lock': File exists: 2105
    * is at * but expected *: 835
    unable to create directory: 0
    Unable to create '*.lock': No such file or directory: 0

Clearly, more work is still needed in this area.  For example, the "*
is at * but expected *" errors are not really errors at all and should
not be reported as such.  And we might want to consider adding a short
delay and then a retry when acquiring locks.  If I run the same test
script with the following patch, then most or all of the "Unable to
create '*.lock': File exists" errors go away too.

======================================================================
diff --git a/refs.c b/refs.c
index 810f802..b3ff1f5 100644
--- a/refs.c
+++ b/refs.c
@@ -2117,7 +2117,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
                         * again:
                         */
                        goto retry;
-               else
+               else if (errno == EEXIST && --attempts > 0) {
+                       usleep(1000);
+                       goto retry;
+               } else
                        unable_to_lock_index_die(ref_file, errno);
        }
        return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
======================================================================

I hope to do some more work here in the near future.

[1] Version 1: http://thread.gmane.org/gmane.comp.version-control.git/239638

Michael Haggerty (17):
  safe_create_leading_directories(): fix format of "if" chaining
  safe_create_leading_directories(): reduce scope of local variable
  safe_create_leading_directories(): add explicit "slash" pointer
  safe_create_leading_directories(): rename local variable
  safe_create_leading_directories(): split on first of multiple slashes
  safe_create_leading_directories(): always restore slash at end of loop
  safe_create_leading_directories(): introduce enum for return values
  cmd_init_db(): when creating directories, handle errors conservatively
  safe_create_leading_directories(): add new error value SCLD_VANISHED
  lock_ref_sha1_basic(): on SCLD_VANISHED, retry
  lock_ref_sha1_basic(): if locking fails with ENOENT, retry
  remove_dir_recurse(): tighten condition for removing unreadable dir
  remove_dir_recurse(): handle disappearing files and directories
  rename_ref(): extract function rename_tmp_log()
  rename_tmp_log(): handle a possible mkdir/rmdir race
  rename_tmp_log(): limit the number of remote_empty_directories()
    attempts
  rename_tmp_log(): on SCLD_VANISHED, retry

 builtin/init-db.c |  9 +++---
 cache.h           | 25 +++++++++++++--
 dir.c             | 27 +++++++++++-----
 merge-recursive.c |  2 +-
 refs.c            | 92 ++++++++++++++++++++++++++++++++++++++++---------------
 sha1_file.c       | 67 ++++++++++++++++++++++------------------
 6 files changed, 155 insertions(+), 67 deletions(-)

-- 
1.8.5.2
