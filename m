From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/5] Update "gc" behavior in commit, merge, am and rebase
Date: Wed, 16 May 2012 19:29:37 +0700
Message-ID: <1337171377-26960-6-git-send-email-pclouds@gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
 <1337171377-26960-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Fernando Vezzosi <buccia@repnz.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:34:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUdQx-0002xb-W1
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118Ab2EPMeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:34:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45919 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab2EPMeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:34:22 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so927067dad.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2F+J/N+PEdtxaN66MVn2jhzgehmcdW0WrtC1pTkeNEI=;
        b=xObz84w0JYHYGOJ7W0DoS6C9iOY1BoS6QA3Ph5KqD/723aQbzpXenuJeXm1g6k67zu
         2Hl1qYMKLtzMtimKLGDqfYsZ6D3/PxjBvLZhmnvo6yoGlG89/QeH1Br4FQryhe4hTHnM
         byKMTp2PGKMEH0bDkE6hmW7otfv3AS/AVP/mOpw01gxce7vY5VxRLYNTk2VdqkBeRqK8
         /Je+7Um7B5EOHAo5mJtlpXbIJ/wB3zE4VsYCScC0iW08iTG0scsS6anGjc1YzY/oYvTR
         ER0OCIfJGPPVzxlFZtjwHCZLZvM9DvXEu85ZwqbDGipt02NhsPlcUA43x+PIu+NYBEqc
         leog==
Received: by 10.68.229.65 with SMTP id so1mr16335305pbc.2.1337171662084;
        Wed, 16 May 2012 05:34:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id ru4sm5325849pbc.66.2012.05.16.05.34.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:34:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:30:30 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1337171377-26960-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197878>

Commit d4bb43e (Invoke "git gc --auto" from commit, merge, am and
rebase. - 2007-09-05) used the rule to put "gc --auto" is "where
update-ref occurs". I would argue that this is not a good condition to
run gc, because (at least current) gc is slow. We encourage commit
often and rebase to make all patches in good shape and this workflow
should not be slowed down by random "gc".

Instead, we could just inform users that "gc" should be run soon in
commonly used commands (commit, merge, am and rebase). The warning is
shown once every hour to avoid constantly annoy users, or flooding the
output with warnings if a command is run repeatedly (e.g. in scripts).

Commands that are not expected to return immediately, like
receive-pack or index-pack, are more suitable for "gc --auto". These
keep "gc --auto" as before.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c           |    2 +-
 builtin/gc.c               |    4 +++-
 builtin/gc.h               |    1 +
 builtin/merge.c            |    2 +-
 git-am.sh                  |    2 +-
 git-rebase--interactive.sh |    2 +-
 6 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index bf7d0aa..bfc4b4e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1590,7 +1590,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		     "new_index file. Check that disk is not full or quota is\n"
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
=20
-	gc("commit.autogc", 0);
+	gc("commit.autogc", GC_DRYRUN);
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
diff --git a/builtin/gc.c b/builtin/gc.c
index f82b9ef..bff3d9c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -182,7 +182,7 @@ static int need_to_gc(void)
=20
 int gc(const char *cmd, int flags)
 {
-	const char *av[] =3D { "gc", "--auto", NULL, NULL };
+	const char *av[] =3D { "gc", "--auto", NULL, NULL, NULL };
 	int ac =3D 2;
=20
 	git_config(gc_config, (void*)cmd);
@@ -190,6 +190,8 @@ int gc(const char *cmd, int flags)
 	if (!auto_gc || !need_to_gc())
 		return 0;
=20
+	if (flags & GC_DRYRUN)
+		av[ac++] =3D "--dry-run";
 	if (flags & GC_QUIET)
 		av[ac++] =3D "--quiet";
 	return run_command_v_opt(av, RUN_GIT_CMD);
diff --git a/builtin/gc.h b/builtin/gc.h
index 3482e92..d022944 100644
--- a/builtin/gc.h
+++ b/builtin/gc.h
@@ -2,6 +2,7 @@
 #define GC_H
=20
 #define GC_QUIET  1
+#define GC_DRYRUN 2
=20
 extern int gc(const char *cmd, int flags);
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index 940259d..a0680b0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -389,7 +389,7 @@ static void finish(struct commit *head_commit,
 			update_ref(reflog_message.buf, "HEAD",
 				new_head, head, 0,
 				DIE_ON_ERR);
-			gc(NULL, 0);
+			gc(NULL, GC_DRYRUN);
 		}
 	}
 	if (new_head && show_diffstat) {
diff --git a/git-am.sh b/git-am.sh
index f8b7a0c..71cd2fd 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -902,4 +902,4 @@ if test -s "$dotest"/rewritten; then
 fi
=20
 rm -fr "$dotest"
-git gc --auto
+git gc --auto --dry-run
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..6c1c054 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -573,7 +573,7 @@ do_next () {
 		true # we don't care if this hook failed
 	fi &&
 	rm -rf "$state_dir" &&
-	git gc --auto &&
+	git gc --auto --dry-run &&
 	warn "Successfully rebased and updated $head_name."
=20
 	exit
--=20
1.7.8.36.g69ee2
