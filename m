From: Michael Lutz <michi@icosahedron.de>
Subject: [PATCH] git-svn: add hook to allow modifying the subversion commit message
Date: Fri, 21 Oct 2011 22:25:08 +0200
Message-ID: <1319228708-9052-1-git-send-email-michi@icosahedron.de>
Cc: Eric Wong <normalperson@yhbt.net>,
	Michael Lutz <michi@icosahedron.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 22:33:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHLmP-0008UG-QH
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 22:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab1JUUdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 16:33:21 -0400
Received: from dude.icosahedron.de ([77.37.19.40]:50539 "EHLO
	mail.icosahedron.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab1JUUdU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 16:33:20 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Oct 2011 16:33:20 EDT
Received: from localhost.localdomain (p5B042764.dip.t-dialin.net [91.4.39.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.icosahedron.de (Postfix) with ESMTPSA id B91C1647E0;
	Fri, 21 Oct 2011 22:26:06 +0200 (CEST)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184084>

Sometimes modifying the commit message git-svn creates for a subversion
commit can be useful, for example if the original message contains meta
information not needed in the git clone or information from svn properties
should be stored visibly in the commit message.

This change adds a hook 'git-svn-msg' analogue to the 'commit-msg' hook.
Additionally to the commit message, the hook is passed the git-svn meta
data by an environment variable.

Signed-off-by: Michael Lutz <michi@icosahedron.de>
---
 Documentation/githooks.txt          |   19 +++++++++++++++++++
 git-svn.perl                        |   25 +++++++++++++++++++++++++
 templates/hooks--git-svn-msg.sample |   18 ++++++++++++++++++
 3 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100755 templates/hooks--git-svn-msg.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 28edefa..dd90c1a 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -45,6 +45,25 @@ the commit after inspecting the message file.
 The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.
 
+git-svn-msg
+~~~~~~~~~~~
+
+This hook is invoked by 'git svn' when creating a git commit
+from a subversion commit.  It takes a single parameter, the name
+of the file that holds the original subversion commit message.
+Exiting with non-zero status causes 'git svn' to abbort before
+creating the git commit. Additional, the environment variable
+`GIT_SVN_METADATA=:` is set to the string that would appear
+after the 'git-svn-id:' line.
+
+The hook is allowed to edit the message file in place, and can
+be used to normalize the message into some project standard
+format (if the project has one). It can also be used to refuse
+the commit after inspecting the message file.
+
+The default 'git-svn-msg' hook, when enabled, runs the
+'commit-msg' hook, if the latter is enabled.
+
 pre-applypatch
 ~~~~~~~~~~~~~~
 
diff --git a/git-svn.perl b/git-svn.perl
index b67fef0..030516c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3007,6 +3007,31 @@ sub do_git_commit {
 		require Encode;
 		Encode::from_to($log_entry->{log}, 'UTF-8', $enc);
 	}
+
+	# execute commit message hook if present
+	if (-x "$ENV{GIT_DIR}/hooks/git-svn-msg") {
+		print "Calling commit mesasage hook\n";
+
+		# write commit message to file
+		my $msg_file = "$ENV{GIT_DIR}/SVN_COMMIT_EDITMSG";
+		mkfile($msg_file);
+		open my $fh, '>', $msg_file or croak $!;
+		binmode $fh;
+		print $fh $log_entry->{log} or croak $!;
+		close $fh or croak $!;
+
+		$ENV{GIT_SVN_METADATA} = $log_entry->{metadata};
+		system("$ENV{GIT_DIR}/hooks/git-svn-msg", $msg_file);
+		die "git-svn-msg hook failed: $!\n" if $?;
+
+		# read commit message back
+		open $fh, '<', $msg_file or croak $!;
+		binmode $fh;
+		$log_entry->{log} = do { local $/; <$fh> };
+		close $fh or croak $!;
+		unlink $msg_file;
+	}
+
 	print $msg_fh $log_entry->{log} or croak $!;
 	restore_commit_header_env($old_env);
 	unless ($self->no_metadata) {
diff --git a/templates/hooks--git-svn-msg.sample b/templates/hooks--git-svn-msg.sample
new file mode 100755
index 0000000..6584fd8
--- /dev/null
+++ b/templates/hooks--git-svn-msg.sample
@@ -0,0 +1,18 @@
+#!/bin/sh
+#
+# An example hook script to check the commit log message taken by
+# git svn from a subversion commit.
+#
+# The hook should exit with non-zero status after issuing an
+# appropriate message if it wants to stop the commit.  The hook is
+# allowed to edit the commit message file.
+#
+# GIT_SVN_METADATA will contain the same info as printed after
+# the git-svn-id line.
+#
+# To enable this hook, rename this file to "git-svn-msg".
+
+. git-sh-setup
+test -x "$GIT_DIR/hooks/commit-msg" &&
+	exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
+:
-- 
1.7.5.1
