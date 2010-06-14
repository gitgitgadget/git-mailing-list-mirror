From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 07/17] gitweb/lib - Simple select(FH) based output capture
Date: Mon, 14 Jun 2010 18:08:19 +0200
Message-ID: <1276531710-22945-8-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:09:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCDh-0001Wt-CI
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab0FNQI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:08:58 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55154 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab0FNQIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:48 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649718fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0/mBVphlRM3wx3murx3OzhV+v4KYs0BkB+uSZLG1nL0=;
        b=HWEvd0NIRsq6S4FFdOcbIo4mVDvtMEaY39FSTScqPmGTIavHHyhT4sNqF7zJWCzMaw
         prYTpS2R2ovy9emk6oXKHwFGuUKvHpdv1wg4FOizt3xfsHZClLO9dBWtnNKoPpd5zIeQ
         Agsscrx8Fx2mXKMoOL2cC240jgNRL0l6DiKh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rYgYQ1uIXnTbgPbnsw6DEICVqRYmFjaLNe083fJ0d8UGy2urScVMfD63CX/MavxpB1
         I0WKBDMgDHWS8HJpI2sFgoGEYlaQn9XalMUaVuii0bieyTmG3CelkwboRkgWmL4RD8Ws
         Qaz1UruZb+DNfuiQTO9hqr+LOh5iTTfHdjmhI=
Received: by 10.223.62.202 with SMTP id y10mr5624315fah.100.1276531727283;
        Mon, 14 Jun 2010 09:08:47 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149105>

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


Includes separate tests for capturing output, in t9503/test_capture.pl
which is run as external test from t9503-gitweb-caching.sh

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/lib/GitwebCache/Capture.pm          |   66 ++++++++++++++++++++=
++
 gitweb/lib/GitwebCache/Capture/SelectFH.pm |   82 ++++++++++++++++++++=
++++++++
 gitweb/lib/GitwebCache/SimpleFileCache.pm  |    7 +--
 t/t9503-gitweb-caching.sh                  |    5 ++-
 t/t9503/test_capture_interface.pl          |   76 ++++++++++++++++++++=
++++++
 5 files changed, 231 insertions(+), 5 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/Capture.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/SelectFH.pm
 create mode 100755 t/t9503/test_capture_interface.pl

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
index 0000000..2b904d3
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
+=09
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
+=09
+	select($self->{'oldfh'});
+	close $self->{'data_fh'}
+		or die "Couldn't close in-memory file for capture: $!";
+	return $self->{'data'};
+}
+
+1;
+__END__
+# end of package GitwebCache::Capture::SelectFH;
diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/Git=
webCache/SimpleFileCache.pm
index 91b3373..7c90350 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -201,16 +201,17 @@ sub store {
=20
 	# ensure that directory leading to cache file exists
 	if (!-d $dir) {
-		mkpath($dir, 0, 0777)
+		eval { mkpath($dir, 0, 0777); 1 }
 			or die "Couldn't create leading directory '$dir' (mkpath): $!";
 	}
=20
 	# generate a temporary file
+	# (Temp::File dies itself if it cannot create file)
 	my $temp =3D File::Temp->new(
 		#DIR =3D> $dir,
 		TEMPLATE =3D> "${file}_XXXXX",
 		SUFFIX =3D> ".tmp"
-	) or die "Couldn't create temporary file with '${file}_XXXXX' templat=
e: $!";
+	);# or die "Couldn't create temporary file with '${file}_XXXXX' templ=
ate: $!";
 	chmod 0666, $temp
 		or warn "Couldn't change permissions to 0666 for '$temp': $!";
=20
@@ -342,5 +343,3 @@ sub compute {
 1;
 __END__
 # end of package GitwebCache::SimpleFileCache;
-
-
diff --git a/t/t9503-gitweb-caching.sh b/t/t9503-gitweb-caching.sh
index 768080c..73b3f5a 100755
--- a/t/t9503-gitweb-caching.sh
+++ b/t/t9503-gitweb-caching.sh
@@ -26,7 +26,10 @@ fi
=20
 # --------------------------------------------------------------------=
--
=20
-test_external 'GitwebCache::* Perl API (in gitweb/cache.pm)' \
+test_external 'GitwebCache::SimpleFileCache Perl API (in gitweb/cache.=
pm)' \
 	"$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
=20
+test_external 'GitwebCache::Capture Perl API (in gitweb/cache.pm)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_capture_interface.pl
+
 test_done
diff --git a/t/t9503/test_capture_interface.pl b/t/t9503/test_capture_i=
nterface.pl
new file mode 100755
index 0000000..d7aa480
--- /dev/null
+++ b/t/t9503/test_capture_interface.pl
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
+use lib "$ENV{TEST_DIRECTORY}/../gitweb/lib";
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
1.7.0.1
