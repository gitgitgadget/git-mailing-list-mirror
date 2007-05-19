From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: don't minimize-url when doing an init that tracks multiple paths
Date: Sat, 19 May 2007 03:59:02 -0700
Message-ID: <20070519105902.GB22230@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 12:59:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpMeV-0005qN-3K
	for gcvg-git@gmane.org; Sat, 19 May 2007 12:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbXESK7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 06:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756744AbXESK7F
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 06:59:05 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59193 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756649AbXESK7E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 06:59:04 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2369A7DC0A4;
	Sat, 19 May 2007 03:59:02 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 19 May 2007 03:59:02 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47738>

I didn't have a chance to test the off-by-default minimize-url
stuff enough before, but it's quite broken for people passing
the --trunk/-T, --tags/-t, --branches/-b switches to "init" or
"clone" commands.

Additionally, follow-parent functionality seems broken when we're
not connected to the root of the repository.

Default behavior for "traditional" git-svn users who only track
one directory (without needing follow-parent) should be
reasonable, as those users started using things before
minimize-url functionality existed.

Behavior for users more used to the git-svnimport-like command
line will also benefit from a more-flexible command-line than
svnimport given the assumption they're working with
non-restrictive read permissions on the repository.

I hope to properly fix these bugs when I get a chance to in the
next week or so, but I would like to get this stopgap measure of
reverting to the old behavior as soon as possible.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6d0cdac..233f4f2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -485,6 +485,11 @@ sub cmd_multi_init {
 	unless (defined $_trunk || defined $_branches || defined $_tags) {
 		usage(1);
 	}
+
+	# there are currently some bugs that prevent multi-init/multi-fetch
+	# setups from working well without this.
+	$Git::SVN::_minimize_url = 1;
+
 	$_prefix = '' unless defined $_prefix;
 	if (defined $url) {
 		$url =~ s#/+$##;
-- 
Eric Wong
