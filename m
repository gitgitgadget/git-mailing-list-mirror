From: Finn Arne Gangstad <finnag@pvv.org>
Subject: inotify daemon speedup for git [POC/HACK]
Date: Tue, 27 Jul 2010 14:20:18 +0200
Message-ID: <20100727122018.GA26780@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 14:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odj92-0004rQ-0c
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 14:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab0G0MUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 08:20:21 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:43999 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab0G0MUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 08:20:20 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Odj8s-0006lK-Ce; Tue, 27 Jul 2010 14:20:18 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151934>

Reading through the thread about subtree I noticed Avery mentioning
using inotify to speed up git status & co.

Here is a quick hack I did some time ago to test this out, to use it
call "igit" instead of "git" for all commmands you want to speed up.

There is one minor nit: The speedup gain is zero :) git still
traverses all directories to look for .gitignore files, which seems to
totally kill the optimisation.

To use it, put igit and git-inotify-daemon.pl in path, and do git
config core.ignorestat=true in the repositories you want to test it
with. The igit wrapper will run git update-index --no-assume-unchanged
on all modified files before running any real git commands.

To get inotify to ignore all changes that the git commands themselves
perform, the "igit" wrapper kills the currently running daemon. Then
it reads the list of updates files, and does git-update-index
--no-assume-unchanged on them. Then the git command is run, and
finally the daemon is fired up again.

I had to do one tiny modification to git to make update-index ignore
bad paths.


igit - a git wrapper with an inotify daemon

Linux only - requires inotifytools installed. This is juct a quick hack/proof
of concept!
update-index: Do not error out on bad paths, just warn
---
 .gitignore             |    1 +
 builtin/update-index.c |    2 +-
 git-inotify-daemon.pl  |   28 ++++++++++++++++++++++++++++
 igit                   |   22 ++++++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletions(-)
 create mode 100755 git-inotify-daemon.pl
 create mode 100755 igit

diff --git a/.gitignore b/.gitignore
index 14e2b6b..fa67132 100644
--- a/.gitignore
+++ b/.gitignore
@@ -204,3 +204,4 @@
 *.pdb
 /Debug/
 /Release/
+.igit-*
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..c905d78 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -282,7 +282,7 @@ static void update_one(const char *path, const char *prefix, int prefix_length)
 	}
 	if (mark_valid_only) {
 		if (mark_ce_flags(p, CE_VALID, mark_valid_only == MARK_FLAG))
-			die("Unable to mark file %s", path);
+			fprintf(stderr, "Unable to mark file %s\n", path);
 		goto free_return;
 	}
 	if (mark_skip_worktree_only) {
diff --git a/git-inotify-daemon.pl b/git-inotify-daemon.pl
new file mode 100755
index 0000000..a57ceef
--- /dev/null
+++ b/git-inotify-daemon.pl
@@ -0,0 +1,28 @@
+#!/usr/bin/env perl
+# Run from igit
+
+use warnings;
+use strict;
+
+die "Usage: $0 <output-file>" unless $#ARGV == 0;
+my $output = $ARGV[0];
+my $pid = open(INOTIFY, "exec inotifywait -q --monitor --recursive --exclude .git -e attrib,moved_to,moved_from,move,create,delete,modify --format '%w%f' .|") or die "Cannot run inotifywait: $!\n";
+
+$| = 1;
+print "$pid\n";
+
+my %modified_files;
+while (<INOTIFY>) {
+    s=^./==;
+    chomp;
+    $modified_files{$_} = 1;
+}
+
+# Output file must be opened as late as possible, it is a named pipe
+# and the listener won't be here before inotifywait exits.
+# open would just hang if it was done earlier.
+open(OUT, ">$output");
+foreach my $key (sort keys %modified_files) {
+    print OUT "$key\000";
+}
+exit 0;
diff --git a/igit b/igit
new file mode 100755
index 0000000..60c5bb2
--- /dev/null
+++ b/igit
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+TOPDIR=`git rev-parse --show-cdup` || exit 1
+
+if [ ! "$TOPDIR" ]; then
+    TOPDIR="./"
+fi
+
+PIPE=.igit-pipe
+PIDFILE=.igit-pid
+
+if [ -p ${TOPDIR}${PIPE} ] && kill -TERM `cat ${TOPDIR}${PIDFILE}`; then
+    ( cd $TOPDIR && git update-index --verbose --no-assume-unchanged -z --stdin < $PIPE )
+fi
+
+git "$@"
+
+cd $TOPDIR
+rm -f $PIPE
+mkfifo $PIPE
+git-inotify-daemon.pl $PIPE > $PIDFILE 2>> .igit-errors </dev/null &
+
-- 
1.7.2.rc0


- Finn Arne
