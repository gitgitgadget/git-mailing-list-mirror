From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] gc: save log from daemonized gc --auto and print it next time
Date: Sat, 22 Aug 2015 09:12:26 +0700
Message-ID: <1440209546-23442-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8AKbXqsuNJL7Usb-haiynDcCDQXk56WYh5PxzGU3NvaAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 04:13:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSyJG-0002Pf-8n
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 04:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbbHVCNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 22:13:08 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36167 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbHVCNG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 22:13:06 -0400
Received: by pdbmi9 with SMTP id mi9so32316557pdb.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 19:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DH9bvRM1pkb6ZeUufzYsC2rTU8+PMRhTaEMK8HWfD7w=;
        b=nJZzotxe8KpCsfEYOIFwwtcbaoGKpLo57msOWvmHJBbsUVSqHSYlalWIt4sBuY23m0
         bBqvdShNR3aT/5thtPXhQFJ5vAwknX63B1d37pCwAJecLuLNDZj+bqrTAudE3embGOxZ
         1cXIGmmM2FBBBpkZoDV8Y7lMj/DS+23dmqGRqtjEDUg3k2sn/F66vp3hv5u3/NXc8xZO
         oSv+Le2QPyZSoZaSVLjC9ilD+hutqKYFn7/PiWL3r8KnfxIKH6EjeAL2i/ZNV6KUl9Op
         6mED/mu5My0yB7nec+9X/D60kWlUjEmA2DyanWjQymlA06AwFXsJs0cnGyEk+qDIfEqJ
         QJXw==
X-Received: by 10.70.50.165 with SMTP id d5mr23524378pdo.23.1440209585396;
        Fri, 21 Aug 2015 19:13:05 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id d4sm9215063pdc.93.2015.08.21.19.13.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 19:13:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 09:13:01 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <CACsJy8AKbXqsuNJL7Usb-haiynDcCDQXk56WYh5PxzGU3NvaAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276362>

While commit 9f673f9 (gc: config option for running --auto in
background - 2014-02-08) helps reduce some complaints about 'gc
--auto' hogging the terminal, it creates another set of problems.

The latest in this set is, as the result of daemonizing, stderr is
closed and all warnings are lost. This warning at the end of cmd_gc()
is particularly important because it tells the user how to avoid "gc
--auto" running repeatedly. Because stderr is closed, the user does
not know, naturally they complain about 'gc --auto' wasting CPU.

Daemonized gc now saves stderr to $GIT_DIR/gc.log. Following gc runs
will not be daemonized and gc.log printed out until the user removes
gc.log.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Let's try again. Compared to v2 [1], this version does not delete
 gc.log automatically any more. The user needs to take action, then
 delete gc.log to bring it background again.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/266182/focu=
s=3D266320

 builtin/gc.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcc75d9..00a83e1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -43,9 +43,20 @@ static struct argv_array prune_worktrees =3D ARGV_AR=
RAY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
=20
 static char *pidfile;
+static struct strbuf log_filename =3D STRBUF_INIT;
+static int daemonized;
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
@@ -330,13 +341,24 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n")=
);
 		}
 		if (detach_auto) {
+			struct strbuf sb =3D STRBUF_INIT;
+			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0) {
+				warning(_("last gc run reported:\n"
+					  "%s\n"
+					  "running in foreground until %s is removed"),
+					sb.buf, git_path("gc.log"));
+				detach_auto =3D 0;
+			}
+			strbuf_release(&sb);
+		}
+		if (detach_auto) {
 			if (gc_before_repack())
 				return -1;
 			/*
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonize();
+			daemonized =3D !daemonize();
 		}
 	} else
 		add_repack_all_option();
@@ -349,6 +371,18 @@ int cmd_gc(int argc, const char **argv, const char=
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
--=20
2.3.0.rc1.137.g477eb31
