From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Fix incorrect ref namespace check
Date: Thu,  5 Jan 2012 19:35:24 +0700
Message-ID: <1325766924-14943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 13:36:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RimY5-00050P-BA
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 13:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668Ab2AEMf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 07:35:56 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50556 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541Ab2AEMfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 07:35:55 -0500
Received: by iaeh11 with SMTP id h11so875615iae.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 04:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=S0URPv9w9Nb7RFkYulD0sdlnwKSGw2e5qZ3XKqle8gA=;
        b=h5tvLC7kdVJekTYpmIJqexNUT4p0uSeycrisyf9QjH5YrqXEAuaYUvERaytJtwp6nT
         SrtfYag/gWq2wWNIeo5DX4jj9yLbHgvcN3HYLL4WtxovoHjkOKZEKStv22jPShwUnekz
         /wqMeWZHTF2akcSdZJ223ZPAp0ziL4PTeILXQ=
Received: by 10.42.131.7 with SMTP id x7mr1925466ics.11.1325766954867;
        Thu, 05 Jan 2012 04:35:54 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.56.82])
        by mx.google.com with ESMTPS id lu10sm101597582igc.0.2012.01.05.04.35.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Jan 2012 04:35:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 05 Jan 2012 19:35:25 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187973>

The reason why the trailing slash is needed is obvious. refs/stash is
not a namespace, but a single ref. Do full string compare on it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c  |    2 +-
 builtin/remote.c |    2 +-
 log-tree.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
index 319bd31..9a88fcc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -119,7 +119,7 @@ static int add_ref_decoration(const char *refname, =
const unsigned char *sha1, in
 		type =3D DECORATION_REF_REMOTE;
 	else if (!prefixcmp(refname, "refs/tags/"))
 		type =3D DECORATION_REF_TAG;
-	else if (!prefixcmp(refname, "refs/stash"))
+	else if (!strcmp(refname, "refs/stash"))
 		type =3D DECORATION_REF_STASH;
 	else if (!prefixcmp(refname, "HEAD"))
 		type =3D DECORATION_REF_HEAD;
--=20
1.7.8.36.g69ee2
