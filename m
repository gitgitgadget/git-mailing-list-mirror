From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] merge: support setting merge.[diff]stat to dynstat
Date: Mon, 16 Jan 2012 11:48:01 +0700
Message-ID: <1326689281-23788-6-git-send-email-pclouds@gmail.com>
References: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 05:49:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmeVM-0002eA-TI
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 05:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab2APEs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 23:48:59 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab2APEs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 23:48:58 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so1947623iag.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 20:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fwgSqoxD/4IEUi1QSU5gPMPCI0S+yusCJ6A5Az9lHs4=;
        b=uK5yN3if09EampQQV19bMw7WvJEHw7Ou+ktgKe5z88qSkannogjxHt4ljs4rRzRChg
         E2u71I+5JWnkADs3mnF3BlGkBeiU3sFLO5C+hgF1gPFJPHtr5x+WpLHk4kXEhAHvGQ+t
         UczUVHRpgUE3hJ6BLKIUrX3TiymKLX8QtXXbg=
Received: by 10.50.40.133 with SMTP id x5mr8420131igk.29.1326689338507;
        Sun, 15 Jan 2012 20:48:58 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id x18sm61412764ibi.2.2012.01.15.20.48.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 20:48:57 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 11:48:48 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188611>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3a45172..b8280ce 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -46,7 +46,13 @@ static const char * const builtin_merge_usage[] =3D =
{
 	NULL
 };
=20
-static int show_diffstat =3D 1, shortlog_len =3D -1, squash;
+enum show_diffstat {
+	NO_STAT,
+	DIFF_STAT,
+	DYNAMIC_STAT
+};
+
+static int show_diffstat =3D NO_STAT, shortlog_len =3D -1, squash;
 static int option_commit =3D 1, allow_fast_forward =3D 1;
 static int fast_forward_only, option_edit;
 static int allow_trivial =3D 1, have_message;
@@ -399,8 +405,15 @@ static void finish(struct commit *head_commit,
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
 		diff_setup(&opts);
-		opts.output_format |=3D
-			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+		switch (show_diffstat) {
+		case DIFF_STAT:
+			opts.output_format |=3D
+				DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+			break;
+		case DYNAMIC_STAT:
+			opts.output_format |=3D DIFF_FORMAT_DYNSTAT;
+			break;
+		}
 		opts.detect_rename =3D DIFF_DETECT_RENAME;
 		if (diff_setup_done(&opts) < 0)
 			die(_("diff_setup_done failed"));
@@ -554,8 +567,15 @@ static int git_merge_config(const char *k, const c=
har *v, void *cb)
 		return 0;
 	}
=20
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
-		show_diffstat =3D git_config_bool(k, v);
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
+		int val =3D git_config_maybe_bool(k, v);
+		if (val !=3D -1)
+			show_diffstat =3D val ? DIFF_STAT : NO_STAT;
+		else if (!strcasecmp(v, "dynstat"))
+			show_diffstat =3D DYNAMIC_STAT;
+		else
+			die(_("unrecognized value \"%s\" for %s"), v, k);
+	}
 	else if (!strcmp(k, "pull.twohead"))
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
--=20
1.7.3.1.256.g2539c.dirty
