From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [git-svn PATCH] Add --no-rebase option to git-svn dcommit
Date: Thu, 03 May 2007 07:51:35 +0200
Message-ID: <20070503054749.20115.53805.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu May 03 07:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjUEJ-00029t-C6
	for gcvg-git@gmane.org; Thu, 03 May 2007 07:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767403AbXECFvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 3 May 2007 01:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767400AbXECFvs
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 01:51:48 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:34156 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1767405AbXECFvq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 01:51:46 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:33159 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <kha@treskal.com>)
	id 1HjUEA-0003F0-8z; Thu, 03 May 2007 07:51:43 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HjUE3-0005GT-T4; Thu, 03 May 2007 07:51:35 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HjUEA-0003F0-8z.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HjUEA-0003F0-8z 321320b98def485825379893c2f94c3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46067>

git-svn dcommit exports commits to Subversion, then imports them back
to git again, and last but not least rebases or resets HEAD to the
last of the new commits. I guess this rebasing is convenient when
using just git, but when the commits to be exported are managed by
StGIT, it's really annoying. So add an option to disable this
behavior. And document it, too!

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

Arguably, the switch should be --rebase instead, and default to not
rebase. But that would change the existing behavior, and possibly make
dcommit less convenient to use for at least the person who implemented
the existing behavior. Opinions?

 Documentation/git-svn.txt |    3 +++
 git-svn.perl              |   33 ++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 62d7ef8..fcdeeaa 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -125,6 +125,9 @@ and have no uncommitted changes.
 	alternative to HEAD.
 	This is advantageous over 'set-tree' (below) because it produces
 	cleaner, more linear history.
++
+--no-rebase;;
+	After committing, do not rebase or reset.
 --
=20
 'log'::
diff --git a/git-svn.perl b/git-svn.perl
index 6657e10..3c4f490 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -55,7 +55,7 @@ $sha1_short =3D qr/[a-f\d]{4,40}/;
 my ($_stdin, $_help, $_edit,
 	$_message, $_file,
 	$_template, $_shared,
-	$_version, $_fetch_all,
+	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_verbose);
 $Git::SVN::_follow_parent =3D 1;
@@ -114,6 +114,7 @@ my %cmd =3D (
 			  'verbose|v' =3D> \$_verbose,
 			  'dry-run|n' =3D> \$_dry_run,
 			  'fetch-all|all' =3D> \$_fetch_all,
+			  'no-rebase' =3D> \$_no_rebase,
 			%cmt_opts, %fc_opts } ],
 	'set-tree' =3D> [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
@@ -413,21 +414,23 @@ sub cmd_dcommit {
 		return;
 	}
 	$_fetch_all ? $gs->fetch_all : $gs->fetch;
-	# we always want to rebase against the current HEAD, not any
-	# head that was passed to us
-	my @diff =3D command('diff-tree', 'HEAD', $gs->refname, '--');
-	my @finish;
-	if (@diff) {
-		@finish =3D rebase_cmd();
-		print STDERR "W: HEAD and ", $gs->refname, " differ, ",
-		             "using @finish:\n", "@diff";
-	} else {
-		print "No changes between current HEAD and ",
-		      $gs->refname, "\nResetting to the latest ",
-		      $gs->refname, "\n";
-		@finish =3D qw/reset --mixed/;
+	unless ($_no_rebase) {
+		# we always want to rebase against the current HEAD, not any
+		# head that was passed to us
+		my @diff =3D command('diff-tree', 'HEAD', $gs->refname, '--');
+		my @finish;
+		if (@diff) {
+			@finish =3D rebase_cmd();
+			print STDERR "W: HEAD and ", $gs->refname, " differ, ",
+				     "using @finish:\n", "@diff";
+		} else {
+			print "No changes between current HEAD and ",
+			      $gs->refname, "\nResetting to the latest ",
+			      $gs->refname, "\n";
+			@finish =3D qw/reset --mixed/;
+		}
+		command_noisy(@finish, $gs->refname);
 	}
-	command_noisy(@finish, $gs->refname);
 }
=20
 sub cmd_find_rev {
