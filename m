From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Let "git svn" run "git gc --auto" occasionally
Date: Sat, 19 Jan 2008 23:36:30 +0100
Message-ID: <20080119223249.8227.31460.stgit@yoghurt>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 19 23:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGMJY-0004ce-Cq
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 23:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbYASWgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 17:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbYASWgx
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 17:36:53 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1652 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbYASWgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 17:36:52 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JGMIt-0001JX-00; Sat, 19 Jan 2008 22:36:43 +0000
In-Reply-To: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71133>

Let "git svn" run "git gc --auto" every 100 imported commits, to
reduce the number of loose objects.

To handle the common use case of frequent imports, where each
invocation typically fetches less than 100 commits, randomly set the
counter to something in the range 1-100 on initialization. It's almost
as good as saving the counter, and much less of a hassle.

Oh, and 100 is just my best guess at a reasonable number. It could
conceivably need tweaking.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

On 2008-01-19 13:35:57 +0100, Karl Hasselstr=C3=B6m wrote:

> On 2008-01-18 12:44:08 -0800, Junio C Hamano wrote:
>=20
> > Patches?
>=20
> Just hot air and noise for now from my end. Sorry.

OK, it didn't feel good saying that. So here's my attempt at being a
model citizen. (It's not hard with a change this small ...)

I'm not quite sure how this should interact with the --repack flag.
Right now they just coexist, except for never running right after one
another, but conceivably we should do something cleverer. Eric?

 git-svn.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)


diff --git a/git-svn.perl b/git-svn.perl
index 9f2b587..89e1d61 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1247,7 +1247,7 @@ use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
 use IPC::Open3;
=20
-my $_repack_nr;
+my ($_repack_nr, $_gc_nr, $_gc_period);
 # properties that we do not log:
 my %SKIP_PROP;
 BEGIN {
@@ -1413,6 +1413,8 @@ sub init_vars {
 		$_repack_nr =3D $_repack;
 		$_repack_flags ||=3D '-d';
 	}
+	$_gc_period =3D 100;
+	$_gc_nr =3D int(rand($_gc_period)) + 1;
 }
=20
 sub verify_remotes_sanity {
@@ -2157,6 +2159,9 @@ sub do_git_commit {
 		print "Running git repack $_repack_flags ...\n";
 		command_noisy('repack', split(/\s+/, $_repack_flags));
 		print "Done repacking\n";
+	} elsif (--$_gc_nr =3D=3D 0) {
+		$_gc_nr =3D $_gc_period;
+		command_noisy('gc', '--auto');
 	}
 	return $commit;
 }
