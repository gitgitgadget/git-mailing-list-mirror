From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 08/17] gitweb/lib - Alternate ways of capturing output
Date: Mon, 14 Jun 2010 18:08:20 +0200
Message-ID: <1276531710-22945-9-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEx-0002Dq-GL
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab0FNQJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44776 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab0FNQIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:50 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649600fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4rBftJaY/P7xZ3UqcSd8ydWtRDaPXEG9rAcL6EeR3MU=;
        b=ClB1PLOTNMIJYQtVk6Zmg4NfUdgb38ezreG4ukw4dPapTjna/IKl51ydg3YCKKoImg
         izeS9+dL+1Hyt6zVM+j92vxii5cAfJ6UcgVqX+VcE+UXYFtJxszkfHfLY1IHTwER8aCk
         GQTYpSbGuak5if1YrvZg2BZWluaXKA6RY2ugo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=N2lMbxPSYkSfrHvQ2TEfUciod363lIL7yWhJO/5b/JAfy5+lMVbxG4pAcsu2XEgMfs
         vvMavBYIG7P2epULIANi6r1qD9YDFurwHMkSleikd+WS9gg7tMuoYDJNWbhd6Qdc0+lZ
         bPiph/1ABtkffU4gA1qUpbbuezCmC4Cd1z/Bo=
Received: by 10.223.29.156 with SMTP id q28mr5642164fac.77.1276531729777;
        Mon, 14 Jun 2010 09:08:49 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149107>

Besides GitwebCache::Capture::SelectFH, which uses select(FH) to
redirect 'print LIST' and 'printf FORMAT, LIST' to in-memory file to
capture output, add GitwebCache::Capture::TiedCapture which uses
tie-ing filehandle to capture output, and GitwebCache::Capture::PerlIO
which uses push_layer method from non-core PerlIO::Util module to
capture output.

Add test (which canbe run standalone) for all those implementations,
checking ':utf8' and ':raw' output, and benchmark comparing them
(includes example benchmark tests).  Please note that the test for
alternate implementations is not run from t/t9503-gitweb-caching.sh
test.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/lib/GitwebCache/Capture/PerlIO.pm      |   79 ++++++++++
 gitweb/lib/GitwebCache/Capture/TiedCapture.pm |  149 +++++++++++++++++++
 t/t9503/benchmark_capture_implementations.pl  |  198 +++++++++++++++++++++++++
 3 files changed, 426 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/Capture/PerlIO.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/TiedCapture.pm
 create mode 100755 t/t9503/benchmark_capture_implementations.pl

diff --git a/gitweb/lib/GitwebCache/Capture/PerlIO.pm b/gitweb/lib/GitwebCache/Capture/PerlIO.pm
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
+our @EXPORT      = @GitwebCache::Capture::EXPORT;
+our @EXPORT_OK   = @GitwebCache::Capture::EXPORT_OK;
+our %EXPORT_TAGS = %GitwebCache::Capture::EXPORT_TAGS;
+
+# Constructor
+sub new {
+	my $proto = shift;
+
+	my $class = ref($proto) || $proto;
+	my $self  = {};
+	$self = bless($self, $class);
+
+	$self->{'data'} = '';
+
+	return $self;
+}
+
+# Start capturing data (STDOUT)
+# (printed using 'print <sth>' or 'printf <sth>')
+sub start {
+	my $self = shift;
+
+	$self->{'data'}    = '';
+	*STDOUT->push_layer('scalar' => \$self->{'data'});
+
+	# push ':utf8' on top, if it was on top
+	*STDOUT->push_layer(':utf8')
+		if ((*STDOUT->get_layers())[-2] eq 'utf8');
+}
+
+# Stop capturing data (required for die_error)
+sub stop {
+	my $self = shift;
+
+	# return if we didn't start capturing
+	my @layers = *STDOUT->get_layers();
+	return unless grep { $_ eq 'scalar' } @layers;
+
+	my $was_utf8 = $layers[-1] eq 'utf8';
+	# stop saving to scalar, i.e. remove topmost 'scalar' layer,
+	# but remember that 'utf8' layer might be on top of it
+	while ((my $layer = *STDOUT->pop_layer())) {
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
diff --git a/gitweb/lib/GitwebCache/Capture/TiedCapture.pm b/gitweb/lib/GitwebCache/Capture/TiedCapture.pm
new file mode 100644
index 0000000..e7cc2e3
--- /dev/null
+++ b/gitweb/lib/GitwebCache/Capture/TiedCapture.pm
@@ -0,0 +1,149 @@
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
+our @EXPORT      = @GitwebCache::Capture::EXPORT;
+our @EXPORT_OK   = @GitwebCache::Capture::EXPORT_OK;
+our %EXPORT_TAGS = %GitwebCache::Capture::EXPORT_TAGS;
+
+# Constructor
+sub new {
+	my $proto = shift;
+
+	my $class = ref($proto) || $proto;
+	my $self  = {};
+	$self = bless($self, $class);
+
+	$self->{'data'} = '';
+	$self->{'tied'} = undef;
+
+	return $self;
+}
+
+# Start capturing data (STDOUT)
+# (printed using 'print <sth>' or 'printf <sth>')
+sub start {
+	my $self = shift;
+
+	# savie tie
+	$self->{'tied'} = tied *STDOUT;
+
+	$self->{'data'} = '';
+	tie *STDOUT, 'GitwebCache::TiedCapture', \$self->{'data'};
+
+	# re-binmode, so that tied class would pick it up
+	binmode STDOUT,
+		(PerlIO::get_layers(*STDOUT))[-1] eq 'utf8' ? ':utf8' : ':raw';
+}
+
+# Stop capturing data (required for die_error)
+sub stop {
+	my $self = shift;
+
+	# return if we didn't start capturing
+	return unless tied(*STDOUT)->isa('GitwebCache::TiedCapture');
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
+
+########################################################################
+
+package GitwebCache::TiedCapture;
+
+our $VERSION = '0.001';
+$VERSION = eval $VERSION;
+
+use utf8; # not strictly necessary: utf8::* is in core
+use strict;
+use warnings;
+
+sub TIEHANDLE {
+	my ($proto, $dataref) = @_;
+	my $class = ref($proto) || $proto;
+	my $self = {};
+	$self = bless($self, $class);
+	$self->{'scalar'} = $dataref;
+	$self->{'binmode'} = ':utf8';
+	return $self;
+}
+
+sub append_str {
+	my ($self, $str) = @_;
+	utf8::encode($str) if ($self->{'binmode'} eq ':utf8');
+	${$self->{'scalar'}} .= $str;
+}
+
+sub WRITE {
+	my ($self, $buffer, $length, $offset) = @_;
+	$self->append_str(substr($buffer, $offset, $length));
+}
+
+sub PRINT {
+	my $self = shift;
+	$self->append_str(join('',@_));
+}
+
+sub PRINTF {
+	my $self = shift;
+	$self->append_str(sprintf(@_));
+}
+
+sub BINMODE {
+	my $self = shift;
+	$self->{'mode'} = shift || ':raw';
+}
+
+#sub UNTIE {
+#	local $^W = 0;
+#}
+
+1;
+
+########################################################################
+
+package Tie::Restore;
+# Written by Robby Walker ( webmaster@pointwriter.com )
+# for Point Writer ( http://www.pointwriter.com/ ).
+
+our $VERSION = '0.11';
+$VERSION = eval $VERSION;
+
+# $object = tied %hash;
+# tie %hash, 'Tie::Restore', $object;
+
+sub TIESCALAR { $_[1] }
+sub TIEARRAY  { $_[1] }
+sub TIEHASH   { $_[1] }
+sub TIEHANDLE { $_[1] }
+
+1;
+
+
+1;
+__END__
+# end of package GitwebCache::Capture::TiedCapture;
diff --git a/t/t9503/benchmark_capture_implementations.pl b/t/t9503/benchmark_capture_implementations.pl
new file mode 100755
index 0000000..73806a3
--- /dev/null
+++ b/t/t9503/benchmark_capture_implementations.pl
@@ -0,0 +1,198 @@
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
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
+}
+use lib __DIR__."/../../gitweb/lib";
+
+# ....................................................................
+
+# Load modules (without importing)
+#
+my @modules =
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
+my @captures = map { $_->new() } @modules;
+
+my $test_data = <<'EOF';
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
+my $repeat = 100;
+sub capture_output {
+	my ($class, $mode) = @_;
+
+	$class->start();
+	binmode select(), $mode if defined($mode);
+	print $test_data for (1..$repeat);
+
+	return $class->stop();
+}
+
+my %codehash;
+for (my $i = 0; $i < @captures; $i++) {
+	my $capture = $captures[$i];
+	my $name = ref($capture);
+	$name =~ s/^.*:://;
+
+	$codehash{$name} = sub { $captured_output[$i] = capture_output($capture) };
+}
+
+# ....................................................................
+
+my $test_other_modules = 0;
+
+if ($test_other_modules) {
+
+	if (eval { require Capture::Tiny; 1; }) {
+		$codehash{'Capture::Tiny'} = sub {
+			my ($stdout, $stderr) = Capture::Tiny::capture(sub {
+				print $test_data for (1..$repeat);
+			});
+			print STDERR $stderr if defined($stderr);
+		};
+	}
+
+	if (eval { require IO::CaptureOutput; 1; }) {
+		$codehash{'IO::CaptureOutput'} = sub {
+			my ($stdout, $stderr);
+			IO::CaptureOutput::capture(sub {
+				print $test_data for (1..$repeat);
+			}, \$stdout, \$stderr);
+			print STDERR $stderr if defined($stderr);
+		};
+		# somehow it interferes with capturing in GitwebCache::Capture::PerlIO
+		delete $codehash{'PerlIO'};
+	}
+
+	if (eval { require IO::Capture::Stdout; 1; }) {
+		$codehash{'IO::Capture'} = sub {
+			my $capture = IO::Capture::Stdout->new();
+
+			$capture->start();
+			print $test_data for (1..$repeat);
+			$capture->stop();
+
+			my $captured_output = join('', $capture->read());
+		};
+	}
+} # end if ($test_other_modules)
+
+# ....................................................................
+
+print "Capturing $repeat x ".length($test_data).
+      " = ".($repeat * length($test_data))." characters\n";
+my $count = -10; # CPU seconds
+my $result = timethese($count, \%codehash);
+cmpthese($result);
+
+#if (exists $codehash{PerlIO}) {
+#	cmpthese(-10, {
+#		'PerlIO::get_layers'  => sub { PerlIO::get_layers(*STDOUT); },
+#		'PerlIO::Util method' => sub { *STDOUT->get_layers(); },
+#	});
+#}
+
+1;
+__END__
+## EXAMPLE OUTPUT ##
+#
+## 1 x $test_data, PerlIO using *STDOUT->get_layers();
+# Benchmark: running PerlIO, SelectFH, TiedCapture for at least 10 CPU seconds...
+#      PerlIO:  9 wallclock secs (10.38 usr +  0.13 sys = 10.51 CPU) @  9676.31/s (n=101698)
+#    SelectFH: 12 wallclock secs (10.51 usr +  0.02 sys = 10.53 CPU) @ 12294.21/s (n=129458)
+# TiedCapture: 10 wallclock secs (10.24 usr +  0.06 sys = 10.30 CPU) @  9489.22/s (n=97739)
+#                Rate TiedCapture      PerlIO    SelectFH
+# TiedCapture  9489/s          --         -2%        -23%
+# PerlIO       9676/s          2%          --        -21%
+# SelectFH    12294/s         30%         27%          --
+#
+## 10 x $test_data, PerlIO using *STDOUT->get_layers();
+# Benchmark: running PerlIO, SelectFH, TiedCapture for at least 10 CPU seconds...
+#      PerlIO:  9 wallclock secs (10.47 usr +  0.07 sys = 10.54 CPU) @ 7558.35/s (n=79665)
+#    SelectFH: 11 wallclock secs (10.36 usr +  0.04 sys = 10.40 CPU) @ 8970.87/s (n=93297)
+# TiedCapture: 11 wallclock secs (10.45 usr +  0.02 sys = 10.47 CPU) @ 2602.77/s (n=27251)
+#               Rate TiedCapture      PerlIO    SelectFH
+# TiedCapture 2603/s          --        -66%        -71%
+# PerlIO      7558/s        190%          --        -16%
+# SelectFH    8971/s        245%         19%          --
+#
+## 100 x $test_data, PerlIO using *STDOUT->get_layers();
+# Benchmark: running PerlIO, SelectFH, TiedCapture for at least 50 CPU seconds...
+#      PerlIO: 67 wallclock secs (35.28 usr + 17.82 sys = 53.10 CPU) @ 832.41/s (n=44201)
+#    SelectFH: 73 wallclock secs (33.83 usr + 18.63 sys = 52.46 CPU) @ 830.06/s (n=43545)
+# TiedCapture: 71 wallclock secs (50.93 usr +  0.41 sys = 51.34 CPU) @  95.31/s (n=4893)
+#               Rate TiedCapture    SelectFH      PerlIO
+# TiedCapture 95.3/s          --        -89%        -89%
+# SelectFH     830/s        771%          --         -0%
+# PerlIO       832/s        773%          0%          --
+#
+## 100 x $test_data, PerlIO using mix of *STDOUT->get_layers() and PerlIO::get_layers(*STDOUT);
+# Capturing 100 x 1314 = 131400 characters
+# Benchmark: timing 25000 iterations of PerlIO, SelectFH, TiedCapture...
+#      PerlIO:  30 wallclock secs  (19.05 usr + 10.29 sys =  29.34 CPU) @ 852.08/s (n=25000)
+#    SelectFH:  30 wallclock secs  (18.95 usr + 10.26 sys =  29.21 CPU) @ 855.87/s (n=25000)
+# TiedCapture: 307 wallclock secs (267.37 usr +  2.95 sys = 270.32 CPU) @  92.48/s (n=25000)
+#               Rate TiedCapture      PerlIO    SelectFH
+# TiedCapture 92.5/s          --        -89%        -89%
+# PerlIO       852/s        821%          --         -0%
+# SelectFH     856/s        825%          0%          --
+#
+## 100 x $test_data (IO::CaptureOutput interferes with GitwebCache::Capture::PerlIO)
+# Capturing 100 x 1314 = 131400 characters
+# Benchmark: running IO::CaptureOutput, SelectFH, TiedCapture for at least 10 CPU seconds...
+# IO::CaptureOutput: 12 wallclock secs ( 5.12 usr +  5.63 sys = 10.75 CPU) @ 126.60/s (n=1361)
+#          SelectFH: 12 wallclock secs ( 6.93 usr +  3.45 sys = 10.38 CPU) @ 808.29/s (n=8390)
+#       TiedCapture: 11 wallclock secs (10.11 usr +  0.01 sys = 10.12 CPU) @ 103.26/s (n=1045)
+#                    Rate       TiedCapture IO::CaptureOutput          SelectFH
+# TiedCapture       103/s                --              -18%              -87%
+# IO::CaptureOutput 127/s               23%                --              -84%
+# SelectFH          808/s              683%              538%                --
+#
+## PerlIO::get_layers   == PerlIO::get_layers(*STDOUT)
+## PerlIU::Util method  == *STDOUT->get_layers()
+#                        Rate PerlIO::Util method  PerlIO::get_layers
+# PerlIO::Util method 54405/s                  --                -38%
+# PerlIO::get_layers  87672/s                 61%                  --
-- 
1.7.0.1
