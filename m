From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH 1/2] git svn : hook before 'git svn dcommit'
Date: Sun,  3 Jul 2011 22:49:15 +0200
Message-ID: <1309726156-31156-2-git-send-email-frederic.heitzmann@gmail.com>
References: <vpqfwmos5sg.fsf@bauges.imag.fr>
 <1309726156-31156-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
To: Matthieu.Moy@grenoble-inp.fr, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 22:49:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdTbs-0008OR-7A
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 22:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab1GCUtd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jul 2011 16:49:33 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:63783 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab1GCUtb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 16:49:31 -0400
Received: by fxd18 with SMTP id 18so4671297fxd.11
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pTlGfQCB/IFaLefVwzFQWPhpu3Ji0pvD1At+g3mIQtI=;
        b=SZ8ASw+JEndk69QP/+SGGKz6TF+LKX1AzwjAHnPqo3WJpDod/FRWLhxxBx/4dzC3I5
         DUOErKLsgkHQBQIRXASWHoe2f1S/pY1FDoRtk3ZU6avvs5dxxt0sBFKjKSzzxyyVMD7q
         MWYZHmswk6GAIQMSTQMQaoA/6TmmzOWuG7dZI=
Received: by 10.223.92.146 with SMTP id r18mr8270627fam.135.1309726169767;
        Sun, 03 Jul 2011 13:49:29 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id n27sm4044550faa.4.2011.07.03.13.49.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 13:49:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.133.gd3b55a
In-Reply-To: <1309726156-31156-1-git-send-email-frederic.heitzmann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176587>

The 'pre-svn-dcommit' hook is called before 'git svn dcommit', which ab=
orts
if return value is not zero.

Signed-off-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.c=
om>
---
 git-svn.perl |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

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
