From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 07/10] clone: --branch=<branch> always means refs/heads/<branch>
Date: Mon, 16 Jan 2012 16:46:13 +0700
Message-ID: <1326707176-8045-8-git-send-email-pclouds@gmail.com>
References: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:47:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmjA4-00032J-Kc
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 10:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab2APJrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 04:47:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55465 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab2APJrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 04:47:24 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so2315494iag.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 01:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/qB19oHvKyGC1eMx2sFB0EIkFHKqms4njyPf0zobjzA=;
        b=QjKKSEwTSBkVnNjuBuMQwPXRoiIN7tRkllYQg3fn4xaci5tTyT2qEjXNxZSuH7jn02
         B1CbP6Q8Vuvet0qKnMJ2li35ir4GmLSOjTGLFNrNqjssVhYdeslbcrFhNyrNjePxYH30
         Ra7fptVJC5gZCdMN7v35TbiSNQd1J0IQvsXY0=
Received: by 10.50.194.202 with SMTP id hy10mr12297254igc.23.1326707243922;
        Mon, 16 Jan 2012 01:47:23 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id uz5sm7066763igc.0.2012.01.16.01.47.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 01:47:23 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:47:14 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188622>

It does not make sense to look outside refs/heads for HEAD's target
(src_ref_prefix can be set to "refs/" if --mirror is used) because ref
code only allows symref in form refs/heads/...

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a1fbb3b..253a794 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -48,7 +48,6 @@ static int option_verbosity;
 static int option_progress;
 static struct string_list option_config;
 static struct string_list option_reference;
-static const char *src_ref_prefix =3D "refs/heads/";
=20
 static int opt_parse_reference(const struct option *opt, const char *a=
rg, int unset)
 {
@@ -413,6 +412,17 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
=20
+static struct ref *find_remote_branch(const struct ref *refs, const ch=
ar *branch)
+{
+	struct ref *ref;
+	struct strbuf head =3D STRBUF_INIT;
+	strbuf_addstr(&head, "refs/heads/");
+	strbuf_addstr(&head, branch);
+	ref =3D find_ref_by_name(refs, head.buf);
+	strbuf_release(&head);
+	return ref;
+}
+
 static struct ref *wanted_peer_refs(const struct ref *refs,
 		struct refspec *refspec)
 {
@@ -425,13 +435,8 @@ static struct ref *wanted_peer_refs(const struct r=
ef *refs,
=20
 		if (!option_branch)
 			remote_head =3D guess_remote_head(head, refs, 0);
-		else {
-			struct strbuf sb =3D STRBUF_INIT;
-			strbuf_addstr(&sb, src_ref_prefix);
-			strbuf_addstr(&sb, option_branch);
-			remote_head =3D find_ref_by_name(refs, sb.buf);
-			strbuf_release(&sb);
-		}
+		else
+			remote_head =3D find_remote_branch(refs, option_branch);
=20
 		if (!remote_head && option_branch)
 			warning(_("Could not find remote branch %s to clone."),
@@ -502,7 +507,7 @@ static void update_remote_refs(const struct ref *re=
fs,
 static void update_head(const struct ref *our, const struct ref *remot=
e,
 			const char *msg)
 {
-	if (our) {
+	if (our && !prefixcmp(our->name, "refs/heads/")) {
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
@@ -609,6 +614,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
+	const char *src_ref_prefix =3D "refs/heads/";
 	struct remote *remote;
 	int err =3D 0;
=20
@@ -807,12 +813,8 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			guess_remote_head(remote_head, mapped_refs, 0);
=20
 		if (option_branch) {
-			struct strbuf head =3D STRBUF_INIT;
-			strbuf_addstr(&head, src_ref_prefix);
-			strbuf_addstr(&head, option_branch);
 			our_head_points_at =3D
-				find_ref_by_name(mapped_refs, head.buf);
-			strbuf_release(&head);
+				find_remote_branch(mapped_refs, option_branch);
=20
 			if (!our_head_points_at) {
 				warning(_("Remote branch %s not found in "
--=20
1.7.3.1.256.g2539c.dirty
