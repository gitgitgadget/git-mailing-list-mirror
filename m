From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 10/12] Git.pm: Implement options for the command interface
Date: Sat, 24 Jun 2006 04:34:49 +0200
Message-ID: <20060624023449.32751.90490.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftxzj-0006kM-9u
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933201AbWFXCfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933199AbWFXCfa
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:35:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64407 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933201AbWFXCf2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:35:28 -0400
Received: (qmail 376 invoked from network); 24 Jun 2006 04:34:49 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:49 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22473>

This gives the user a way to easily pass options to the command routines.
Currently only the STDERR option is implemented and can be used to adjust
what shall be done with error output of the called command (most usefully,
it can be used to silence it).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 11ec62d..e2b66c4 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -36,7 +36,8 @@ # Totally unstable API.
   my $lastrev = <$fh>; chomp $lastrev;
   $repo->command_close_pipe($fh, $c);
 
-  my $lastrev = $repo->command_oneline('rev-list', '--all');
+  my $lastrev = $repo->command_oneline( [ 'rev-list', '--all' ],
+                                        STDERR => 0 );
 
 =cut
 
@@ -178,9 +179,21 @@ sub repository {
 
 =item command ( COMMAND [, ARGUMENTS... ] )
 
+=item command ( [ COMMAND, ARGUMENTS... ], { Opt => Val ... } )
+
 Execute the given Git C<COMMAND> (specify it without the 'git-'
 prefix), optionally with the specified extra C<ARGUMENTS>.
 
+The second more elaborate form can be used if you want to further adjust
+the command execution. Currently, only one option is supported:
+
+B<STDERR> - How to deal with the command's error output. By default (C<undef>)
+it is delivered to the caller's C<STDERR>. A false value (0 or '') will cause
+it to be thrown away. If you want to process it, you can get it in a filehandle
+you specify, but you must be extremely careful; if the error output is not
+very short and you want to read it in the same process as where you called
+C<command()>, you are set up for a nice deadlock!
+
 The method can be called without any instance or on a specified Git repository
 (in that case the command will be run in the repository context).
 
@@ -231,6 +244,8 @@ sub command {
 
 =item command_oneline ( COMMAND [, ARGUMENTS... ] )
 
+=item command_oneline ( [ COMMAND, ARGUMENTS... ], { Opt => Val ... } )
+
 Execute the given C<COMMAND> in the same way as command()
 does but always return a scalar string containing the first line
 of the command's standard output.
@@ -256,6 +271,8 @@ sub command_oneline {
 
 =item command_output_pipe ( COMMAND [, ARGUMENTS... ] )
 
+=item command_output_pipe ( [ COMMAND, ARGUMENTS... ], { Opt => Val ... } )
+
 Execute the given C<COMMAND> in the same way as command()
 does but return a pipe filehandle from which the command output can be
 read.
@@ -272,6 +289,8 @@ sub command_output_pipe {
 
 =item command_input_pipe ( COMMAND [, ARGUMENTS... ] )
 
+=item command_input_pipe ( [ COMMAND, ARGUMENTS... ], { Opt => Val ... } )
+
 Execute the given C<COMMAND> in the same way as command_output_pipe()
 does but return an input pipe filehandle instead; the command output
 is not captured.
@@ -534,13 +553,27 @@ sub _check_valid_cmd {
 # Common backend for the pipe creators.
 sub _command_common_pipe {
 	my $direction = shift;
-	my ($self, $cmd, @args) = _maybe_self(@_);
+	my ($self, @p) = _maybe_self(@_);
+	my (%opts, $cmd, @args);
+	if (ref $p[0]) {
+		($cmd, @args) = @{shift @p};
+		%opts = ref $p[0] ? %{$p[0]} : @p;
+	} else {
+		($cmd, @args) = @p;
+	}
 	_check_valid_cmd($cmd);
 
 	my $pid = open(my $fh, $direction);
 	if (not defined $pid) {
 		throw Error::Simple("open failed: $!");
 	} elsif ($pid == 0) {
+		if (defined $opts{STDERR}) {
+			close STDERR;
+		}
+		if ($opts{STDERR}) {
+			open (STDERR, '>&', $opts{STDERR})
+				or die "dup failed: $!";
+		}
 		_cmd_exec($self, $cmd, @args);
 	}
 	return wantarray ? ($fh, join(' ', $cmd, @args)) : $fh;
