From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 08/12] Git.pm: Handle failed commands' output
Date: Sat, 24 Jun 2006 04:34:44 +0200
Message-ID: <20060624023444.32751.77423.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftxzj-0006kM-Rd
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933200AbWFXCfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933195AbWFXCfY
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:35:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63383 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933200AbWFXCfW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:35:22 -0400
Received: (qmail 360 invoked from network); 24 Jun 2006 04:34:44 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:44 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22476>

Currently if an external command returns error exit code, a generic exception
is thrown and there is no chance for the caller to retrieve the command's
output.

This patch introduces a Git::Error::Command exception class which is thrown
in this case and contains both the error code and the captured command output.
You can use the new git_cmd_try statement to fatally catch the exception
while producing a user-friendly message.

It also adds command_close_pipe() for easier checking of exit status of
a command we have just a pipe handle of. It has partial forward dependency
on the next patch, but basically only in the area of documentation.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-fmt-merge-msg.perl |   13 +++
 perl/Git.pm            |  192 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 183 insertions(+), 22 deletions(-)

diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index be2a48c..f86231e 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -7,6 +7,7 @@ # by grouping branches and tags together
 
 use strict;
 use Git;
+use Error qw(:try);
 
 my $repo = Git->repository();
 
@@ -31,7 +32,17 @@ sub andjoin {
 }
 
 sub repoconfig {
-	my ($val) = $repo->command_oneline('repo-config', '--get', 'merge.summary');
+	my $val;
+	try {
+		$val = $repo->command_oneline('repo-config', '--get', 'merge.summary');
+	} catch Git::Error::Command with {
+		my ($E) = shift;
+		if ($E->value() == 1) {
+			return undef;
+		} else {
+			throw $E;
+		}
+	};
 	return $val;
 }
 
diff --git a/perl/Git.pm b/perl/Git.pm
index 733fec9..4205ac5 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -24,16 +24,17 @@ # Totally unstable API.
 
   my $version = Git::command_oneline('version');
 
-  Git::command_noisy('update-server-info');
+  git_cmd_try { Git::command_noisy('update-server-info') }
+              '%s failed w/ code %d';
 
   my $repo = Git->repository (Directory => '/srv/git/cogito.git');
 
 
   my @revs = $repo->command('rev-list', '--since=last monday', '--all');
 
-  my $fh = $repo->command_pipe('rev-list', '--since=last monday', '--all');
+  my ($fh, $c) = $repo->command_pipe('rev-list', '--since=last monday', '--all');
   my $lastrev = <$fh>; chomp $lastrev;
-  close $fh; # You may want to test rev-list exit status here
+  $repo->command_close_pipe($fh, $c);
 
   my $lastrev = $repo->command_oneline('rev-list', '--all');
 
@@ -44,11 +45,11 @@ require Exporter;
 
 @ISA = qw(Exporter);
 
-@EXPORT = qw();
+@EXPORT = qw(git_cmd_try);
 
 # Methods which can be called as standalone functions as well:
 @EXPORT_OK = qw(command command_oneline command_pipe command_noisy
-                version exec_path hash_object);
+                version exec_path hash_object git_cmd_try);
 
 
 =head1 DESCRIPTION
@@ -88,7 +89,7 @@ increate nonwithstanding).
 =cut
 
 
-use Carp qw(carp); # croak is bad - throw instead
+use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
 
 require XSLoader;
@@ -193,21 +194,35 @@ In both cases, the command's stdin and s
 =cut
 
 sub command {
-	my $fh = command_pipe(@_);
+	my ($fh, $ctx) = command_pipe(@_);
 
 	if (not defined wantarray) {
-		_cmd_close($fh);
+		# Nothing to pepper the possible exception with.
+		_cmd_close($fh, $ctx);
 
 	} elsif (not wantarray) {
 		local $/;
 		my $text = <$fh>;
-		_cmd_close($fh);
+		try {
+			_cmd_close($fh, $ctx);
+		} catch Git::Error::Command with {
+			# Pepper with the output:
+			my $E = shift;
+			$E->{'-outputref'} = \$text;
+			throw $E;
+		};
 		return $text;
 
 	} else {
 		my @lines = <$fh>;
-		_cmd_close($fh);
 		chomp @lines;
+		try {
+			_cmd_close($fh, $ctx);
+		} catch Git::Error::Command with {
+			my $E = shift;
+			$E->{'-outputref'} = \@lines;
+			throw $E;
+		};
 		return @lines;
 	}
 }
@@ -222,12 +237,18 @@ of the command's standard output.
 =cut
 
 sub command_oneline {
-	my $fh = command_pipe(@_);
+	my ($fh, $ctx) = command_pipe(@_);
 
 	my $line = <$fh>;
-	_cmd_close($fh);
-
 	chomp $line;
+	try {
+		_cmd_close($fh, $ctx);
+	} catch Git::Error::Command with {
+		# Pepper with the output:
+		my $E = shift;
+		$E->{'-outputref'} = \$line;
+		throw $E;
+	};
 	return $line;
 }
 
@@ -251,7 +272,32 @@ sub command_pipe {
 	} elsif ($pid == 0) {
 		_cmd_exec($self, $cmd, @args);
 	}
-	return $fh;
+	return wantarray ? ($fh, join(' ', $cmd, @args)) : $fh;
+}
+
+
+=item command_close_pipe ( PIPE [, CTX ] )
+
+Close the C<PIPE> as returned from C<command_pipe()>, checking
+whether the command finished successfuly. The optional C<CTX> argument
+is required if you want to see the command name in the error message,
+and it is the second value returned by C<command_pipe()> when
+called in array context. The call idiom is:
+
+       my ($fh, $ctx) = $r->command_pipe('status');
+       while (<$fh>) { ... }
+       $r->command_close_pipe($fh, $ctx);
+
+Note that you should not rely on whatever actually is in C<CTX>;
+currently it is simply the command name but in future the context might
+have more complicated structure.
+
+=cut
+
+sub command_close_pipe {
+	my ($self, $fh, $ctx) = _maybe_self(@_);
+	$ctx ||= '<unknown>';
+	_cmd_close($fh, $ctx);
 }
 
 
@@ -280,9 +326,8 @@ sub command_noisy {
 	} elsif ($pid == 0) {
 		_cmd_exec($self, $cmd, @args);
 	}
-	if (waitpid($pid, 0) > 0 and $? != 0) {
-		# This is the best candidate for a custom exception class.
-		throw Error::Simple("exit status: $?");
+	if (waitpid($pid, 0) > 0 and $?>>8 != 0) {
+		throw Git::Error::Command(join(' ', $cmd, @args), $? >> 8);
 	}
 }
 
@@ -340,12 +385,117 @@ are involved.
 # Implemented in Git.xs.
 
 
+
 =back
 
 =head1 ERROR HANDLING
 
 All functions are supposed to throw Perl exceptions in case of errors.
-See L<Error>.
+See the L<Error> module on how to catch those. Most exceptions are mere
+L<Error::Simple> instances.
+
+However, the C<command()>, C<command_oneline()> and C<command_noisy()>
+functions suite can throw C<Git::Error::Command> exceptions as well: those are
+thrown when the external command returns an error code and contain the error
+code as well as access to the captured command's output. The exception class
+provides the usual C<stringify> and C<value> (command's exit code) methods and
+in addition also a C<cmd_output> method that returns either an array or a
+string with the captured command output (depending on the original function
+call context; C<command_noisy()> returns C<undef>) and $<cmdline> which
+returns the command and its arguments (but without proper quoting).
+
+Note that the C<command_pipe()> function cannot throw this exception since
+it has no idea whether the command failed or not. You will only find out
+at the time you C<close> the pipe; if you want to have that automated,
+use C<command_close_pipe()>, which can throw the exception.
+
+=cut
+
+{
+	package Git::Error::Command;
+
+	@Git::Error::Command::ISA = qw(Error);
+
+	sub new {
+		my $self = shift;
+		my $cmdline = '' . shift;
+		my $value = 0 + shift;
+		my $outputref = shift;
+		my(@args) = ();
+
+		local $Error::Depth = $Error::Depth + 1;
+
+		push(@args, '-cmdline', $cmdline);
+		push(@args, '-value', $value);
+		push(@args, '-outputref', $outputref);
+
+		$self->SUPER::new(-text => 'command returned error', @args);
+	}
+
+	sub stringify {
+		my $self = shift;
+		my $text = $self->SUPER::stringify;
+		$self->cmdline() . ': ' . $text . ': ' . $self->value() . "\n";
+	}
+
+	sub cmdline {
+		my $self = shift;
+		$self->{'-cmdline'};
+	}
+
+	sub cmd_output {
+		my $self = shift;
+		my $ref = $self->{'-outputref'};
+		defined $ref or undef;
+		if (ref $ref eq 'ARRAY') {
+			return @$ref;
+		} else { # SCALAR
+			return $$ref;
+		}
+	}
+}
+
+=over 4
+
+=item git_cmd_try { CODE } ERRMSG
+
+This magical statement will automatically catch any C<Git::Error::Command>
+exceptions thrown by C<CODE> and make your program die with C<ERRMSG>
+on its lips; the message will have %s substituted for the command line
+and %d for the exit status. This statement is useful mostly for producing
+more user-friendly error messages.
+
+In case of no exception caught the statement returns C<CODE>'s return value.
+
+Note that this is the only auto-exported function.
+
+=cut
+
+sub git_cmd_try(&$) {
+	my ($code, $errmsg) = @_;
+	my @result;
+	my $err;
+	my $array = wantarray;
+	try {
+		if ($array) {
+			@result = &$code;
+		} else {
+			$result[0] = &$code;
+		}
+	} catch Git::Error::Command with {
+		my $E = shift;
+		$err = $errmsg;
+		$err =~ s/\%s/$E->cmdline()/ge;
+		$err =~ s/\%d/$E->value()/ge;
+		# We can't croak here since Error.pm would mangle
+		# that to Error::Simple.
+	};
+	$err and croak $err;
+	return $array ? @result : $result[0];
+}
+
+
+=back
 
 =head1 COPYRIGHT
 
@@ -384,14 +534,14 @@ # _execv_git_cmd(), implemented in Git.x
 
 # Close pipe to a subprocess.
 sub _cmd_close {
-	my ($fh) = @_;
+	my ($fh, $ctx) = @_;
 	if (not close $fh) {
 		if ($!) {
 			# It's just close, no point in fatalities
 			carp "error closing pipe: $!";
 		} elsif ($? >> 8) {
-			# This is the best candidate for a custom exception class.
-			throw Error::Simple("exit status: ".($? >> 8));
+			# The caller should pepper this.
+			throw Git::Error::Command($ctx, $? >> 8);
 		}
 		# else we might e.g. closed a live stream; the command
 		# dying of SIGPIPE would drive us here.
