From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] Add an (optional, since expensive) test for >2g clones
Date: Thu, 5 Mar 2009 17:05:09 +0100 (CET)
Message-ID: <96a26f3a883890b3e56c867e8183618784837d4d.1236268730u.git.johannes.schindelin@gmx.de>
References: <cover.1236268730u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 05 17:09:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfG62-0001lB-MP
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 17:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbZCEQFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 11:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbZCEQFP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 11:05:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:36437 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752977AbZCEQFM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 11:05:12 -0500
Received: (qmail invoked by alias); 05 Mar 2009 16:05:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp028) with SMTP; 05 Mar 2009 17:05:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UFRpVDU4ULT5Kcn3dannYttaZEEbpWWiZajBJZp
	XCqOmx2sDFccAb
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1236268730u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112313>

Define GIT_TEST_CLONE_2GB=t if you want the test not to be skipped.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5705-clone-2gb.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100755 t/t5705-clone-2gb.sh

diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
new file mode 100755
index 0000000..dd4a8ec
--- /dev/null
+++ b/t/t5705-clone-2gb.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='Test cloning a repository larger than 2 gigabyte'
+. ./test-lib.sh
+
+test -z "$GIT_TEST_CLONE_2GB" &&
+say "Skipping expensive 2GB clone test; enable it with GIT_TEST_CLONE_2GB=t" &&
+test_done &&
+exit
+
+test_expect_success 'setup' '
+
+	git config pack.compression 0 &&
+	git config pack.depth 0 &&
+	blobsize=$((20*1024*1024))
+	blobcount=$((2*1024*1024*1024/$blobsize+1))
+	i=1
+	(while test $i -le $blobcount
+	 do
+		printf "Generating blob $i/$blobcount\r" >&2 &&
+		printf "blob\nmark :$i\ndata $blobsize\n" &&
+		#test-genrandom $i $blobsize &&
+		printf "%-${blobsize}s" $i &&
+		echo "M 100644 :$i $i" >> commit
+		i=$(($i+1)) ||
+		echo $? > exit-status
+	 done &&
+	 echo "commit refs/heads/master" &&
+	 echo "author A U Thor <author@email.com> 123456789 +0000" &&
+	 echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
+	 echo "data 5" &&
+	 echo ">2gb" &&
+	 cat commit) |
+	git fast-import &&
+	test ! -f exit-status
+
+'
+
+test_expect_success 'clone' '
+
+	git clone --bare --no-hardlinks . clone
+
+'
+
+test_done
-- 
1.6.2.rc1.493.g27ad8
