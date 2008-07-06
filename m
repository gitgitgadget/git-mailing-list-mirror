From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH/rfc] git-svn.perl: workaround assertions in svn library
	1.5.0
Date: Sun, 6 Jul 2008 19:28:50 +0000
Message-ID: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 21:29:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFZvB-0007Ch-FL
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 21:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159AbYGFT2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755646AbYGFT2S
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 15:28:18 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:34831 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755485AbYGFT2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 15:28:17 -0400
Received: (qmail 32548 invoked by uid 1000); 6 Jul 2008 19:28:50 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87546>

With subversion 1.5.0 (C and perl libraries) the git-svn selftest
t9101-git-svn-props.sh fails at test 25 and 26.  The following commands
cause assertions in the svn library

 $ cd deeply
 $ git-svn propget svn:ignore .
 perl: /build/buildd/subversion-1.5.0dfsg1/subversion/libsvn_ra/ra_loader.c:674: svn_ra_get_dir: Assertion `*path != '/'' failed.
 Aborted

 $ git-svn propget svn:ignore ..
 perl: /build/buildd/subversion-1.5.0dfsg1/subversion/libsvn_subr/path.c:120: svn_path_join: Assertion `is_canonical(component, clen)' failed.

With this commit, git-svn makes sure the path doesn't start with a
slash, and is not a dot, working around these assertions.

The breakage was reported by Lucas Nussbaum through
 http://bugs.debian.org/489108

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-svn.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

I ran into this on Debian/unstable.  With svn 1.5.0 the selftest fails
without the patch, with svn 1.4.6 it succeeds with and without the
patch.  I'm not familar with the svn interfaces, not sure whether this
is a regression in subversion, or a bug in git-svn.


diff --git a/git-svn.perl b/git-svn.perl
index f789a6e..a366c89 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -643,6 +643,8 @@ sub canonicalize_path {
 	$path =~ s#/[^/]+/\.\.##g;
 	$path =~ s#/$##g;
 	$path =~ s#^\./## if $dot_slash_added;
+	$path =~ s#^/##;
+	$path =~ s#^\.$##;
 	return $path;
 }
 
-- 
1.5.6
