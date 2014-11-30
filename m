From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/34] checkout: don't require a work tree when checking out into a new one
Date: Sun, 30 Nov 2014 15:24:56 +0700
Message-ID: <1417335899-27307-32-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:30:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuztk-0000hp-Mz
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbaK3IaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:30:23 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:37140 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbaK3IaV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:30:21 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so9120216pab.7
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3CzpLFd0gJtZNucyH6x86P02y+I5tKLOfh2LSGZYww0=;
        b=VNBCyKbhjkIQHd1QC14QpJcJCvFp3NZVN2BxH+QzQfyZ/6rvT7969xmJnmuIWJbPRw
         UgjF0woi1CSzmJSzK5HVNr2nALWVigFPXtApOCKWVV7hPcblENv0PT31doxDHAsWC/P6
         x4HN8DUU849R4fY6cxRzTjiqWhvGE/XBntL+9b8XOF6aSEZDHs+m6HGAaYC+JHdQ0XDJ
         ipsjY20yV7VBy5GQ70Dxs7ETeHdE1OxS5GPxsPkeK/fa/F8AR2qAXTi1tqC7B/3FVvPI
         0fiYK835DDLiFnjAZ/rzLK+oBNcHEvmXvV/b4Ly1NAEymmmD76Zruljk9mlXJrzwKdfi
         ycQA==
X-Received: by 10.66.226.167 with SMTP id rt7mr52883537pac.12.1417336221516;
        Sun, 30 Nov 2014 00:30:21 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id fy4sm14264548pbb.42.2014.11.30.00.30.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:30:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:30:19 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260418>

=46rom: Dennis Kaarsemaker <dennis@kaarsemaker.net>

=46or normal use cases, it does not make sense for 'checkout' to work o=
n
a bare repository, without a worktree. But "checkout --to" is an
exception because it _creates_ a new worktree. Allow this option to
run on bare repositories.

People who check out from a bare repository should remember that
core.logallrefupdates is off by default and it should be turned back
on. `--to` cannot do this automatically behind the user's back because
some user may deliberately want no reflog.

=46or people interested in repository setup/discovery code,
is_bare_repository_cfg (aka "core.bare") is unchanged by this patch,
which means 'true' by default for bare repos. Fortunately when we get
the repo through a linked checkout, is_bare_repository_cfg is never
used. So all is still good.

[nd: commit message]

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     |  3 +++
 git.c                  |  2 +-
 t/t2025-checkout-to.sh | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5dfdbda..8c5276c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1364,6 +1364,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	if (opts.new_worktree_mode)
 		opts.new_worktree =3D NULL;
=20
+	if (!opts.new_worktree)
+		setup_work_tree();
+
 	if (conflict_style) {
 		opts.merge =3D 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/git.c b/git.c
index 18fbf79..160896a 100644
--- a/git.c
+++ b/git.c
@@ -383,7 +383,7 @@ static struct cmd_struct commands[] =3D {
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format },
-	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout", cmd_checkout, RUN_SETUP },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index e2db078..4bd1df4 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -81,4 +81,19 @@ test_expect_success 'not die on re-checking out curr=
ent branch' '
 	)
 '
=20
+test_expect_success 'checkout --to from a bare repo' '
+	(
+		git clone --bare . bare &&
+		cd bare &&
+		git checkout --to ../there2 -b bare-master master
+	)
+'
+
+test_expect_success 'checkout from a bare repo without --to' '
+	(
+		cd bare &&
+		test_must_fail git checkout master
+	)
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
