From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 07/12] Git.pm: Better error handling
Date: Sat, 24 Jun 2006 04:34:42 +0200
Message-ID: <20060624023442.32751.28342.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtxzZ-0006iq-95
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933197AbWFXCfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933196AbWFXCfV
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:35:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62871 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933197AbWFXCfU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:35:20 -0400
Received: (qmail 352 invoked from network); 24 Jun 2006 04:34:42 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:42 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22472>

So far, errors just killed the whole program and in case of an error
inside of libgit it would be totally uncatchable. This patch makes
Git.pm throw standard Perl exceptions instead. In the future we might
subclass Error to Git::Error or something but for now Error::Simple
is more than enough.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   37 +++++++++++++++++++++----------------
 perl/Git.xs |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index dcd769b..733fec9 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -88,7 +88,8 @@ increate nonwithstanding).
 =cut
 
 
-use Carp qw(carp croak);
+use Carp qw(carp); # croak is bad - throw instead
+use Error qw(:try);
 
 require XSLoader;
 XSLoader::load('Git', $VERSION);
@@ -143,14 +144,14 @@ sub repository {
 	if (defined $args[0]) {
 		if ($#args % 2 != 1) {
 			# Not a hash.
-			$#args == 0 or croak "bad usage";
-			%opts = (Directory => $args[0]);
+			$#args == 0 or throw Error::Simple("bad usage");
+			%opts = ( Directory => $args[0] );
 		} else {
 			%opts = @args;
 		}
 
 		if ($opts{Directory}) {
-			-d $opts{Directory} or croak "Directory not found: $!";
+			-d $opts{Directory} or throw Error::Simple("Directory not found: $!");
 			if (-d $opts{Directory}."/.git") {
 				# TODO: Might make this more clever
 				$opts{WorkingCopy} = $opts{Directory};
@@ -242,11 +243,11 @@ read.
 sub command_pipe {
 	my ($self, $cmd, @args) = _maybe_self(@_);
 
-	$cmd =~ /^[a-z0-9A-Z_-]+$/ or croak "bad command: $cmd";
+	$cmd =~ /^[a-z0-9A-Z_-]+$/ or throw Error::Simple("bad command: $cmd");
 
 	my $pid = open(my $fh, "-|");
 	if (not defined $pid) {
-		croak "open failed: $!";
+		throw Error::Simple("open failed: $!");
 	} elsif ($pid == 0) {
 		_cmd_exec($self, $cmd, @args);
 	}
@@ -271,16 +272,17 @@ The function returns only after the comm
 sub command_noisy {
 	my ($self, $cmd, @args) = _maybe_self(@_);
 
-	$cmd =~ /^[a-z0-9A-Z_-]+$/ or croak "bad command: $cmd";
+	$cmd =~ /^[a-z0-9A-Z_-]+$/ or throw Error::Simple("bad command: $cmd");
 
 	my $pid = fork;
 	if (not defined $pid) {
-		croak "fork failed: $!";
+		throw Error::Simple("fork failed: $!");
 	} elsif ($pid == 0) {
 		_cmd_exec($self, $cmd, @args);
 	}
 	if (waitpid($pid, 0) > 0 and $? != 0) {
-		croak "exit status: $?";
+		# This is the best candidate for a custom exception class.
+		throw Error::Simple("exit status: $?");
 	}
 }
 
@@ -340,10 +342,10 @@ # Implemented in Git.xs.
 
 =back
 
-=head1 TODO
+=head1 ERROR HANDLING
 
-This is still fairly crude.
-We need some good way to report errors back except just dying.
+All functions are supposed to throw Perl exceptions in case of errors.
+See L<Error>.
 
 =head1 COPYRIGHT
 
@@ -372,8 +374,8 @@ sub _cmd_exec {
 		$self->{opts}->{Repository} and $ENV{'GIT_DIR'} = $self->{opts}->{Repository};
 		$self->{opts}->{WorkingCopy} and chdir($self->{opts}->{WorkingCopy});
 	}
-	xs__execv_git_cmd(@args);
-	croak "exec failed: $!";
+	_execv_git_cmd(@args);
+	die "exec failed: $!";
 }
 
 # Execute the given Git command ($_[0]) with arguments ($_[1..])
@@ -388,7 +390,8 @@ sub _cmd_close {
 			# It's just close, no point in fatalities
 			carp "error closing pipe: $!";
 		} elsif ($? >> 8) {
-			croak "exit status: ".($? >> 8);
+			# This is the best candidate for a custom exception class.
+			throw Error::Simple("exit status: ".($? >> 8));
 		}
 		# else we might e.g. closed a live stream; the command
 		# dying of SIGPIPE would drive us here.
@@ -415,6 +418,8 @@ sub _call_gate {
 		#xs_call_gate($self->{opts}->{Repository});
 	}
 
+	# Having to call throw from the C code is a sure path to insanity.
+	local $SIG{__DIE__} = sub { throw Error::Simple("@_"); };
 	&$xsfunc(@args);
 }
 
@@ -422,7 +427,7 @@ sub AUTOLOAD {
 	my $xsname;
 	our $AUTOLOAD;
 	($xsname = $AUTOLOAD) =~ s/.*:://;
-	croak "&Git::$xsname not defined" if $xsname =~ /^xs_/;
+	throw Error::Simple("&Git::$xsname not defined") if $xsname =~ /^xs_/;
 	$xsname = 'xs_'.$xsname;
 	_call_gate(\&$xsname, @_);
 }
diff --git a/perl/Git.xs b/perl/Git.xs
index 9623fdd..ebaac4b 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -8,6 +8,8 @@ #include <ctype.h>
 #include "../cache.h"
 #include "../exec_cmd.h"
 
+#define die perlyshadow_die__
+
 /* XS and Perl interface */
 #include "EXTERN.h"
 #include "perl.h"
@@ -15,11 +17,48 @@ #include "XSUB.h"
 
 #include "ppport.h"
 
+#undef die
+
+
+static char *
+report_xs(const char *prefix, const char *err, va_list params)
+{
+	static char buf[4096];
+	strcpy(buf, prefix);
+	vsnprintf(buf + strlen(prefix), 4096 - strlen(prefix), err, params);
+	return buf;
+}
+
+void
+die_xs(const char *err, va_list params)
+{
+	char *str;
+	str = report_xs("fatal: ", err, params);
+	croak(str);
+}
+
+int
+error_xs(const char *err, va_list params)
+{
+	char *str;
+	str = report_xs("error: ", err, params);
+	warn(str);
+	return -1;
+}
+
 
 MODULE = Git		PACKAGE = Git		
 
 PROTOTYPES: DISABLE
 
+
+BOOT:
+{
+	set_error_routine(error_xs);
+	set_die_routine(die_xs);
+}
+
+
 # /* TODO: xs_call_gate(). See Git.pm. */
 
 
