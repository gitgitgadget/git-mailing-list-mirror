From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] git-svn: add an option to skip the creation of empty directories
Date: Fri,  1 Apr 2011 12:26:00 +0200
Message-ID: <1301653560-10769-1-git-send-email-mhagger@alum.mit.edu>
References: <7vhbanywb4.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 12:46:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5brs-0005sD-C6
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 12:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580Ab1DAKqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 06:46:11 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:42713 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab1DAKqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 06:46:10 -0400
X-Greylist: delayed 1203 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Apr 2011 06:46:09 EDT
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1Q5bYJ-0006VN-2F; Fri, 01 Apr 2011 12:26:03 +0200
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <7vhbanywb4.fsf@alter.siamese.dyndns.org>
CC: Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170580>

"git svn mkdirs" (which creates empty directories in the current
working copy) can be very slow and is often unnecessary.  Provide a
config file option "svn-remote.<name>.automkdirs" that prevents empty
directories from being created automatically.  (They are still created
if "git svn mkdirs" is invoked explicitly.)

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
I hope I have done the attribution correctly.  The git-svn.perl file
change is by Junio and the doc and test changes are by me.

Regarding the name of the option: I prefer "automkdirs" to something
like "skipautomkdirs" because the latter is effectively the inverse of
doing something, leading to confusing double-negatives like "if (!
skipautomkdirs)".  But I am not adamant about this preference.

For completeness it might be nice to have corresponding command-line
options like --auto-mkdirs and --no-auto-mkdirs, but I doubt that it
is worth the extra effort.  If you want to create the directories when
automkdirs==false, you can simply run "git svn mkdirs".  It is more
inconvenient if you have automkdirs==true but occasionally want to
skip the creation of the directories, but this seems an uncommon
scenario.

 Documentation/git-svn.txt     |   10 ++++++++++
 git-svn.perl                  |   17 +++++++++++++++--
 t/t9146-git-svn-empty-dirs.sh |   17 +++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ea8fafd..f470fbf 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -343,6 +343,8 @@ Any other arguments are passed directly to 'git log'
 	Empty directories are automatically recreated when using
 	"git svn clone" and "git svn rebase", so "mkdirs" is intended
 	for use after commands like "git checkout" or "git reset".
+	(See the svn-remote.<name>.automkdirs config file option for
+	more information.)
 
 'commit-diff'::
 	Commits the diff of two tree-ish arguments from the
@@ -663,6 +665,14 @@ svn.pathnameencoding::
 	locales to avoid corrupted file names with non-ASCII characters.
 	Valid encodings are the ones supported by Perl's Encode module.
 
+svn-remote.<name>.automkdirs::
+	Normally, the "git svn clone" and "git svn rebase" commands
+	attempt to recreate empty directories that are in the
+	Subversion repository.  If this option is set to "false", then
+	empty directories will only be created if the "git svn mkdirs"
+	command is run explicitly.  If unset, 'git svn' assumes this
+	option to be "true".
+
 Since the noMetadata, rewriteRoot, rewriteUUID, useSvnsyncProps and useSvmProps
 options all affect the metadata generated and used by 'git svn'; they
 *must* be set in the configuration file before any history is imported
diff --git a/git-svn.perl b/git-svn.perl
index a5857c1..9a9b094 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -781,6 +781,15 @@ sub cmd_find_rev {
 	print "$result\n" if $result;
 }
 
+sub auto_create_empty_directories {
+	my ($gs) = @_;
+	my $var = eval { command_oneline('config', '--get', '--bool',
+					 "svn-remote.$gs->{repo_id}.automkdirs") };
+	# By default, create empty directories by consulting the unhandled log,
+	# but allow setting it to 'false' to skip it.
+	return !($var && $var eq 'false');
+}
+
 sub cmd_rebase {
 	command_noisy(qw/update-index --refresh/);
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
@@ -804,7 +813,9 @@ sub cmd_rebase {
 		$_fetch_all ? $gs->fetch_all : $gs->fetch;
 	}
 	command_noisy(rebase_cmd(), $gs->refname);
-	$gs->mkemptydirs;
+	if (auto_create_empty_directories($gs)) {
+		$gs->mkemptydirs;
+	}
 }
 
 sub cmd_show_ignore {
@@ -1242,7 +1253,9 @@ sub post_fetch_checkout {
 	command_noisy(qw/read-tree -m -u -v HEAD HEAD/);
 	print STDERR "Checked out HEAD:\n  ",
 	             $gs->full_url, " r", $gs->last_rev, "\n";
-	$gs->mkemptydirs($gs->last_rev);
+	if (auto_create_empty_directories($gs)) {
+		$gs->mkemptydirs($gs->last_rev);
+	}
 }
 
 sub complete_svn_url {
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 158c8e3..6d3130e 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -28,6 +28,23 @@ test_expect_success 'empty directories exist' '
 	)
 '
 
+test_expect_success 'option automkdirs set to false' '
+	(
+		git svn init "$svnrepo" cloned-no-mkdirs &&
+		cd cloned-no-mkdirs &&
+		git config svn-remote.svn.automkdirs false &&
+		git svn fetch &&
+		for i in a b c d d/e d/e/f "weird file name"
+		do
+			if test -d "$i"
+			then
+				echo >&2 "$i exists"
+				exit 1
+			fi
+		done
+	)
+'
+
 test_expect_success 'more emptiness' '
 	svn_cmd mkdir -m "bang bang"  "$svnrepo"/"! !"
 '
-- 
1.7.4.2
