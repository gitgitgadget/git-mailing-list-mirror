From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/20] clone: define shallow clone boundary based on time with --since
Date: Tue, 29 Dec 2015 19:10:36 +0700
Message-ID: <1451391043-28093-14-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt8T-0006vP-CI
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbbL2MMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:13 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34041 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbL2MML (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:11 -0500
Received: by mail-pf0-f173.google.com with SMTP id e65so74286884pfe.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ti2ilEneEKO7p9D8wJstgMWSOSfipe8Hikow0qDA6BY=;
        b=KtZeAyIR8UrzVsDyWh17lSp3VNnkBEggNxxiTiGbemdH5Cvu9qttKg+iRT9NpDGcg+
         ZhxmsK456opc6HK1RbtIiCln3ZztMD+6lSgSbr1bPVT3a6gTkBFHFQ6p432lUXjGr21c
         sk7PzcK63ZrQ/5R0SnfkgdBD7lrBSMcy/BlM57X1KrXL/4aeVgALBz/xwfpYlgsd/xJe
         33zXidEDTQzi+MYUcK0vI4a4IsZqqmf+NMD0J6anBuNlnJRNjVRLIgoKGy4uUYgfPhx5
         g+59yFEc3NkJot+eL9yZCOKqEsY2g6hIk5qbEVQDY39PAiqfL6gnJGCqxJs6d4oil8ZV
         fpmw==
X-Received: by 10.98.7.4 with SMTP id b4mr37637036pfd.152.1451391131270;
        Tue, 29 Dec 2015 04:12:11 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id i72sm63945761pfj.64.2015.12.29.04.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:12:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:12:06 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283123>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |  3 +++
 builtin/clone.c             | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6bf000d..28993c6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -192,6 +192,9 @@ objects from the source repository into a pack in t=
he cloned repository.
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revisions.
=20
+--since=3D<date>::
+	Create a 'shallow' clone with a history after the specified time.
+
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
diff --git a/builtin/clone.c b/builtin/clone.c
index a0b3cd9..94bbfef 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -40,7 +40,8 @@ static const char * const builtin_clone_usage[] =3D {
=20
 static int option_no_checkout, option_bare, option_mirror, option_sing=
le_branch =3D -1;
 static int option_local =3D -1, option_no_hardlinks, option_shared, op=
tion_recursive;
-static char *option_template, *option_depth;
+static int deepen;
+static char *option_template, *option_depth, *option_since;
 static char *option_origin =3D NULL;
 static char *option_branch =3D NULL;
 static const char *real_git_dir;
@@ -86,6 +87,8 @@ static struct option builtin_clone_options[] =3D {
 		   N_("path to git-upload-pack on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
 		    N_("create a shallow clone of that depth")),
+	OPT_STRING(0, "since", &option_since, N_("time"),
+		    N_("create a shallow clone since a specific time")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
@@ -846,8 +849,10 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
+	if (option_depth || option_since)
+		deepen =3D 1;
 	if (option_single_branch =3D=3D -1)
-		option_single_branch =3D option_depth ? 1 : 0;
+		option_single_branch =3D deepen ? 1 : 0;
=20
 	if (option_mirror)
 		option_bare =3D 1;
@@ -973,6 +978,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	if (is_local) {
 		if (option_depth)
 			warning(_("--depth is ignored in local clones; use file:// instead.=
"));
+		if (option_since)
+			warning(_("--since is ignored in local clones; use file:// instead.=
"));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -991,6 +998,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	if (option_depth)
 		transport_set_option(transport, TRANS_OPT_DEPTH,
 				     option_depth);
+	if (option_since)
+		transport_set_option(transport, TRANS_OPT_DEEPEN_SINCE,
+				     option_since);
 	if (option_single_branch)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
=20
@@ -998,7 +1008,7 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
=20
-	if (transport->smart_options && !option_depth)
+	if (transport->smart_options && !deepen)
 		transport->smart_options->check_self_contained_and_connected =3D 1;
=20
 	refs =3D transport_get_remote_refs(transport);
--=20
2.3.0.rc1.137.g477eb31
