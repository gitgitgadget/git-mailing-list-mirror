From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add NO_CROSS_DIRECTORY_HARDLINKS support to the Makefile
Date: Mon, 11 May 2009 13:02:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905111256580.4973@intel-tinevez-2-302>
References: <loom.20090511T101424-212@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Cedric Staniewski <cedric@gmx.ca>
X-From: git-owner@vger.kernel.org Mon May 11 13:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3THB-0005YO-J8
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 13:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbZEKLCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 07:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZEKLCU
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 07:02:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:33644 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751406AbZEKLCU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 07:02:20 -0400
Received: (qmail invoked by alias); 11 May 2009 11:02:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 11 May 2009 13:02:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180u7sMFok0LwxOJapWM1m9VY11eKmyZVasoa9CXX
	UcmaP5bts3Ny6n
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <loom.20090511T101424-212@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118790>


When the installed programs are tar'ed up and installed on a system where
bin/ and libexec/git-core/ live on different file systems, we do not want
libexec/git-core/git-* to be hardlinks to bin/git.

Noticed by Cedric Staniewski.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 11 May 2009, Cedric Staniewski wrote:

	> git commit 6a0861 [1] made bin/git the target of the builtins 
	> hard links which results in 'cross-directory' hard links. While the 
	> Makefile always works fine for the local installation via 'make 
	> install', these links can raise trouble when installing git via
	> package manager.

	I do not understand how this commit could be responsible, but here 
	is an attempt to fix things.

 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 6e21643..b00e22d 100644
--- a/Makefile
+++ b/Makefile
@@ -175,6 +175,9 @@ all::
 # Define OBJECT_CREATION_USES_RENAMES if your operating systems has problems
 # when hardlinking a file to another name and unlinking the original file right
 # away (some NTFS drivers seem to zero the contents in that scenario).
+#
+# Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
+# programs as a tar, where bin/ and libexec/ might be on different file systems.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1549,6 +1552,7 @@ endif
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	{ $(RM) "$$execdir/git-add$X" && \
+		test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
 		ln "$$bindir/git$X" "$$execdir/git-add$X" 2>/dev/null || \
 		cp "$$bindir/git$X" "$$execdir/git-add$X"; } && \
 	{ for p in $(filter-out git-add$X,$(BUILT_INS)); do \
-- 
1.6.3.49.g4d15.dirty
