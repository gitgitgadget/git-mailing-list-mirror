From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Sat,  9 Jul 2011 14:18:33 +0200
Message-ID: <1310213913-26179-1-git-send-email-frederic.heitzmann@gmail.com>
References: <1309898684-9486-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 09 14:19:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfWV9-0003GQ-LK
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 14:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab1GIMTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jul 2011 08:19:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43491 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab1GIMTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2011 08:19:07 -0400
Received: by bwd5 with SMTP id 5so2297207bwd.19
        for <git@vger.kernel.org>; Sat, 09 Jul 2011 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cUqsFcCTUNHxmhHiUk0FW+oEF3BlHtd58acVVXwbatM=;
        b=lCsTx7rF5AZZNY4JQSwuK1oqKL/iQ+AeLGoPh6av+LYY0IU0fBLWu+U7Q7gufgQ1dn
         4xFP2HJjlwzU2GJrHpQr6Sx+TNUM1Dtkufigbs5MZUurSyijwhtYrEwR+6tWD5y71Onf
         It2mJSY78DPWZnonbeYg3Jn9RZQuxp7gjBIaw=
Received: by 10.205.65.68 with SMTP id xl4mr822000bkb.303.1310213945709;
        Sat, 09 Jul 2011 05:19:05 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id q1sm310320faa.3.2011.07.09.05.19.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Jul 2011 05:19:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.133.gd3b55a
In-Reply-To: <1309898684-9486-1-git-send-email-frederic.heitzmann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176814>

The 'pre-svn-dcommit' hook is called before 'git svn dcommit', which ab=
orts
if return value is not zero. The only parameter given to the hook is th=
e
reference given to 'git svn dcommit'. If no paramter was used, hook get=
s HEAD
as its only parameter.

Signed-off-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.c=
om>
---
There was no remark about patch v2.
I suppose it should be OK for merging upstream.

 Documentation/git-svn.txt |   14 +++++++++++++-
 git-svn.perl              |   21 +++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 713e523..ec87ed3 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -700,6 +700,18 @@ section because they affect the 'git-svn-id:' meta=
data line, except
 for rewriteRoot and rewriteUUID which can be used together.
=20
=20
+HOOKS
+-----
+
+The 'pre-svn-dcommit' hook is called by 'git svn dcommit' and can be u=
sed to
+prevent some diff to be committed to a SVN repository. It may typicall=
y be
+used to filter some intermediate patches, which were committed into gi=
t but
+must not find their way to the SVN repository.
+
+It takes a single parameter, the reference given to 'git svn dcommit'.=
 If the
+hook exists with a non zero-status, 'git svn dcommit' will abort.
+
+
 BASIC EXAMPLES
 --------------
=20
@@ -901,7 +913,7 @@ reset) branches-maxRev and/or tags-maxRev as approp=
riate.
=20
 SEE ALSO
 --------
-linkgit:git-rebase[1]
+linkgit:git-rebase[1], linkgit:githooks[5]
=20
 GIT
 ---
diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..a537858 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -396,6 +396,25 @@ sub init_subdir {
 	$_repository =3D Git->repository(Repository =3D> $ENV{GIT_DIR});
 }
=20
+sub pre_svn_dcommit_hook {
+	my $head =3D shift;
+
+	my $hook =3D "$ENV{GIT_DIR}/hooks/pre-svn-dcommit";
+	return 0 if ! -e $hook || ! -x $hook;
+
+	system($hook, $head);
+	if ($? =3D=3D -1) {
+		print "[pre_svn_dcommit_hook] failed to execute $hook: $!\n";
+		return 1;
+	} elsif ($? & 127) {
+		printf "[pre_svn_dcommit_hook] child died with signal %d, %s coredum=
p\n",
+		($? & 127),  ($? & 128) ? 'with' : 'without';
+		return 1;
+	} else {
+		return $? >> 8;
+	}
+}
+
 sub cmd_clone {
 	my ($url, $path) =3D @_;
 	if (!defined $path &&
@@ -505,6 +524,8 @@ sub cmd_dcommit {
 		. "or stash them with `git stash'.\n";
 	$head ||=3D 'HEAD';
=20
+	return if pre_svn_dcommit_hook($head);
+
 	my $old_head;
 	if ($head ne 'HEAD') {
 		$old_head =3D eval {
--=20
1.7.6.133.gd3b55a
