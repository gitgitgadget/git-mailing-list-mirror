From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: add a note about the NO_MMAP setting on IRIX and IRIX64
Date: Thu,  8 Oct 2009 19:09:37 -0500
Message-ID: <wTau-ugyVF7kG6Pxm7DRuWdrZABot_lbCcrG1e9aKIiNkU3X9L4ELEaLmN_rFVebheOs8fQEyx028yJUR9W-0w@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 09 02:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw35Q-0006F6-QR
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 02:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbZJIAKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 20:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbZJIAKk
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 20:10:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34248 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbZJIAKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 20:10:40 -0400
Received: by mail.nrlssc.navy.mil id n9909pti025631; Thu, 8 Oct 2009 19:09:51 -0500
X-OriginalArrivalTime: 09 Oct 2009 00:09:51.0270 (UTC) FILETIME=[D227A460:01CA4874]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129724>

From: Brandon Casey <drafnel@gmail.com>

When git is compiled with the MIPSpro 7.4.4m compiler, and NO_PTHREADS is
set, and NO_MMAP is _not_ set, then git segfaults when trying to access the
first entry in a reflog.  If NO_PTHREADS is not set (which implies that the
pthread library is linked in), or NO_MMAP _is_ set, then the segfault is
not encountered.  The conservative choise has been made to set NO_MMAP in
the Makefile to avoid this flaw.  The GNU C compiler does not produce this
behavior.

The segfault happens in refs.c:read_ref_at().  The mmap succeeds, and the
loop is executed properly until rec is rewound into the first line (reflog
entry) of the file.  The segfault is caught by test 28 of
t1400-update-ref.sh which fails when 'git rev-parse --verify "master@{May 25
2005}"' is called.

So, add a comment in the Makefile to describe why NO_MMAP is set and as a
hint to those who may be interested in unsetting it.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index dd3d520..a340fb1 100644
--- a/Makefile
+++ b/Makefile
@@ -841,6 +841,12 @@ ifeq ($(uname_S),IRIX)
 	NO_MEMMEM = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_MKDTEMP = YesPlease
+	# When compiled with the MIPSpro 7.4.4m compiler, and without pthreads
+	# (i.e. NO_PTHREADS is set), and _with_ MMAP (i.e. NO_MMAP is not set),
+	# git dies with a segmentation fault when trying to access the first
+	# entry of a reflog.  The conservative choice is made to always set
+	# NO_MMAP.  If you suspect that your compiler is not affected by this
+	# issue, comment out the NO_MMAP statement.
 	NO_MMAP = YesPlease
 	NO_EXTERNAL_GREP = UnfortunatelyYes
 	SNPRINTF_RETURNS_BOGUS = YesPlease
@@ -854,6 +860,12 @@ ifeq ($(uname_S),IRIX64)
 	NO_MEMMEM = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_MKDTEMP = YesPlease
+	# When compiled with the MIPSpro 7.4.4m compiler, and without pthreads
+	# (i.e. NO_PTHREADS is set), and _with_ MMAP (i.e. NO_MMAP is not set),
+	# git dies with a segmentation fault when trying to access the first
+	# entry of a reflog.  The conservative choice is made to always set
+	# NO_MMAP.  If you suspect that your compiler is not affected by this
+	# issue, comment out the NO_MMAP statement.
 	NO_MMAP = YesPlease
 	NO_EXTERNAL_GREP = UnfortunatelyYes
 	SNPRINTF_RETURNS_BOGUS = YesPlease
-- 
1.6.5.rc2.17.gdbc1b
