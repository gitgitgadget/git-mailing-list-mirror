From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH v2] Windows: Fix intermittent failures of t7701
Date: Wed, 28 Jan 2009 10:52:26 +0100
Message-ID: <49802ADA.6030401@viscovery.net>
References: <497F076F.8060509@viscovery.net> <alpine.DEB.1.00.0901271740320.3586@pacific.mpi-cbg.de> <498008BA.2000201@viscovery.net> <7v3af3vnti.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 10:54:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS77v-0002L1-8g
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 10:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbZA1Jwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 04:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbZA1Jwn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 04:52:43 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62838 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbZA1Jwm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 04:52:42 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LS75u-00039J-I0; Wed, 28 Jan 2009 10:52:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2BBB56C4; Wed, 28 Jan 2009 10:52:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7v3af3vnti.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107517>

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

- add_packed_git() picks up a truncated whole second modification time
  from the pack file time stamp, which is then used for the loose objects,
  while the pack file retains its time stamp in fractional seconds;

- but the test case compared the pack file's rounded modification times
  to the loose objects' truncated modification times.

And half of the time the rounded modification time is not the same as its
truncated modification time.

The fix is that we replace perl by 'test-chmtime -v +0', which prints the
truncated whole-second mtime without modifying it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Junio C Hamano schrieb:
> Care to reroll with the simpler, dumber but clearer version?

OK. This time I use an intermediate file and dquotes around $t.

-- Hannes

 t/t7701-repack-unpack-unreachable.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 63a8225..5babdf2 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -50,12 +50,10 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '

 compare_mtimes ()
 {
-	perl -e 'my $reference = shift;
-		 foreach my $file (@ARGV) {
-			exit(1) unless(-f $file && -M $file == -M $reference);
-		 }
-		 exit(0);
-		' -- "$@"
+	read tref rest &&
+	while read t rest; do
+		test "$tref" = "$t" || break
+	done
 }

 test_expect_success '-A without -d option leaves unreachable objects packed' '
@@ -87,7 +85,9 @@ test_expect_success 'unpacked objects receive timestamp of pack file' '
 	tmppack=".git/objects/pack/tmp_pack" &&
 	ln "$packfile" "$tmppack" &&
 	git repack -A -l -d &&
-	compare_mtimes "$tmppack" "$fsha1path" "$csha1path" "$tsha1path"
+	test-chmtime -v +0 "$tmppack" "$fsha1path" "$csha1path" "$tsha1path" \
+		> mtimes &&
+	compare_mtimes < mtimes
 '

 test_done
-- 
1.6.1.1.1203.g5882
