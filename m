From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Makefile: add a knob to turn off hardlinks within same
 directory
Date: Wed, 12 Oct 2011 03:38:42 -0500
Message-ID: <20111012083842.GA21969@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bastian Blank <waldi@debian.org>, Cedric Staniewski <cedric@gmx.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 10:39:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDuL5-0006vB-Pt
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 10:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016Ab1JLIiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 04:38:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33797 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab1JLIix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 04:38:53 -0400
Received: by iaek3 with SMTP id k3so569889iae.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=itEl/CTtnt2BHQRwl1RcxJA+Gpi9iuK0IojPoiCRGtE=;
        b=qzW7jyq1Du8ZI/DS+BgtGCdsSkQs1PEeaptqqXN/f4t8ZN2kCf5gniS6Ha8LQuFeg5
         YxJNImy1It7+uRo4DBPuwaaleb3PkyLm5WP6WNR4JdSIURwwp9XjGCHyVe2xFXN4jRZT
         7PDtbLCQkpUpIP0oVLDCMID2btetdiqiU1fQ0=
Received: by 10.42.145.7 with SMTP id d7mr32806125icv.14.1318408733246;
        Wed, 12 Oct 2011 01:38:53 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l28sm3819377ibc.3.2011.10.12.01.38.51
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 01:38:52 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183361>

The git builtins in $(gitexecdir) are implemented as hard links to a
single git binary by default, so even the overhead of symlink
resolution is not needed to run them.  However, the trick can be
harmful, in two cases:

 - on Windows, some tools to estimate directory size hugely
   overestimate the size of git (each hardlink counts as taking up the
   same amount of space as git.exe)

 - various filesystems have limits on the number of hardlinks that
   can be made to a particular file --- Linux's LINK_MAX is 127,
   _POSIX_LINK_MAX is 8, and btrfs has a limit of 4096 /
   ($len_filename + 8) or so links to a given inode in a single
   directory.

Normally that second case is not a problem (when ln fails, "make
install" falls back to "ln -s"), but if git is tar'ed up on one
filesystem and then extracted on a more limited one, it can result in
"Too many links" errors.

Nowadays people are encouraged to (and typically do) run builtins
using the "git" command name directly rather than those dashed forms
in scripts, making the use of hardlinks for the dashed forms a
somewhat pointless optimization.  Introduce a new knob to allow people
to turn it off with a simple "make install NO_HARDLINKS=YesPlease".

Typically someone using this setting would want to set
NO_CROSS_DIRECTORY_HARDLINKS, too, but that is not enforced, so you
can make $(bindir)/git and $(gitexecdir)/git into hardlinks to the
same inode and still make sure your tarball avoids the btrfs limits if
you want.

Requested-by: Bastian Blank <waldi@debian.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

See <http://bugs.debian.org/642603> for context.  Sane?

 Makefile |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 9afdcf2a..ab64ff4c 100644
--- a/Makefile
+++ b/Makefile
@@ -226,6 +226,10 @@ all::
 # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
 # programs as a tar, where bin/ and libexec/ might be on different file systems.
 #
+# Define NO_HARDLINKS if you plan to distribute the installed programs as a tar
+# that might be extracted on a filesystem like btrfs that does not cope well
+# with many links to one inode in one directory.
+#
 # Define USE_NED_ALLOCATOR if you want to replace the platforms default
 # memory allocators with the nedmalloc allocator written by Niall Douglas.
 #
@@ -2326,12 +2330,14 @@ endif
 	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
 		$(RM) "$$bindir/$$p" && \
+		test -z "$(NO_HARDLINKS)" && \
 		ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
 		ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
 		cp "$$bindir/git$X" "$$bindir/$$p" || exit; \
 	done && \
 	for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \
+		test -z "$(NO_HARDLINKS)" && \
 		ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
@@ -2339,6 +2345,7 @@ endif
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
 	for p in $$remote_curl_aliases; do \
 		$(RM) "$$execdir/$$p" && \
+		test -z "$(NO_HARDLINKS)" && \
 		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
-- 
1.7.7
