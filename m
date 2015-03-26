From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] gc: save log from daemonized gc --auto and print it next time
Date: Thu, 26 Mar 2015 17:54:23 +0700
Message-ID: <1427367263-16004-1-git-send-email-pclouds@gmail.com>
References: <1427199448-28278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 11:55:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb5RH-00053z-Vg
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 11:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbbCZKy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2015 06:54:59 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35078 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbbCZKy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 06:54:57 -0400
Received: by pacwz10 with SMTP id wz10so8597400pac.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GwrS62ZB/711NNf4/RyAz7XR4/YdkfIGWb9NgDdy2p4=;
        b=f7O+NrRDsoYkjyH5tdtduF6hN6DgEv2PioCRoD13J5knWj/r9BX57mp+SGA+tuU6Jf
         mpNbBVW8wlZPE3YFPpXzPPNNJFsOh93/Sh16OTb3myL1Iq2m3CH91Y6f3z8FMK3MAPIS
         /xINpDUr7N7qlrQHVwE7Tr+faCXHdiT6dw0fFkTjI/32x71QdO71SZVbH19tGeSPxMuL
         tkfJz0wUMh7ps+JdsN6JuJaxKQDU+5944HwV3RlOzj+2HKIgcrwotz5chK4xVbmQa39p
         JDL7UwP61FY/HfdsBmSMKSzKjc+V7D/bGmszGP3V/2IEn6YUwmP3JSSJpyAafitSzXOL
         4C0w==
X-Received: by 10.70.38.195 with SMTP id i3mr9380285pdk.82.1427367296947;
        Thu, 26 Mar 2015 03:54:56 -0700 (PDT)
Received: from lanh ([115.73.229.111])
        by mx.google.com with ESMTPSA id lr1sm5226725pab.39.2015.03.26.03.54.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 03:54:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 26 Mar 2015 17:54:56 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1427199448-28278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266320>

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
 The test is dropped. It does not feel good enough.. The rest of
 changes is minor
=20
  diff --git a/builtin/gc.c b/builtin/gc.c
  index 07769a9..3886937 100644
  --- a/builtin/gc.c
  +++ b/builtin/gc.c
  @@ -32,8 +32,6 @@ static int aggressive_window =3D 250;
   static int gc_auto_threshold =3D 6700;
   static int gc_auto_pack_limit =3D 50;
   static int detach_auto =3D 1;
  -static struct strbuf log_filename =3D STRBUF_INIT;
  -static int daemonized;
   static const char *prune_expire =3D "2.weeks.ago";
  =20
   static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
  @@ -43,6 +41,8 @@ static struct argv_array prune =3D ARGV_ARRAY_INIT;
   static struct argv_array rerere =3D ARGV_ARRAY_INIT;
  =20
   static char *pidfile;
  +static struct strbuf log_filename =3D STRBUF_INIT;
  +static int daemonized;
  =20
   static void remove_pidfile(void)
   {
  @@ -338,7 +338,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
   			struct strbuf sb =3D STRBUF_INIT;
  =20
   			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0) {
  -				warning(_("Last gc run reported the following, gc skipped"));
  +				warning(_("skipping gc; last gc reported:"));
   				fputs(sb.buf, stderr);
   				strbuf_release(&sb);
   				/* let the next gc --auto run as usual */
  @@ -352,8 +352,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
   			 * failure to daemonize is ok, we'll continue
   			 * in foreground
   			 */
  -			if (!daemonize())
  -				daemonized =3D 1;
  +			daemonized =3D !daemonize();
   		}
   	} else
   		add_repack_all_option();

 builtin/gc.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 5c634af..3886937 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -41,9 +41,20 @@ static struct argv_array prune =3D ARGV_ARRAY_INIT;
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
@@ -324,13 +335,24 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n")=
);
 		}
 		if (detach_auto) {
+			struct strbuf sb =3D STRBUF_INIT;
+
+			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0) {
+				warning(_("skipping gc; last gc reported:"));
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
+			daemonized =3D !daemonize();
 		}
 	} else
 		add_repack_all_option();
@@ -343,6 +365,18 @@ int cmd_gc(int argc, const char **argv, const char=
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
