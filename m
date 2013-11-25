From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 15/28] fetch: add --update-shallow to get refs that require updating .git/shallow
Date: Mon, 25 Nov 2013 10:55:41 +0700
Message-ID: <1385351754-9954-16-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:53:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknEy-0002D8-35
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab3KYDxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:53:30 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:54945 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab3KYDw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:52:58 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so4738969pbc.26
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eBhifkJlJhj1Jcand4A80fKEds0DX5EoszsEqAHr/xk=;
        b=dsTfX33vHExfvQcGMpjshecZkgOVtVvFizSPQsiHnG/yQ062WhEanSwqBXQAPTz+24
         eqjzuh+Z4/kSiLP9K6leLTozF7o3Fdj+DrEYq5/pnQZn8XeVPS3ruOaNM/zBkW7E4DKB
         Z4z6rINGETjqsldfC7cTK6j+EBz545+sBv475FdDhjIsGpzk4OhYFWbQutIk6DEHJHBv
         nHbF0ovF3eBmCDo54XTeWI8OFSjQ9Oq0S9xODiKhXF/x/3uT28wI7MDSuWLof8IfT7mq
         UIegk/zmB+1/sbinq7QxubQfWeS9lfhaUyCVypPkmroGzlyqMQH6fhv1Cekcr24RCcxV
         PTIA==
X-Received: by 10.68.211.39 with SMTP id mz7mr15863421pbc.90.1385351578160;
        Sun, 24 Nov 2013 19:52:58 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id pe3sm38941924pbc.23.2013.11.24.19.52.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:52:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:57:28 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238293>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt |  6 ++++++
 builtin/fetch.c                 |  6 +++++-
 fetch-pack.c                    | 26 ++++++++++++++++++++++++++
 fetch-pack.h                    |  1 +
 t/t5536-fetch-shallow.sh        | 22 ++++++++++++++++++++++
 transport.c                     |  4 ++++
 transport.h                     |  4 ++++
 7 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index a83d2b4..54043e3 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -21,6 +21,12 @@
 If the source repository is shallow, fetch as much as possible so that
 the current repository has the same history as the source repository.
=20
+--update-shallow::
+	By default when fetching from a shallow repository,
+	`git fetch` refuses refs that require updating
+	.git/shallow. This option updates .git/shallow and accept such
+	refs.
+
 ifndef::git-pull[]
 --dry-run::
 	Show what would be done, without making any changes.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7b41a7e..d2e4fc0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -36,7 +36,7 @@ static int prune =3D -1; /* unspecified */
=20
 static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
-static int tags =3D TAGS_DEFAULT, unshallow;
+static int tags =3D TAGS_DEFAULT, unshallow, update_shallow;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla =3D STRBUF_INIT;
@@ -104,6 +104,8 @@ static struct option builtin_fetch_options[] =3D {
 	{ OPTION_STRING, 0, "recurse-submodules-default",
 		   &recurse_submodules_default, NULL,
 		   N_("default mode for recursion"), PARSE_OPT_HIDDEN },
+	OPT_BOOL(0, "update-shallow", &update_shallow,
+		 N_("accept refs that update .git/shallow")),
 	OPT_END()
 };
=20
@@ -768,6 +770,8 @@ static struct transport *prepare_transport(struct r=
emote *remote)
 		set_option(transport, TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
+	if (update_shallow)
+		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
 }
=20
diff --git a/fetch-pack.c b/fetch-pack.c
index 64fa5d2..82aa5db 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -995,6 +995,32 @@ static void update_shallow(struct fetch_pack_args =
*args,
 	for (i =3D 0; i < nr_sought; i++)
 		add_extra_have(&ref, sought[i]->old_sha1);
=20
+	if (args->update_shallow) {
+		/*
+		 * remote is also shallow, .git/shallow may be updated
+		 * so all refs can be accepted. Make sure we only add
+		 * shallow roots that are actually reachable from new
+		 * refs.
+		 */
+		uint32_t **used =3D xmalloc(sizeof(*used) * shallow->nr);
+		if (mark_new_shallow_refs(&ref, NULL, used, shallow)) {
+			struct extra_have_objects extra;
+			memset(&extra, 0, sizeof(extra));
+			for (i =3D 0; i < shallow->nr; i++)
+				if (used[i])
+					add_extra_have(&extra,
+						       shallow->array[i]);
+			setup_alternate_shallow(&shallow_lock,
+						&alternate_shallow_file,
+						&extra);
+			commit_lock_file(&shallow_lock);
+			free(extra.array);
+		}
+		free(used);
+		free(ref.array);
+		return;
+	}
+
 	status =3D xcalloc(nr_sought, sizeof(*status));
=20
 	/*
diff --git a/fetch-pack.h b/fetch-pack.h
index cabfb60..5cfb77b 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -23,6 +23,7 @@ struct fetch_pack_args {
 	unsigned check_self_contained_and_connected:1;
 	unsigned self_contained_and_connected:1;
 	unsigned cloning:1;
+	unsigned update_shallow:1;
 };
=20
 /*
diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
index e011ead..95b6313 100755
--- a/t/t5536-fetch-shallow.sh
+++ b/t/t5536-fetch-shallow.sh
@@ -141,4 +141,26 @@ EOF
 	)
 '
=20
+test_expect_success 'fetch --update-shallow' '
+	(
+	cd notshallow &&
+	git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/=
shallow/* &&
+	git fsck &&
+	git for-each-ref --format=3D"%(refname)" |sort >actual.refs &&
+	cat <<EOF >expect.refs &&
+refs/remotes/shallow/master
+refs/remotes/shallow/no-shallow
+EOF
+	test_cmp expect.refs actual.refs &&
+	git log --format=3D%s shallow/master >actual &&
+	cat <<EOF >expect &&
+6
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index d6d14eb..c0be6b1 100644
--- a/transport.c
+++ b/transport.c
@@ -476,6 +476,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 	} else if (!strcmp(name, TRANS_OPT_KEEP)) {
 		opts->keep =3D !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_UPDATE_SHALLOW)) {
+		opts->update_shallow =3D !!value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
 		if (!value)
 			opts->depth =3D 0;
@@ -542,6 +545,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
 	args.cloning =3D transport->cloning;
+	args.update_shallow =3D data->options.update_shallow;
=20
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
diff --git a/transport.h b/transport.h
index 59842d4..02ea248 100644
--- a/transport.h
+++ b/transport.h
@@ -11,6 +11,7 @@ struct git_transport_options {
 	unsigned followtags : 1;
 	unsigned check_self_contained_and_connected : 1;
 	unsigned self_contained_and_connected : 1;
+	unsigned update_shallow : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
@@ -152,6 +153,9 @@ struct transport *transport_get(struct remote *, co=
nst char *);
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
=20
+/* Accept refs that may update .git/shallow without --depth */
+#define TRANS_OPT_UPDATE_SHALLOW "updateshallow"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
--=20
1.8.2.83.gc99314b
