From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/2] t5004: resurrect original empty tar archive test
Date: Thu, 09 May 2013 15:36:10 +0200
Message-ID: <518BA64A.5020302@lsrfire.ath.cx>
References: <518BA058.6050300@lsrfire.ath.cx> <518BA10B.2080003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	BJ Hargrave <bj@bjhargrave.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 09 15:36:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaR19-0005ED-2Q
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 15:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab3EINgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 09:36:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:51334 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab3EINgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 09:36:14 -0400
Received: from [192.168.2.105] (p4FFD9FB6.dip0.t-ipconnect.de [79.253.159.182])
	by india601.server4you.de (Postfix) with ESMTPSA id B73D84B9;
	Thu,  9 May 2013 15:36:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <518BA10B.2080003@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223732>

Add a test to verify the emptiness of an archive by extracting its
contents.  Don't run this test if the version of tar doesn't support
archives containing only a comment header, though.

The existing check 'tar archive of empty tree is empty' used to work
like that (minus the tar capability check) but was changed to depend
on the exact representation of empty tar files created by git archive
instead of on the behaviour of tar in order to avoid issues with
different tar versions.

The different approaches test different things: The existing one is
for empty trees, for which we know the exact expected output and thus
we can simply check it without extracting; the new one is for commits
with empty trees, whose archives include stamps and so the more
"natural" check by extraction is a better fit because it focuses on
the interesting aspect, namely the absence of any archive entries.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Not urgent.  By the way: A fix for the bsdtar issue worked around by
our 24676f02 (t5004: fix issue with empty archive test and bsdtar) has
been committed to the libarchive repo, but it's not in any released
version, yet.

 t/t5004-archive-corner-cases.sh   |  14 ++++++++++++++
 t/t5004/empty-with-pax-header.tar | Bin 0 -> 10240 bytes
 2 files changed, 14 insertions(+)
 create mode 100644 t/t5004/empty-with-pax-header.tar

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 8d1bbd3..f25f06b 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -27,6 +27,20 @@ check_dir() {
 	test_cmp expect actual
 }
 
+# bsdtar/libarchive versions before 3.1.3 consider a tar file with a
+# global pax header that is not followed by a file record as corrupt.
+if "$TAR" tf "$TEST_DIRECTORY"/t5004/empty-with-pax-header.tar >/dev/null 2>&1
+then
+	test_set_prereq HEADER_ONLY_TAR_OK
+fi
+
+test_expect_success HEADER_ONLY_TAR_OK 'tar archive of commit with empty tree' '
+	git archive --format=tar HEAD >empty-with-pax-header.tar &&
+	make_dir extract &&
+	"$TAR" xf empty-with-pax-header.tar -C extract &&
+	check_dir extract
+'
+
 test_expect_success 'tar archive of empty tree is empty' '
 	git archive --format=tar HEAD: >empty.tar &&
 	perl -e "print \"\\0\" x 10240" >10knuls.tar &&
diff --git a/t/t5004/empty-with-pax-header.tar b/t/t5004/empty-with-pax-header.tar
new file mode 100644
index 0000000000000000000000000000000000000000..da9e39e6cf49841254a2d75aabb9ef575f9fd805
GIT binary patch
literal 10240
zcmeIuF%H5Y6vlC8PvH>&fx_TfnwHW!v|?&aJib+jCU$V?VB-HRkMITZ-tSV~%dXFL
z)t9GKHE9&vmz>KvC!T$-&pwAnD6NckQtDT(j47<>wjX8v<Lx?C<2=%s^R!Nvn{WAh
zw`IBI<xiii-p4!)={y}{+a@P%2!(3ZA%xgSuTAZ&@lBAmw}p36CcpdXg%}P21Q0*~
t0R#|0009ILKmY**5I_I{1Q0*~0R#|0009ILKmY**5I_I{1Q7TWfd`KEC+GkG

literal 0
HcmV?d00001

-- 
1.8.2.1
