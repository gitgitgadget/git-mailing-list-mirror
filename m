From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix symlink-to-file changes when using command-line svn 1.4.0
Date: Tue, 24 Oct 2006 02:50:37 -0700
Message-ID: <20061024095037.GA15936@soma>
References: <20061018085948.GA27357@cepheus.pub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 11:50:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcIvj-0006rB-Ew
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 11:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWJXJuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 05:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWJXJuk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 05:50:40 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59854 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030261AbWJXJuj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 05:50:39 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B80EF7DC09D;
	Tue, 24 Oct 2006 02:50:37 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 24 Oct 2006 02:50:37 -0700
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20061018085948.GA27357@cepheus.pub>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29956>

I incorrectly thought this was hopelessly broken in svn 1.4.0,
but now it's just broken in that the old method didn't work.  It
looks like svn propdel and svn propset must be used now and the
(imho) more obvious svn rm --force && svn add no longer works.

make -C t full-svn-test should now work

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 54d2356..37ecc51 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1501,10 +1501,13 @@ sub svn_checkout_tree {
 			apply_mod_line_blob($m);
 			svn_check_prop_executable($m);
 		} elsif ($m->{chg} eq 'T') {
-			sys(qw(svn rm --force),$m->{file_b});
-			apply_mod_line_blob($m);
-			sys(qw(svn add), $m->{file_b});
 			svn_check_prop_executable($m);
+			apply_mod_line_blob($m);
+			if ($m->{mode_a} =~ /^120/ && $m->{mode_b} !~ /^120/) {
+				sys(qw(svn propdel svn:special), $m->{file_b});
+			} else {
+				sys(qw(svn propset svn:special *),$m->{file_b});
+			}
 		} elsif ($m->{chg} eq 'A') {
 			svn_ensure_parent_path( $m->{file_b} );
 			apply_mod_line_blob($m);
-- 
1.4.3.2.g125940
