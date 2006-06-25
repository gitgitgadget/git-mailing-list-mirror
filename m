From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/7] Git.pm: Try to support ActiveState output pipe
Date: Sun, 25 Jun 2006 03:54:23 +0200
Message-ID: <20060625015423.29906.86666.stgit@machine.or.cz>
References: <20060625015421.29906.50002.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:54:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJpX-00069P-P2
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWFYBy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWFYBy0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:54:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64937 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751348AbWFYByZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:54:25 -0400
Received: (qmail 29929 invoked from network); 25 Jun 2006 03:54:24 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Jun 2006 03:54:24 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060625015421.29906.50002.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22572>

The code is stolen from git-annotate and completely untested since
I don't have access to any Microsoft operating system now. Someone
ActiveState-savvy should look at it anyway and try to implement
the input pipe as well, if it is possible at all; also, the implementation
seems to be horribly whitespace-unsafe.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   68 +++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 08f56c0..6da11a6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -748,18 +748,29 @@ sub _command_common_pipe {
 	}
 	_check_valid_cmd($cmd);
 
-	my $pid = open(my $fh, $direction);
-	if (not defined $pid) {
-		throw Error::Simple("open failed: $!");
-	} elsif ($pid == 0) {
-		if (defined $opts{STDERR}) {
-			close STDERR;
-		}
-		if ($opts{STDERR}) {
-			open (STDERR, '>&', $opts{STDERR})
-				or die "dup failed: $!";
+	my $fh;
+	if ($^O eq '##INSERT_ACTIVESTATE_STRING_HERE##') {
+		# ActiveState Perl
+		#defined $opts{STDERR} and
+		#	warn 'ignoring STDERR option - running w/ ActiveState';
+		$direction eq '-|' or
+			die 'input pipe for ActiveState not implemented';
+		tie ($fh, 'Git::activestate_pipe', $cmd, @args);
+
+	} else {
+		my $pid = open($fh, $direction);
+		if (not defined $pid) {
+			throw Error::Simple("open failed: $!");
+		} elsif ($pid == 0) {
+			if (defined $opts{STDERR}) {
+				close STDERR;
+			}
+			if ($opts{STDERR}) {
+				open (STDERR, '>&', $opts{STDERR})
+					or die "dup failed: $!";
+			}
+			_cmd_exec($self, $cmd, @args);
 		}
-		_cmd_exec($self, $cmd, @args);
 	}
 	return wantarray ? ($fh, join(' ', $cmd, @args)) : $fh;
 }
@@ -834,4 +845,39 @@ sub AUTOLOAD {
 sub DESTROY { }
 
 
+# Pipe implementation for ActiveState Perl.
+
+package Git::activestate_pipe;
+use strict;
+
+sub TIEHANDLE {
+	my ($class, @params) = @_;
+	# FIXME: This is probably horrible idea and the thing will explode
+	# at the moment you give it arguments that require some quoting,
+	# but I have no ActiveState clue... --pasky
+	my $cmdline = join " ", @params;
+	my @data = qx{$cmdline};
+	bless { i => 0, data => \@data }, $class;
+}
+
+sub READLINE {
+	my $self = shift;
+	if ($self->{i} >= scalar @{$self->{data}}) {
+		return undef;
+	}
+	return $self->{'data'}->[ $self->{i}++ ];
+}
+
+sub CLOSE {
+	my $self = shift;
+	delete $self->{data};
+	delete $self->{i};
+}
+
+sub EOF {
+	my $self = shift;
+	return ($self->{i} >= scalar @{$self->{data}});
+}
+
+
 1; # Famous last words
