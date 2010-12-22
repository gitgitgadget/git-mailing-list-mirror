From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 6/9] gitweb/lib - Simple output capture by redirecting
	STDOUT to file
Date: Thu, 23 Dec 2010 00:57:05 +0100
Message-ID: <20101222235705.7998.76695.stgit@localhost.localdomain>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:57:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYZ3-0007tp-C9
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab0LVX5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Dec 2010 18:57:44 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39560 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab0LVX5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:57:43 -0500
Received: by fxm20 with SMTP id 20so6639663fxm.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=oKXW/xiSehRDP87laIZ/OxdIiT/vGAlreOQ8rTIM2Do=;
        b=Gu43c0ZXkmO+dfRIg1DQD3yZztBZbcbavyQqZsBiG1mvrGVa2eFa+/Dk02rGAU5Ysz
         CY575aXictk+Dwt+ongjZlb6e+J+Ndl0OLvatGIar5fcI/fgcvBIaLkWrLkl3jkfIuwi
         OGWnw3S3j17z3bVlNjaTrVPIX5qYIwelIP64g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=YAlBaHGkc5CCe5JE390Jtg1E1Gl70gpkQ0/B432VgLDqgOcv8jUrpwcY54e33B0GbV
         W047S/S4BMCvDso4MeiCGtEKtc3WZjttHQpkACJnHL+gRs+Zjj0JjRGza9aBbouF9V3p
         0xhi1PvuscLkzviVtpfNR83kBwj8qpeLNd5dM=
Received: by 10.223.110.77 with SMTP id m13mr521006fap.86.1293062262034;
        Wed, 22 Dec 2010 15:57:42 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id 5sm1867516fak.47.2010.12.22.15.57.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:57:41 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNv5Kn008168;
	Thu, 23 Dec 2010 00:57:16 +0100
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164107>



Add GitwebCache::Capture::ToFile package, which captures output by
redirecting STDOUT to given file (specified by filename, or given opene=
d
filehandle), earlier saving original STDOUT to restore it when finished
capturing.

GitwebCache::Capture::ToFile preserves PerlIO layers, both those set
before started capturing output, and those set during capture.

No care was taken to handle the following special cases (prior to
starting capture): closed STDOUT, STDOUT reopened to scalar reference,
tied STDOUT.  You shouldn't modify STDOUT during capture.

Includes separate tests for capturing output in
t9510/test_capture_interface.pl which is run as external test from
t9510-gitweb-capture-interface.sh.  It tests capturing of utf8 data
printed in :utf8 mode, and of binary data (containing invalid utf8) in
:raw mode.


This patch was based on "gitweb: add output buffering and associated
functions" patch by John 'Warthog9' Hawley (J.H.) in "Gitweb caching v7=
"
series, and on code of Capture::Tiny by David Golden (Apache License 2.=
0).

Based-on-work-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/lib/GitwebCache/Capture/ToFile.pm |  109 ++++++++++++++++++++++=
+++
 t/t9510-gitweb-capture-interface.sh      |   34 ++++++++
 t/t9510/test_capture_interface.pl        |  132 ++++++++++++++++++++++=
++++++++
 3 files changed, 275 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/Capture/ToFile.pm
 create mode 100755 t/t9510-gitweb-capture-interface.sh
 create mode 100755 t/t9510/test_capture_interface.pl


diff --git a/gitweb/lib/GitwebCache/Capture/ToFile.pm b/gitweb/lib/Gitw=
ebCache/Capture/ToFile.pm
new file mode 100644
index 0000000..d2dbf0f
--- /dev/null
+++ b/gitweb/lib/GitwebCache/Capture/ToFile.pm
@@ -0,0 +1,109 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+#
+# This program is licensed under the GPLv2
+
+#
+# Simple output capturing via redirecting STDOUT to given file.
+#
+
+# This is the same mechanism that Capture::Tiny uses, only simpler;
+# we don't capture STDERR at all, we don't tee, we capture to
+# explicitely provided file (or filehandle).
+
+package GitwebCache::Capture::ToFile;
+
+use strict;
+use warnings;
+
+use PerlIO;
+use Symbol qw(qualify_to_ref);
+
+# Constructor
+sub new {
+	my $class =3D shift;
+
+	my $self =3D {};
+	$self =3D bless($self, $class);
+
+	return $self;
+}
+
+sub capture {
+	my $self =3D shift;
+	my $code =3D shift;
+
+	$self->capture_start(@_); # pass rest of params
+	eval { $code->(); 1; };
+	my $exit_code =3D $?; # save this for later
+	my $error =3D $@;     # save this for later
+
+	my $got_out =3D $self->capture_stop();
+	$? =3D $exit_code;
+	die $error if $error;
+
+	return $got_out;
+}
+
+# --------------------------------------------------------------------=
--
+
+# Start capturing data (STDOUT)
+sub capture_start {
+	my $self =3D shift;
+	my $to   =3D shift;
+
+	# save copy of real STDOUT via duplicating it
+	my @layers =3D PerlIO::get_layers(\*STDOUT);
+	open $self->{'orig_stdout'}, ">&", \*STDOUT
+		or die "Couldn't dup STDOUT for capture: $!";
+
+	# close STDOUT, so that it isn't used anymode (to have it fd0)
+	close STDOUT;
+
+	$self->{'to'} =3D $to;
+	my $fileno =3D fileno(qualify_to_ref($to));=20
+	if (defined $fileno) {
+		# if $to is filehandle, redirect
+		open STDOUT, '>&', $fileno;
+	} elsif (! ref($to)) {
+		# if $to is name of file, open it
+		open STDOUT, '>',  $to;
+	}
+	_relayer(\*STDOUT, \@layers);
+
+	# started capturing
+	$self->{'capturing'} =3D 1;
+}
+
+# Stop capturing data (required for die_error)
+sub capture_stop {
+	my $self =3D shift;
+
+	# return if we didn't start capturing
+	return unless delete $self->{'capturing'};
+
+	# close capture file, and restore original STDOUT
+	my @layers =3D PerlIO::get_layers(\*STDOUT);
+	close STDOUT;
+	open STDOUT, '>&', fileno($self->{'orig_stdout'});
+	_relayer(\*STDOUT, \@layers);
+
+	return exists $self->{'to'} ? $self->{'to'} : $self->{'data'};
+}
+
+# taken from Capture::Tiny by David Golden, Apache License 2.0
+# with debugging stripped out
+sub _relayer {
+	my ($fh, $layers) =3D @_;
+
+	my %seen =3D ( unix =3D> 1, perlio =3D> 1); # filter these out
+	my @unique =3D grep { !$seen{$_}++ } @$layers;
+
+	binmode($fh, join(":", ":raw", @unique));
+}
+
+
+1;
+__END__
+# end of package GitwebCache::Capture::ToFile
diff --git a/t/t9510-gitweb-capture-interface.sh b/t/t9510-gitweb-captu=
re-interface.sh
new file mode 100755
index 0000000..9151454
--- /dev/null
+++ b/t/t9510-gitweb-capture-interface.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jakub Narebski
+#
+
+test_description=3D'gitweb capturing interface
+
+This test checks capturing interface used for capturing gitweb output
+in gitweb caching (GitwebCache::Capture* modules).'
+
+# for now we are running only cache interface tests
+. ./test-lib.sh
+
+# this test is present in gitweb-lib.sh
+if ! test_have_prereq PERL; then
+	skip_all=3D'perl not available, skipping test'
+	test_done
+fi
+
+"$PERL_PATH" -MTest::More -e 0 >/dev/null 2>&1 || {
+	skip_all=3D'perl module Test::More unavailable, skipping test'
+	test_done
+}
+
+# --------------------------------------------------------------------=
--
+
+# The external test will outputs its own plan
+test_external_has_tap=3D1
+
+test_external \
+	'GitwebCache::Capture* Perl API (in gitweb/lib/)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9510/test_capture_interface.pl
+
+test_done
diff --git a/t/t9510/test_capture_interface.pl b/t/t9510/test_capture_i=
nterface.pl
new file mode 100755
index 0000000..6d90497
--- /dev/null
+++ b/t/t9510/test_capture_interface.pl
@@ -0,0 +1,132 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+use utf8;
+
+use Test::More;
+
+# test source version
+use lib $ENV{GITWEBLIBDIR} || "$ENV{GIT_BUILD_DIR}/gitweb/lib";
+
+# ....................................................................
+
+use_ok('GitwebCache::Capture::ToFile');
+note("Using lib '$INC[0]'");
+note("Testing '$INC{'GitwebCache/Capture/ToFile.pm'}'");
+
+# Test setting up capture
+#
+my $capture =3D new_ok('GitwebCache::Capture::ToFile' =3D> [], 'The $c=
apture');
+
+
+# Test capturing to file (given by filename) and to filehandle
+#
+sub capture_block (&;$) {
+	$capture->capture(shift, shift || 'actual');
+
+	open my $fh, '<', 'actual' or return;
+	local $/ =3D undef;
+	my $result =3D <$fh>;
+	close $fh;
+	return $result;
+}
+
+diag('Should not print anything except test results and diagnostic');
+my $test_data =3D 'Capture this';
+my $captured =3D capture_block {
+	print $test_data;
+};
+is($captured, $test_data, 'capture simple data: filename');
+
+open my $fh, '>', 'actual';
+$captured =3D capture_block(sub {
+	print $test_data;
+}, $fh);
+close $fh;
+is($captured, $test_data, 'capture simple data: filehandle');
+
+
+# Test capturing :utf8 and :raw data
+#
+binmode STDOUT, ':utf8';
+$test_data =3D <<'EOF';
+Za=C5=BC=C3=B3=C5=82=C4=87 g=C4=99si=C4=85 ja=C5=BA=C5=84
+EOF
+utf8::decode($test_data);
+$captured =3D capture_block {
+	binmode STDOUT, ':utf8';
+
+	print $test_data;
+};
+utf8::decode($captured);
+is($captured, $test_data, 'capture utf8 data');
+
+$test_data =3D '|\x{fe}\x{ff}|\x{9F}|\000|'; # invalid utf-8
+$captured =3D capture_block {
+	binmode STDOUT, ':raw';
+
+	print $test_data;
+};
+is($captured, $test_data, 'capture raw data');
+
+
+# Test nested capturing, useful for future GitwebCache::CacheOutput te=
sts
+#
+sub read_file {
+	my $filename =3D shift;
+
+	open my $fh, '<', $filename or return;
+	local $/ =3D undef;
+	my $result =3D <$fh>;
+	close $fh;
+
+	return $result;
+}
+
+my $outer_capture =3D GitwebCache::Capture::ToFile->new();
+$captured =3D $outer_capture->capture(sub {
+	print "pre|";
+	my $captured =3D $capture->capture(sub {
+		print "INNER";
+	}, 'inner_actual');
+	print "|post";
+}, 'outer_actual');
+
+my $inner =3D read_file('inner_actual');
+my $outer =3D read_file('outer_actual');
+
+is($inner, "INNER",     'nested capture: inner');
+is($outer, "pre||post", 'nested capture: outer');
+
+
+# Testing capture when code dies
+#
+$captured =3D $outer_capture->capture(sub {
+	print "pre|";
+	eval {
+		my $captured =3D $capture->capture(sub {
+			print "INNER:pre|";
+			die "die from inner\n";
+			print "INNER:post|"
+		}, 'inner_actual');
+	};
+	print "@=3D$@" if $@;
+	print "|post";
+}, 'outer_actual');
+
+my $inner =3D read_file('inner_actual');
+my $outer =3D read_file('outer_actual');
+
+is($inner, "INNER:pre|",
+   'nested capture with die: inner output captured up to die');
+is($outer, "pre|@=3Ddie from inner\n|post",
+   'nested capture with die: outer caught rethrown exception from inne=
r');
+
+
+done_testing();
+
+# Local Variables:
+# coding: utf-8
+# End:
