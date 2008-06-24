From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: [PATCH v2] git-svn: make rebuild respect rewriteRoot option
Date: Tue, 24 Jun 2008 02:17:36 +0200
Message-ID: <20080624021736.2d272d9c@neuron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 02:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAwFP-0007D0-PI
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 02:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbYFXARu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jun 2008 20:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbYFXARu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 20:17:50 -0400
Received: from zoidberg.org ([213.133.99.5]:33314 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbYFXARt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 20:17:49 -0400
Received: from neuron (xdsl-87-78-93-226.netcologne.de [::ffff:87.78.93.226])
  (IDENT: unknown, AUTH: LOGIN jast, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 24 Jun 2008 02:17:38 +0200
  id 00181C7F.48603D23.000079C5
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85956>

Suppose someone fetches git-svn-ified commits from another repo and the=
n
attempts to use 'git-svn init --rewrite-root=3Dfoo bar'. Using git svn =
rebase
after that will fail badly:

 * For each commit tried by working_head_info, rebuild is called indire=
ctly.
 * rebuild will iterate over all commits and skip all of them because t=
he
   URL does not match. Because of that no rev_map file is generated at =
all.
 * Thus, rebuild will run once for every commit. This takes ages.
 * In the end there still isn't any rev_map file and thus working_head_=
info
   fails.

Addressing this behaviour fixes an apparently not too uncommon problem =
with
providing git-svn mirrors of Subversion repositories. Some repositories=
 are
accessed using different URLs depending on whether the user has push
privileges or not. In the latter case, an anonymous URL is often used t=
hat
differs from the push URL. Providing a mirror that is usable in both ca=
ses
becomes a lot more possible with this change.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
=46or reference, the previous version of this patch at
<http://thread.gmane.org/gmane.comp.version-control.git/85551> was
acked by Eric Wong (see that thread); the only change here is the added
test case as suggested by Eric.

The test doesn't exactly reproduce the original situation but it does
trigger the rebuild process to ensure it works correctly despite
'rewriteRoot' being set to something not equal to 'url', which is what
we are after in the first place.

 git-svn.perl                                |    6 ++--
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |   32 +++++++++++++++++++=
++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)
 create mode 100755 t/t9123-git-svn-rebuild-with-rewriteroot.sh

diff --git a/git-svn.perl b/git-svn.perl
index a54979d..4c9c59b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2577,8 +2577,8 @@ sub rebuild {
 	my ($log, $ctx) =3D
 	    command_output_pipe(qw/rev-list --pretty=3Draw --no-color --rever=
se/,
 	                        $self->refname, '--');
-	my $full_url =3D $self->full_url;
-	remove_username($full_url);
+	my $metadata_url =3D $self->metadata_url;
+	remove_username($metadata_url);
 	my $svn_uuid =3D $self->ra_uuid;
 	my $c;
 	while (<$log>) {
@@ -2596,7 +2596,7 @@ sub rebuild {
 		# if we merged or otherwise started elsewhere, this is
 		# how we break out of it
 		if (($uuid ne $svn_uuid) ||
-		    ($full_url && $url && ($url ne $full_url))) {
+		    ($metadata_url && $url && ($url ne $metadata_url))) {
 			next;
 		}
=20
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-=
svn-rebuild-with-rewriteroot.sh
new file mode 100755
index 0000000..cf3f64d
--- /dev/null
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Jan Kr=C3=BCger
+#
+
+test_description=3D'git-svn respects rewriteRoot during rebuild'
+
+. ./lib-git-svn.sh
+
+mkdir import
+cd import
+	touch foo
+	svn import -m 'import for git-svn' . "$svnrepo" >/dev/null
+cd ..
+rm -rf import
+
+test_expect_success 'init, fetch and checkout repository' '
+	git svn init --rewrite-root=3Dhttp://invalid.invalid/ "$svnrepo" &&
+	git svn fetch
+	git checkout -b mybranch remotes/git-svn
+	'
+
+test_expect_success 'remove rev_map' '
+	rm "$GIT_SVN_DIR"/.rev_map.*
+	'
+
+test_expect_success 'rebuild rev_map' '
+	git svn rebase >/dev/null
+	'
+
+test_done
+
--=20
1.5.6.2.g4316
