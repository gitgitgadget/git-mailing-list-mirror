From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH] git-cvsimport: support local timezone
Date: Thu, 11 Oct 2012 15:48:17 -0500
Message-ID: <1349988497-6158-1-git-send-email-chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 22:54:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMPmE-0000Kq-8W
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 22:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759345Ab2JKUy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 16:54:29 -0400
Received: from [38.98.186.242] ([38.98.186.242]:3741 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1759332Ab2JKUy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 16:54:28 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2012 16:54:27 EDT
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id 177BE2B096D; Thu, 11 Oct 2012 15:48:17 -0500 (CDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207514>

CVS patches are unconditionally imported with a UTC timezone.  Allow
the local timezone by adding -l to the command line or specifying
cvsimport.l in the config.

This could be made the default behavior, as setting TZ=UTC in the
environment before doing the import is equivalent to the current
behavior.  But since a new default may be an unwelcome surprise to
some, make this new behavior available os an option.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---

I have tested this with various TZ values (including "UTC") and confirmed
that the <fuzz> + 5min timeout is observed correctly in each case.

Chris Rorvick

 Documentation/git-cvsimport.txt |   11 ++++++++---
 git-cvsimport.perl              |   13 +++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 6695ab3..41cd289 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -11,9 +11,9 @@ SYNOPSIS
 [verse]
 'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
 	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
-	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
-	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
-	      [-r <remote>] [-R] [<CVS_module>]
+	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-l] [-u]
+	      [-s <subst>] [-a] [-m] [-M <regex>] [-S <regex>]
+	      [-L <commitlimit>] [-r <remote>] [-R] [<CVS_module>]
 
 
 DESCRIPTION
@@ -89,6 +89,11 @@ the old cvs2git tool.
 	to avoid noisy changesets. Highly recommended, but off by default
 	to preserve compatibility with early imported trees.
 
+-l::
+	Apply the local timezone to timestamps.  The `TZ` environment
+	variable can be used to override the default, possibly useful
+	if you are importing a non-local repository.
+
 -u::
 	Convert underscores in tag and branch names to dots.
 
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8032f23..927d75c 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -28,9 +28,8 @@ use POSIX qw(strftime dup2 ENOENT);
 use IPC::Open2;
 
 $SIG{'PIPE'}="IGNORE";
-$ENV{'TZ'}="UTC";
 
-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
+our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_l,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
 my (%conv_author_name, %conv_author_email);
 
 sub usage(;$) {
@@ -40,7 +39,7 @@ sub usage(;$) {
 Usage: git cvsimport     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
-       [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
+       [-l] [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
        [-r remote] [-R] [CVS_module]
 END
 	exit(1);
@@ -128,7 +127,7 @@ sub read_repo_config {
 	}
 }
 
-my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:R";
+my $opts = "haivmkulo:d:p:r:C:z:s:M:P:A:S:L:R";
 read_repo_config($opts);
 Getopt::Long::Configure( 'no_ignore_case', 'bundling' );
 
@@ -138,6 +137,8 @@ GetOptions( map { s/:/=s/; /M/ ? "$_\@" : $_ } split( /(?!:)/, $opts ) )
     or usage();
 usage if $opt_h;
 
+$ENV{'TZ'}="UTC" unless $opt_l;
+
 if (@ARGV == 0) {
 		chomp(my $module = `git config --get cvsimport.module`);
 		push(@ARGV, $module) if $? == 0;
@@ -582,7 +583,7 @@ sub pdate($) {
 	m#(\d{2,4})/(\d\d)/(\d\d)\s(\d\d):(\d\d)(?::(\d\d))?#
 		or die "Unparseable date: $d\n";
 	my $y=$1; $y-=1900 if $y>1900;
-	return timegm($6||0,$5,$4,$3,$2-1,$y);
+	return timelocal($6||0,$5,$4,$3,$2-1,$y);
 }
 
 sub pmode($) {
@@ -844,7 +845,7 @@ sub commit {
 		}
 	}
 
-	my $commit_date = strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date));
+	my $commit_date = strftime("%z %Y-%m-%d %H:%M:%S",localtime($date));
 	$ENV{GIT_AUTHOR_NAME} = $author_name;
 	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
 	$ENV{GIT_AUTHOR_DATE} = $commit_date;
-- 
1.7.1
