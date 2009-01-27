From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Windows: Fix intermittent failures of t7701
Date: Tue, 27 Jan 2009 14:09:03 +0100
Message-ID: <497F076F.8060509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 14:10:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRniD-0005w3-9r
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 14:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZA0NJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 08:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbZA0NJQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 08:09:16 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59645 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbZA0NJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 08:09:15 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LRngd-0004QX-SG; Tue, 27 Jan 2009 14:09:11 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9E8394FB; Tue, 27 Jan 2009 14:09:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107342>

From: Johannes Sixt <j6t@kdbg.org>

The last test case checks whether unpacked objects receive the time stamp
of the pack file. Due to different implementations of stat(2) by MSYS and
our version in compat/mingw.c, the test fails in about half of the test
runs.

Note the following facts:

- The test uses perl's -M operator to compare the time stamps. Since we
  depend on MSYS perl, the result of this operator is based on MSYS's
  implementation of the stat(2) call.

- NTFS on Windows records fractional seconds.

- The MSYS implementation of stat(2) *rounds* fractional seconds to full
  seconds instead of truncating them. This becomes obvious by comparing the
  modification times reported by 'ls --full-time $f' and 'stat $f' for
  various files $f.

- Our implementation of stat(2) in compat/mingw.c *truncates* to full
  seconds.

The consequence of this is that

- add_packed_git() picks up truncated whole second modification times
  from the pack file time stamp, which is then used for the loose objects,
  while the pack file retains its time stamp in fractional seconds;

- but the test case compares the pack file's rounded modification times
  to the loose objects' truncated modification times.

And half of the time the rounded modification time is not the same as its
truncated modification time.

The fix is that we replace perl by 'test-chmtime -v +0', which prints the
truncated whole-second mtime without modifying it.

We want to catch failures of test-chmtime; but since it appears in a pipe,
we cannot access its exit code. Therefore, we at least make sure that it
prints time stamps of all files that are passed on its command line.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t7701-repack-unpack-unreachable.sh |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 63a8225..e6e9f99 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -50,12 +50,15 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '

 compare_mtimes ()
 {
-	perl -e 'my $reference = shift;
-		 foreach my $file (@ARGV) {
-			exit(1) unless(-f $file && -M $file == -M $reference);
-		 }
-		 exit(0);
-		' -- "$@"
+	test-chmtime -v +0 "$@" |
+	{
+		read ref files &&
+		while read t name; do
+			test $ref = $t || break
+			files="$files $name"
+		done &&
+		test "$files" = "$*"
+	}
 }

 test_expect_success '-A without -d option leaves unreachable objects packed' '
-- 
1.6.1.1.1203.g5882
