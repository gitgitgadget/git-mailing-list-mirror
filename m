From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] log: support --full-diff=<pathspec>
Date: Thu,  3 Nov 2011 17:01:14 +0700
Message-ID: <1320314474-19536-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 11:01:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLu6z-0003RZ-TH
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 11:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab1KCKBZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 06:01:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45205 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab1KCKBY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 06:01:24 -0400
Received: by iage36 with SMTP id e36so1148494iag.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NHzeFDV9uLQfVgTl75rMxHmiG/5ib7mMA4iLshs5TJY=;
        b=mvGEoTiHIDuQlKljV8Xry5uM2hwI/Jcg2mNXXBvE/ElRh9FGZg1llEgAp/vIIBLl+n
         X90R1MA4wRXgfWXDCchmQbHHjm76H8ptWHq7eW59LuoPhTC9WdrZuhnhT+ZFwwGWODgQ
         MmYoWFL8e7sjU+p07Cq1KaCgFw093Km/NlvFk=
Received: by 10.42.163.200 with SMTP id d8mr5174135icy.41.1320314483918;
        Thu, 03 Nov 2011 03:01:23 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id el2sm7309092ibb.10.2011.11.03.03.01.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Nov 2011 03:01:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 Nov 2011 17:01:16 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184711>

I wanted to check if any patches that update builtin/fsck.c also
update 't' directory and git seemed not support this case
(true?). With this I can do

  git log --patch --full-diff=3D"'builtin/fsck.c' 't'" -- builtin/fsck.=
c

I guess this may be something people find useful.

This patch is a bit inconvenient though because <pathspec> is parsed
with sq_dequote_to_argv() and all arguments must be wrapped by ''.
Also "full-diff" name does not make much sense when it comes with
pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 revision.c |   19 +++++++++++++++++++
 revision.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 8764dde..f508953 100644
--- a/revision.c
+++ b/revision.c
@@ -13,6 +13,7 @@
 #include "decorate.h"
 #include "log-tree.h"
 #include "string-list.h"
+#include "quote.h"
=20
 volatile show_early_output_fn_t show_early_output;
=20
@@ -1531,6 +1532,10 @@ static int handle_revision_opt(struct rev_info *=
revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--full-diff")) {
 		revs->diff =3D 1;
 		revs->full_diff =3D 1;
+	} else if (!prefixcmp(arg, "--full-diff=3D")) {
+		revs->diff =3D 1;
+		revs->full_diff =3D 1;
+		revs->full_diff_opt =3D arg + strlen("--full-diff=3D");
 	} else if (!strcmp(arg, "--full-history")) {
 		revs->simplify_history =3D 0;
 	} else if (!strcmp(arg, "--relative-date")) {
@@ -1819,6 +1824,20 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, struct s
 			revs->prune =3D 1;
 		if (!revs->full_diff)
 			diff_tree_setup_paths(revs->prune_data.raw, &revs->diffopt);
+		else if (revs->full_diff_opt) {
+			const char **argv =3D NULL;
+			int alloc =3D 0, nr =3D 0;
+			char *arg;
+
+			arg =3D xstrdup(revs->full_diff_opt);
+			sq_dequote_to_argv(arg, &argv, &nr, &alloc);
+
+			ALLOC_GROW(argv, nr + 1, alloc);
+			argv[nr] =3D NULL;
+			argv =3D get_pathspec(revs->prefix, argv);
+
+			diff_tree_setup_paths(argv, &revs->diffopt);
+		}
 	}
 	if (revs->combine_merges)
 		revs->ignore_merges =3D 0;
diff --git a/revision.h b/revision.h
index 6aa53d1..baa709c 100644
--- a/revision.h
+++ b/revision.h
@@ -137,6 +137,7 @@ struct rev_info {
 	const char	*subject_prefix;
 	int		no_inline;
 	int		show_log_size;
+	const char      *full_diff_opt;
=20
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
--=20
1.7.3.1.256.g2539c.dirty
