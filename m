From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] perl: make Git.pm use new Git::Config module
Date: Mon,  6 Apr 2009 11:46:16 +1200
Message-ID: <1238975176-14354-2-git-send-email-sam.vilain@catalyst.net.nz>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Petr Baudis <pasky@suse.cz>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 02:23:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqcce-0005Og-7x
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 02:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbZDFAF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 20:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbZDFAF2
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 20:05:28 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:34174 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZDFAF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 20:05:27 -0400
X-Greylist: delayed 1130 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Apr 2009 20:05:27 EDT
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <sam.vilain@catalyst.net.nz>)
	id 1Lqc2a-0003KK-TH; Mon, 06 Apr 2009 11:46:16 +1200
X-Mailer: git-send-email 1.5.5.1.50.g1d36.dirty
In-Reply-To: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115742>

Plug these two modules together.  The only minor API difference is that
in void context (ie, return value is not being used), the new Git::Config
function does not try to unpack the value.  So, the exist test - which was
testing an error condition - must be changed to actually try to retrieve
the values so that the exceptions can happen.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 perl/Git.pm     |  103 +++++++++++++++++++++++++++----------------------------
 t/t9700/test.pl |    4 +-
 2 files changed, 53 insertions(+), 54 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 7d7f2b1..3141b41 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -550,32 +550,38 @@ does. In scalar context requires the variable to be set only one time
 (exception is thrown otherwise), in array context returns allows the
 variable to be set multiple times and returns all the values.
 
-This currently wraps command('config') so it is not so fast.
+This delegates via L<Git::Config> for cached config file access.  To
+force a re-read of the configuration, call C<$git-E<gt>config->read>
 
-=cut
+=item config
 
-sub config {
-	my ($self, $var) = _maybe_self(@_);
+With no arguments, the C<config> method returns a L<Git::Config>
+object.  See L<Git::Config> for the API information.
 
-	try {
-		my @cmd = ('config');
-		unshift @cmd, $self if $self;
-		if (wantarray) {
-			return command(@cmd, '--get-all', $var);
-		} else {
-			return command_oneline(@cmd, '--get', $var);
-		}
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return;
-		} else {
-			throw $E;
-		}
+=item config ( VARIABLE => value )
+
+With two arguments, the configuration is updated with the passed
+value.
+
+=cut
+
+sub _config {
+	my ($self) = _maybe_self_new(@_);
+	$self->{config} ||= do {
+		require Git::Config;
+		Git::Config->new($self);
 	};
 }
 
+sub config {
+	(my $self, @_) = _maybe_self_new(@_);
+	if (@_) {
+		return $self->_config->config(@_);
+	}
+	else {
+		return $self->_config;
+	}
+}
 
 =item config_bool ( VARIABLE )
 
@@ -583,28 +589,21 @@ Retrieve the bool configuration C<VARIABLE>. The return value
 is usable as a boolean in perl (and C<undef> if it's not defined,
 of course).
 
-This currently wraps command('config') so it is not so fast.
+This delegates via L<Git::Config> for cached config file access.
+
+=item config_bool ( VARIABLE => value )
+
+Sets a boolean slot to the given value.  This always writes 'true' or
+'false' to the configuration file, regardless of the value passed.
 
 =cut
 
 sub config_bool {
-	my ($self, $var) = _maybe_self(@_);
+	(my ($self, $var), @_) = _maybe_self_new(@_);
 
-	try {
-		my @cmd = ('config', '--bool', '--get', $var);
-		unshift @cmd, $self if $self;
-		my $val = command_oneline(@cmd);
-		return undef unless defined $val;
-		return $val eq 'true';
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return undef;
-		} else {
-			throw $E;
-		}
-	};
+	my $conf = $self->_config;
+	$conf->type($var => "boolean");
+	$conf->config($var, @_);
 }
 
 =item config_int ( VARIABLE )
@@ -615,26 +614,22 @@ or 'g' in the config file will cause the value to be multiplied
 by 1024, 1048576 (1024^2), or 1073741824 (1024^3) prior to output.
 It would return C<undef> if configuration variable is not defined,
 
-This currently wraps command('config') so it is not so fast.
+This delegates via L<Git::Config> for cached config file access.
+
+=item config_int ( VARIABLE => value )
+
+Sets a integer slot to the given value.  This method will reduce the
+written value to the shortest way to express the given number; eg
+1024 is written as C<1k> and 16777216 will be written as C<16M>.
 
 =cut
 
 sub config_int {
-	my ($self, $var) = _maybe_self(@_);
+	(my ($self, $var), @_) = _maybe_self_new(@_);
 
-	try {
-		my @cmd = ('config', '--int', '--get', $var);
-		unshift @cmd, $self if $self;
-		return command_oneline(@cmd);
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return undef;
-		} else {
-			throw $E;
-		}
-	};
+	my $conf = $self->_config;
+	$conf->type($var => "integer");
+	$conf->config($var, @_);
 }
 
 =item get_colorbool ( NAME )
@@ -1204,6 +1199,7 @@ either version 2, or (at your option) any later version.
 
 =cut
 
+our $_self;
 
 # Take raw method argument list and return ($obj, @args) in case
 # the method was called upon an instance and (undef, @args) if
@@ -1211,6 +1207,9 @@ either version 2, or (at your option) any later version.
 sub _maybe_self {
 	UNIVERSAL::isa($_[0], 'Git') ? @_ : (undef, @_);
 }
+sub _maybe_self_new {
+	UNIVERSAL::isa($_[0], 'Git') ? @_ : ($_self||=Git->repository, @_);
+}
 
 # Check if the command id is something reasonable.
 sub _check_valid_cmd {
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 697daf3..1b94633 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -35,9 +35,9 @@ is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
 # Save and restore STDERR; we will probably extract this into a
 # "dies_ok" method and possibly move the STDERR handling to Git.pm.
 open our $tmpstderr, ">&STDERR" or die "cannot save STDERR"; close STDERR;
-eval { $r->config("test.dupstring") };
+eval { my $x = $r->config("test.dupstring") };
 ok($@, "config: duplicate entry in scalar context fails");
-eval { $r->config_bool("test.boolother") };
+eval { my $x = $r->config_bool("test.boolother") };
 ok($@, "config_bool: non-boolean values fail");
 open STDERR, ">&", $tmpstderr or die "cannot restore STDERR";
 
-- 
1.6.0
