From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 10/26] shortlog: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:01 +0700
Message-ID: <1266336317-607-11-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:15:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ52-0005Rn-ES
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144Ab0BPQPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:15:13 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:61942 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130Ab0BPQPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:15:12 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2010 11:15:12 EST
Received: by ywh35 with SMTP id 35so4824679ywh.21
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oAjEvfkrRGoHBDHTcr9/Yra5HGsDX/bW4o0Nxjq6O0g=;
        b=AQcY0QiegArTlCpV3OYCes8SrSROdKzJ0OswFtJytKpIg2Hmzdnk32iN3c73MM0baY
         IWWMlEBfHfhTeN4CqDrGEAD8c4YVN2JSgC4wdoTe0U2Rv8QRAEy1/MzWLJlxRU4FyL+Z
         8qHYGDKQUwUq1oNncxs2p858YJ5o+tQgogb8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GYlmoPedAwFmC8XOthTEuZbqiYAz3stkXRxsZuu6sSrtB1WJjLiTh1gOdG27c/YTdD
         DxvlFwwUm3YQa94bbBavw8ds+cEsJWgkZdBJql51RkX5m6JdQqViMQ36gpVlqmxpNyWN
         ejkjjMh3oN08aN0N6pgAWL46pnRBEeR7e3Ay8=
Received: by 10.150.47.19 with SMTP id u19mr12429250ybu.160.1266336544527;
        Tue, 16 Feb 2010 08:09:04 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 5sm2870508ywd.27.2010.02.16.08.09.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:09:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:06:21 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140117>

shortlog has USE_PAGER set. setup_pager() may read config even
setup_git_dir* is not run yet. When the config path is required,
setup_git_env() plays hero and set gitdir to ".git". Shortly after,
setup_git_dir* is run inside cmd_shortlog() and may move gitdir
to somewhere else.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-shortlog.c  |    4 +---
 git.c               |    2 +-
 t/t4201-shortlog.sh |    2 ++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b3b055f..a62dfb0 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -249,7 +249,6 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
 {
 	static struct shortlog log;
 	static struct rev_info rev;
-	int nongit;
=20
 	static const struct option options[] =3D {
 		OPT_BOOLEAN('n', "numbered", &log.sort_by_number,
@@ -265,7 +264,6 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
=20
 	struct parse_opt_ctx_t ctx;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
 	init_revisions(&rev, prefix);
@@ -292,7 +290,7 @@ parse_done:
 	log.user_format =3D rev.commit_format =3D=3D CMIT_FMT_USERFORMAT;
=20
 	/* assume HEAD if from a tty */
-	if (!nongit && !rev.pending.nr && isatty(0))
+	if (startup_info->have_repository && !rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
 	if (rev.pending.nr =3D=3D 0) {
 		read_from_stdin(&log);
diff --git a/git.c b/git.c
index a165b43..c7af80e 100644
--- a/git.c
+++ b/git.c
@@ -386,7 +386,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
-		{ "shortlog", cmd_shortlog, USE_PAGER },
+		{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index a01e55b..7ae327a 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -8,6 +8,8 @@ test_description=3D'git shortlog
=20
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 echo 1 > a1
 git add a1
 tree=3D$(git write-tree)
--=20
1.7.0.195.g637a2
