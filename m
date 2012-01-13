From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 06/10] clone: delay cloning until after remote HEAD checking
Date: Fri, 13 Jan 2012 14:21:58 +0700
Message-ID: <1326439322-15648-7-git-send-email-pclouds@gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:23:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbTl-00084P-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab2AMHXK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 02:23:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab2AMHXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 02:23:08 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so3939442iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ud0+EMDaG78M8u2VyyhE4jSITL42IYDdIVHWLSKqdD8=;
        b=WiiEzdvI2vK3aXMRFxv/Umy6BG0yOSQbhm1qBt6eHQiAon3QDQw7etPH7n1uSp4KTy
         Una2GmhDZM4L1MqTGUS1BSowys/+/aBoMu+jy7I3lWksCTFGGb7qxkjAlOS4q7YhwZAH
         gSEAntX6fwxkvEaOc/nXwMcbXBHDcKCsjDHgk=
Received: by 10.50.183.199 with SMTP id eo7mr1516041igc.5.1326439387956;
        Thu, 12 Jan 2012 23:23:07 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id lu10sm13106086igc.0.2012.01.12.23.23.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:23:07 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Jan 2012 14:22:58 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188503>

This gives us an opportunity to abort the command during remote HEAD
check without wasting much bandwidth.

Cloning with remote-helper remains before the check because the remote
helper updates mapped_refs, which is necessary for remote ref checks.
foreign_vcs field is used to indicate the transport is handled by
remote helper.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   54 +++++++++++++++++++++++++++--------------------=
-------
 transport.c     |    5 ++++-
 2 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d1d6dca..a9d06a4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -361,13 +361,8 @@ static void copy_or_link_directory(struct strbuf *=
src, struct strbuf *dest,
 	closedir(dir);
 }
=20
-static const struct ref *clone_local(const char *src_repo,
-				     const char *dest_repo)
+static void clone_local(const char *src_repo, const char *dest_repo)
 {
-	const struct ref *ret;
-	struct remote *remote;
-	struct transport *transport;
-
 	if (option_shared) {
 		struct strbuf alt =3D STRBUF_INIT;
 		strbuf_addf(&alt, "%s/objects", src_repo);
@@ -383,13 +378,8 @@ static const struct ref *clone_local(const char *s=
rc_repo,
 		strbuf_release(&dest);
 	}
=20
-	remote =3D remote_get(src_repo);
-	transport =3D transport_get(remote, src_repo);
-	ret =3D transport_get_remote_refs(transport);
-	transport_disconnect(transport);
 	if (0 <=3D option_verbosity)
 		printf(_("done.\n"));
-	return ret;
 }
=20
 static const char *junk_work_tree;
@@ -581,6 +571,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
 	char *src_ref_prefix =3D "refs/heads/";
+	struct remote *remote;
 	int err =3D 0;
=20
 	struct refspec *refspec;
@@ -732,13 +723,10 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
=20
 	strbuf_reset(&value);
=20
-	if (is_local) {
-		refs =3D clone_local(path, git_dir);
-		mapped_refs =3D wanted_peer_refs(refs, refspec);
-	} else {
-		struct remote *remote =3D remote_get(option_origin);
-		transport =3D transport_get(remote, remote->url[0]);
+	remote =3D remote_get(option_origin);
+	transport =3D transport_get(remote, remote->url[0]);
=20
+	if (!is_local) {
 		if (!transport->get_refs_list || !transport->fetch)
 			die(_("Don't know how to clone %s"), transport->url);
=20
@@ -753,14 +741,23 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		if (option_upload_pack)
 			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 					     option_upload_pack);
-
-		refs =3D transport_get_remote_refs(transport);
-		if (refs) {
-			mapped_refs =3D wanted_peer_refs(refs, refspec);
-			transport_fetch_refs(transport, mapped_refs);
-		}
 	}
=20
+	refs =3D transport_get_remote_refs(transport);
+	mapped_refs =3D refs ? wanted_peer_refs(refs, refspec) : NULL;
+
+	/*
+	 * mapped_refs may be updated if transport-helper is used so
+	 * we need fetch it early because remote_head code below
+	 * relies on it.
+	 *
+	 * for normal clones, transport_get_remote_refs() should
+	 * return reliable ref set, we can delay cloning until after
+	 * remote HEAD check.
+	 */
+	if (!is_local && remote->foreign_vcs && refs)
+		transport_fetch_refs(transport, mapped_refs);
+
 	if (refs) {
 		remote_head =3D find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =3D
@@ -795,15 +792,18 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 					      "refs/heads/master");
 	}
=20
+	if (is_local)
+		clone_local(path, git_dir);
+	else if (refs && !remote->foreign_vcs)
+		transport_fetch_refs(transport, mapped_refs);
+
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf);
=20
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
=20
-	if (transport) {
-		transport_unlock_pack(transport);
-		transport_disconnect(transport);
-	}
+	transport_unlock_pack(transport);
+	transport_disconnect(transport);
=20
 	err =3D checkout();
=20
diff --git a/transport.c b/transport.c
index a99b7c9..4366639 100644
--- a/transport.c
+++ b/transport.c
@@ -895,8 +895,10 @@ struct transport *transport_get(struct remote *rem=
ote, const char *url)
=20
 		while (is_urlschemechar(p =3D=3D url, *p))
 			p++;
-		if (!prefixcmp(p, "::"))
+		if (!prefixcmp(p, "::")) {
 			helper =3D xstrndup(url, p - url);
+			remote->foreign_vcs =3D helper;
+		}
 	}
=20
 	if (helper) {
@@ -938,6 +940,7 @@ struct transport *transport_get(struct remote *remo=
te, const char *url)
 		char *handler =3D xmalloc(len + 1);
 		handler[len] =3D 0;
 		strncpy(handler, url, len);
+		remote->foreign_vcs =3D handler;
 		transport_helper_init(ret, handler);
 	}
=20
--=20
1.7.3.1.256.g2539c.dirty
