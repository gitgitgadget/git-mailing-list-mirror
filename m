From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] Limit refs to fetch to minimum in shallow clones
Date: Thu,  5 Jan 2012 13:05:16 +0700
Message-ID: <1325743516-14940-1-git-send-email-pclouds@gmail.com>
References: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 07:05:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RigSB-0000xf-8X
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 07:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab2AEGF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 01:05:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62258 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab2AEGF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 01:05:26 -0500
Received: by iaeh11 with SMTP id h11so396850iae.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 22:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fjDovMgBldKsMTFWqqVCl66AouZf6fpxj5/8YFJF1Vo=;
        b=K3SJVDtbpUMHAKvpmFcOVTwQwz5v7OBGF3SFxBTOIvcOilgtd1YalAq9mnPJ/sFq8i
         vPoUcoRsRXDiNql41nPeFHOrVxdV2ixlSKyQcv28J+z1MO/+TXT1ZKTPLiyVTiRP3e8H
         9e9QCuHtfz6gWwzGo9wjb7FL8Oa2LkkTHUneE=
Received: by 10.50.180.167 with SMTP id dp7mr1224637igc.26.1325743525447;
        Wed, 04 Jan 2012 22:05:25 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id g7sm19248792igv.7.2012.01.04.22.05.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Jan 2012 22:05:24 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 05 Jan 2012 13:05:17 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187966>

The main purpose of shallow clones is to reduce download by only
fetching objects up to a certain depth from the given refs. The number
of objects depends on how many refs to follow. So:

 - Only fetch HEAD or the ref specified by --branch
 - Only fetch tags that point to downloaded objects

More tags/branches can be fetched later using git-fetch as usual.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Only lightly tested, but seems to work. I'll check later if --branch
 works with a tag like Junio's example --single=3Dv3.2

 Documentation/git-clone.txt |   14 ++++++----
 builtin/clone.c             |   54 +++++++++++++++++++++++++++++++++++=
++++----
 2 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4b8b26b..d69f440 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -172,12 +172,14 @@ objects from the source repository into a pack in=
 the cloned repository.
=20
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.  A shallow repository has a
-	number of limitations (you cannot clone or fetch from
-	it, nor push from nor into it), but is adequate if you
-	are only interested in the recent history of a large project
-	with a long history, and would want to send in fixes
-	as patches.
+	specified number of revisions. Only one branch (either HEAD
+	or specified by --branch) is fetched. Tags that point
+	outside truncated history are not fetched.
++
+A shallow repository has a number of limitations (you cannot clone or
+fetch from it, nor push from nor into it), but is adequate if you are
+only interested in the recent history of a large project with a long
+history, and would want to send in fixes as patches.
=20
 --recursive::
 --recurse-submodules::
diff --git a/builtin/clone.c b/builtin/clone.c
index efe8b6c..8de9248 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -48,6 +48,7 @@ static int option_verbosity;
 static int option_progress;
 static struct string_list option_config;
 static struct string_list option_reference;
+static char *src_ref_prefix =3D "refs/heads/";
=20
 static int opt_parse_reference(const struct option *opt, const char *a=
rg, int unset)
 {
@@ -427,9 +428,27 @@ static struct ref *wanted_peer_refs(const struct r=
ef *refs,
 	struct ref *local_refs =3D head;
 	struct ref **tail =3D head ? &head->next : &local_refs;
=20
-	get_fetch_map(refs, refspec, &tail, 0);
-	if (!option_mirror)
-		get_fetch_map(refs, tag_refspec, &tail, 0);
+	if (option_depth) {
+		struct ref *remote_head =3D NULL;
+
+		if (!option_branch)
+			remote_head =3D guess_remote_head(head, refs, 0);
+		else {
+			struct strbuf sb =3D STRBUF_INIT;
+			strbuf_addstr(&sb, src_ref_prefix);
+			strbuf_addstr(&sb, option_branch);
+			remote_head =3D find_ref_by_name(refs, sb.buf);
+			strbuf_release(&sb);
+		}
+
+		if (remote_head)
+			get_fetch_map(remote_head, refspec, &tail, 0);
+	}
+	else {
+		get_fetch_map(refs, refspec, &tail, 0);
+		if (!option_mirror)
+			get_fetch_map(refs, tag_refspec, &tail, 0);
+	}
=20
 	return local_refs;
 }
@@ -448,6 +467,27 @@ static void write_remote_refs(const struct ref *lo=
cal_refs)
 	clear_extra_refs();
 }
=20
+static void write_followtags(const struct ref *refs)
+{
+	struct ref_lock *lock;
+	const struct ref *ref;
+
+	for (ref =3D refs; ref; ref =3D ref->next) {
+		if (prefixcmp(ref->name, "refs/tags"))
+			continue;
+		if (!suffixcmp(ref->name, "^{}"))
+			continue;
+		if (!has_sha1_file(ref->old_sha1))
+			continue;
+
+		lock =3D lock_any_ref_for_update(ref->name, NULL, 0);
+		if (!lock)
+			die_errno(_("unable to lock %s for writing"), ref->name);
+		if (write_ref_sha1(lock, ref->old_sha1, "storing tag") < 0)
+			die_errno(_("unable to write %s"), ref->name);
+	}
+}
+
 static int write_one_config(const char *key, const char *value, void *=
data)
 {
 	return git_config_set_multivar(key, value ? value : "true", "^$", 0);
@@ -478,7 +518,6 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
-	char *src_ref_prefix =3D "refs/heads/";
 	int err =3D 0;
=20
 	struct refspec *refspec;
@@ -642,9 +681,12 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
=20
 		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
=20
-		if (option_depth)
+		if (option_depth) {
 			transport_set_option(transport, TRANS_OPT_DEPTH,
 					     option_depth);
+			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS,
+					     "1");
+		}
=20
 		transport_set_verbosity(transport, option_verbosity, option_progress=
);
=20
@@ -663,6 +705,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		clear_extra_refs();
=20
 		write_remote_refs(mapped_refs);
+		if (option_depth)
+			write_followtags(refs);
=20
 		remote_head =3D find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =3D
--=20
1.7.3.1.256.g2539c.dirty
