From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH 4/5] Add git svn proplist.
Date: Mon, 15 Oct 2007 17:35:05 +0200
Message-ID: <1192462506-3783-4-git-send-email-tsuna@lrde.epita.fr>
References: <1192462506-3783-1-git-send-email-tsuna@lrde.epita.fr>
 <1192462506-3783-2-git-send-email-tsuna@lrde.epita.fr>
 <1192462506-3783-3-git-send-email-tsuna@lrde.epita.fr>
Cc: normalperson@yhbt.net, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 16:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhnYF-0006VL-Hm
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbXJPOhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbXJPOhc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:37:32 -0400
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:56258 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759136AbXJPOh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 10:37:28 -0400
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id 2CBDDB411D3; Mon, 15 Oct 2007 17:35:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.214.g6f43
In-Reply-To: <1192462506-3783-3-git-send-email-tsuna@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61178>

	* git-svn.perl (%cmd): Add the command `proplist'.
	(&cmd_proplist): New.
	* t/t9101-git-svn-props.sh: Test git svn proplist.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
 git-svn.perl             |   17 +++++++++++++++++
 t/t9101-git-svn-props.sh |   21 +++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e58ff38..466fdd3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -132,6 +132,9 @@ my %cmd = (
         'propget' => [ \&cmd_propget,
 		       'Print the value of a property on a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
+        'proplist' => [ \&cmd_proplist,
+		       'List all properties of a file or directory',
+		       { 'revision|r=i' => \$_revision } ],
 	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
 			{ 'revision|r=i' => \$_revision
 			} ],
@@ -583,6 +586,20 @@ sub cmd_propget {
 	print $props->{$prop} . "\n";
 }
 
+# cmd_proplist (PATH)
+# -------------------
+# Print the list of SVN properties for PATH.
+sub cmd_proplist {
+	my $path = shift;
+	$path = '.' if not defined $path;
+	my $props = get_svnprops($path);
+	print "Properties on '$path':\n";
+	foreach (sort keys %{$props})
+	{
+		print "  $_\n";
+	}
+}
+
 sub cmd_multi_init {
 	my $url = shift;
 	unless (defined $_trunk || defined $_branches || defined $_tags) {
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 61c8799..3c83127 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -193,4 +193,25 @@ test_expect_success 'test propget' "
 	git-svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
 	"
 
+cat >prop.expect <<\EOF
+Properties on '.':
+  svn:entry:committed-date
+  svn:entry:committed-rev
+  svn:entry:last-author
+  svn:entry:uuid
+  svn:ignore
+EOF
+cat >prop2.expect <<\EOF
+Properties on 'nested/directory/.keep':
+  svn:entry:committed-date
+  svn:entry:committed-rev
+  svn:entry:last-author
+  svn:entry:uuid
+EOF
+
+test_expect_success 'test proplist' "
+	git-svn proplist . | cmp - prop.expect &&
+	git-svn proplist nested/directory/.keep | cmp - prop2.expect
+	"
+
 test_done
-- 
1.5.3.4.214.g6f43
