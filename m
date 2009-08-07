From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/1] git-svn: ignore leading blank lines in svn:ignore
Date: Fri,  7 Aug 2009 21:21:21 +0200
Message-ID: <e6857eacc53d862018138bd8d9e1ab778e8f5725.1249672562.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 21:39:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZVID-0001TY-D1
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 21:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173AbZHGTjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbZHGTjt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 15:39:49 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:56976 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbZHGTjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 15:39:49 -0400
X-Greylist: delayed 1100 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2009 15:39:48 EDT
Received: from michael.berlin.jpk.com ([192.168.100.152] helo=localhost.localdomain)
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1MZV0G-0006Zw-DQ; Fri, 07 Aug 2009 21:21:24 +0200
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125213>

Subversion ignores all blank lines in svn:ignore properties.  The old
git-svn code ignored blank lines everywhere except for the first line
of the svn:ignore property.  This patch makes the "git svn
show-ignore" and "git svn create-ignore" commands ignore leading blank
lines, too.

Also include leading blank lines in the test suite.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-svn.perl             |    2 ++
 t/t9101-git-svn-props.sh |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d075810..f1cc849 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -764,6 +764,7 @@ sub cmd_show_ignore {
 		print STDOUT "\n# $path\n";
 		my $s = $props->{'svn:ignore'} or return;
 		$s =~ s/[\r\n]+/\n/g;
+		$s =~ s/^\n+//;
 		chomp $s;
 		$s =~ s#^#$path#gm;
 		print STDOUT "$s\n";
@@ -801,6 +802,7 @@ sub cmd_create_ignore {
 		open(GITIGNORE, '>', $ignore)
 		  or fatal("Failed to open `$ignore' for writing: $!");
 		$s =~ s/[\r\n]+/\n/g;
+		$s =~ s/^\n+//;
 		chomp $s;
 		# Prefix all patterns so that the ignore doesn't apply
 		# to sub-directories.
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 9da4178..929499e 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -142,7 +142,9 @@ test_expect_success 'test show-ignore' "
 	touch deeply/nested/directory/.keep &&
 	svn_cmd add deeply &&
 	svn_cmd up &&
-	svn_cmd propset -R svn:ignore 'no-such-file*' .
+	svn_cmd propset -R svn:ignore '
+no-such-file*
+' .
 	svn_cmd commit -m 'propset svn:ignore'
 	cd .. &&
 	git svn show-ignore > show-ignore.got &&
@@ -171,6 +173,7 @@ test_expect_success 'test create-ignore' "
 	"
 
 cat >prop.expect <<\EOF
+
 no-such-file*
 
 EOF
-- 
1.6.4
