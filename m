From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/2] Add an (optional, since expensive) test for >2gb
 clones
Date: Fri, 6 Mar 2009 10:48:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903061048220.10279@pacific.mpi-cbg.de>
References: <cover.1236268730u.git.johannes.schindelin@gmx.de> <96a26f3a883890b3e56c867e8183618784837d4d.1236268730u.git.johannes.schindelin@gmx.de> <7vfxhry3da.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 10:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfWfn-0003hx-11
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 10:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbZCFJr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 04:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbZCFJr1
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 04:47:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:36173 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751040AbZCFJr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 04:47:26 -0500
Received: (qmail invoked by alias); 06 Mar 2009 09:47:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 06 Mar 2009 10:47:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7W9wkkYK7c+vSKGLFhxCq9iubhexG9lppoAwiqm
	WAW7Up4pNkj3Cg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vfxhry3da.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112412>


Define GIT_TEST_CLONE_2GB=t if you want the test not to be skipped.

The test works by constructing a repository larger than 2gb, and then
cloning it.

The repository is forced larger than 2gb by setting compression and
delta depth to zero, and then adding just enough unique objects of
a given size.

The objects consist of a running decimal number in ASCII, padded by
spaces.  Should that break in the future, e.g. when pack v4 becomes
default, there is a commented-out call to test-genrandom which can be
substituted, but that uses more cycles than the current method.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Changes since v1: fixed && chain, better commit message.

 t/t5705-clone-2gb.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100755 t/t5705-clone-2gb.sh

diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
new file mode 100755
index 0000000..9f52154
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
+	blobsize=$((20*1024*1024)) &&
+	blobcount=$((2*1024*1024*1024/$blobsize+1)) &&
+	i=1 &&
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
1.6.2.240.g23c7
