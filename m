From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: [PATCH] git-svn: make rebuild respect rewriteRoot option
Date: Fri, 20 Jun 2008 00:33:59 +0200
Message-ID: <20080620003359.0dbb7725@neuron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Sia-0003Aw-PO
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYFSWeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 18:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbYFSWeE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:34:04 -0400
Received: from zoidberg.org ([213.133.99.5]:60109 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbYFSWeD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 18:34:03 -0400
Received: from neuron (xdsl-87-78-141-113.netcologne.de [::ffff:87.78.141.113])
  (IDENT: unknown, AUTH: LOGIN jast, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Fri, 20 Jun 2008 00:34:00 +0200
  id 0016F154.485ADEDA.0000195F
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85551>

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
Since this patch focuses on a case that is discouraged by the git-svn
manpage (use rewriteRoot even though commits already exist), a bit of
discussion might be helpful. On the up side, I think it doesn't affect =
any
other cases.

The specific problem situation looks like this:

% git fetch git://.../clone-of-some-svn-repo (...)
% git svn init -s --rewrite-root=3D<url contained in fetched commits> <=
url \
      we want to use>
% git svn rebase
[Boom]

This patch passes all existing git-svn tests; feel free to suggest
additional test(s) to cover this sort of situation.

 git-svn.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

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
--=20
1.5.5.1
