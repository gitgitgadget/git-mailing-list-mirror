From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Fix incorrect ref namespace check
Date: Thu,  5 Jan 2012 19:39:40 +0700
Message-ID: <1325767180-15083-1-git-send-email-pclouds@gmail.com>
References: <1325766924-14943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 13:40:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RimcC-0006iu-CN
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 13:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270Ab2AEMkK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 07:40:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56695 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab2AEMkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 07:40:09 -0500
Received: by iaeh11 with SMTP id h11so880530iae.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 04:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uzyrMUw1KeKWFCajy8CJbhoixt9ZONlKzCbg1k3LH/I=;
        b=CDBZqamzi7UDdxz0OoumZEqd2CsfzDbi0K9ePKF9Zp+LItHhz6GxPJFY6b6B0Png0A
         zqD3VGuwDzyu05yi2nlYpHGSylW4IsWjnk7ZQpjsKoV9/3iTNeS3YHa7C2l0fzI3l5Pn
         vaiAXpVZBIrvwWGUeDjEJALeHvPozhlPzkKOA=
Received: by 10.50.189.137 with SMTP id gi9mr2438978igc.1.1325767209367;
        Thu, 05 Jan 2012 04:40:09 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.56.82])
        by mx.google.com with ESMTPS id z22sm201167994ibg.5.2012.01.05.04.40.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Jan 2012 04:40:08 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 05 Jan 2012 19:39:41 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1325766924-14943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187975>

The reason why the trailing slash is needed is obvious. refs/stash and
HEAD are not namespace, but complete refs. Do full string compare on th=
em.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I missed prefixcmp(..., "HEAD") right below prefixcmp(..., "refs/stash=
")

 builtin/fetch.c  |    2 +-
 builtin/remote.c |    2 +-
 log-tree.c       |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 33ad3aa..daa68d2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -573,7 +573,7 @@ static void find_non_local_tags(struct transport *t=
ransport,
=20
 	for_each_ref(add_existing, &existing_refs);
 	for (ref =3D transport_get_remote_refs(transport); ref; ref =3D ref->=
next) {
-		if (prefixcmp(ref->name, "refs/tags"))
+		if (prefixcmp(ref->name, "refs/tags/"))
 			continue;
=20
 		/*
diff --git a/builtin/remote.c b/builtin/remote.c
index 583eec9..f54a89a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -534,7 +534,7 @@ static int add_branch_for_removal(const char *refna=
me,
 	}
=20
 	/* don't delete non-remote-tracking refs */
-	if (prefixcmp(refname, "refs/remotes")) {
+	if (prefixcmp(refname, "refs/remotes/")) {
 		/* advise user how to delete local branches */
 		if (!prefixcmp(refname, "refs/heads/"))
 			string_list_append(branches->skipped,
diff --git a/log-tree.c b/log-tree.c
index 319bd31..535b905 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -119,9 +119,9 @@ static int add_ref_decoration(const char *refname, =
const unsigned char *sha1, in
 		type =3D DECORATION_REF_REMOTE;
 	else if (!prefixcmp(refname, "refs/tags/"))
 		type =3D DECORATION_REF_TAG;
-	else if (!prefixcmp(refname, "refs/stash"))
+	else if (!strcmp(refname, "refs/stash"))
 		type =3D DECORATION_REF_STASH;
-	else if (!prefixcmp(refname, "HEAD"))
+	else if (!strcmp(refname, "HEAD"))
 		type =3D DECORATION_REF_HEAD;
=20
 	if (!cb_data || *(int *)cb_data =3D=3D DECORATE_SHORT_REFS)
--=20
1.7.8.36.g69ee2
