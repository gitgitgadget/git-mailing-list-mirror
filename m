From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Fix path duplication in git svn commit-diff
Date: Sat, 17 May 2008 17:07:09 +0200
Message-ID: <20080517150330.31899.12398.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat May 17 17:08:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxO14-0007t1-W5
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 17:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbYEQPHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 May 2008 11:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYEQPHU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 11:07:20 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2917 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbYEQPHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 11:07:19 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JxO0A-0007NJ-00; Sat, 17 May 2008 16:07:14 +0100
User-Agent: StGIT/0.14.2.152.g77bd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82349>

Given an SVN repo file:///tmp/svntest/repo, trying to commit changes
to a file proj/trunk/foo.txt in that repo with this command line

  git svn commit-diff -r2 HEAD^ HEAD file:///tmp/svntest/repo/proj/trun=
k

gave the error message

  Filesystem has no item: File not found: transaction '2-6', path
  '/proj/trunk/proj/trunk/foo.txt'

This fixes the duplication.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

I really don't have a clue as to why this was broken, but the patch
fixes the problem for me, and doesn't break the tests. I got the idea
from dcommit, which is setting svn_path to '' unconditionally.

 git-svn.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)


diff --git a/git-svn.perl b/git-svn.perl
index 2c53f39..1c2a10a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -741,7 +741,7 @@ sub cmd_commit_diff {
 	my $usage =3D "Usage: $0 commit-diff -r<revision> ".
 	            "<tree-ish> <tree-ish> [<URL>]";
 	fatal($usage) if (!defined $ta || !defined $tb);
-	my $svn_path;
+	my $svn_path =3D '';
 	if (!defined $url) {
 		my $gs =3D eval { Git::SVN->new };
 		if (!$gs) {
@@ -765,7 +765,6 @@ sub cmd_commit_diff {
 		$_message ||=3D get_commit_entry($tb)->{log};
 	}
 	my $ra ||=3D Git::SVN::Ra->new($url);
-	$svn_path ||=3D $ra->{svn_path};
 	my $r =3D $_revision;
 	if ($r eq 'HEAD') {
 		$r =3D $ra->get_latest_revnum;
