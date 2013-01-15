From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 1/3] Move Git::SVN::get_tz to Git::get_tz_offset
Date: Tue, 15 Jan 2013 23:10:03 +0000
Message-ID: <1358291405-10173-2-git-send-email-bdwalton@gmail.com>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
Cc: esr@thyrsus.com, git@vger.kernel.org,
	Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 16 00:10:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvFee-0008Lj-MW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934170Ab3AOXKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 18:10:15 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:44872 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758113Ab3AOXKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 18:10:11 -0500
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:57199 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1TvFdx-0005dw-Qj ; Tue, 15 Jan 2013 18:10:09 -0500
Received: from 86-42-159-147-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.159.147]:55552 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1TvFdu-0005Cs-Vf ; Tue, 15 Jan 2013 18:10:07 -0500
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1TvFe4-0002hF-47; Tue, 15 Jan 2013 23:10:16 +0000
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213685>

This function has utility outside of the SVN module for any routine
that needs the equivalent of GNU strftime's %z formatting option.
Move it to the top-level Git.pm so that non-SVN modules don't need to
import the SVN module to use it.

The rename makes the purpose of the function clearer.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 perl/Git.pm         |   23 +++++++++++++++++++++++
 perl/Git/SVN.pm     |   12 ++----------
 perl/Git/SVN/Log.pm |    8 ++++++--
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 931047c..5649bcc 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -59,6 +59,7 @@ require Exporter;
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
                 remote_refs prompt
+                get_tz_offset
                 temp_acquire temp_release temp_reset temp_path);
 
 
@@ -102,6 +103,7 @@ use Error qw(:try);
 use Cwd qw(abs_path cwd);
 use IPC::Open2 qw(open2);
 use Fcntl qw(SEEK_SET SEEK_CUR);
+use Time::Local qw(timelocal);
 }
 
 
@@ -511,6 +513,27 @@ C<git --html-path>). Useful mostly only internally.
 
 sub html_path { command_oneline('--html-path') }
 
+
+=item get_tz_offset ( TIME )
+
+Return the time zone offset from GMT in the form +/-HHMM where HH is
+the number of hours from GMT and MM is the number of minutes.  This is
+the equivalent of what strftime("%z", ...) would provide on a GNU
+platform.
+
+If TIME is not supplied, the current local time is used.
+
+=cut
+
+sub get_tz_offset {
+	# some systmes don't handle or mishandle %z, so be creative.
+	my $t = shift || time;
+	my $gm = timelocal(gmtime($t));
+	my $sign = qw( + + - )[ $t <=> $gm ];
+	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
+}
+
+
 =item prompt ( PROMPT , ISPASSWORD  )
 
 Query user C<PROMPT> and return answer from user.
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 59215fa..8c84560 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -11,7 +11,6 @@ use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
 use IPC::Open3;
-use Time::Local;
 use Memoize;  # core since 5.8.0, Jul 2002
 use Memoize::Storable;
 use POSIX qw(:signal_h);
@@ -22,6 +21,7 @@ use Git qw(
     command_noisy
     command_output_pipe
     command_close_pipe
+    get_tz_offset
 );
 use Git::SVN::Utils qw(
 	fatal
@@ -1311,14 +1311,6 @@ sub get_untracked {
 	\@out;
 }
 
-sub get_tz {
-	# some systmes don't handle or mishandle %z, so be creative.
-	my $t = shift || time;
-	my $gm = timelocal(gmtime($t));
-	my $sign = qw( + + - )[ $t <=> $gm ];
-	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
-}
-
 # parse_svn_date(DATE)
 # --------------------
 # Given a date (in UTC) from Subversion, return a string in the format
@@ -1351,7 +1343,7 @@ sub parse_svn_date {
 			delete $ENV{TZ};
 		}
 
-		my $our_TZ = get_tz();
+		my $our_TZ = get_tz_offset();
 
 		# This converts $epoch_in_UTC into our local timezone.
 		my ($sec, $min, $hour, $mday, $mon, $year,
diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
index 3cc1c6f..3f8350a 100644
--- a/perl/Git/SVN/Log.pm
+++ b/perl/Git/SVN/Log.pm
@@ -2,7 +2,11 @@ package Git::SVN::Log;
 use strict;
 use warnings;
 use Git::SVN::Utils qw(fatal);
-use Git qw(command command_oneline command_output_pipe command_close_pipe);
+use Git qw(command
+           command_oneline
+           command_output_pipe
+           command_close_pipe
+           get_tz_offset);
 use POSIX qw/strftime/;
 use constant commit_log_separator => ('-' x 72) . "\n";
 use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
@@ -119,7 +123,7 @@ sub run_pager {
 sub format_svn_date {
 	my $t = shift || time;
 	require Git::SVN;
-	my $gmoff = Git::SVN::get_tz($t);
+	my $gmoff = get_tz_offset($t);
 	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime($t));
 }
 
-- 
1.7.10.4
