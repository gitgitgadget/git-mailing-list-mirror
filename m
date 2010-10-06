From: Jakub Narebski <jnareb@gmail.com>
Subject: =?UTF-8?q?=5BPoC=20PATCHv5=2021/17=5D=20gitweb/lib=20-=20Alternate=20ways=20of=20capturing=20output?=
Date: Thu,  7 Oct 2010 00:02:06 +0200
Message-ID: <1286402526-13143-22-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5s-0002Gb-Pa
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264Ab0JFWD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:03:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35042 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823Ab0JFWDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:03:17 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49424bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pZryUMEQM8zjSOw3cBPEP29utP4n4GueR3A510AoeuU=;
        b=iN3qPfcTcKDcpmCQZ/JrBeXLQVJJpVoVniN1qyT0ab7FN+ApQILCyNSBi7BlUDNcaC
         8QTEy1KfRSbm3G35/8RAu0vepx06lfwsepspoStrFvXBo22kBxR2XAQJamStxnNn20TX
         oDrmATUtDEw8IakZ/cWgu03EoEAsbT79hVP5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=di2uLHd9YiLZy+nXbhcq1G4SsJoxIHxKn+E1amB3ujc8YwUXg8NzDMY+i+ZoEahf+U
         u3c76ygeSP7esMYHlVtt41hvSM8UBWB6burP06V5HJ4WoTohJ7Wc8wF8v7AsEownAdXp
         HNk/y08LiyK5aDXtlIC2C8j7Tk0KWkqKFsJw0=
Received: by 10.204.79.223 with SMTP id q31mr10369127bkk.92.1286402594287;
        Wed, 06 Oct 2010 15:03:14 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.03.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:03:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158328>

Besides GitwebCache::Capture::SelectFH, which uses select(FH) to
redirect 'print LIST' and 'printf FORMAT, LIST' to in-memory file to
capture output, add GitwebCache::Capture::TiedCapture which uses
tie-ing filehandle to capture output, and GitwebCache::Capture::PerlIO
which uses push_layer method from non-core PerlIO::Util module to
capture output.

Add test (which can be run standalone) for all those implementations,
checking ':utf8' and ':raw' output, and benchmark comparing them
(includes example benchmark tests).  Please note that the test for
alternate implementations is not run from t9504 test.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
=46ormerly as patch 08/17 in previous version of series, now marked PoC
("proof of concept"), and moved to the end of series.

Differences from v4:
* GitwebCache::Capture::TiedCapture has now two (sub)versions: one
  appending data from tied operations to a string (after conversion)
  via TiedCapture::String (default), other redirecting tied operations
  to save to in-memory file via TiedCapture::PerlIO (new).

  Add tests for new TiedCapture::PerlIO.

* Tie::Restore (non-core module from CPAN) is now in separate file;
  should be probably in 'inc/' and not in 'lib/'.

* Change name of field in TiedCapture::* from 'mode' to 'binmode'.

* New example results of benchmark.

* Add test checking that all those implementations work correctly for
  capturing both ':utf8' and ':raw' printed data.

 gitweb/lib/GitwebCache/Capture/PerlIO.pm      |   79 +++++++++
 gitweb/lib/GitwebCache/Capture/TiedCapture.pm |   76 +++++++++
 gitweb/lib/Tie/Restore.pm                     |   24 +++
 gitweb/lib/TiedCapture/PerlIO.pm              |   56 ++++++
 gitweb/lib/TiedCapture/String.pm              |   53 ++++++
 t/t9504/benchmark_capture_implementations.pl  |  226 +++++++++++++++++=
++++++++
 t/t9504/test_capture_implementations.pl       |   85 +++++++++
 7 files changed, 599 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/Capture/PerlIO.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/TiedCapture.pm
 create mode 100644 gitweb/lib/Tie/Restore.pm
 create mode 100644 gitweb/lib/TiedCapture/PerlIO.pm
 create mode 100644 gitweb/lib/TiedCapture/String.pm
 create mode 100755 t/t9504/benchmark_capture_implementations.pl
 create mode 100755 t/t9504/test_capture_implementations.pl

diff --git a/gitweb/lib/GitwebCache/Capture/PerlIO.pm b/gitweb/lib/Gitw=
ebCache/Capture/PerlIO.pm
new file mode 100644
index 0000000..199aeed
--- /dev/null
+++ b/gitweb/lib/GitwebCache/Capture/PerlIO.pm
@@ -0,0 +1,79 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+#
+# This program is licensed under the GPLv2
+
+#
+# Output capturing using PerlIO layers
+#
+
+# This module requires PaerlIO::Util installed.
+
+package GitwebCache::Capture::PerlIO;
+
+use PerlIO::Util;
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
+	*STDOUT->push_layer('scalar' =3D> \$self->{'data'});
+
+	# push ':utf8' on top, if it was on top
+	*STDOUT->push_layer(':utf8')
+		if ((*STDOUT->get_layers())[-2] eq 'utf8');
+}
+
+# Stop capturing data (required for die_error)
+sub stop {
+	my $self =3D shift;
+
+	# return if we didn't start capturing
+	my @layers =3D *STDOUT->get_layers();
+	return unless grep { $_ eq 'scalar' } @layers;
+
+	my $was_utf8 =3D $layers[-1] eq 'utf8';
+	# stop saving to scalar, i.e. remove topmost 'scalar' layer,
+	# but remember that 'utf8' layer might be on top of it
+	while ((my $layer =3D *STDOUT->pop_layer())) {
+		pop @layers;
+		last if $layer eq 'scalar';
+	}
+	# restore ':utf8' mode, if needed
+	if ($was_utf8 && $layers[-1] ne 'utf8') {
+		*STDOUT->push_layer('utf8');
+	}
+
+	return $self->{'data'};
+}
+
+1;
+__END__
+# end of package GitwebCache::Capture::PerlIO;
diff --git a/gitweb/lib/GitwebCache/Capture/TiedCapture.pm b/gitweb/lib=
/GitwebCache/Capture/TiedCapture.pm
new file mode 100644
index 0000000..6bed0f8
--- /dev/null
+++ b/gitweb/lib/GitwebCache/Capture/TiedCapture.pm
@@ -0,0 +1,76 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+#
+# This program is licensed under the GPLv2
+
+#
+# Simple output capturing by tie-ing filehandle
+#
+
+package GitwebCache::Capture::TiedCapture;
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
+	$self->{'data'} =3D '';
+	$self->{'tied'} =3D undef;
+	$self->{'tie_class'} =3D shift || 'TiedCapture::String';
+	eval "require $self->{'tie_class'}";
+
+	return $self;
+}
+
+# Start capturing data (STDOUT)
+# (printed using 'print <sth>' or 'printf <sth>')
+sub start {
+	my $self =3D shift;
+
+	# savie tie
+	$self->{'tied'} =3D tied *STDOUT;
+
+	$self->{'data'} =3D '';
+	tie *STDOUT, $self->{'tie_class'}, \$self->{'data'};
+
+	# re-binmode, so that tied class would pick it up
+	binmode STDOUT,
+		(PerlIO::get_layers(*STDOUT))[-1] eq 'utf8' ? ':utf8' : ':raw';
+}
+
+# Stop capturing data (required for die_error)
+sub stop {
+	my $self =3D shift;
+
+	# return if we didn't start capturing
+	return unless tied(*STDOUT)->isa($self->{'tie_class'});
+
+	# restore ties, if there were any
+	untie *STDOUT;
+	if ($self->{'tied'}) {
+		tie *STDOUT, 'Tie::Restore', $self->{'tied'};
+	}
+
+	return $self->{'data'};
+}
+
+1;
+__END__
+# end of package GitwebCache::Capture::TiedCapture;
diff --git a/gitweb/lib/Tie/Restore.pm b/gitweb/lib/Tie/Restore.pm
new file mode 100644
index 0000000..687434e
--- /dev/null
+++ b/gitweb/lib/Tie/Restore.pm
@@ -0,0 +1,24 @@
+######################################################################=
##
+# This package should probably be put in `gitweb/inc/' instead
+#
+# taken from http://search.cpan.org/~robwalker/Tie-Restore-0.11/Restor=
e.pm
+# with POD documentation stripped out
+
+package Tie::Restore;
+# Written by Robby Walker ( webmaster@pointwriter.com )
+# for Point Writer ( http://www.pointwriter.com/ ).
+
+our $VERSION =3D '0.11';
+$VERSION =3D eval $VERSION;
+
+# $object =3D tied %hash;                # save
+# tie %hash, 'Tie::Restore', $object;  # restore
+
+sub TIESCALAR { $_[1] }
+sub TIEARRAY  { $_[1] }
+sub TIEHASH   { $_[1] }
+sub TIEHANDLE { $_[1] }
+
+1;
+__END__
+# end of package Tie::Restore
diff --git a/gitweb/lib/TiedCapture/PerlIO.pm b/gitweb/lib/TiedCapture/=
PerlIO.pm
new file mode 100644
index 0000000..4bbd724
--- /dev/null
+++ b/gitweb/lib/TiedCapture/PerlIO.pm
@@ -0,0 +1,56 @@
+######################################################################=
##
+
+package TiedCapture::PerlIO;
+
+our $VERSION =3D '0.001';
+$VERSION =3D eval $VERSION;
+
+use strict;
+use warnings;
+
+use PerlIO;
+
+sub TIEHANDLE {
+	my ($proto, $dataref) =3D @_;
+	my $class =3D ref($proto) || $proto;
+	my $self =3D {};
+	$self =3D bless($self, $class);
+	$self->{'scalar'} =3D $dataref;
+	$self->{'binmode'} =3D ':utf8';
+
+	$self->{'scalar_fh'} =3D undef;
+	open $self->{'scalar_fh'}, '>', $self->{'scalar'}
+		or die "Couldn't open in-memory file for capture: $!";
+
+	return $self;
+}
+
+sub WRITE {
+	my $self =3D shift;
+	syswrite $self->{'scalar_fh'}, @_;
+}
+
+sub PRINT {
+	my $self =3D shift;
+	print { $self->{'scalar_fh'} } @_;
+}
+
+sub PRINTF {
+	my $self =3D shift;
+	printf { $self->{'scalar_fh'} } @_;
+}
+
+sub BINMODE {
+	my $self =3D shift;
+	$self->{'binmode'} =3D shift || ':raw';
+	binmode $self->{'scalar_fh'}, $self->{'binmode'};
+}
+
+#sub UNTIE {
+#	close $self->{'scalar_fh'};
+#	$self->{'scalar_fh'} =3D undef;
+#}
+
+1;
+__END__
+# end of package TiedCapture::PerlIO
diff --git a/gitweb/lib/TiedCapture/String.pm b/gitweb/lib/TiedCapture/=
String.pm
new file mode 100644
index 0000000..72b15a7
--- /dev/null
+++ b/gitweb/lib/TiedCapture/String.pm
@@ -0,0 +1,53 @@
+######################################################################=
##
+
+package TiedCapture::String;
+
+our $VERSION =3D '0.001';
+$VERSION =3D eval $VERSION;
+
+use strict;
+use warnings;
+
+sub TIEHANDLE {
+	my ($proto, $dataref) =3D @_;
+	my $class =3D ref($proto) || $proto;
+	my $self =3D {};
+	$self =3D bless($self, $class);
+	$self->{'scalar'} =3D $dataref;
+	$self->{'binmode'} =3D ':utf8';
+	return $self;
+}
+
+sub append_str {
+	my ($self, $str) =3D @_;
+	utf8::encode($str) if ($self->{'binmode'} eq ':utf8');
+	${$self->{'scalar'}} .=3D $str;
+}
+
+sub WRITE {
+	my ($self, $buffer, $length, $offset) =3D @_;
+	$self->append_str(substr($buffer, $offset, $length));
+}
+
+sub PRINT {
+	my $self =3D shift;
+	$self->append_str(join('',@_));
+}
+
+sub PRINTF {
+	my $self =3D shift;
+	$self->append_str(sprintf(@_));
+}
+
+sub BINMODE {
+	my $self =3D shift;
+	$self->{'binmode'} =3D shift || ':raw';
+}
+
+#sub UNTIE {
+#	local $^W =3D 0;
+#}
+
+1;
+__END__
+# end of package TiedCapture::String
diff --git a/t/t9504/benchmark_capture_implementations.pl b/t/t9504/ben=
chmark_capture_implementations.pl
new file mode 100755
index 0000000..588c1dc
--- /dev/null
+++ b/t/t9504/benchmark_capture_implementations.pl
@@ -0,0 +1,226 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use File::Spec;
+use File::Path;
+use Benchmark qw(:all);
+
+use PerlIO;
+
+# benchmark source version
+sub __DIR__ () {
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1])=
;
+}
+use lib __DIR__."/../../gitweb/lib";
+
+# ....................................................................
+
+# Load modules (without importing)
+#
+my @modules =3D
+	map { "GitwebCache::Capture::$_" }
+	qw(SelectFH TiedCapture);
+foreach my $mod (@modules) {
+	eval "require $mod";
+}
+if (eval { require PerlIO::Util; 1 }) {
+	require GitwebCache::Capture::PerlIO;
+	push @modules, 'GitwebCache::Capture::PerlIO';
+}
+
+# Set up capturing, for each module
+#
+my @captures =3D map { $_->new() } @modules;
+push @captures, GitwebCache::Capture::TiedCapture->new('TiedCapture::P=
erlIO');
+
+
+my $test_data =3D <<'EOF';
+Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
+eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
+minim veniam, quis nostrud exercitation ullamco laboris nisi ut
+aliquip ex ea commodo consequat. Duis aute irure dolor in
+reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
+pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
+culpa qui officia deserunt mollit anim id est laborum.
+
+Sed ut perspiciatis unde omnis iste natus error sit voluptatem
+accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae
+ab illo inventore veritatis et quasi architecto beatae vitae dicta
+sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit
+aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos
+qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui
+dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed
+quia non numquam eius modi tempora incidunt ut labore et dolore magnam
+aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum
+exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex
+ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in
+ea voluptate velit esse quam nihil molestiae consequatur, vel illum
+qui dolorem eum fugiat quo voluptas nulla pariatur?
+EOF
+
+my @captured_output;
+my $repeat =3D 100;
+sub capture_output {
+	my ($class, $mode) =3D @_;
+
+	$class->start();
+	binmode select(), $mode if defined($mode);
+	print $test_data for (1..$repeat);
+
+	return $class->stop();
+}
+
+my %codehash;
+for (my $i =3D 0; $i < @captures; $i++) {
+	my $capture =3D $captures[$i];
+	my $name =3D ref($capture);
+	$name =3D~ s/^.*:://;
+	$name .=3D " ($captures[$i]->{'tie_class'})"
+		if $captures[$i]->{'tie_class'};
+	$name =3D~ s/TiedCapture:://;
+
+	$codehash{$name} =3D sub { $captured_output[$i] =3D capture_output($c=
apture) };
+}
+
+# ....................................................................
+
+my $test_other_modules =3D 0;
+
+if ($test_other_modules) {
+
+	if (eval { require Capture::Tiny; 1; }) {
+		$codehash{'Capture::Tiny'} =3D sub {
+			my ($stdout, $stderr) =3D Capture::Tiny::capture(sub {
+				print $test_data for (1..$repeat);
+			});
+			print STDERR $stderr if defined($stderr);
+		};
+	}
+
+	if (eval { require IO::CaptureOutput; 1; }) {
+		$codehash{'IO::CaptureOutput'} =3D sub {
+			my ($stdout, $stderr);
+			IO::CaptureOutput::capture(sub {
+				print $test_data for (1..$repeat);
+			}, \$stdout, \$stderr);
+			print STDERR $stderr if defined($stderr);
+		};
+		# somehow it interferes with capturing in GitwebCache::Capture::Perl=
IO
+		delete $codehash{'PerlIO'};
+	}
+
+	if (eval { require IO::Capture::Stdout; 1; }) {
+		$codehash{'IO::Capture'} =3D sub {
+			my $capture =3D IO::Capture::Stdout->new();
+
+			$capture->start();
+			print $test_data for (1..$repeat);
+			$capture->stop();
+
+			my $captured_output =3D join('', $capture->read());
+		};
+	}
+} # end if ($test_other_modules)
+
+# ....................................................................
+
+print "Capturing $repeat x ".length($test_data).
+      " =3D ".($repeat * length($test_data))." characters\n";
+my $count =3D -10; # CPU seconds
+my $result =3D timethese($count, \%codehash);
+cmpthese($result);
+
+#if (exists $codehash{PerlIO}) {
+#	cmpthese(-10, {
+#		'PerlIO::get_layers'  =3D> sub { PerlIO::get_layers(*STDOUT); },
+#		'PerlIO::Util method' =3D> sub { *STDOUT->get_layers(); },
+#	});
+#}
+
+1;
+__END__
+## EXAMPLE OUTPUT ##
+#
+## 1 x $test_data, PerlIO using *STDOUT->get_layers();
+# Benchmark: running PerlIO, SelectFH, TiedCapture for at least 10 CPU=
 seconds...
+#      PerlIO:  9 wallclock secs (10.38 usr +  0.13 sys =3D 10.51 CPU)=
 @  9676.31/s (n=3D101698)
+#    SelectFH: 12 wallclock secs (10.51 usr +  0.02 sys =3D 10.53 CPU)=
 @ 12294.21/s (n=3D129458)
+# TiedCapture: 10 wallclock secs (10.24 usr +  0.06 sys =3D 10.30 CPU)=
 @  9489.22/s (n=3D97739)
+#                Rate TiedCapture      PerlIO    SelectFH
+# TiedCapture  9489/s          --         -2%        -23%
+# PerlIO       9676/s          2%          --        -21%
+# SelectFH    12294/s         30%         27%          --
+#
+## 10 x $test_data, PerlIO using *STDOUT->get_layers();
+# Benchmark: running PerlIO, SelectFH, TiedCapture for at least 10 CPU=
 seconds...
+#      PerlIO:  9 wallclock secs (10.47 usr +  0.07 sys =3D 10.54 CPU)=
 @ 7558.35/s (n=3D79665)
+#    SelectFH: 11 wallclock secs (10.36 usr +  0.04 sys =3D 10.40 CPU)=
 @ 8970.87/s (n=3D93297)
+# TiedCapture: 11 wallclock secs (10.45 usr +  0.02 sys =3D 10.47 CPU)=
 @ 2602.77/s (n=3D27251)
+#               Rate TiedCapture      PerlIO    SelectFH
+# TiedCapture 2603/s          --        -66%        -71%
+# PerlIO      7558/s        190%          --        -16%
+# SelectFH    8971/s        245%         19%          --
+#
+## 100 x $test_data, PerlIO using *STDOUT->get_layers();
+# Benchmark: running PerlIO, SelectFH, TiedCapture for at least 50 CPU=
 seconds...
+#      PerlIO: 67 wallclock secs (35.28 usr + 17.82 sys =3D 53.10 CPU)=
 @ 832.41/s (n=3D44201)
+#    SelectFH: 73 wallclock secs (33.83 usr + 18.63 sys =3D 52.46 CPU)=
 @ 830.06/s (n=3D43545)
+# TiedCapture: 71 wallclock secs (50.93 usr +  0.41 sys =3D 51.34 CPU)=
 @  95.31/s (n=3D4893)
+#               Rate TiedCapture    SelectFH      PerlIO
+# TiedCapture 95.3/s          --        -89%        -89%
+# SelectFH     830/s        771%          --         -0%
+# PerlIO       832/s        773%          0%          --
+#
+## 100 x $test_data, PerlIO using mix of *STDOUT->get_layers() and Per=
lIO::get_layers(*STDOUT);
+# Capturing 100 x 1314 =3D 131400 characters
+# Benchmark: timing 25000 iterations of PerlIO, SelectFH, TiedCapture.=
=2E.
+#      PerlIO:  30 wallclock secs  (19.05 usr + 10.29 sys =3D  29.34 C=
PU) @ 852.08/s (n=3D25000)
+#    SelectFH:  30 wallclock secs  (18.95 usr + 10.26 sys =3D  29.21 C=
PU) @ 855.87/s (n=3D25000)
+# TiedCapture: 307 wallclock secs (267.37 usr +  2.95 sys =3D 270.32 C=
PU) @  92.48/s (n=3D25000)
+#               Rate TiedCapture      PerlIO    SelectFH
+# TiedCapture 92.5/s          --        -89%        -89%
+# PerlIO       852/s        821%          --         -0%
+# SelectFH     856/s        825%          0%          --
+#
+## 100 x $test_data (IO::CaptureOutput interferes with GitwebCache::Ca=
pture::PerlIO)
+# Capturing 100 x 1314 =3D 131400 characters
+# Benchmark: running IO::CaptureOutput, SelectFH, TiedCapture for at l=
east 10 CPU seconds...
+# IO::CaptureOutput: 12 wallclock secs ( 5.12 usr +  5.63 sys =3D 10.7=
5 CPU) @ 126.60/s (n=3D1361)
+#          SelectFH: 12 wallclock secs ( 6.93 usr +  3.45 sys =3D 10.3=
8 CPU) @ 808.29/s (n=3D8390)
+#       TiedCapture: 11 wallclock secs (10.11 usr +  0.01 sys =3D 10.1=
2 CPU) @ 103.26/s (n=3D1045)
+#                    Rate       TiedCapture IO::CaptureOutput         =
 SelectFH
+# TiedCapture       103/s                --              -18%         =
     -87%
+# IO::CaptureOutput 127/s               23%                --         =
     -84%
+# SelectFH          808/s              683%              538%         =
       --
+#
+## PerlIO::get_layers   =3D=3D PerlIO::get_layers(*STDOUT)
+## PerlIU::Util method  =3D=3D *STDOUT->get_layers()
+#                        Rate PerlIO::Util method  PerlIO::get_layers
+# PerlIO::Util method 54405/s                  --                -38%
+# PerlIO::get_layers  87672/s                 61%                  --
+
+##
+# Capturing 100 x 1314 =3D 131400 characters
+# Benchmark: running PerlIO, SelectFH, TiedCapture (PerlIO), TiedCaptu=
re (String)
+#   for at least 10 CPU seconds...
+#                        Rate TiedCapture (String) TiedCapture (PerlIO=
) SelectFH PerlIO
+# TiedCapture (String) 96.5/s                   --                 -76=
%     -88%   -88%
+# TiedCapture (PerlIO)  407/s                 322%                   -=
-     -48%   -48%
+# SelectFH              787/s                 715%                  93=
%       --    -0%
+# PerlIO                789/s                 717%                  94=
%       0%     --
+#
+# comment: you can see effects of perltie overhead and repeated string=
 concatenation here.
+
+##
+#
+# Capturing 100 x 1314 =3D 131400 characters
+# Benchmark: running IO::CaptureOutput, SelectFH, TiedCapture (PerlIO)=
, TiedCapture (String)
+#   for at least 10 CPU seconds...
+#                       Rate TiedCapture (String) IO::CaptureOutput Ti=
edCapture (PerlIO) SelectFH
+# TiedCapture (String) 109/s                   --               -4%   =
              -72%     -84%
+# IO::CaptureOutput    114/s                   4%                --   =
              -70%     -84%
+# TiedCapture (PerlIO) 384/s                 253%              237%   =
                --     -45%
+# SelectFH             693/s                 536%              509%   =
               80%       --
diff --git a/t/t9504/test_capture_implementations.pl b/t/t9504/test_cap=
ture_implementations.pl
new file mode 100755
index 0000000..86796ac
--- /dev/null
+++ b/t/t9504/test_capture_implementations.pl
@@ -0,0 +1,85 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use File::Spec;
+
+use Test::More;
+
+# test source version
+#use if defined($ENV{TEST_DIRECTORY}),
+#	lib =3D> "$ENV{TEST_DIRECTORY}/../gitweb/lib";
+sub __DIR__ () {
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1])=
;
+}
+use lib __DIR__."/../../gitweb/lib";
+
+# ....................................................................
+
+# Load modules
+my @modules =3D
+	map { "GitwebCache::Capture::$_" }
+	qw(SelectFH TiedCapture);
+require_ok($_) foreach @modules;
+if (eval { require PerlIO::Util; 1 }) {
+	require_ok('GitwebCache::Capture::PerlIO');
+	unshift @modules, 'GitwebCache::Capture::PerlIO';
+}
+
+# Test setting up capture
+#
+my @captures =3D map { new_ok($_ =3D> []) } @modules;
+push @captures, new_ok('GitwebCache::Capture::TiedCapture' =3D> ['Tied=
Capture::PerlIO']);
+isa_ok($_, 'GitwebCache::Capture', ref($_)) foreach @captures;
+
+# Test capturing
+#
+diag('Should not print anything except test results and diagnostic');
+
+my $test_data;
+my @captured_output;
+sub capture {
+	my ($class, $mode) =3D @_;
+
+	$class->start();
+	binmode select(), $mode if defined($mode);
+	print $test_data;
+	return $class->stop();
+}
+sub test_captures {
+	my $mode =3D shift;
+
+	@captured_output =3D map { capture($_, $mode); } @captures;
+	if ($mode eq ':utf8') {
+		utf8::decode($_) foreach @captured_output;
+	}
+	for (my $i =3D 0; $i < @captures; $i++) {
+		my $name =3D ref($captures[$i]);
+		$name .=3D " ($captures[$i]->{'tie_class'})"
+			if $captures[$i]->{'tie_class'};
+		my $output =3D $captured_output[$i];
+		is($output, $test_data, "$name captures $mode data");
+	}
+}
+
+
+binmode STDOUT, ':utf8';
+$test_data =3D 'Za=C5=BC=C3=B3=C5=82=C4=87 g=C4=99si=C4=85 ja=C5=BA=C5=
=84';
+utf8::decode($test_data);
+#diag("\$test_data =3D $test_data (decoded)\n");
+ok(utf8::is_utf8($test_data), '$test_data is utf8  (utf8::is_utf8)');
+ok(utf8::valid($test_data),   '$test_data is valid (utf8::valid)');
+test_captures(':utf8');
+
+$test_data =3D '|\x{fe}\x{ff}|\x{9F}|\000|'; # invalid utf-8
+ok(!utf8::is_utf8($test_data), '$test_data is not utf8 (utf8::is_utf8)=
');
+ok(utf8::valid($test_data),    '$test_data is valid    (utf8::valid)')=
;
+test_captures(':raw');
+
+done_testing();
+
+# Local Variables:
+# encoding: utf-8
+# End:
--=20
1.7.3
