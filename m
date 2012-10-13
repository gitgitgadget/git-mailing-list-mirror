From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 2/2] git-cvsimport: allow local timezone for commits
Date: Fri, 12 Oct 2012 23:11:55 -0500
Message-ID: <db5c9b72e08ed9d5522f38098d68126e5d3c7e5a.1350100320.git.chris@rorvick.com>
References: <cover.1350100320.git.chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 06:12:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMt5N-00031t-Bk
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 06:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755Ab2JMEMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 00:12:10 -0400
Received: from [38.98.186.242] ([38.98.186.242]:39398 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1750839Ab2JMEL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 00:11:56 -0400
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id 0A6BB2B096E; Fri, 12 Oct 2012 23:11:55 -0500 (CDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1350100320.git.chris@rorvick.com>
In-Reply-To: <cover.1350100320.git.chris@rorvick.com>
References: <cover.1350100320.git.chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207570>

CVS patches are imported with the timezone offset of +0000 (UTC).
Allow timezone offsets to be calculated from the the local timezone by
adding -l to the command line or specifying cvsimport.l in the config.

This could be made the default behavior, as setting TZ=UTC in the
environment before doing the import is equivalent to the current
behavior.  But since a new default may be an unwelcome surprise to
some, make this new behavior available as an option.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 Documentation/git-cvsimport.txt |   13 ++++++++++---
 git-cvsimport.perl              |    9 +++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 6695ab3..9059ad1 100644
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
@@ -89,6 +89,13 @@ the old cvs2git tool.
 	to avoid noisy changesets. Highly recommended, but off by default
 	to preserve compatibility with early imported trees.
 
+-l::
+	Use the local timezone for computing the timezone offset of commit
+	timestamps instead of the default of +0000 (UTC).  The `TZ`
+	environment variable can be used to override the default local
+	timezone, possibly useful if you are importing from a non-local
+	repository.
+
 -u::
 	Convert underscores in tag and branch names to dots.
 
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 2f5da9e..927d75c 100755
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
-- 
1.7.1
