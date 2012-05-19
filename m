From: Subho Sankar Banerjee <subs.zero@gmail.com>
Subject: [PATCH][GIT.PM 3/3] Perl code uses eval{}/die instead of Error::Simple and Git::Error::Command
Date: Sat, 19 May 2012 12:38:37 +0530
Message-ID: <1337411317-14931-3-git-send-email-subs.zero@gmail.com>
References: <7vobpulhbk.fsf@alter.siamese.dyndns.org>
 <1337411317-14931-1-git-send-email-subs.zero@gmail.com>
Cc: Subho Sankar Banerjee <subs.zero@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 09:09:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVdn4-0006lj-1X
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 09:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758025Ab2ESHJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 03:09:21 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33041 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757367Ab2ESHJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 03:09:15 -0400
Received: by pbbrp8 with SMTP id rp8so4848690pbb.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lB+UDWU+WuUc0fU3zoB797CYk8V5LCgCOogDUzX4u9M=;
        b=XzTKd5tvTWtSj1nDeIukiX+vdXVRl1IJ/uOyTjaMsAcncKoTMw3cHxU96aThQYPNHb
         KfAADAJyTlh6Eg6RydhmaeFmZ/7fHYcmHDSFQBUKhT1Hz7DUDg9tb8Xg1zjOQMfW9vLk
         iOibcZZ7MRew75PXb4dZR5Il7CusuAKkc93ltSRNf6G4iOWp/xANGBDQO5Bp2pD8R8JQ
         Eq/QuUT4H6A600HPOFzcziPljbm7SYyolp+MGrlDU81DWu/H+uOBu3q8fAkaIa8Hhra8
         z2a0jcRJ47KaFVr1EY6/fUe6hZYw9ahnoS9EWudvRkXzqgkJZpaAVvYsdP/7jeWRD5nf
         8fxA==
Received: by 10.68.231.40 with SMTP id td8mr19148749pbc.150.1337411355071;
        Sat, 19 May 2012 00:09:15 -0700 (PDT)
Received: from localhost.localdomain (triband-mum-120.61.158.30.mtnl.net.in. [120.61.158.30])
        by mx.google.com with ESMTPS id rj4sm15424408pbc.30.2012.05.19.00.09.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 May 2012 00:09:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1337411317-14931-1-git-send-email-subs.zero@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198022>


Signed-off-by: Subho Sankar Banerjee <subs.zero@gmail.com>
---
 git-send-email.perl |    7 +--
 git-svn.perl        |    2 +-
 perl/Git.pm         |  170 ++++++++++++---------------------------------------
 3 files changed, 41 insertions(+), 138 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ef30c55..e56b379 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,7 +26,6 @@ use Data::Dumper;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
-use Error qw(:try);
 use Git;
 
 Getopt::Long::Configure qw/ pass_through /;
@@ -512,7 +511,7 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 sub check_file_rev_conflict($) {
 	return unless $repo;
 	my $f = shift;
-	try {
+	eval {
 		$repo->command('rev-parse', '--verify', '--quiet', $f);
 		if (defined($format_patch)) {
 			return $format_patch;
@@ -524,9 +523,7 @@ to produce patches for.  Please disambiguate by...
     * Saying "./$f" if you mean a file; or
     * Giving --format-patch option if you mean a range.
 EOF
-	} catch Git::Error::Command with {
-		return 0;
-	}
+	} or return 0;
 }
 
 # Now that all the defaults are set, process the rest of the command line
diff --git a/git-svn.perl b/git-svn.perl
index 31d02b5..c299137 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3714,7 +3714,7 @@ sub find_extra_svn_parents {
 		};
 		if ($@) {
 			die "An error occurred during merge-base"
-				unless $@->isa("Git::Error::Command");
+				unless $@ =~ /command returned error/;
 
 			warn "W: Cannot find common ancestor between ".
 			     "@$parents and $merge_tip. Ignoring merge info.\n";
diff --git a/perl/Git.pm b/perl/Git.pm
index 52777d4..a025f5d 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -97,8 +97,7 @@ increase notwithstanding).
 =cut
 
 
-use Carp qw(carp croak); # but croak is bad - throw instead
-use Error qw(:try);
+use Carp qw(carp croak);
 use Cwd qw(abs_path cwd);
 use IPC::Open2 qw(open2);
 use Fcntl qw(SEEK_SET SEEK_CUR);
@@ -123,7 +122,6 @@ B<Repository> - Path to the Git repository.
 
 B<WorkingCopy> - Path to the associated working copy; not strictly required
 as many commands will happily crunch on a bare repository.
-
 B<WorkingSubdir> - Subdirectory in the working copy to work inside.
 Just left undefined if you do not want to limit the scope of operations.
 
@@ -160,7 +158,7 @@ sub repository {
 	if (defined $args[0]) {
 		if ($#args % 2 != 1) {
 			# Not a hash.
-			$#args == 0 or die "bad usage";
+			$#args == 0 or croak "bad usage";
 			%opts = ( Directory => $args[0] );
 		} else {
 			%opts = @args;
@@ -177,12 +175,10 @@ sub repository {
 
 		my $search = Git->repository(WorkingCopy => $opts{Directory});
 		my $dir;
-		try {
+		eval {
 			$dir = $search->command_oneline(['rev-parse', '--git-dir'],
-			                                STDERR => 0);
-		} catch Git::Error::Command with {
-			$dir = undef;
-		};
+			                                STDERR => 0);1;
+		} or $dir = undef and print $@;
 
 		if ($dir) {
 			$dir =~ m#^/# or $dir = $opts{Directory} . '/' . $dir;
@@ -206,15 +202,12 @@ sub repository {
 
 			unless (-d "$dir/refs" and -d "$dir/objects" and -e "$dir/HEAD") {
 				# Mimic git-rev-parse --git-dir error message:
-				die "fatal: Not a git repository: $dir";
+				croak "fatal: Not a git repository: $dir";
 			}
 			my $search = Git->repository(Repository => $dir);
-			try {
-				$search->command('symbolic-ref', 'HEAD');
-			} catch Git::Error::Command with {
-				# Mimic git-rev-parse --git-dir error message:
-				die "fatal: Not a git repository: $dir";
-			}
+			eval {
+				$search->command('symbolic-ref', 'HEAD');1;
+			} or croak "fatal: Not a git repository: $dir"; # Mimic git-rev-parse --git-dir error message
 
 			$opts{Repository} = abs_path($dir);
 		}
@@ -265,33 +258,20 @@ In both cases, the command's stdin and stderr are the same as the caller's.
 sub command {
 	my ($fh, $ctx) = command_output_pipe(@_);
 
+	local $@;
 	if (not defined wantarray) {
-		# Nothing to pepper the possible exception with.
 		_cmd_close($fh, $ctx);
 
 	} elsif (not wantarray) {
 		local $/;
 		my $text = <$fh>;
-		try {
-			_cmd_close($fh, $ctx);
-		} catch Git::Error::Command with {
-			# Pepper with the output:
-			my $E = shift;
-			$E->{'-outputref'} = \$text;
-			throw $E;
-		};
+	eval { _cmd_close($fh, $ctx); 1; } or die $@;
 		return $text;
 
 	} else {
 		my @lines = <$fh>;
 		defined and chomp for @lines;
-		try {
-			_cmd_close($fh, $ctx);
-		} catch Git::Error::Command with {
-			my $E = shift;
-			$E->{'-outputref'} = \@lines;
-			throw $E;
-		};
+		eval { _cmd_close($fh, $ctx); 1; } or die $@;
 		return @lines;
 	}
 }
@@ -312,14 +292,7 @@ sub command_oneline {
 
 	my $line = <$fh>;
 	defined $line and chomp $line;
-	try {
-		_cmd_close($fh, $ctx);
-	} catch Git::Error::Command with {
-		# Pepper with the output:
-		my $E = shift;
-		$E->{'-outputref'} = \$line;
-		throw $E;
-	};
+	eval { _cmd_close($fh, $ctx); }	or die $@;
 	return $line;
 }
 
@@ -436,7 +409,7 @@ sub command_close_bidi_pipe {
 			if ($!) {
 				carp "error closing pipe: $!";
 			} elsif ($? >> 8) {
-				throw Git::Error::Command($ctx, $? >>8);
+				die $ctx." : command returned error : ".($? >> 8)."\n";
 			}
 		}
 	}
@@ -444,7 +417,7 @@ sub command_close_bidi_pipe {
 	waitpid $pid, 0;
 
 	if ($? >> 8) {
-		throw Git::Error::Command($ctx, $? >>8);
+		die $ctx." : command returned error : ".($? >> 8)."\n";
 	}
 }
 
@@ -474,7 +447,7 @@ sub command_noisy {
 		_cmd_exec($self, $cmd, @args);
 	}
 	if (waitpid($pid, 0) > 0 and $?>>8 != 0) {
-		throw Git::Error::Command(join(' ', $cmd, @args), $? >> 8);
+		die join(' ', $cmd, @args)." : command returned error : ".($? >> 8)."\n";
 	}
 }
 
@@ -552,10 +525,10 @@ and the directory must exist.
 sub wc_chdir {
 	my ($self, $subdir) = @_;
 	$self->wc_path()
-		or die "bare repository";
+		or croak "bare repository";
 
 	-d $self->wc_path().'/'.$subdir
-		or die "subdir not found: $subdir $!";
+		or croak "subdir not found: $subdir $!";
 	# Of course we will not "hold" the subdirectory so anyone
 	# can delete it now and we will never know. But at least we tried.
 
@@ -629,8 +602,9 @@ sub config_int {
 sub _config_common {
 	my ($opts) = shift @_;
 	my ($self, $var) = _maybe_self(@_);
-
-	try {
+	
+	local $@;
+	eval {
 		my @cmd = ('config', $opts->{'kind'} ? $opts->{'kind'} : ());
 		unshift @cmd, $self if $self;
 		if (wantarray) {
@@ -638,15 +612,9 @@ sub _config_common {
 		} else {
 			return command_oneline(@cmd, '--get', $var);
 		}
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return;
-		} else {
-			throw $E;
-		}
-	};
+		1;
+	} or $@ =~ /([\d]+)$/ and (0+$1 == 1) or die $@;
+	return;
 }
 
 =item get_colorbool ( NAME )
@@ -920,7 +888,7 @@ sub cat_blob {
 
 	unless (print $fh $blob) {
 		$self->_close_cat_blob();
-    die "couldn't write to passed in filehandle";
+		die "couldn't write to passed in filehandle";
 	}
 
 	return $size;
@@ -1023,7 +991,7 @@ sub _temp_cache {
 	my $temp_fd = \$TEMP_FILEMAP{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
 		if ($TEMP_FILES{$$temp_fd}{locked}) {
-			die "Temp file with moniker '" .
+			croak "Temp file with moniker '" .
 				$name . "' already in use";
 		}
 	} else {
@@ -1103,72 +1071,13 @@ All functions are supposed to throw Perl exceptions in case of errors.
 These errors are perl scalars which can be caught in the $@ values in
 eval{} blocks.
 
-However, the C<command()>, C<command_oneline()> and C<command_noisy()>
-functions suite can throw C<Git::Error::Command> exceptions as well: those are
-thrown when the external command returns an error code and contain the error
-code as well as access to the captured command's output. The exception class
-provides the usual C<stringify> and C<value> (command's exit code) methods and
-in addition also a C<cmd_output> method that returns either an array or a
-string with the captured command output (depending on the original function
-call context; C<command_noisy()> returns C<undef>) and $<cmdline> which
-returns the command and its arguments (but without proper quoting).
-
-Note that the C<command_*_pipe()> functions cannot throw this exception since
-it has no idea whether the command failed or not. You will only find out
-at the time you C<close> the pipe; if you want to have that automated,
-use C<command_close_pipe()>, which can throw the exception.
-
 =cut
 
-{
-	package Git::Error::Command;
-
-	@Git::Error::Command::ISA = qw(Error);
-
-	sub new {
-		my $self = shift;
-		my $cmdline = '' . shift;
-		my $value = 0 + shift;
-		my $outputref = shift;
-		my(@args) = ();
-
-		local $Error::Depth = $Error::Depth + 1;
-
-		push(@args, '-cmdline', $cmdline);
-		push(@args, '-value', $value);
-		push(@args, '-outputref', $outputref);
-
-		$self->SUPER::new(-text => 'command returned error', @args);
-	}
-
-	sub stringify {
-		my $self = shift;
-		my $text = $self->SUPER::stringify;
-		$self->cmdline() . ': ' . $text . ': ' . $self->value() . "\n";
-	}
-
-	sub cmdline {
-		my $self = shift;
-		$self->{'-cmdline'};
-	}
-
-	sub cmd_output {
-		my $self = shift;
-		my $ref = $self->{'-outputref'};
-		defined $ref or undef;
-		if (ref $ref eq 'ARRAY') {
-			return @$ref;
-		} else { # SCALAR
-			return $$ref;
-		}
-	}
-}
-
 =over 4
 
 =item git_cmd_try { CODE } ERRMSG
 
-This magical statement will automatically catch any C<Git::Error::Command>
+This magical statement will automatically catch any 
 exceptions thrown by C<CODE> and make your program die with C<ERRMSG>
 on its lips; the message will have %s substituted for the command line
 and %d for the exit status. This statement is useful mostly for producing
@@ -1184,22 +1093,20 @@ sub git_cmd_try(&$) {
 	my ($code, $errmsg) = @_;
 	my @result;
 	my $err;
+	my $err_string;
+	my $err_value;
 	my $array = wantarray;
-	try {
+	eval {
 		if ($array) {
 			@result = &$code;
 		} else {
 			$result[0] = &$code;
-		}
-	} catch Git::Error::Command with {
-		my $E = shift;
-		$err = $errmsg;
-		$err =~ s/\%s/$E->cmdline()/ge;
-		$err =~ s/\%d/$E->value()/ge;
-		# We can't croak here since Error.pm would mangle
-		# that to Error::Simple.
-	};
-	$err and croak $err;
+		}1;
+	} or $@ =~ /^([a-zA-Z ]+) : .* : ([\d]+)$/
+	and ($err, $err_string, $err_value) = ($errmsg, $1, $2)
+	and $err =~ s/\%s/$1/ge and $err =~ s/\%d/$2/ge; 
+  
+ 	$err and croak $err;
 	return $array ? @result : $result[0];
 }
 
@@ -1227,7 +1134,7 @@ sub _maybe_self {
 # Check if the command id is something reasonable.
 sub _check_valid_cmd {
 	my ($cmd) = @_;
-	$cmd =~ /^[a-z0-9A-Z_-]+$/ or die "bad command: $cmd";
+	$cmd =~ /^[a-z0-9A-Z_-]+$/ or croak "bad command: $cmd";
 }
 
 # Common backend for the pipe creators.
@@ -1309,8 +1216,7 @@ sub _cmd_close {
 			# It's just close, no point in fatalities
 			carp "error closing pipe: $!";
 		} elsif ($? >> 8) {
-			# The caller should pepper this.
-			throw Git::Error::Command($ctx, $? >> 8);
+			die $ctx." : command returned error : ".($? >> 8)."\n";
 		}
 		# else we might e.g. closed a live stream; the command
 		# dying of SIGPIPE would drive us here.
-- 
1.7.9.5
