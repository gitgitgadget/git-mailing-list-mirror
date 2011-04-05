From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Tue,  5 Apr 2011 16:15:09 -0400
Message-ID: <1302034509-8842-1-git-send-email-asedeno@mit.edu>
References: <4D9B310A.9020203@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 22:15:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Ceq-0008ID-6z
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 22:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab1DEUPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 16:15:19 -0400
Received: from mx2.itasoftware.com ([63.115.78.21]:50484 "EHLO
	mx2.itasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab1DEUPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 16:15:18 -0400
Received: from ita4mta3.internal.itasoftware.com (ita4mta3.internal.itasoftware.com [10.4.52.159])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.itasoftware.com (Postfix) with ESMTP id CA5B357D48;
	Tue,  5 Apr 2011 16:17:03 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (lb1.dc4nat180.dc4.internal.itasoftware.com [10.4.199.180])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ita4mta3.internal.itasoftware.com (Postfix) with ESMTP id 739DA1C24053;
	Tue,  5 Apr 2011 16:15:09 -0400 (EDT)
Received: from asedeno by asedeno.corp.itasoftware.com with local (Exim 4.74)
	(envelope-from <asedeno@asedeno.corp.itasoftware.com>)
	id 1Q7Ceb-0002J7-Dy; Tue, 05 Apr 2011 16:15:09 -0400
X-Mailer: git-send-email 1.7.4.2.1.gd6f1f
In-Reply-To: <4D9B310A.9020203@mit.edu>
X-ITASoftware-MailScanner: Found to be clean
X-ITASoftware-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 3, ALL_TRUSTED -1.00)
X-ITASoftware-MailScanner-From: asedeno@itasoftware.com
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170909>

Similar to the 'remote.<name>.pushurl' config key for git remotes, the
'pushurl' key is treated the same as the 'url' key. This is distinct
from the 'commiturl' key, which is defined to be a full svn path.

This is necessary if you want to be able to commit to multiple branches=
=2E

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
Reviewed-off-by: James Y Knight <jknight@itasoftware.com>
---
 Documentation/git-svn.txt |    6 ++++++
 git-svn.perl              |   14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ea8fafd..94f7497 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -648,6 +648,12 @@ svn-remote.<name>.rewriteUUID::
 	where the original UUID is not available via either useSvmProps
 	or useSvnsyncProps.
=20
+svn-remote.<name>.pushurl::
+	Similar to git's remote.<name>.pushurl, this is useful in
+	cases where the SVN repository url is read-only. Unlike
+	'commiturl', 'pushurl' is a base path. This key is overridden
+	by the 'commiturl' config key.
+
 svn.brokenSymlinkWorkaround::
 	This disables potentially expensive checks to workaround
 	broken symlinks checked into SVN by broken clients.  Set this
diff --git a/git-svn.perl b/git-svn.perl
index fa8cd07..8372606 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -531,7 +531,13 @@ sub cmd_dcommit {
 		$url =3D eval { command_oneline('config', '--get',
 			      "svn-remote.$gs->{repo_id}.commiturl") };
 		if (!$url) {
-			$url =3D $gs->full_url
+			$url =3D eval { command_oneline('config', '--get',
+				      "svn-remote.$gs->{repo_id}.pushurl") };
+			if ($url) {
+				$url .=3D (length $gs->{path} ? '/' . $gs->{path} : '');
+			} else {
+				$url =3D $gs->full_url
+			}
 		}
 	}
=20
@@ -730,7 +736,11 @@ sub cmd_branch {
 		$url =3D eval { command_oneline('config', '--get',
 			"svn-remote.$gs->{repo_id}.commiturl") };
 		if (!$url) {
-			$url =3D $remote->{url};
+			$url =3D eval { command_oneline('config', '--get',
+				      "svn-remote.$gs->{repo_id}.pushurl") };
+			if (!$url) {
+				$url =3D $remote->{url};
+			}
 		}
 	}
 	my $dst =3D join '/', $url, $lft, $branch_name, ($rgt || ());
--=20
1.7.4.2.1.gd6f1f
