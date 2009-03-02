From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [PATCH] git-clone: Add option --branch to override initial branch
Date: Mon,  2 Mar 2009 23:11:22 +0100
Message-ID: <1236031882-2052-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 23:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeGKb-0002Qg-9Z
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 23:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbZCBWIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 17:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbZCBWIR
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 17:08:17 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:65032 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbZCBWIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 17:08:16 -0500
Received: by fxm24 with SMTP id 24so2195654fxm.37
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=4f1ZMrK8/mu9MVSqaZodqkDyA8hqdhRLQp5r4ebq8EQ=;
        b=Y2zLN2w8uBC8jmb5ZO9fn0lxpX7mN1i2ubLLobLXJnVt3axdFhZedFHPlBcDIaMxdY
         0FjaXqcuNelTjowUAxQU4W9GLvs62WqfAjJdK1DjsDqPKSIBn8HUm9NB3KWhSQ5SsDIw
         mpsbEgyXXPx0Ro9q7nf71q3EbWqR6ekZlcLtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Q3bQEorKUroAVRP/Q1yOECHdpRzxuizOyJ+KW2x8D4vgsyuEe+aeIEy34wjtrvqrRP
         /F3MeIjC7JCJBiEwTqco94+OG45HregJk+tRoFEsyFTKsUCbnUNuohzPi+WzD8Qpjtk2
         oibmWwhOnU0oeo50BBULuolwT/PTus6dpfb6M=
Received: by 10.86.72.15 with SMTP id u15mr904049fga.8.1236031693332;
        Mon, 02 Mar 2009 14:08:13 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id e11sm358969fga.50.2009.03.02.14.08.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Mar 2009 14:08:12 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 65A0A468001; Mon,  2 Mar 2009 23:11:22 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc2.16.gf474c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111967>

The options --branch and -b allow the user to override the initial
branch created and checked out by git-clone. Normally this is the
active branch of the remote repository, which is also the fallback
if the selected branch is not found.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 Documentation/git-clone.txt |    5 +++++
 builtin-clone.c             |   33 +++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 95f08b9..e7feb4d 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -119,6 +119,11 @@ then the cloned repository will become corrupt.
 	Instead of using the remote name 'origin' to keep track
 	of the upstream repository, use <name> instead.
=20
+--branch <name>::
+-b <name>::
+	Instead of using the remote repository's active branch as the
+	initial branch, use <name> instead.
+
 --upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is accessed
diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..601c2c2 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -38,6 +38,7 @@ static int option_quiet, option_no_checkout, option_b=
are, option_mirror;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin =3D NULL;
+static char *option_branch =3D NULL;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbose;
=20
@@ -66,6 +67,8 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_STRING('b', "branch", &option_branch, "branch",
+		    "initial remote branch to check out"),
=20
 	OPT_END()
 };
@@ -372,7 +375,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
 	int dest_exists;
-	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
+	const struct ref *refs, *mapped_refs;
+	const struct ref *remote_head =3D NULL;
+	const struct ref *head_points_at =3D NULL;
 	struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
@@ -545,12 +550,32 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
=20
 		mapped_refs =3D write_remote_refs(refs, &refspec, reflog_msg.buf);
=20
-		head_points_at =3D locate_head(refs, mapped_refs, &remote_head);
+		if (option_branch) {
+		    const int offset =3D 11;
+		    const char *branch =3D option_branch;
+		    if (!prefixcmp(branch, "refs/heads/"))
+			branch +=3D offset;
+
+		    const struct ref *r;
+		    for (r =3D mapped_refs; r; r =3D r->next) {
+			if (!strcmp(r->name + offset, branch)) {
+			    /* Override initial branch */
+			    head_points_at =3D r;
+			    remote_head =3D r;
+			    break;
+			}
+		    }
+
+		    if (!head_points_at)
+			warning("remote has no branch named '%s', "
+				"falling back to default.", option_branch);
+		}
+
+		if (!head_points_at)
+		    head_points_at =3D locate_head(refs, mapped_refs, &remote_head);
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
-		head_points_at =3D NULL;
-		remote_head =3D NULL;
 		option_no_checkout =3D 1;
 		if (!option_bare)
 			install_branch_config("master", option_origin,
--=20
1.6.2.rc2.16.gf474c.dirty
