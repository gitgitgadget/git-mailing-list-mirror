From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gc --auto: do not lock refs in the background
Date: Sun, 25 May 2014 07:38:29 +0700
Message-ID: <1400978309-25235-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8BfziZ7ciyKL0+X3rT9EfH_0E8nKNu9mTb_WSeTYWix_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kilobyte@angband.pl, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 02:31:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoMLN-00025S-4t
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 02:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbaEYAbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 May 2014 20:31:10 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:53960 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaEYAbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 20:31:08 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so6551698wes.0
        for <git@vger.kernel.org>; Sat, 24 May 2014 17:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3T/GY42L7C5VHJcRtKrV8HAOeppHROtjyr/G+7HqLbc=;
        b=jNlKu/w5Rl0nZoxuDGTnvdqJZJdUNGPyBva3gLG1XW/g7CAEBbG0MUg466ghfFM6ST
         LPeIXkFvl+tDLTC98X42g66igFxu+dTwBFyX18sQXXaARso4KeYQMrP94OI7vy+UrpoO
         CuueWnUaukFQdrFjCngWO8y33rAp4GCTMxkE00QPQ/bt0/kZCdcxnOCKM/OmtyGp5t34
         9U9wrjg0/dFuzuj2YyD9Zr4sIvBaJEShBdek+5hQCdbpLX3D3B9IBWFAfdgrrzQ8fYF6
         RfN/DvlfND8WyWvBe67W3lkTmosSQs2bkDHu0VA9485A4EE+g6KzHI6eEb3KOQZXx/I2
         MS8A==
X-Received: by 10.180.91.114 with SMTP id cd18mr14823009wib.28.1400977866906;
        Sat, 24 May 2014 17:31:06 -0700 (PDT)
Received: from lanh ([115.73.238.36])
        by mx.google.com with ESMTPSA id ej7sm13929900wib.9.2014.05.24.17.31.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 May 2014 17:31:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 May 2014 07:38:43 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <CACsJy8BfziZ7ciyKL0+X3rT9EfH_0E8nKNu9mTb_WSeTYWix_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250064>

9f673f9 (gc: config option for running --auto in background -
2014-02-08) puts "gc --auto" in background to reduce user's wait
time. Part of the garbage collecting is pack-refs and pruning
reflogs. These require locking some refs and may abort other processes
trying to lock the same ref. If gc --auto is fired in the middle of a
script, gc's holding locks in the background could fail the script,
which could never happen before 9f673f9.

Keep running pack-refs and "reflog --prune" in foreground to stop
parallel ref updates. The remaining background operations (repack,
prune and rerere) should impact running git processes.

Reported-by: Adam Borowski <kilobyte@angband.pl>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 85f5c2b..8d219d8 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -26,6 +26,7 @@ static const char * const builtin_gc_usage[] =3D {
 };
=20
 static int pack_refs =3D 1;
+static int prune_reflogs =3D 1;
 static int aggressive_depth =3D 250;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
@@ -258,6 +259,19 @@ static const char *lock_repo_for_gc(int force, pid=
_t* ret_pid)
 	return NULL;
 }
=20
+static int gc_before_repack(void)
+{
+	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
+		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
+
+	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
+		return error(FAILED_RUN, reflog.argv[0]);
+
+	pack_refs =3D 0;
+	prune_reflogs =3D 0;
+	return 0;
+}
+
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int aggressive =3D 0;
@@ -320,12 +334,15 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 				fprintf(stderr, _("Auto packing the repository for optimum perform=
ance.\n"));
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n")=
);
 		}
-		if (detach_auto)
+		if (detach_auto) {
+			if (gc_before_repack())
+				return -1;
 			/*
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
 			daemonize();
+		}
 	} else
 		add_repack_all_option();
=20
@@ -337,11 +354,8 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 		    name, (uintmax_t)pid);
 	}
=20
-	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
-
-	if (run_command_v_opt(reflog.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, reflog.argv[0]);
+	if (gc_before_repack())
+		return -1;
=20
 	if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, repack.argv[0]);
--=20
1.9.1.346.ga2b5940
