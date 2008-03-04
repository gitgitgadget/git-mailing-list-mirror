From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] Add test illustrating issues with sha1_file_name() and
 switching repos
Date: Tue, 04 Mar 2008 04:04:16 +0100
Message-ID: <200803040404.17133.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <alpine.LNX.1.00.0803031318000.19665@iabervon.org>
 <200803040402.57993.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>,
	Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 04:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNSc-0004bh-UN
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbYCDDEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbYCDDEW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:04:22 -0500
Received: from smtp.getmail.no ([84.208.20.33]:40885 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925AbYCDDEV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:04:21 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JX600L07R78C000@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 04 Mar 2008 04:04:20 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX6008DBR75LO40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 04 Mar 2008 04:04:17 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX600FDBR75MSA0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 04 Mar 2008 04:04:17 +0100 (CET)
In-reply-to: <200803040402.57993.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76020>

This test fails with the current iteration of builtin-clone.

After builtin-clone.c have finished processing the "--reference" option,
it switches (i.e. calls set_git_dir()) to the cloned repo. However, when
updating refs in the cloned repo, git is unable to find the (loose) objects
they point at due to the underlying plumbing generating incorrect filenames
for these loose objects (referring to non-existing files in the
"--reference" repo instead of existing files in the cloned repo).

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t5700-clone-reference.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index d318780..40826ac 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -118,4 +118,25 @@ test_expect_success 'cloning with reference being subset of source (-l -s)' \
 
 cd "$base_dir"
 
+test_expect_success 'preparing alternate repository #1' \
+'test_create_repo F && cd F &&
+echo first > file1 &&
+git add file1 &&
+git commit -m initial'
+
+cd "$base_dir"
+
+test_expect_success 'cloning alternate repo #2 and adding changes to repo #1' \
+'git clone F G && cd F &&
+echo second > file2 &&
+git add file2 &&
+git commit -m addition'
+
+cd "$base_dir"
+
+test_expect_failure 'cloning alternate repo #1, using #2 as reference' \
+'git clone --reference G F H'
+
+cd "$base_dir"
+
 test_done
-- 
1.5.4.3.328.gcaed


