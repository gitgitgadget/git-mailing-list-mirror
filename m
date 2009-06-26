From: Ulrich Dangel <uli@spamt.net>
Subject: [PATCH] Canonicalize svn urls to prevent libsvn assertion
Date: Fri, 26 Jun 2009 16:52:09 +0200
Message-ID: <1246027929-2792-1-git-send-email-uli@spamt.net>
Cc: Ulrich Dangel <uli@spamt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 16:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKCu3-0006n7-P8
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 16:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbZFZO7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 10:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbZFZO7f
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 10:59:35 -0400
Received: from mail.spamt.net ([78.46.151.67]:34864 "EHLO mail.spamt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbZFZO7e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 10:59:34 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2009 10:59:34 EDT
Received: from localhost (d91-128-181-41.cust.tele2.at [91.128.181.41])
	by mail.spamt.net (Postfix) with ESMTPSA id 98E346956B;
	Fri, 26 Jun 2009 16:52:30 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122303>

Cloning/initializing svn repositories with an uncanonicalize url does not
work as libsvn throws an assertion. This patch canonicalize svn uris for the
clone and init command from git-svn.

Signed-off-by: Ulrich Dangel <uli@spamt.net>
---
 git-svn.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3301797..5130a8c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -380,6 +380,7 @@ sub cmd_init {
 	}
 	my $url = shift or die "SVN repository location required ",
 	                       "as a command-line argument\n";
+	$url = canonicalize_url($url);
 	init_subdir(@_);
 	do_git_init_db();
 
@@ -741,6 +742,12 @@ sub canonicalize_path {
 	return $path;
 }
 
+sub canonicalize_url {
+	my ($url) = @_;
+	$url =~ s#^([^:]+://[^/]*/)(.*)$#$1 . canonicalize_path($2)#e;
+	return $url;
+}
+
 # get_svnprops(PATH)
 # ------------------
 # Helper for cmd_propget and cmd_proplist below.
@@ -810,7 +817,7 @@ sub cmd_multi_init {
 
 	$_prefix = '' unless defined $_prefix;
 	if (defined $url) {
-		$url =~ s#/+$##;
+		$url = canonicalize_url($url);    
 		init_subdir(@_);
 	}
 	do_git_init_db();
-- 
1.6.3.1
