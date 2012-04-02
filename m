From: Roman Kagan <rkagan@mail.ru>
Subject: [PATCH 2/3] git-svn: ignore SIGPIPE
Date: Mon, 2 Apr 2012 17:52:34 +0400
Message-ID: <b5b0657dbf648eccab746b5e448aacbc8dc83c8b.1335198921.git.rkagan@mail.ru>
References: <cover.1335198921.git.rkagan@mail.ru>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:39:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMMIX-0005T2-55
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab2DWQjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 12:39:13 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:32904 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514Ab2DWQjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 12:39:12 -0400
Received: from localhost ([10.30.3.95])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id q3NGcxve022693;
	Mon, 23 Apr 2012 20:39:00 +0400 (MSK)
In-Reply-To: <cover.1335198921.git.rkagan@mail.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196143>

In HTTP with keep-alive it's not uncommon for the client to notice that
the server decided to stop maintaining the current connection only when
sending a new request.  This naturally results in -EPIPE and possibly
SIGPIPE.

The subversion library itself makes no provision for SIGPIPE.  Some
combinations of the underlying libraries do (typically SIG_IGN-ing it),
some don't.

Presumably for that reason all subversion commands set SIGPIPE to
SIG_IGN early in their main()-s.

So should we.

This, together with the previous patch, fixes the notorious "git-svn
died of signal 13" problem (see e.g.
http://thread.gmane.org/gmane.comp.version-control.git/134936).

Signed-off-by: Roman Kagan <rkagan@mail.ru>
---
 git-svn.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 570504c..aa14564 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -36,6 +36,11 @@ $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT
 
 sub fatal (@) { print STDERR "@_\n"; exit 1 }
+
+# All SVN commands do it.  Otherwise we may die on SIGPIPE when the remote
+# repository decides to close the connection which we expect to be kept alive.
+$SIG{PIPE} = 'IGNORE';
+
 sub _req_svn {
 	require SVN::Core; # use()-ing this causes segfaults for me... *shrug*
 	require SVN::Ra;
-- 
1.7.7.6
