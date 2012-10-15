From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2] git-cvsimport: allow author-specific timezones
Date: Sun, 14 Oct 2012 21:39:29 -0500
Message-ID: <1350268769-15895-1-git-send-email-chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 04:39:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNaak-00019T-2y
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 04:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab2JOCjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 22:39:31 -0400
Received: from [38.98.186.242] ([38.98.186.242]:3580 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1753619Ab2JOCja (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 22:39:30 -0400
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id 9D1D62B096D; Sun, 14 Oct 2012 21:39:29 -0500 (CDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207687>

CVS patchsets are imported with timestamps having an offset of +0000
(UTC).  The cvs-authors file is already used to translate the CVS
username to full name and email in the corresponding commit.  Extend
this file to support an optional timezone for calculating a user-
specific timestamp offset.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---

This supersedes the patches submitted for using the local timezone in
commits.

(sorry for the noise, I messed up sending the patch previously)

 Documentation/git-cvsimport.txt    |   5 +-
 git-cvsimport.perl                 |  22 ++-
 t/t9604-cvsimport-timestamps.sh    |  92 +++++++++++++
 t/t9604/cvsroot/.gitattributes     |   1 +
 t/t9604/cvsroot/CVSROOT/.gitignore |   2 +
 t/t9604/cvsroot/module/a,v         | 265 +++++++++++++++++++++++++++++++++++++
 6 files changed, 381 insertions(+), 6 deletions(-)
 create mode 100755 t/t9604-cvsimport-timestamps.sh
 create mode 100644 t/t9604/cvsroot/.gitattributes
 create mode 100644 t/t9604/cvsroot/CVSROOT/.gitignore
 create mode 100644 t/t9604/cvsroot/module/a,v

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 6695ab3..35dc636 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -141,13 +141,14 @@ This option can be used several times to provide several detection regexes.
 +
 ---------
 	exon=Andreas Ericsson <ae@op5.se>
-	spawn=Simon Pawn <spawn@frog-pond.org>
+	spawn=Simon Pawn <spawn@frog-pond.org> America/Chicago
 
 ---------
 +
 'git cvsimport' will make it appear as those authors had
 their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
-all along.
+all along.  If a timezone is specified, GIT_AUTHOR_DATE will
+have the corresponding offset applied.
 +
 For convenience, this data is saved to `$GIT_DIR/cvs-authors`
 each time the '-A' option is provided and read from that same
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8032f23..ceb119d 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -31,7 +31,7 @@ $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
 our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
-my (%conv_author_name, %conv_author_email);
+my (%conv_author_name, %conv_author_email, %conv_author_tz);
 
 sub usage(;$) {
 	my $msg = shift;
@@ -59,6 +59,14 @@ sub read_author_info($) {
 			$conv_author_name{$user} = $2;
 			$conv_author_email{$user} = $3;
 		}
+		# or with an optional timezone:
+		#   spawn=Simon Pawn <spawn@frog-pond.org> America/Chicago
+		elsif (m/^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*(\S+?)\s*$/) {
+			$user = $1;
+			$conv_author_name{$user} = $2;
+			$conv_author_email{$user} = $3;
+			$conv_author_tz{$user} = $4;
+		}
 		# However, we also read from CVSROOT/users format
 		# to ease migration.
 		elsif (/^(\w+):(['"]?)(.+?)\2\s*$/) {
@@ -84,7 +92,9 @@ sub write_author_info($) {
 	  die("Failed to open $file for writing: $!");
 
 	foreach (keys %conv_author_name) {
-		print $f "$_=$conv_author_name{$_} <$conv_author_email{$_}>\n";
+		print $f "$_=$conv_author_name{$_} <$conv_author_email{$_}>";
+		print $f " $conv_author_tz{$_}" if ($conv_author_tz{$_});
+		print $f "\n";
 	}
 	close ($f);
 }
@@ -795,7 +805,7 @@ sub write_tree () {
 	return $tree;
 }
 
-my ($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
+my ($patchset,$date,$author_name,$author_email,$author_tz,$branch,$ancestor,$tag,$logmsg);
 my (@old,@new,@skipped,%ignorebranch,@commit_revisions);
 
 # commits that cvsps cannot place anywhere...
@@ -844,7 +854,9 @@ sub commit {
 		}
 	}
 
-	my $commit_date = strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date));
+	$ENV{'TZ'}=$author_tz;
+	my $commit_date = strftime("%s %z", localtime($date));
+	$ENV{'TZ'}="UTC";
 	$ENV{GIT_AUTHOR_NAME} = $author_name;
 	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
 	$ENV{GIT_AUTHOR_DATE} = $commit_date;
@@ -945,12 +957,14 @@ while (<CVS>) {
 		}
 		$state=3;
 	} elsif ($state == 3 and s/^Author:\s+//) {
+		$author_tz = "UTC";
 		s/\s+$//;
 		if (/^(.*?)\s+<(.*)>/) {
 		    ($author_name, $author_email) = ($1, $2);
 		} elsif ($conv_author_name{$_}) {
 			$author_name = $conv_author_name{$_};
 			$author_email = $conv_author_email{$_};
+			$author_tz = $conv_author_tz{$_} if ($conv_author_tz{$_});
 		} else {
 		    $author_name = $author_email = $_;
 		}
diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
new file mode 100755
index 0000000..17d456c
--- /dev/null
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='git cvsimport timestamps'
+. ./lib-cvs.sh
+
+setup_cvs_test_repository t9604
+
+test_expect_success 'check timestamps are UTC (TZ=America/Chicago)' '
+
+	TZ=America/Chicago git cvsimport -p"-x" -C module-1 module &&
+	git cvsimport -p"-x" -C module-1 module &&
+	(cd module-1 &&
+		git log --pretty="format:%s %ai" -- >../actual-1 &&
+		echo "" >>../actual-1
+	) &&
+	echo "Rev 16 2011-11-06 07:00:01 +0000
+Rev 15 2011-11-06 06:59:59 +0000
+Rev 14 2011-03-13 08:00:01 +0000
+Rev 13 2011-03-13 07:59:59 +0000
+Rev 12 2010-12-01 00:00:00 +0000
+Rev 11 2010-11-01 00:00:00 +0000
+Rev 10 2010-10-01 00:00:00 +0000
+Rev  9 2010-09-01 00:00:00 +0000
+Rev  8 2010-08-01 00:00:00 +0000
+Rev  7 2010-07-01 00:00:00 +0000
+Rev  6 2010-06-01 00:00:00 +0000
+Rev  5 2010-05-01 00:00:00 +0000
+Rev  4 2010-04-01 00:00:00 +0000
+Rev  3 2010-03-01 00:00:00 +0000
+Rev  2 2010-02-01 00:00:00 +0000
+Rev  1 2010-01-01 00:00:00 +0000" >expect-1 &&
+	test_cmp actual-1 expect-1
+'
+
+test_expect_success 'check timestamps are UTC (TZ=Australia/Sydney)' '
+
+	TZ=America/Chicago git cvsimport -p"-x" -C module-2 module &&
+	git cvsimport -p"-x" -C module-2 module &&
+	(cd module-2 &&
+		git log --pretty="format:%s %ai" -- >../actual-2 &&
+		echo "" >>../actual-2
+	) &&
+	echo "Rev 16 2011-11-06 07:00:01 +0000
+Rev 15 2011-11-06 06:59:59 +0000
+Rev 14 2011-03-13 08:00:01 +0000
+Rev 13 2011-03-13 07:59:59 +0000
+Rev 12 2010-12-01 00:00:00 +0000
+Rev 11 2010-11-01 00:00:00 +0000
+Rev 10 2010-10-01 00:00:00 +0000
+Rev  9 2010-09-01 00:00:00 +0000
+Rev  8 2010-08-01 00:00:00 +0000
+Rev  7 2010-07-01 00:00:00 +0000
+Rev  6 2010-06-01 00:00:00 +0000
+Rev  5 2010-05-01 00:00:00 +0000
+Rev  4 2010-04-01 00:00:00 +0000
+Rev  3 2010-03-01 00:00:00 +0000
+Rev  2 2010-02-01 00:00:00 +0000
+Rev  1 2010-01-01 00:00:00 +0000" >expect-2 &&
+	test_cmp actual-2 expect-2
+'
+
+test_expect_success 'check timestamps with author-specific timezones' '
+
+	echo "user1=User One <user1@domain.org>
+user2=User Two <user2@domain.org> America/Chicago
+user3=User Three <user3@domain.org> Australia/Sydney
+user4=User Four <user4@domain.org> Asia/Shanghai" >cvs-authors &&
+	git cvsimport -p"-x" -A cvs-authors -C module-3 module &&
+	(cd module-3 &&
+		git log --pretty="format:%s %ai" -- >../actual-3 &&
+		echo "" >>../actual-3
+	) &&
+	echo "Rev 16 2011-11-06 01:00:01 -0600
+Rev 15 2011-11-06 01:59:59 -0500
+Rev 14 2011-03-13 03:00:01 -0500
+Rev 13 2011-03-13 01:59:59 -0600
+Rev 12 2010-12-01 08:00:00 +0800
+Rev 11 2010-11-01 11:00:00 +1100
+Rev 10 2010-09-30 19:00:00 -0500
+Rev  9 2010-09-01 00:00:00 +0000
+Rev  8 2010-08-01 08:00:00 +0800
+Rev  7 2010-07-01 10:00:00 +1000
+Rev  6 2010-05-31 19:00:00 -0500
+Rev  5 2010-05-01 00:00:00 +0000
+Rev  4 2010-04-01 08:00:00 +0800
+Rev  3 2010-03-01 11:00:00 +1100
+Rev  2 2010-01-31 18:00:00 -0600
+Rev  1 2010-01-01 00:00:00 +0000" >expect-3 &&
+	test_cmp actual-3 expect-3
+'
+
+test_done
diff --git a/t/t9604/cvsroot/.gitattributes b/t/t9604/cvsroot/.gitattributes
new file mode 100644
index 0000000..562b12e
--- /dev/null
+++ b/t/t9604/cvsroot/.gitattributes
@@ -0,0 +1 @@
+* -whitespace
diff --git a/t/t9604/cvsroot/CVSROOT/.gitignore b/t/t9604/cvsroot/CVSROOT/.gitignore
new file mode 100644
index 0000000..3bb9b34
--- /dev/null
+++ b/t/t9604/cvsroot/CVSROOT/.gitignore
@@ -0,0 +1,2 @@
+history
+val-tags
diff --git a/t/t9604/cvsroot/module/a,v b/t/t9604/cvsroot/module/a,v
new file mode 100644
index 0000000..7165de7
--- /dev/null
+++ b/t/t9604/cvsroot/module/a,v
@@ -0,0 +1,265 @@
+head	1.16;
+access;
+symbols;
+locks; strict;
+comment	@# @;
+
+
+1.16
+date	2011.11.06.07.00.01;	author user2;	state Exp;
+branches;
+next	1.15;
+
+1.15
+date	2011.11.06.06.59.59;	author user2;	state Exp;
+branches;
+next	1.14;
+
+1.14
+date	2011.03.13.08.00.01;	author user2;	state Exp;
+branches;
+next	1.13;
+
+1.13
+date	2011.03.13.07.59.59;	author user2;	state Exp;
+branches;
+next	1.12;
+
+1.12
+date	2010.12.01.00.00.00;	author user4;	state Exp;
+branches;
+next	1.11;
+
+1.11
+date	2010.11.01.00.00.00;	author user3;	state Exp;
+branches;
+next	1.10;
+
+1.10
+date	2010.10.01.00.00.00;	author user2;	state Exp;
+branches;
+next	1.9;
+
+1.9
+date	2010.09.01.00.00.00;	author user1;	state Exp;
+branches;
+next	1.8;
+
+1.8
+date	2010.08.01.00.00.00;	author user4;	state Exp;
+branches;
+next	1.7;
+
+1.7
+date	2010.07.01.00.00.00;	author user3;	state Exp;
+branches;
+next	1.6;
+
+1.6
+date	2010.06.01.00.00.00;	author user2;	state Exp;
+branches;
+next	1.5;
+
+1.5
+date	2010.05.01.00.00.00;	author user1;	state Exp;
+branches;
+next	1.4;
+
+1.4
+date	2010.04.01.00.00.00;	author user4;	state Exp;
+branches;
+next	1.3;
+
+1.3
+date	2010.03.01.00.00.00;	author user3;	state Exp;
+branches;
+next	1.2;
+
+1.2
+date	2010.02.01.00.00.00;	author user2;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2010.01.01.00.00.00;	author user1;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.16
+log
+@Rev 16
+@
+text
+@Rev 16
+@
+
+
+1.15
+log
+@Rev 15
+@
+text
+@d1 1
+a1 1
+Rev 15
+@
+
+
+1.14
+log
+@Rev 14
+@
+text
+@d1 1
+a1 1
+Rev 14
+@
+
+
+1.13
+log
+@Rev 13
+@
+text
+@d1 1
+a1 1
+Rev 13
+@
+
+
+1.12
+log
+@Rev 12
+@
+text
+@d1 1
+a1 1
+Rev 12
+@
+
+
+1.11
+log
+@Rev 11
+@
+text
+@d1 1
+a1 1
+Rev 11
+@
+
+
+1.10
+log
+@Rev 10
+@
+text
+@d1 1
+a1 1
+Rev 10
+@
+
+
+1.9
+log
+@Rev  9
+@
+text
+@d1 1
+a1 1
+Rev 9
+@
+
+
+1.8
+log
+@Rev  8
+@
+text
+@d1 1
+a1 1
+Rev 8
+@
+
+
+1.7
+log
+@Rev  7
+@
+text
+@d1 1
+a1 1
+Rev 7
+@
+
+
+1.6
+log
+@Rev  6
+@
+text
+@d1 1
+a1 1
+Rev 6
+@
+
+
+1.5
+log
+@Rev  5
+@
+text
+@d1 1
+a1 1
+Rev 5
+@
+
+
+1.4
+log
+@Rev  4
+@
+text
+@d1 1
+a1 1
+Rev 4
+@
+
+
+1.3
+log
+@Rev  3
+@
+text
+@d1 1
+a1 1
+Rev 3
+@
+
+
+1.2
+log
+@Rev  2
+@
+text
+@d1 1
+a1 1
+Rev 2
+@
+
+
+1.1
+log
+@Rev  1
+@
+text
+@d1 1
+a1 1
+Rev 1
+@
+
-- 
1.8.0.rc1.19.gbecacc0
