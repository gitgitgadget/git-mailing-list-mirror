From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 09/12] Git.pm: Enhance the command_pipe() mechanism
Date: Sat, 24 Jun 2006 04:34:47 +0200
Message-ID: <20060624023447.32751.71482.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftxzi-0006kM-AT
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202AbWFXCf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933195AbWFXCf0
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:35:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63895 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933196AbWFXCfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:35:25 -0400
Received: (qmail 368 invoked from network); 24 Jun 2006 04:34:47 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:47 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22474>

Rename command_pipe() to command_output_pipe(), outsource
the functionality to _command_common_pipe().

Add command_input_pipe().

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   76 +++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 4205ac5..11ec62d 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -32,7 +32,7 @@ # Totally unstable API.
 
   my @revs = $repo->command('rev-list', '--since=last monday', '--all');
 
-  my ($fh, $c) = $repo->command_pipe('rev-list', '--since=last monday', '--all');
+  my ($fh, $c) = $repo->command_output_pipe('rev-list', '--since=last monday', '--all');
   my $lastrev = <$fh>; chomp $lastrev;
   $repo->command_close_pipe($fh, $c);
 
@@ -48,7 +48,8 @@ require Exporter;
 @EXPORT = qw(git_cmd_try);
 
 # Methods which can be called as standalone functions as well:
-@EXPORT_OK = qw(command command_oneline command_pipe command_noisy
+@EXPORT_OK = qw(command command_oneline command_noisy
+                command_output_pipe command_input_pipe command_close_pipe
                 version exec_path hash_object git_cmd_try);
 
 
@@ -194,7 +195,7 @@ In both cases, the command's stdin and s
 =cut
 
 sub command {
-	my ($fh, $ctx) = command_pipe(@_);
+	my ($fh, $ctx) = command_output_pipe(@_);
 
 	if (not defined wantarray) {
 		# Nothing to pepper the possible exception with.
@@ -237,7 +238,7 @@ of the command's standard output.
 =cut
 
 sub command_oneline {
-	my ($fh, $ctx) = command_pipe(@_);
+	my ($fh, $ctx) = command_output_pipe(@_);
 
 	my $line = <$fh>;
 	chomp $line;
@@ -253,40 +254,49 @@ sub command_oneline {
 }
 
 
-=item command_pipe ( COMMAND [, ARGUMENTS... ] )
+=item command_output_pipe ( COMMAND [, ARGUMENTS... ] )
 
 Execute the given C<COMMAND> in the same way as command()
 does but return a pipe filehandle from which the command output can be
 read.
 
+The function can return C<($pipe, $ctx)> in array context.
+See C<command_close_pipe()> for details.
+
 =cut
 
-sub command_pipe {
-	my ($self, $cmd, @args) = _maybe_self(@_);
+sub command_output_pipe {
+	_command_common_pipe('-|', @_);
+}
 
-	$cmd =~ /^[a-z0-9A-Z_-]+$/ or throw Error::Simple("bad command: $cmd");
 
-	my $pid = open(my $fh, "-|");
-	if (not defined $pid) {
-		throw Error::Simple("open failed: $!");
-	} elsif ($pid == 0) {
-		_cmd_exec($self, $cmd, @args);
-	}
-	return wantarray ? ($fh, join(' ', $cmd, @args)) : $fh;
+=item command_input_pipe ( COMMAND [, ARGUMENTS... ] )
+
+Execute the given C<COMMAND> in the same way as command_output_pipe()
+does but return an input pipe filehandle instead; the command output
+is not captured.
+
+The function can return C<($pipe, $ctx)> in array context.
+See C<command_close_pipe()> for details.
+
+=cut
+
+sub command_input_pipe {
+	_command_common_pipe('|-', @_);
 }
 
 
 =item command_close_pipe ( PIPE [, CTX ] )
 
-Close the C<PIPE> as returned from C<command_pipe()>, checking
+Close the C<PIPE> as returned from C<command_*_pipe()>, checking
 whether the command finished successfuly. The optional C<CTX> argument
 is required if you want to see the command name in the error message,
-and it is the second value returned by C<command_pipe()> when
+and it is the second value returned by C<command_*_pipe()> when
 called in array context. The call idiom is:
 
-       my ($fh, $ctx) = $r->command_pipe('status');
-       while (<$fh>) { ... }
-       $r->command_close_pipe($fh, $ctx);
+	my ($fh, $ctx) = $r->command_output_pipe('status');
+	while (<$fh>) { ... }
+	$r->command_close_pipe($fh, $ctx);
 
 Note that you should not rely on whatever actually is in C<CTX>;
 currently it is simply the command name but in future the context might
@@ -317,8 +327,7 @@ The function returns only after the comm
 
 sub command_noisy {
 	my ($self, $cmd, @args) = _maybe_self(@_);
-
-	$cmd =~ /^[a-z0-9A-Z_-]+$/ or throw Error::Simple("bad command: $cmd");
+	_check_valid_cmd($cmd);
 
 	my $pid = fork;
 	if (not defined $pid) {
@@ -404,7 +413,7 @@ string with the captured command output 
 call context; C<command_noisy()> returns C<undef>) and $<cmdline> which
 returns the command and its arguments (but without proper quoting).
 
-Note that the C<command_pipe()> function cannot throw this exception since
+Note that the C<command_*_pipe()> functions cannot throw this exception since
 it has no idea whether the command failed or not. You will only find out
 at the time you C<close> the pipe; if you want to have that automated,
 use C<command_close_pipe()>, which can throw the exception.
@@ -516,6 +525,27 @@ sub _maybe_self {
 	ref $_[0] eq 'Git' ? @_ : (undef, @_);
 }
 
+# Check if the command id is something reasonable.
+sub _check_valid_cmd {
+	my ($cmd) = @_;
+	$cmd =~ /^[a-z0-9A-Z_-]+$/ or throw Error::Simple("bad command: $cmd");
+}
+
+# Common backend for the pipe creators.
+sub _command_common_pipe {
+	my $direction = shift;
+	my ($self, $cmd, @args) = _maybe_self(@_);
+	_check_valid_cmd($cmd);
+
+	my $pid = open(my $fh, $direction);
+	if (not defined $pid) {
+		throw Error::Simple("open failed: $!");
+	} elsif ($pid == 0) {
+		_cmd_exec($self, $cmd, @args);
+	}
+	return wantarray ? ($fh, join(' ', $cmd, @args)) : $fh;
+}
+
 # When already in the subprocess, set up the appropriate state
 # for the given repository and execute the git command.
 sub _cmd_exec {
