From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Tue,  5 Jul 2011 22:44:44 +0200
Message-ID: <1309898684-9486-1-git-send-email-frederic.heitzmann@gmail.com>
References: <4E11558B.90708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu.Moy@grenoble-inp.fr,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 22:45:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeCUW-0000ND-8P
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 22:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab1GEUpB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jul 2011 16:45:01 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:49990 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab1GEUpA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 16:45:00 -0400
Received: by fxd18 with SMTP id 18so6536026fxd.11
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 13:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eCp/qjlNhnLx+7CzLlhPlVXcP2IgDpxxg5JZAObkq+s=;
        b=E5hHgpzwNYEvQnBIim7UzP3mE6B4lknuTkRvtdX4xq36zOSkeOzkh3FEi/lm1m8Egf
         55B3sKMEiMBneblIkJSB7zL3EWWxg8J60bBm3T4EO0HBbhkk7JW0ILfvogMODKgnDaQI
         rX27iOKP+GoX499OSLP6QvZuVFSNC23KBcneQ=
Received: by 10.223.13.13 with SMTP id z13mr936584faz.114.1309898699181;
        Tue, 05 Jul 2011 13:44:59 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id b13sm5548146fab.12.2011.07.05.13.44.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 13:44:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.133.gd3b55a
In-Reply-To: <4E11558B.90708@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176625>

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

This is the second iteration of the patch.
Previous 2 patches were merged into one.=20

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
