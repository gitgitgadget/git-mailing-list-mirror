From: Jakub Narebski <jnareb@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=2006/24=5D=20gitweb/lib=20-=20Simple=20output=20capture=20by=20redirecting=20STDOUT?=
Date: Tue,  7 Dec 2010 00:10:51 +0100
Message-ID: <1291677069-6559-7-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkE0-0008Ec-SU
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab0LFXL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 18:11:59 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:50271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab0LFXL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:11:58 -0500
Received: by ewy10 with SMTP id 10so7581892ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=D59iOyZwNpjv8uYnNTdJLYO0F2tn8N7BwnGo8l1ammM=;
        b=p3NSh0LhBYdNT3vsfdl6HirO+e845U8qpinNO/J6gik7G6tPZCPQb8Jdj/LacfZdvL
         19HCSNoLgksKj0ODjqsfeRsDn/6y9Oi+jd1uadx2gSCI7Vdx91pDAxaAntIXL/87xMnC
         PYPMDfB6XpHcAdX3n0Ansnmb5soeL97cHYWH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=n5MvTo3zMW3Lgk9iIJDu69KI2FKYWOnxXPNBRm9leLg/oc1jPTIq324lqt/XgXERLQ
         g0+riFfdMZoeipdXafNhQdZEYKn50qekxlidjCHhIXz3lOyaO4CQLhDRyDYYSBEJxPoG
         ZvfOiqzy0WouUwpMKjoLwC7kxOocVWzZyQX1A=
Received: by 10.213.32.6 with SMTP id a6mr149824ebd.31.1291677117227;
        Mon, 06 Dec 2010 15:11:57 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.11.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:11:56 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163034>

Add GitwebCache::Capture::Simple package, which captures output by
redirecting STDOUT to in-memory file (saving what is printed to
scalar), earlier saving original STDOUT to restore it when finished
capturing.

GitwebCache::Capture::Simple preserves PerlIO layers, both those set
before started capturing output, and those set during capture.  The
exceptions is the 'scalar' layer, which needs additional parameter,
and which for proper handling needs non-core module PerlIO::Util.

No care was taken to handle the following special cases (prior to
starting capture): closed STDOUT, STDOUT reopened to scalar reference,
tied STDOUT.  You shouldn't modify STDOUT during capture.

Includes separate tests for capturing output in
t9504/test_capture_interface.pl which is run as external test from
t9504-gitweb-capture-interface.sh.  It tests capturing of utf8 data
printed in :utf8 mode, and of binary data (containing invalid utf8) in
:raw mode.

Note that nested capturing doesn't work (and probably couldn't be made
to work when capturing to in-memory file), but this feature wouldn't
be needed for capturing gitweb output (to cache it).


This patch was based on "gitweb: add output buffering and associated
functions" patch by John 'Warthog9' Hawley (J.H.) in "Gitweb caching v7=
"
series, and on code of Capture::Tiny by David Golden (Apache License 2.=
0).

Based-on-work-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
In previous version of this series the basic (default) capturing
engine was GitwebCache::Capture::SelectFH, which made use of
select(FH) to change default filehandle used for print and printf
without filehandle argument (print LIST).  This required changing
  binmode STDOUT, <mode>
to
  binmode select(), <mode>
in gitweb.perl, which is now not necessary.

To simplify code this time we don't use GitwebCache::Capture as base
class providing common features, but we reserve space to add it if we
feel it necessary (e.g. when adding more capturing engines).

Even re-layering is probably not necessary in the case of gitweb, as
we set ':utf8' mode at beginning, and if we change it to ':raw' it is
always after we started capture.

Original "Gitweb caching v7" used capturing to in-memory files in the
case when caching was disabled; in my minimal fixup i.e. in the
"Gitweb caching v7.x" threads capturing to in-memory file is not done
at all; output is redirected straight to cache file (or equivalent).
The same would be done later in this series.

 gitweb/lib/GitwebCache/Capture/Simple.pm           |   96 ++++++++++++=
++++++++
 ...erface.sh =3D> t9504-gitweb-capture-interface.sh} |   10 +-
 t/t9504/test_capture_interface.pl                  |   91 ++++++++++++=
+++++++
 3 files changed, 192 insertions(+), 5 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/Capture/Simple.pm
 copy t/{t9503-gitweb-caching-interface.sh =3D> t9504-gitweb-capture-in=
terface.sh} (66%)
 create mode 100755 t/t9504/test_capture_interface.pl

diff --git a/gitweb/lib/GitwebCache/Capture/Simple.pm b/gitweb/lib/Gitw=
ebCache/Capture/Simple.pm
new file mode 100644
index 0000000..3585e58
--- /dev/null
+++ b/gitweb/lib/GitwebCache/Capture/Simple.pm
@@ -0,0 +1,96 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+#
+# This program is licensed under the GPLv2
+
+#
+# Simple output capturing via redirecting STDOUT to in-memory file.
+#
+
+# This is the same mechanism that Capture::Tiny uses, only simpler;
+# we don't capture STDERR at all, we don't tee, we don't support
+# capturing output of external commands.
+
+package GitwebCache::Capture::Simple;
+
+use strict;
+use warnings;
+
+use PerlIO;
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
+	my ($self, $code) =3D @_;
+
+	$self->capture_start();
+	$code->();
+	return $self->capture_stop();
+}
+
+# --------------------------------------------------------------------=
--
+
+# Start capturing data (STDOUT)
+sub capture_start {
+	my $self =3D shift;
+
+	# save copy of real STDOUT via duplicating it
+	my @layers =3D PerlIO::get_layers(\*STDOUT);
+	open $self->{'orig_stdout'}, ">&", \*STDOUT
+		or die "Couldn't dup STDOUT for capture: $!";
+
+	# close STDOUT, so that it isn't used anymode (to have it fd0)
+	close STDOUT;
+
+	# reopen STDOUT as in-memory file
+	$self->{'data'} =3D '';
+	unless (open STDOUT, '>', \$self->{'data'}) {
+		open STDOUT, '>&', fileno($self->{'orig_stdout'});
+		die "Couldn't reopen STDOUT as in-memory file for capture: $!";
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
+	# close in-memory file, and restore original STDOUT
+	my @layers =3D PerlIO::get_layers(\*STDOUT);
+	close STDOUT;
+	open STDOUT, '>&', fileno($self->{'orig_stdout'});
+	_relayer(\*STDOUT, \@layers);
+
+	return $self->{'data'};
+}
+
+# taken from Capture::Tiny by David Golden, Apache License 2.0
+# with debugging stripped out, and added filtering out 'scalar' layer
+sub _relayer {
+	my ($fh, $layers) =3D @_;
+
+	my %seen =3D ( unix =3D> 1, perlio =3D> 1, scalar =3D> 1 ); # filter =
these out
+	my @unique =3D grep { !$seen{$_}++ } @$layers;
+
+	binmode($fh, join(":", ":raw", @unique));
+}
+
+
+1;
+__END__
+# end of package GitwebCache::Capture::Simple
diff --git a/t/t9503-gitweb-caching-interface.sh b/t/t9504-gitweb-captu=
re-interface.sh
similarity index 66%
copy from t/t9503-gitweb-caching-interface.sh
copy to t/t9504-gitweb-capture-interface.sh
index 819da1d..82623f1 100755
--- a/t/t9503-gitweb-caching-interface.sh
+++ b/t/t9504-gitweb-capture-interface.sh
@@ -3,10 +3,10 @@
 # Copyright (c) 2010 Jakub Narebski
 #
=20
-test_description=3D'gitweb caching interface
+test_description=3D'gitweb capturing interface
=20
-This test checks caching interface used in gitweb caching, and caching
-infrastructure (GitwebCache::* modules).'
+This test checks capturing interface used for capturing gitweb output
+in gitweb caching (GitwebCache::Capture* modules).'
=20
 # for now we are running only cache interface tests
 . ./test-lib.sh
@@ -28,7 +28,7 @@ fi
 test_external_has_tap=3D1
=20
 test_external \
-	'GitwebCache::* Perl API (in gitweb/lib/)' \
-	"$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
+	'GitwebCache::Capture Perl API (in gitweb/lib/)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9504/test_capture_interface.pl
=20
 test_done
diff --git a/t/t9504/test_capture_interface.pl b/t/t9504/test_capture_i=
nterface.pl
new file mode 100755
index 0000000..47ab804
--- /dev/null
+++ b/t/t9504/test_capture_interface.pl
@@ -0,0 +1,91 @@
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
+use_ok('GitwebCache::Capture::Simple');
+diag("Using lib '$INC[0]'");
+diag("Testing '$INC{'GitwebCache/Capture/Simple.pm'}'");
+
+# Test setting up capture
+#
+my $capture =3D new_ok('GitwebCache::Capture::Simple' =3D> [], 'The $c=
apture');
+
+# Test capturing
+#
+sub capture_block (&) {
+	return $capture->capture(shift);
+}
+
+diag('Should not print anything except test results and diagnostic');
+my $test_data =3D 'Capture this';
+my $captured =3D capture_block {
+	print $test_data;
+};
+is($captured, $test_data, 'capture simple data');
+
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
+# Test nested capturing
+#
+TODO: {
+	local $TODO =3D "not required for capturing gitweb output";
+	no warnings;
+
+	my $outer_capture =3D GitwebCache::Capture::Simple->new();
+	$captured =3D $outer_capture->capture(sub {
+		print "pre|";
+		my $captured =3D $capture->capture(sub {
+			print "INNER";
+		});
+		print lc($captured);
+		print "|post";
+	});
+	is($captured, "pre|inner|post", 'nested capture');
+}
+
+SKIP: {
+	skip "Capture::Tiny not available", 1
+		unless eval { require Capture::Tiny; };
+
+	$captured =3D Capture::Tiny::capture(sub {
+		my $inner =3D $capture->capture(sub {
+			print "INNER";
+		});
+	});
+	is($captured, '', "doesn't print while capturing");
+}
+
+done_testing();
+
+# Local Variables:
+# coding: utf-8
+# End:
--=20
1.7.3
