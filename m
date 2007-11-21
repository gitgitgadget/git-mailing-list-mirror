From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH 1/3] git-svn: extract reusable code into utility functions
Date: Tue, 20 Nov 2007 22:43:17 -0800
Message-ID: <1195627399-25209-2-git-send-email-ddkilzer@kilzer.net>
References: <20071117225402.GC28755@muzzle>
 <1195627399-25209-1-git-send-email-ddkilzer@kilzer.net>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:43:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujJF-0003I2-Dn
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbXKUGnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXKUGnX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:43:23 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:55945 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbXKUGnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:43:20 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 5495A19CCE01;
	Tue, 20 Nov 2007 22:43:20 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 3B6E128083;
	Tue, 20 Nov 2007 22:43:20 -0800 (PST)
X-AuditID: 1180711d-a0abebb0000008bf-d6-4743d38860cc
Received: from localhost.localdomain (unknown [17.151.112.145])
	by relay13.apple.com (Apple SCV relay) with ESMTP id E74D028057;
	Tue, 20 Nov 2007 22:43:19 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1195627399-25209-1-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65595>

Extacted canonicalize_path() in the main package.

Created new Git::SVN::Util package with an md5sum() function.  A
new package was created so that Digest::MD5 did not have to be
loaded in the main package.  Replaced code in the SVN::Git::Editor
and SVN::Git::Fetcher packages with calls to md5sum().

Extracted the format_svn_date(), parse_git_date() and
set_local_timezone() functions within the Git::SVN::Log package.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 git-svn.perl |   96 ++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e3e00fd..aff429a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -48,7 +48,8 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe/) {
 		for my $package ( qw(SVN::Git::Editor SVN::Git::Fetcher
-			Git::SVN::Migration Git::SVN::Log Git::SVN),
+			Git::SVN::Migration Git::SVN::Log Git::SVN
+			Git::SVN::Util),
 			__PACKAGE__) {
 			*{"${package}::$_"} = \&{"Git::$_"};
 		}
@@ -580,6 +581,17 @@ sub cmd_create_ignore {
 	});
 }
 
+sub canonicalize_path {
+	my ($path) = @_;
+	# File::Spec->canonpath doesn't collapse x/../y into y (for a
+	# good reason), so let's do this manually.
+	$path =~ s#/+#/#g;
+	$path =~ s#/\.(?:/|$)#/#g;
+	$path =~ s#/[^/]+/\.\.##g;
+	$path =~ s#/$##g;
+	return $path;
+}
+
 # get_svnprops(PATH)
 # ------------------
 # Helper for cmd_propget and cmd_proplist below.
@@ -597,12 +609,7 @@ sub get_svnprops {
 
 	# canonicalize the path (otherwise libsvn will abort or fail to
 	# find the file)
-	# File::Spec->canonpath doesn't collapse x/../y into y (for a
-	# good reason), so let's do this manually.
-	$path =~ s#/+#/#g;
-	$path =~ s#/\.(?:/|$)#/#g;
-	$path =~ s#/[^/]+/\.\.##g;
-	$path =~ s#/$##g;
+	$path = canonicalize_path($path);
 
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
 	my $props;
@@ -1040,6 +1047,27 @@ sub linearize_history {
 	(\@linear_refs, \%parents);
 }
 
+package Git::SVN::Util;
+use strict;
+use warnings;
+use Digest::MD5;
+
+sub md5sum {
+	my $arg = shift;
+	my $ref = ref $arg;
+	my $md5 = Digest::MD5->new();
+        if ($ref eq 'GLOB' || $ref eq 'IO::File') {
+		$md5->addfile($arg) or croak $!;
+	} elsif ($ref eq 'SCALAR') {
+		$md5->add($$arg) or croak $!;
+	} elsif (!$ref) {
+		$md5->add($arg) or croak $!;
+	} else {
+		::fatal "Can't provide MD5 hash for unknown ref type: '", $ref, "'";
+	}
+	return $md5->hexdigest();
+}
+
 package Git::SVN;
 use strict;
 use warnings;
@@ -2585,7 +2613,6 @@ use strict;
 use warnings;
 use Carp qw/croak/;
 use IO::File qw//;
-use Digest::MD5;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
@@ -2737,9 +2764,7 @@ sub apply_textdelta {
 
 		if (defined $exp) {
 			seek $base, 0, 0 or croak $!;
-			my $md5 = Digest::MD5->new;
-			$md5->addfile($base);
-			my $got = $md5->hexdigest;
+			my $got = Git::SVN::Util::md5sum($base);
 			die "Checksum mismatch: $fb->{path} $fb->{blob}\n",
 			    "expected: $exp\n",
 			    "     got: $got\n" if ($got ne $exp);
@@ -2758,9 +2783,7 @@ sub close_file {
 	if (my $fh = $fb->{fh}) {
 		if (defined $exp) {
 			seek($fh, 0, 0) or croak $!;
-			my $md5 = Digest::MD5->new;
-			$md5->addfile($fh);
-			my $got = $md5->hexdigest;
+			my $got = Git::SVN::Util::md5sum($fh);
 			if ($got ne $exp) {
 				die "Checksum mismatch: $path\n",
 				    "expected: $exp\n    got: $got\n";
@@ -2812,7 +2835,6 @@ use strict;
 use warnings;
 use Carp qw/croak/;
 use IO::File;
-use Digest::MD5;
 
 sub new {
 	my ($class, $opts) = @_;
@@ -3116,11 +3138,9 @@ sub chg_file {
 	$fh->flush == 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
 
-	my $md5 = Digest::MD5->new;
-	$md5->addfile($fh) or croak $!;
+	my $exp = Git::SVN::Util::md5sum($fh);
 	seek $fh, 0, 0 or croak $!;
 
-	my $exp = $md5->hexdigest;
 	my $pool = SVN::Pool->new;
 	my $atd = $self->apply_textdelta($fbat, undef, $pool);
 	my $got = SVN::TxDelta::send_stream($fh, @$atd, $pool);
@@ -3833,6 +3853,29 @@ sub run_pager {
 	exec $pager or ::fatal "Can't run pager: $! ($pager)";
 }
 
+sub format_svn_date {
+	return strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime(shift));
+}
+
+sub parse_git_date {
+	my ($t, $tz) = @_;
+	# Date::Parse isn't in the standard Perl distro :(
+	if ($tz =~ s/^\+//) {
+		$t += tz_to_s_offset($tz);
+	} elsif ($tz =~ s/^\-//) {
+		$t -= tz_to_s_offset($tz);
+	}
+	return $t;
+}
+
+sub set_local_timezone {
+	if (defined $TZ) {
+		$ENV{TZ} = $TZ;
+	} else {
+		delete $ENV{TZ};
+	}
+}
+
 sub tz_to_s_offset {
 	my ($tz) = @_;
 	$tz =~ s/(\d\d)$//;
@@ -3853,13 +3896,7 @@ sub get_author_info {
 	$dest->{t} = $t;
 	$dest->{tz} = $tz;
 	$dest->{a} = $au;
-	# Date::Parse isn't in the standard Perl distro :(
-	if ($tz =~ s/^\+//) {
-		$t += tz_to_s_offset($tz);
-	} elsif ($tz =~ s/^\-//) {
-		$t -= tz_to_s_offset($tz);
-	}
-	$dest->{t_utc} = $t;
+	$dest->{t_utc} = parse_git_date($t, $tz);
 }
 
 sub process_commit {
@@ -3913,8 +3950,7 @@ sub show_commit_normal {
 	my ($c) = @_;
 	print '-' x72, "\nr$c->{r} | ";
 	print "$c->{c} | " if $show_commit;
-	print "$c->{a} | ", strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)",
-				 localtime($c->{t_utc})), ' | ';
+	print "$c->{a} | ", format_svn_date($c->{t_utc}), ' | ';
 	my $nr_line = 0;
 
 	if (my $l = $c->{l}) {
@@ -3954,11 +3990,7 @@ sub cmd_show_log {
 	my (@args) = @_;
 	my ($r_min, $r_max);
 	my $r_last = -1; # prevent dupes
-	if (defined $TZ) {
-		$ENV{TZ} = $TZ;
-	} else {
-		delete $ENV{TZ};
-	}
+	set_local_timezone();
 	if (defined $::_revision) {
 		if ($::_revision =~ /^(\d+):(\d+)$/) {
 			($r_min, $r_max) = ($1, $2);
-- 
1.5.3.4
