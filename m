From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] checkout: record full target ref in reflog
Date: Sun,  3 Mar 2013 16:41:17 +0700
Message-ID: <1362303681-6585-2-git-send-email-pclouds@gmail.com>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 03 10:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC5Q8-000115-8U
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 10:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab3CCJkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Mar 2013 04:40:39 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:43317 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab3CCJkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 04:40:37 -0500
Received: by mail-da0-f46.google.com with SMTP id z8so2057900dad.5
        for <git@vger.kernel.org>; Sun, 03 Mar 2013 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=XmKEDglYtAtLVwWS1V4ibkpRy4Jv31/u0NpAPdX2xmc=;
        b=Eo2PtNnP0Og07ZTXS2IkWC0e5Wyu170KBBq+onWBWMbZmH8OG/1wMtn6TtiOKX3sw2
         T+I7D4HDRjAz3EFQetIytUnfQhSrVC8457U+5VzCizvhZl/qirxXbFSktkU5+nZ17QgF
         3+3PM/2Zu3rQ4dBxKiL/fJPyBXKDPxCTuDddTWPp9gO6AHNxozeRpQaiL8Le3Uv98PwH
         JGpR3xdYu1Thvn2CJu1g4UjSKqFrf5wLx1r2IgvH1ZGLWUqMVrHW69drr2AUgfWm866F
         2QF2j7BA5Jl7iK92d3nzvxO7JBBTSHixrlIuy5Bxjcv3QdWkyyw8SX9jaP0OjMonQEM2
         IIYA==
X-Received: by 10.68.239.3 with SMTP id vo3mr9067214pbc.184.1362303636391;
        Sun, 03 Mar 2013 01:40:36 -0800 (PST)
Received: from lanh ([115.74.33.184])
        by mx.google.com with ESMTPS id qp13sm18320684pbb.3.2013.03.03.01.40.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Mar 2013 01:40:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 03 Mar 2013 16:41:40 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217345>

This simplifies parsing later on because the parser does not need to
do dwim on the target (and later dwim may be ambiguous if new refs are
added).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..b11bd31 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -398,6 +398,7 @@ static int reset_tree(struct tree *tree, const stru=
ct checkout_opts *o,
=20
 struct branch_info {
 	const char *name; /* The short name used */
+	const char *full_ref; /* The full name of a real ref */
 	const char *path; /* The full name of a real branch */
 	struct commit *commit; /* The named commit */
 };
@@ -589,7 +590,8 @@ static void update_refs_for_switch(const struct che=
ckout_opts *opts,
 	if (!old_desc && old->commit)
 		old_desc =3D sha1_to_hex(old->commit->object.sha1);
 	strbuf_addf(&msg, "checkout: moving from %s to %s",
-		    old_desc ? old_desc : "(invalid)", new->name);
+		    old_desc ? old_desc : "(invalid)",
+		    new->full_ref ? new->full_ref : new->name);
=20
 	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) =
{
 		/* Nothing to do. */
@@ -907,10 +909,21 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
 	setup_branch_path(new);
=20
 	if (!check_refname_format(new->path, 0) &&
-	    !read_ref(new->path, branch_rev))
+	    !read_ref(new->path, branch_rev)) {
 		hashcpy(rev, branch_rev);
-	else
+		new->full_ref =3D xstrdup(new->path);
+	} else {
+		char *real_ref =3D NULL;
+		unsigned char sha1[20];
 		new->path =3D NULL; /* not an existing branch */
+		if (dwim_ref(new->name, strlen(new->name), sha1,
+			     &real_ref) =3D=3D 1 &&
+		    !hashcmp(sha1, rev)) {
+			new->full_ref =3D real_ref;
+			real_ref =3D NULL;
+		}
+		free(real_ref);
+	}
=20
 	new->commit =3D lookup_commit_reference_gently(rev, 1);
 	if (!new->commit) {
--=20
1.8.1.2.536.gf441e6d
