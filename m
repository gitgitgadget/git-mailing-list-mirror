From: Roman Kagan <rkagan@mail.ru>
Subject: [PATCH 1/2] git-svn: use POSIX::sigprocmask to block signals
Date: Mon, 2 Apr 2012 20:13:37 +0400 (MSK)
Message-ID: <9eaaebac91dc2b1a45a4dec77142be0b0b338056.1333381684.git.rkagan@mail.ru>
References: <cover.1333381684.git.rkagan@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 18:14:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEjtb-0007rg-7h
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab2DBQOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 12:14:09 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:20845 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055Ab2DBQOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 12:14:08 -0400
Received: from localhost ([10.30.3.95])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id q32GDbhN021547;
	Mon, 2 Apr 2012 20:13:38 +0400 (MSK)
In-Reply-To: <cover.1333381684.git.rkagan@mail.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194525>

rev_map_set() tries to avoid being interrupted by signals.

The conventional way to achieve this is through sigprocmask(), which is
available in the standard POSIX module.

This is implemented by this patch.  One important consequence of it is
that the signal handlers won't be unconditionally set to SIG_DFL anymore
upon the first invocation of rev_map_set() as they used to.

[That said, I'm not convinced that messing with signals is necessary
(and sufficient) here at all, but my perl-foo is too weak for a more
intrusive change.]

Signed-off-by: Roman Kagan <rkagan@mail.ru>
---
 git-svn.perl |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4334b95..570504c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2031,6 +2031,7 @@ use IPC::Open3;
 use Time::Local;
 use Memoize;  # core since 5.8.0, Jul 2002
 use Memoize::Storable;
+use POSIX qw(:signal_h);
 
 my ($_gc_nr, $_gc_period);
 
@@ -4059,11 +4060,14 @@ sub rev_map_set {
 	length $commit == 40 or die "arg3 must be a full SHA1 hexsum\n";
 	my $db = $self->map_path($uuid);
 	my $db_lock = "$db.lock";
-	my $sig;
+	my $sigmask;
 	$update_ref ||= 0;
 	if ($update_ref) {
-		$SIG{INT} = $SIG{HUP} = $SIG{TERM} = $SIG{ALRM} = $SIG{PIPE} =
-		            $SIG{USR1} = $SIG{USR2} = sub { $sig = $_[0] };
+		$sigmask = POSIX::SigSet->new();
+		my $signew = POSIX::SigSet->new(SIGINT, SIGHUP, SIGTERM,
+			SIGALRM, SIGPIPE, SIGUSR1, SIGUSR2);
+		sigprocmask(SIG_BLOCK, $signew, $sigmask) or
+			croak "Can't block signals: $!";
 	}
 	mkfile($db);
 
@@ -4102,9 +4106,8 @@ sub rev_map_set {
 	                            "$db_lock => $db ($!)\n";
 	delete $LOCKFILES{$db_lock};
 	if ($update_ref) {
-		$SIG{INT} = $SIG{HUP} = $SIG{TERM} = $SIG{ALRM} = $SIG{PIPE} =
-		            $SIG{USR1} = $SIG{USR2} = 'DEFAULT';
-		kill $sig, $$ if defined $sig;
+		sigprocmask(SIG_SETMASK, $sigmask) or
+			croak "Can't restore signal mask: $!";
 	}
 }
 
-- 
1.7.7.6
