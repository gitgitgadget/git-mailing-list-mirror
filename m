From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gc: save log from daemonized gc --auto and print it next time
Date: Tue, 24 Mar 2015 19:17:28 +0700
Message-ID: <1427199448-28278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 13:17:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaNm6-0002Ld-0J
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 13:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbbCXMRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 08:17:33 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33670 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbbCXMRc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 08:17:32 -0400
Received: by pdnc3 with SMTP id c3so219928513pdn.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=4EOLXJvbuCK71tX4YYnOP0G2r6iCzVKHOLaZRGasjBY=;
        b=grm7Ybv0vlxNeaJv/Y3x7WpyUlqGhNSfJa8tzgw3fDbpL+cSiesX9nxy8xCAsCxzRm
         yAP+LpuHHUAn69hhXJL2R1U+PLASVDjaXLJ3+jink6vw/X4A7Gvk5VEmoQmIS7Pv+Quf
         V3TCm6eqwPpBNi84Tc9oflwj6Sa+IMah7WIAQX8CGskkia94EoTAtP1prbIATlRRCABU
         1zAqefpW4SOyW/kDoC+VKJUMPZLSeZRA3ZicZbXmQXbg9I0XRogHbbdiRkX+SV/1TRLR
         wu2nayUaQZNnlGjHFWAdXMAlHnibzF/IIyNBihGflxoBwG5nJdmGQ+g4k+E6SjpKDeqF
         wTNA==
X-Received: by 10.68.167.131 with SMTP id zo3mr6862896pbb.123.1427199451691;
        Tue, 24 Mar 2015 05:17:31 -0700 (PDT)
Received: from lanh ([115.73.227.194])
        by mx.google.com with ESMTPSA id ef3sm4066516pbc.26.2015.03.24.05.17.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 05:17:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 24 Mar 2015 19:17:30 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266182>

While commit 9f673f9 (gc: config option for running --auto in
background - 2014-02-08) helps reduce some complaints about 'gc
--auto' hogging the terminal, it creates another set of problems.

The latest in this set is, as the result of daemonizing, stderr is
closed and all warnings are lost. This warning at the end of cmd_gc()
is particularly important because it tells the user how to avoid "gc
--auto" running repeatedly. Because stderr is closed, the user does
not know, naturally they complain about 'gc --auto' wasting CPU.

Besides reverting 9f673f9 and looking at the problem from another
angle, we could save the stderr in $GIT_DIR/gc.log. Next time, 'gc
--auto' will print the saved warnings, delete gc.log and exit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c  | 37 ++++++++++++++++++++++++++++++++++++-
 t/t6500-gc.sh | 20 ++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 5c634af..07769a9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,8 @@ static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
 static int detach_auto =3D 1;
+static struct strbuf log_filename =3D STRBUF_INIT;
+static int daemonized;
 static const char *prune_expire =3D "2.weeks.ago";
=20
 static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
@@ -44,6 +46,15 @@ static char *pidfile;
=20
 static void remove_pidfile(void)
 {
+	if (daemonized && log_filename.len) {
+		struct stat st;
+
+		close(2);
+		if (stat(log_filename.buf, &st) ||
+		    !st.st_size ||
+		    rename(log_filename.buf, git_path("gc.log")))
+			unlink(log_filename.buf);
+	}
 	if (pidfile)
 		unlink(pidfile);
 }
@@ -324,13 +335,25 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n")=
);
 		}
 		if (detach_auto) {
+			struct strbuf sb =3D STRBUF_INIT;
+
+			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0) {
+				warning(_("Last gc run reported the following, gc skipped"));
+				fputs(sb.buf, stderr);
+				strbuf_release(&sb);
+				/* let the next gc --auto run as usual */
+				unlink(git_path("gc.log"));
+				return 0;
+			}
+
 			if (gc_before_repack())
 				return -1;
 			/*
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonize();
+			if (!daemonize())
+				daemonized =3D 1;
 		}
 	} else
 		add_repack_all_option();
@@ -343,6 +366,18 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 		    name, (uintmax_t)pid);
 	}
=20
+	if (daemonized) {
+		int fd;
+
+		strbuf_addstr(&log_filename, git_path("gc.log_XXXXXX"));
+		fd =3D xmkstemp(log_filename.buf);
+		if (fd >=3D 0) {
+			dup2(fd, 2);
+			close(fd);
+		} else
+			strbuf_release(&log_filename);
+	}
+
 	if (gc_before_repack())
 		return -1;
=20
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 63194d8..54bc9c4 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -30,4 +30,24 @@ test_expect_success 'gc -h with invalid configuratio=
n' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
=20
+test_expect_success !MINGW 'gc --auto and logging' '
+	git init abc &&
+	(
+		cd abc &&
+		# These create blobs starting with the magic number "17"
+		for i in 901 944; do
+			echo $i >test && git hash-object -w test >/dev/null
+		done &&
+		git config gc.auto 1 &&
+		LANG=3DC git gc --auto &&
+		sleep 1 && # give it time to daemonize
+		while test -f .git/gc.pid; do sleep 1; done &&
+		grep "too many unreachable loose objects" .git/gc.log &&
+		LANG=3DC git gc --auto 2>error &&
+		grep skipped error &&
+		grep "too many unreachable loose objects" error &&
+		! test -f .git/gc.log
+	)
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
