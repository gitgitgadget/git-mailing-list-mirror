From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/5] tweak t1304 ACL tests so they work on Solaris
Date: Mon, 15 Mar 2010 12:14:32 -0500
Message-ID: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
Cc: Matthieu.Moy@imag.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 18:15:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDsv-0004JA-Fe
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965509Ab0CORPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:15:14 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43456 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965505Ab0CORPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:15:13 -0400
Received: by mail.nrlssc.navy.mil id o2FHF2B7002207; Mon, 15 Mar 2010 12:15:02 -0500
X-OriginalArrivalTime: 15 Mar 2010 17:14:59.0092 (UTC) FILETIME=[0A873540:01CAC463]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142228>

The operaton of setfacl and the interaction of mode bits with ACL seem
to differ on Solaris and Linux.  The current t1304 tests fail on Solaris
7 and 10.

The following patch series seems to fix the tests on Solaris 10.  Solaris
7 still fails t1304.3 for some unknown reason.  I used the script below to
do some testing.

On Linux it prints out:

  Initialized empty Git repository in /var/tmp/test_acl2/.git/
  [master (root-commit) 22176cb] test commit
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 foo.txt
  -r--r-----+ 1 casey NRL7240 29 Mar 15 11:47 .git/objects/90/bfcb510602aa11ae53a42dcec18ea39fbd8cec
  # file: .git/objects/90/bfcb510602aa11ae53a42dcec18ea39fbd8cec
  # owner: casey
  # group: NRL7240
  user::r--
  user:display:rwx	#effective:r--
  group::---
  mask::r--
  other::---

  -r--r-----+ 1 casey NRL7240 225 Mar 15 11:47 .git/objects/pack/pack-0611d0bcfb48f3db9f0d51334a035289272dbb2c.pack
  # file: .git/objects/pack/pack-0611d0bcfb48f3db9f0d51334a035289272dbb2c.pack
  # owner: casey
  # group: NRL7240
  user::r--
  user:display:rwx	#effective:r--
  group::---
  mask::r--
  other::---


On Solaris 10 it prints out:

  Initialized empty Git repository in /var/tmp/test_acl2/.git/
  [master (root-commit) 5e4c0c6] test commit
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 foo.txt
  -r--------+  1 casey    NRL7240       29 Mar 15 11:49 .git/objects/90/bfcb510602aa11ae53a42dcec18ea39fbd8cec

  # file: .git/objects/90/bfcb510602aa11ae53a42dcec18ea39fbd8cec
  # owner: casey
  # group: NRL7240
  user::r--
  user:display:rwx		#effective:r--
  group::---		#effective:---
  mask:r--
  other:---
  -r--------+  1 casey    NRL7240      225 Mar 15 11:49 .git/objects/pack/pack-fedf57238f710f6b713019fe02fddab7a63702d0.pack

  # file: .git/objects/pack/pack-fedf57238f710f6b713019fe02fddab7a63702d0.pack
  # owner: casey
  # group: NRL7240
  user::r--
  user:display:rwx		#effective:r--
  group::---		#effective:---
  mask:r--
  other:---


On Solaris 7 it prints out:

  Initialized empty Git repository in /var/tmp/test_acl2/.git/
  [master (root-commit) ca62c6f] test commit
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 foo.txt
  -r--------+  1 casey    NRL7240       29 Mar 15 10:51 .git/objects/90/bfcb510602aa11ae53a42dcec18ea39fbd8cec

  # file: .git/objects/90/bfcb510602aa11ae53a42dcec18ea39fbd8cec
  # owner: casey
  # group: NRL7240
  user::r--
  user:display:rwx		#effective:r--
  group::---		#effective:---
  mask:r--
  other:---
  -r--------+  1 casey    NRL7240      225 Mar 15 10:51 .git/objects/pack/pack-dc814256703ad9c01e6dd1080c7151f664c6382a.pack

  # file: .git/objects/pack/pack-dc814256703ad9c01e6dd1080c7151f664c6382a.pack
  # owner: casey
  # group: NRL7240
  user::r--
  user:display:rwx		#effective:---
  group::---		#effective:---
  mask:---
  other:---


So, on Solaris 7, the pack file incorrectly has effective permissions of
'---' for the 'display' user.  For some reason the mask ACL was not
inherited from the parent directory.


When the patch series is applied on top of 7aba6185, which introduced these
tests, Linux still correctly fails t1304.3, but t1304.2 now passes.  This is
ok since t1304.2 was only failing because git gave object files more
permissive file permissions than what were requested, not because the ACL's
were clobbered.  Of course, when applied on top of master, all tests pass on
Linux, and now on Solaris 10.


--->8--- test_acl.sh --->8---
#!/bin/sh

alt_user=display

testcase=${1:-'1'}

case "$testcase" in
   1) test_dir=/var/tmp/test_acl1 ;;
   2) test_dir=/var/tmp/test_acl2
      GIT_EXEC_PATH=`pwd`
      PATH=`pwd`:$PATH
      GITPERLLIB=`pwd`/perl/blib/lib
      export GIT_EXEC_PATH PATH GITPERLLIB
      ;;
   *)
      echo 1>&2 "Usage: $0 [1|2]"
      exit 1
      ;;
esac


umask 077 &&
  rm -rf "$test_dir" && mkdir "$test_dir" && cd "$test_dir" &&
  setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx . &&
  setfacl -m d:u:$alt_user:rwx . &&
  setfacl -m u:$alt_user:rwx,m:rwx . &&
  git init &&
  echo 'this is a test' > foo.txt &&
  git add foo.txt &&
  git commit -m 'test commit' &&
  ls -l .git/objects/90/bfcb510602aa11ae53a42dcec18ea39fbd8cec &&
  getfacl .git/objects/90/bfcb510602aa11ae53a42dcec18ea39fbd8cec &&
  git gc &&
  ls -l .git/objects/pack/*.pack &&
  getfacl .git/objects/pack/*.pack
--->8---


Brandon Casey (5):
  t/t1304: avoid -d option to setfacl
  t/t1304: set the Default ACL base entries
  t/t1304: use 'test -r' to test readability rather than looking at
    mode bits
  t/t1304: set the mask ACL that is checked in check_perms_and_acl
  t/t1304: make a second colon optional in the mask ACL check

 t/t1304-default-acl.sh |   23 ++++++-----------------
 1 files changed, 6 insertions(+), 17 deletions(-)
