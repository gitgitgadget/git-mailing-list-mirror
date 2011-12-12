From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 3/3] grep: disable threading in non-worktree case
Date: Mon, 12 Dec 2011 22:16:08 +0100
Message-ID: <faa76319c7863852eb6848614c193b56af5789f9.1323723759.git.trast@student.ethz.ch>
References: <cover.1323723759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDES-0004dm-VF
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab1LLVQS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 16:16:18 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:7152 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002Ab1LLVQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:16:14 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 22:16:09 +0100
Received: from thomas.inf.ethz.ch (129.132.208.62) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 22:16:11 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323723759.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.208.62]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186949>

Measurements by various people have shown that grepping in parallel is
not beneficial when the object store is involved.  For example, with a
simple regex:

  Threads     | --cached case            | worktree case
  ----------------------------------------------------------------
  8 (default) | 2.88u 0.21s 0:02.94real  | 0.19u 0.32s 0:00.16real
  4           | 2.89u 0.29s 0:02.99real  | 0.16u 0.34s 0:00.17real
  2           | 2.83u 0.36s 0:02.87real  | 0.18u 0.32s 0:00.26real
  NO_PTHREADS | 2.16u 0.08s 0:02.25real  | 0.12u 0.17s 0:00.31real

This happens because all the threads contend on read_sha1_mutex almost
all of the time.  A more complex regex allows the threads to do more
work in parallel, but as Jeff King found out, the "super boost" (much
higher clock when only one core is active) feature of recent CPUs
still causes the unthreaded case to win by a large margin.

So until the pack machinery allows unthreaded access, we disable
grep's threading in all but the worktree case.

Helped-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/grep.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index bc23c3c..7affbda 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1003,24 +1003,6 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |=3D REG_ICASE;
=20
-#ifndef NO_PTHREADS
-	if (online_cpus() =3D=3D 1)
-		use_threads =3D 0;
-#else
-	use_threads =3D 0;
-#endif
-
-	opt.use_threads =3D use_threads;
-
-#ifndef NO_PTHREADS
-	if (use_threads) {
-		if (opt.pre_context || opt.post_context || opt.file_break ||
-		    opt.funcbody)
-			skip_first_line =3D 1;
-		start_threads(&opt);
-	}
-#endif
-
 	compile_grep_patterns(&opt);
=20
 	/* Check revs and then paths */
@@ -1042,6 +1024,24 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
 		break;
 	}
=20
+#ifndef NO_PTHREADS
+	if (list.nr || cached || online_cpus() =3D=3D 1)
+		use_threads =3D 0;
+#else
+	use_threads =3D 0;
+#endif
+
+	opt.use_threads =3D use_threads;
+
+#ifndef NO_PTHREADS
+	if (use_threads) {
+		if (opt.pre_context || opt.post_context || opt.file_break ||
+		    opt.funcbody)
+			skip_first_line =3D 1;
+		start_threads(&opt);
+	}
+#endif
+
 	/* The rest are paths */
 	if (!seen_dashdash) {
 		int j;
--=20
1.7.8.431.g2abf2
