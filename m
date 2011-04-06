From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Wed,  6 Apr 2011 11:05:36 -0400
Message-ID: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
References: <4D9B7A9E.6040902@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:05:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7UIo-0004nV-Cg
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 17:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282Ab1DFPFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 11:05:44 -0400
Received: from mx1.itasoftware.com ([63.115.78.20]:42870 "EHLO
	mx1.itasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203Ab1DFPFn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 11:05:43 -0400
Received: from ita4mta2.internal.itasoftware.com (ita4mta2.internal.itasoftware.com [10.4.52.168])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.itasoftware.com (Postfix) with ESMTP id 71377256D46;
	Wed,  6 Apr 2011 11:05:36 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (lb1.dc4nat162.dc4.internal.itasoftware.com [10.4.199.162])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ita4mta2.internal.itasoftware.com (Postfix) with ESMTPS id 4796619D8031;
	Wed,  6 Apr 2011 11:05:36 -0400 (EDT)
Received: from asedeno by asedeno.corp.itasoftware.com with local (Exim 4.74)
	(envelope-from <asedeno@asedeno.corp.itasoftware.com>)
	id 1Q7UIa-0002ON-7X; Wed, 06 Apr 2011 11:05:36 -0400
X-Mailer: git-send-email 1.7.4.2.1.gd6f1f
In-Reply-To: <4D9B7A9E.6040902@mit.edu>
X-ITASoftware-MailScanner: Found to be clean
X-ITASoftware-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 3, ALL_TRUSTED -1.00)
X-ITASoftware-MailScanner-From: asedeno@itasoftware.com
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170979>

Similar to the 'remote.<name>.pushurl' config key for git remotes,
'pushurl' is designed to be used in cases where 'url' points to an SVN
repository via a read-only transport, to provide an alternate
read/write transport. It is assumed that both keys point to the same
repository.

The 'pushurl' key is distinct from the 'commiturl' key in that
'commiturl' is a full svn path while 'pushurl' (like 'url') is a base
path. 'commiturl' takes precendece over 'pushurl' in cases where
either might be used.

The 'pushurl' is used by git-svn's dcommit and branch commands.

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
Reviewed-off-by: James Y Knight <jknight@itasoftware.com>
---
 Documentation/git-svn.txt |   10 ++++++++++
 git-svn.perl              |   18 +++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ea8fafd..4aa6404 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -648,6 +648,16 @@ svn-remote.<name>.rewriteUUID::
 	where the original UUID is not available via either useSvmProps
 	or useSvnsyncProps.
=20
+svn-remote.<name>.pushurl::
+
+	Similar to git's 'remote.<name>.pushurl', this key is designed
+	to be used in cases where 'url' points to an SVN repository
+	via a read-only transport, to provide an alternate read/write
+	transport. It is assumed that both keys point to the same
+	repository. Unlike 'commiturl', 'pushurl' is a base path. If
+	either 'commiturl' or 'pushurl' could be used, 'commiturl'
+	takes precedence.
+
 svn.brokenSymlinkWorkaround::
 	This disables potentially expensive checks to workaround
 	broken symlinks checked into SVN by broken clients.  Set this
diff --git a/git-svn.perl b/git-svn.perl
index fa8cd07..184442a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -531,7 +531,7 @@ sub cmd_dcommit {
 		$url =3D eval { command_oneline('config', '--get',
 			      "svn-remote.$gs->{repo_id}.commiturl") };
 		if (!$url) {
-			$url =3D $gs->full_url
+			$url =3D $gs->full_pushurl
 		}
 	}
=20
@@ -679,7 +679,7 @@ sub cmd_branch {
 	$head ||=3D 'HEAD';
=20
 	my (undef, $rev, undef, $gs) =3D working_head_info($head);
-	my $src =3D $gs->full_url;
+	my $src =3D $gs->full_pushurl;
=20
 	my $remote =3D Git::SVN::read_all_remotes()->{$gs->{repo_id}};
 	my $allglobs =3D $remote->{ $_tag ? 'tags' : 'branches' };
@@ -730,7 +730,7 @@ sub cmd_branch {
 		$url =3D eval { command_oneline('config', '--get',
 			"svn-remote.$gs->{repo_id}.commiturl") };
 		if (!$url) {
-			$url =3D $remote->{url};
+			$url =3D $remote->{pushurl} || $remote->{url};
 		}
 	}
 	my $dst =3D join '/', $url, $lft, $branch_name, ($rgt || ());
@@ -1834,6 +1834,8 @@ sub read_all_remotes {
 			$r->{$1}->{svm} =3D {};
 		} elsif (m!^(.+)\.url=3D\s*(.*)\s*$!) {
 			$r->{$1}->{url} =3D $2;
+		} elsif (m!^(.+)\.pushurl=3D\s*(.*)\s*$!) {
+			$r->{$1}->{pushurl} =3D $2;
 		} elsif (m!^(.+)\.(branches|tags)=3D$svn_refspec$!) {
 			my ($remote, $t, $local_ref, $remote_ref) =3D
 			                                     ($1, $2, $3, $4);
@@ -2071,6 +2073,8 @@ sub new {
 	$self->{url} =3D command_oneline('config', '--get',
 	                               "svn-remote.$repo_id.url") or
                   die "Failed to read \"svn-remote.$repo_id.url\" in c=
onfig\n";
+	$self->{pushurl} =3D eval { command_oneline('config', '--get',
+	                          "svn-remote.$repo_id.pushurl") };
 	$self->rebuild;
 	$self;
 }
@@ -2548,6 +2552,14 @@ sub full_url {
 	$self->{url} . (length $self->{path} ? '/' . $self->{path} : '');
 }
=20
+sub full_pushurl {
+	my ($self) =3D @_;
+	if ($self->{pushurl}) {
+		return $self->{pushurl} . (length $self->{path} ? '/' . $self->{path=
} : '');
+	} else {
+		return $self->full_url;
+	}
+}
=20
 sub set_commit_header_env {
 	my ($log_entry) =3D @_;
--=20
1.7.4.2.1.gd6f1f
