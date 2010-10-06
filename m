From: Jakub Narebski <jnareb@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv5=2006/17=5D=20gitweb/lib=20-=20Simple=20select=28FH=29=20based=20output=20capture?=
Date: Thu,  7 Oct 2010 00:01:51 +0200
Message-ID: <1286402526-13143-7-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5l-0002Gb-Ab
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759949Ab0JFWCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:02:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35042 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757090Ab0JFWCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:42 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49424bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=V0ki+6FlzyS05v8DxIOycYCWkM8muHgAoLX5isLRx1I=;
        b=CwcTPngsna+dNS/0TK9WQUmpZuv1KMGz9B1VKrz7bPAPbC/uQ6s1VzN2mQus1u4F7g
         vmh16Y9G9X+QDBL/G4am9xeJL2YOiV92Owa41XeUet6nYPDLDxoayj+5vfYV6dABad1D
         jcj7yBJTgiNpvSEAxy0XhbYz7IXm7A5xoesDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=orK3QrZkGH+8aSCdkIAYBtwa9decYaPEpEgkjyKjXhRgx4AcrHli9x8u1cJ5GGhvYW
         weH8osqixKyC2VhXvaElMkkoPMubkZNtxtvbQFP5EOHoVi7dwQ1YOnQ3bI6/qCSTDWJI
         +krCz2hvVYe16LYRYEzCOPI4hT67HXKAwtzK4=
Received: by 10.204.84.92 with SMTP id i28mr10343350bkl.57.1286402560020;
        Wed, 06 Oct 2010 15:02:40 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158320>

Add two packages: GitwebCache::Capture, which defines interface, and
GitwebCache::Capture::SelectFH, which is actually implements simple
capturing.  GitwebCache::Capture::SelectFH captures output by using
select(FILEHANDLE) to change default filehandle for output.  This
means that output of a "print" or a "printf" (or a "write") without
a filehandle would be captured.

To change mode of filehandle used for capturing correctly,
  binmode select(), <mode>;
needs to be used in place of
  binmode STDOUT, <mode>;

Capturing is done using in-memory file held in Perl scalar.

Using select(FILEHANDLE) is a bit fragile as a method of capturing
output, as it assumes that we always use "print" or "printf" without
filehandle, and use select() which returns default filehandle for
output in place of explicit STDOUT.  On the other hand it has the
advantage of being simple.  Alternate solutions include using tie
(like in CGI::Cache), or using PerlIO layers - but the last requires
non-standard PerlIO::Util module.


Includes separate tests for capturing output.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
You can see alternate solutions for capturing output in 21/17 patch of
this series: "gitweb/lib - Alternate ways of capturing output" (an
appendix to this series).

Differences from v4:
* The capture interface tests are now invoked by a separate test
  script t/t9504-gitweb-capture-interface.sh, for 'prove' to work
  correctly (as test_external doesn't yet work as subtest).

* The t/t9504/test_capture_interface.pl uses GIT_BUILD_DIR rather than
  TEST_DIRECTORY, and respect GITWEBLIBDIR to make it possible to test
  installed version of module.

* Removed spurious changes and fixes to commits earlier in series
  (patch cleanup).


Differences from relevant parts of J.H. patch:
* Capturing gitweb output will be done without need to modify gitweb
  to either save generated output into $output variable, and then
  print it or save it in cache after it is generated in full (original
  J.H. patch in "Gitweb caching v2"), or changing all print statements
  to print to explicit filehandle which points to STDOUT if caching is
  disabled and to in-memory file if caching is enabled (modified
  J.H. patch in "Gitweb caching v5").

* Contrary to the '$output .=3D <sth>' solution, and similar to the
  'print {$out} <sth>' or 'print $out <sth>' (which can be thought of
  as explicit version of select($out)), this way of capturing output
  doesn't change gitweb behavior when caching is turned off; in
  particular it preserves streaming.

  Also the '$output .=3D <sth>' solution can affect performance because
  of repeated string concatenation.

* The most important issue is that I/O "layers" (PerlIO), like ':utf8'
  or ':raw', are *already applied* to the output that is captured.
  This means that captured output is *always* in binary (':raw') mode.
  In Perl 6 language it means that data returned by capturing engine
  is an equivalent of Buf, a collection of bytes, whether Buf or Str
  (a colection of logical characters) is printed.

  The overal result is that we would not need separate code path for
  caching binary output, and separate naming conventions for cache
  files for binary data.

  The t9504 test is about checking if both ':utf8' and ':raw' output
  is captured correctly.

 gitweb/lib/GitwebCache/Capture.pm          |   66 ++++++++++++++++++++=
++
 gitweb/lib/GitwebCache/Capture/SelectFH.pm |   82 ++++++++++++++++++++=
++++++++
 t/t9504-gitweb-capture-interface.sh        |   34 ++++++++++++
 t/t9504/test_capture_interface.pl          |   76 ++++++++++++++++++++=
++++++
 4 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/Capture.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/SelectFH.pm
 create mode 100755 t/t9504-gitweb-capture-interface.sh
 create mode 100755 t/t9504/test_capture_interface.pl

diff --git a/gitweb/lib/GitwebCache/Capture.pm b/gitweb/lib/GitwebCache=
/Capture.pm
new file mode 100644
index 0000000..3e9fe81
--- /dev/null
+++ b/gitweb/lib/GitwebCache/Capture.pm
@@ -0,0 +1,66 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+#
+# This program is licensed under the GPLv2
+
+#
+# Output capturing for gitweb caching engine
+#
+
+# It is base abstract class (a role) for capturing output of gitweb
+# actions for gitweb caching engine.
+#=20
+# Child (derived) concrete classes, which actually implement some meth=
od
+# of capturing STDOUT output, must implement the following methods:
+# * ->new(), to create new object of a capturing class
+# * ->start(), to start capturing output
+# * ->stop(), to stop capturing output and return it
+#
+# Before starting capture by using capture_block etc. subroutines,
+# one has to run <child class>->setup().
+
+package GitwebCache::Capture;
+
+use strict;
+use warnings;
+
+use Exporter qw(import);
+our @EXPORT    =3D qw(capture_start capture_stop capture_block);
+our @EXPORT_OK =3D qw(setup_capture);
+our %EXPORT_TAGS =3D (all =3D> [ @EXPORT, @EXPORT_OK ]);
+
+# Holds object used for capture (of child class)
+my $capture;
+
+sub setup_capture {
+	my $self =3D shift || __PACKAGE__;
+
+	$capture =3D $self->new(@_);
+}
+
+sub capture {
+	my ($self, $code) =3D @_;
+
+	$self->start();
+	$code->();
+	return $self->stop();
+}
+
+# Wrap caching data; capture only STDOUT
+sub capture_block (&) {
+	my $code =3D shift;
+	return $capture->capture($code);
+}
+
+sub capture_start {
+	$capture->start(@_);
+}
+
+sub capture_stop {
+	return $capture->stop(@_);
+}
+
+1;
+__END__
+# end of package GitwebCache::Capture;
diff --git a/gitweb/lib/GitwebCache/Capture/SelectFH.pm b/gitweb/lib/Gi=
twebCache/Capture/SelectFH.pm
new file mode 100644
index 0000000..18ce5c3
--- /dev/null
+++ b/gitweb/lib/GitwebCache/Capture/SelectFH.pm
@@ -0,0 +1,82 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+#
+# This program is licensed under the GPLv2
+
+#
+# Simple output capturing using select(FH);
+#
+
+# This module (class) captures output of 'print <sth>', 'printf <sth>'
+# and 'write <sth>' (without a filehandle) by using select(FILEHANDLE)
+# to change default filehandle for output, changing it to in-memory
+# file (saving output to scalar).
+#
+# Note that when using this simplest way of capturing, to change mode =
of
+# filehandle using for capturing correctly, "binmode STDOUT, <mode>;"
+# has to be changed to "binmode select(), <mode>;".  This has no chang=
e
+# if we are not capturing output using GitwebCache::Capture::SelectFH.
+
+package GitwebCache::Capture::SelectFH;
+
+use PerlIO;
+
+use strict;
+use warnings;
+
+use base qw(GitwebCache::Capture);
+use GitwebCache::Capture qw(:all);
+
+use Exporter qw(import);
+our @EXPORT      =3D @GitwebCache::Capture::EXPORT;
+our @EXPORT_OK   =3D @GitwebCache::Capture::EXPORT_OK;
+our %EXPORT_TAGS =3D %GitwebCache::Capture::EXPORT_TAGS;
+
+# Constructor
+sub new {
+	my $proto =3D shift;
+
+	my $class =3D ref($proto) || $proto;
+	my $self  =3D {};
+	$self =3D bless($self, $class);
+
+	$self->{'oldfh'} =3D select();
+	$self->{'data'} =3D '';
+
+	return $self;
+}
+
+# Start capturing data (STDOUT)
+# (printed using 'print <sth>' or 'printf <sth>')
+sub start {
+	my $self =3D shift;
+
+	$self->{'data'}    =3D '';
+	$self->{'data_fh'} =3D undef;
+=09
+	open $self->{'data_fh'}, '>', \$self->{'data'}
+		or die "Couldn't open in-memory file for capture: $!";
+	$self->{'oldfh'} =3D select($self->{'data_fh'});
+
+	# note: this does not cover all cases
+	binmode select(), ':utf8'
+		if ((PerlIO::get_layers($self->{'oldfh'}))[-1] eq 'utf8');
+}
+
+# Stop capturing data (required for die_error)
+sub stop {
+	my $self =3D shift;
+
+	# return if we didn't start capturing
+	return unless defined $self->{'data_fh'};
+
+	select($self->{'oldfh'});
+	close $self->{'data_fh'}
+		or die "Couldn't close in-memory file for capture: $!";
+	return $self->{'data'};
+}
+
+1;
+__END__
+# end of package GitwebCache::Capture::SelectFH;
diff --git a/t/t9504-gitweb-capture-interface.sh b/t/t9504-gitweb-captu=
re-interface.sh
new file mode 100755
index 0000000..82623f1
--- /dev/null
+++ b/t/t9504-gitweb-capture-interface.sh
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
+	'GitwebCache::Capture Perl API (in gitweb/lib/)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9504/test_capture_interface.pl
+
+test_done
diff --git a/t/t9504/test_capture_interface.pl b/t/t9504/test_capture_i=
nterface.pl
new file mode 100755
index 0000000..55c402a
--- /dev/null
+++ b/t/t9504/test_capture_interface.pl
@@ -0,0 +1,76 @@
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
+# prototypes must be known at compile time, otherwise they do not work
+BEGIN { use_ok('GitwebCache::Capture::SelectFH', qw(:all)); }
+
+# Test setting up capture
+#
+my $capture =3D new_ok('GitwebCache::Capture::SelectFH' =3D> [], 'The =
$capture');
+isa_ok($capture, 'GitwebCache::Capture', 'The $capture');
+ok(setup_capture('GitwebCache::Capture::SelectFH'),
+   'setup_capture with package name: GitwebCache::Capture::SelectFH');
+ok(setup_capture($capture),
+   'setup_capture with subclass object: $capture');
+
+# Test properties of capture_block
+#
+is(prototype('capture_block'), '&', 'capture_block has (&) prototype')=
;
+
+# Test capturing
+#
+diag('Should not print anything except test results and diagnostic');
+my $test_data =3D 'Capture this';
+my $captured =3D capture_block {
+	print $test_data;
+};
+is($captured, $test_data, 'capture_block captures simple data');
+
+binmode STDOUT, ':utf8';
+$test_data =3D <<'EOF';
+=C3=81=C3=A9=C3=AD =C3=B3=C3=BA
+=C3=84=C3=8B=C3=91=C3=8F=C3=96
+=C3=81b=C3=A7d=C3=A8fg
+Za=C5=BC=C3=B3=C5=82=C4=87 g=C4=99si=C4=85 ja=C5=BA=C5=84
+=E5=B1=B1=E7=94=B0 =E5=A4=AA=E9=83=8E
+=E3=83=96=E3=83=AC=E3=83=BC=E3=83=A0=E3=81=AE=E3=83=86=E3=82=B9=E3=83=88=
=E3=81=A7=E3=81=99=E3=80=82
+
+=E3=81=AF=E3=82=8C=E3=81=B2=E3=81=BB=E3=81=B5
+
+=E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AE=E3=81=8C=E3=80=81=E3=81=84=
=E3=82=8B=E3=81=AE=E3=81=A7=E3=80=82
+=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3=E3=81=90=E3=82=8A=E3=82=8D=E3=81=B8=E3=80=82
+EOF
+utf8::decode($test_data);
+$captured =3D capture_block {
+	binmode select(), ':utf8';
+
+	print $test_data;
+};
+utf8::decode($captured);
+is($captured, $test_data, 'capture_block captures utf8 data');
+
+$test_data =3D '|\x{fe}\x{ff}|\x{9F}|\000|'; # invalid utf-8
+$captured =3D capture_block {
+	binmode select(), ':raw';
+
+	print $test_data;
+};
+is($captured, $test_data, 'capture_block captures raw data');
+
+
+done_testing();
+
+# Local Variables:
+# encoding: utf-8
+# End:
--=20
1.7.3
