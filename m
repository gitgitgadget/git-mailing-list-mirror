From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clone: fix up delay cloning conditions
Date: Tue, 24 Jan 2012 18:10:38 +0700
Message-ID: <1327403438-11514-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 12:11:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpeHd-00084L-WE
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 12:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab2AXLLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 06:11:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52230 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab2AXLLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 06:11:16 -0500
Received: by iacb35 with SMTP id b35so5226216iac.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 03:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0tuL+8Ulwzq23VnFz2+3oWZF8XU52WeoAfxZudkICXI=;
        b=xIWbuIQlHG3x3pgak1mgnOykJnS+H5WqlAHAIms/4AR3C6opnsALUhtNPfQvhqFPAu
         iBnIkzy/z36xrXTZ1SmeFpgcebK0caVdHjXR2h1RBQ+6DXba+jFnh1RD58r0svoLNwTt
         PF3iEQMgIUJxusxMyPaF2NkHffIJDAyq+FUzU=
Received: by 10.50.47.136 with SMTP id d8mr14223041ign.21.1327403475843;
        Tue, 24 Jan 2012 03:11:15 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.57.120])
        by mx.google.com with ESMTPS id l35sm57734567ibj.0.2012.01.24.03.11.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 03:11:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 24 Jan 2012 18:10:39 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189045>

6f48d39 (clone: delay cloning until after remote HEAD checking -
2012-01-16) allows us to perform some checks on remote refs before the
actual cloning happens. But not all transport types support
this. Remote helper with "import" capability will not return complete
ref information until fetch is performed and therefore the clone cannot
be delayed.

foreign_vcs field in struct remote was used to detect this kind of tran=
sport
and save the result. This is a mistake because foreign_vcs is designed
to override url-based transport detection. As a result, if the same
"struct transport *" object is used on many different urls and one of
them attached remote transport, the following urls will be mistakenly
attached to the same transport. This fault is worked around by dad0b3d
(push: do not let configured foreign-vcs permanently clobbered -
2012-01-23)

To fix this, detect incomplete refs from transport_get_remote_refs()
by SHA-1. Incomplete ones must have null SHA-1 (*). Then revert
changes related to foreign_cvs field in 6f48d39 and dad0b3d.

A good thing from this change is that cloning smart http transport can
also be delayed. Earlier it falls into the same category "remote
transport, no delay".

(*) Theoretically if one of the remote refs happens to have null SHA-1,
it will trigger false alarm and the clone will not be delayed. But
that chance may be too small for us to pay attention to.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   20 ++++++++++++++------
 builtin/push.c  |    2 --
 transport.c     |    5 +----
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 72eebca..379cafa 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -631,12 +631,13 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 	const struct ref *remote_head_points_at;
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
+	const struct ref *ref;
 	struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
 	const char *src_ref_prefix =3D "refs/heads/";
 	struct remote *remote;
-	int err =3D 0;
+	int err =3D 0, complete_refs_before_fetch =3D 1;
=20
 	struct refspec *refspec;
 	const char *fetch_pattern;
@@ -816,15 +817,22 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 	mapped_refs =3D refs ? wanted_peer_refs(refs, refspec) : NULL;
=20
 	/*
-	 * mapped_refs may be updated if transport-helper is used so
-	 * we need fetch it early because remote_head code below
-	 * relies on it.
+	 * transport_get_remote_refs() may return refs with null sha-1
+	 * in mapped_refs (see struct transport->get_refs_list
+	 * comment). In that case we need fetch it early because
+	 * remote_head code below relies on it.
 	 *
 	 * for normal clones, transport_get_remote_refs() should
 	 * return reliable ref set, we can delay cloning until after
 	 * remote HEAD check.
 	 */
-	if (!is_local && remote->foreign_vcs && refs)
+	for (ref =3D refs; ref; ref =3D ref->next)
+		if (is_null_sha1(ref->old_sha1)) {
+			complete_refs_before_fetch =3D 0;
+			break;
+		}
+
+	if (!is_local && !complete_refs_before_fetch && refs)
 		transport_fetch_refs(transport, mapped_refs);
=20
 	if (refs) {
@@ -856,7 +864,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (is_local)
 		clone_local(path, git_dir);
-	else if (refs && !remote->foreign_vcs)
+	else if (refs && complete_refs_before_fetch)
 		transport_fetch_refs(transport, mapped_refs);
=20
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
diff --git a/builtin/push.c b/builtin/push.c
index 5fb98a0..35cce53 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -204,13 +204,11 @@ static int do_push(const char *repo, int flags)
 		url_nr =3D remote->url_nr;
 	}
 	if (url_nr) {
-		const char *configured_foreign_vcs =3D remote->foreign_vcs;
 		for (i =3D 0; i < url_nr; i++) {
 			struct transport *transport =3D
 				transport_get(remote, url[i]);
 			if (push_with_options(transport, flags))
 				errs++;
-			remote->foreign_vcs =3D configured_foreign_vcs;
 		}
 	} else {
 		struct transport *transport =3D
diff --git a/transport.c b/transport.c
index 4366639..a99b7c9 100644
--- a/transport.c
+++ b/transport.c
@@ -895,10 +895,8 @@ struct transport *transport_get(struct remote *rem=
ote, const char *url)
=20
 		while (is_urlschemechar(p =3D=3D url, *p))
 			p++;
-		if (!prefixcmp(p, "::")) {
+		if (!prefixcmp(p, "::"))
 			helper =3D xstrndup(url, p - url);
-			remote->foreign_vcs =3D helper;
-		}
 	}
=20
 	if (helper) {
@@ -940,7 +938,6 @@ struct transport *transport_get(struct remote *remo=
te, const char *url)
 		char *handler =3D xmalloc(len + 1);
 		handler[len] =3D 0;
 		strncpy(handler, url, len);
-		remote->foreign_vcs =3D handler;
 		transport_helper_init(ret, handler);
 	}
=20
--=20
1.7.8.36.g69ee2
