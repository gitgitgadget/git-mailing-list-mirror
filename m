From: Roman Kagan <rkagan@mail.ru>
Subject: [PATCH 1/3] git-svn: use POSIX::sigprocmask to block signals
Date: Mon, 2 Apr 2012 17:29:32 +0400
Message-ID: <35ffdcb9d4a61885debd0fca9020c9eda98534b4.1335250396.git.rkagan@mail.ru>
References: <cover.1335250396.git.rkagan@mail.ru>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 08:59:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMZid-0008OJ-15
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 08:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab2DXG7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 02:59:18 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:42811 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab2DXG7R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 02:59:17 -0400
Received: from localhost ([10.30.3.95])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id q3O6x9LW023936;
	Tue, 24 Apr 2012 10:59:10 +0400 (MSK)
In-Reply-To: <cover.1335250396.git.rkagan@mail.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196187>

In order to maintain consistency of the database mapping svn revision
numbers to git commit ids, rev_map_set() defers signal processing until
it's finished with an append transaction.[*]

The conventional way to achieve this is through sigprocmask(), which is
available in perl in the standard POSIX module.

This is implemented by this patch.  One important consequence of it is
that the signal handlers won't be unconditionally set to SIG_DFL anymore
upon the first invocation of rev_map_set() as they used to.  As a
result, the signals ignored by git-svn parent will remain ignored;
otherwise the behavior remains the same.

This patch paves the way to ignoring SIGPIPE throughout git-svn which
will be done in the followup patch.

[*] Deferring signals is not enough to ensure the database consistency:
the program may die on SIGKILL or power loss, run out of disk space,
etc.  However that's a separate issue that this patch doesn't address.

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
