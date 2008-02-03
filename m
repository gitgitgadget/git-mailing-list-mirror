From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/2] Let "git svn" run "git gc --auto" occasionally
Date: Sun, 03 Feb 2008 17:56:18 +0100
Message-ID: <20080203165618.10816.6757.stgit@yoghurt>
References: <20080203165234.10816.6061.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 17:57:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLi9W-0006Zt-5H
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 17:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbYBCQ4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 11:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756474AbYBCQ4g
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 11:56:36 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3874 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460AbYBCQ4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 11:56:34 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JLi8g-0005f9-00; Sun, 03 Feb 2008 16:56:18 +0000
In-Reply-To: <20080203165234.10816.6061.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72367>

Let "git svn" run "git gc --auto" every 1000 imported commits to
reduce the number of loose objects.

To handle the common use case of frequent imports, where each
invocation typically fetches much less than 1000 commits, also run gc
unconditionally at the end of the import.

"1000" is the same number that was used by default when we called
git-repack. It isn't necessarily still the best choice.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 git-svn.perl |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)


diff --git a/git-svn.perl b/git-svn.perl
index 074068c..6cc3157 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1247,6 +1247,8 @@ use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
 use IPC::Open3;
=20
+my ($_gc_nr, $_gc_period);
+
 # properties that we do not log:
 my %SKIP_PROP;
 BEGIN {
@@ -1407,6 +1409,7 @@ sub read_all_remotes {
 }
=20
 sub init_vars {
+	$_gc_nr =3D $_gc_period =3D 1000;
 	if (defined $_repack || defined $_repack_flags) {
 	       warn "Repack options are obsolete; they have no effect.\n";
 	}
@@ -2095,6 +2098,10 @@ sub restore_commit_header_env {
 	}
 }
=20
+sub gc {
+	command_noisy('gc', '--auto');
+};
+
 sub do_git_commit {
 	my ($self, $log_entry) =3D @_;
 	my $lr =3D $self->last_rev;
@@ -2148,6 +2155,10 @@ sub do_git_commit {
 		                   0, $self->svm_uuid);
 	}
 	print " =3D $commit ($self->{ref_id})\n";
+	if (--$_gc_nr =3D=3D 0) {
+		$_gc_nr =3D $_gc_period;
+		gc();
+	}
 	return $commit;
 }
=20
@@ -3975,6 +3986,7 @@ sub gs_fetch_loop_common {
 		$max +=3D $inc;
 		$max =3D $head if ($max > $head);
 	}
+	Git::SVN::gc();
 }
=20
 sub match_globs {
