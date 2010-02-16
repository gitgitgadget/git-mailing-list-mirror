From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 12/26] grep: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:03 +0700
Message-ID: <1266336317-607-13-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:14:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ4P-0004yx-W5
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126Ab0BPQOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:14:36 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:59140 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab0BPQOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:14:35 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2010 11:14:35 EST
Received: by gxk27 with SMTP id 27so88474gxk.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=z0QKq4yAKxd4/YlF2BnG8M6goxRvYZqWUV48j1maVGQ=;
        b=MHphZQeY5qXYyEZ5u8Og/UcEt+OPBLYIFloRTdKmCgyt1UTbGo6Jhm30uhVs813EJ2
         saNUYYTkoaJfiSqYtwOKwUEpuR1i5R87YYUVVpyqfTTclUHPPqjL/Wo/5Ip47X6yDY0j
         G09kmIUDvjaqQezcDnhfXHSqkFOJmAFP6ka9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=C6re6kppmkjp7f4FmrYdfoLi/HehEvO5u9he5KGRoqqDBdgcUonTE/4D3zIWDIp9VT
         QDMvtNFypNPF2qs+P9T6EFr66nIOdEzhocsQDFi+wrGsSbnGUcUhXFMWs8WqbkEd4+4Y
         y7AlFCz686N2ZjniMDFcAJe4jPffwaNDi9BYs=
Received: by 10.101.128.39 with SMTP id f39mr4591524ann.95.1266336557228;
        Tue, 16 Feb 2010 08:09:17 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 8sm2855870ywg.19.2010.02.16.08.09.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:09:16 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:06:33 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140116>

grep has USE_PAGER set. setup_pager() may read config even
setup_git_dir* is not run yet. When the config path is required,
setup_git_env() plays hero and set gitdir to ".git". Shortly after,
setup_git_dir* is run inside cmd_shortlog() and may move gitdir
to somewhere else.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-grep.c  |    9 +++------
 git.c           |    2 +-
 t/t7002-grep.sh |    2 ++
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 46ffc1d..84c05e0 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -758,7 +758,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	const char **paths =3D NULL;
 	int i;
 	int dummy;
-	int nongit =3D 0, use_index =3D 1;
+	int use_index =3D 1;
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -846,8 +846,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_END()
 	};
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-
 	/*
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
@@ -885,9 +883,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
=20
-	if (use_index && nongit)
-		/* die the same way as if we did it at the beginning */
-		setup_git_directory();
+	if (use_index && !startup_info->have_repository)
+		die("No git repository found");
=20
 	/*
 	 * skip a -- separator; we know it cannot be
diff --git a/git.c b/git.c
index c7af80e..3462b49 100644
--- a/git.c
+++ b/git.c
@@ -339,7 +339,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, USE_PAGER },
+		{ "grep", cmd_grep, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "hash-object", cmd_hash_object, RUN_SETUP_GENTLY },
 		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack },
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index ebae152..67afb42 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -8,6 +8,8 @@ test_description=3D'git grep various.
=20
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 cat >hello.c <<EOF
 #include <stdio.h>
 int main(int argc, const char **argv)
--=20
1.7.0.195.g637a2
