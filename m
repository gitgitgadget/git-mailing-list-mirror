From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 13/28] fetch: support fetching from a shallow repository
Date: Mon, 25 Nov 2013 10:55:39 +0700
Message-ID: <1385351754-9954-14-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknE8-0001vo-5Y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab3KYDwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:52:44 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:52409 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3KYDwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:52:43 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so4754535pbb.23
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6HlYr+tIg/eS0gE80t0vZaJGW7SAwa9T1X9YIgcbujM=;
        b=hKgXocKglRffy3KNlbRp5ODqF8SdHWmuZnoBuM9zSLWiMBZ2zeAu++HGLlP//z10s/
         YZ8HCcKdMk78M2rP4mQsKLySZUDoyV5aBo7IzmYZAnpCmvuWWOYL/t8jv9aNReGJQgF0
         S6kkExkC8Dk+QJGk6SvoSifNqZDE8hQi2eIeASSqSLxjcIZUSzsYQY/JVzfbHGYxPB0b
         S262+Dt+dqzFU9BmcBqPyeX2JQe2X8WQoA8wk4LfYz0VBiD6JaMo3374BG9wL2mcH56n
         aInBVKZiHLfgbn/7b2x++iHyXhXtxyjp4Uly4H4sU9yohPk4aD2Yh/WiJmYhaaVZKIpk
         t8jQ==
X-Received: by 10.66.139.130 with SMTP id qy2mr25626290pab.73.1385351563353;
        Sun, 24 Nov 2013 19:52:43 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id kd1sm79046513pab.20.2013.11.24.19.52.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:52:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:57:15 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238285>

This patch just put together pieces from the previous patches:

 - Before getting the new pack, we need to remove all new reachable
   shallow roots. The remaining roots may or may not be added to
   .git/shallow.

 - After getting the pack, walk all new refs until they connect to
   current refs, or hit the bottom of current repo, or hit new
   shallow roots.

Those refs that hit new shallow roots are rejected because by default
we do not allow to update .git/shallow (the only exception so far is
cloning from a shallow repo, which is more like creating .git/shallow
than updating it)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c                   |   9 +++
 fetch-pack.c                      |  35 ++++++++++-
 remote.h                          |   1 +
 t/t5536-fetch-shallow.sh (new +x) | 128 ++++++++++++++++++++++++++++++=
++++++++
 transport.c                       |  11 +++-
 5 files changed, 179 insertions(+), 5 deletions(-)
 create mode 100755 t/t5536-fetch-shallow.sh

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd7a101..7b41a7e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -405,6 +405,8 @@ static int iterate_ref_map(void *cb_data, unsigned =
char sha1[20])
 	struct ref **rm =3D cb_data;
 	struct ref *ref =3D *rm;
=20
+	while (ref && ref->status =3D=3D REF_STATUS_REJECT_SHALLOW)
+		ref =3D ref->next;
 	if (!ref)
 		return -1; /* end of the list */
 	*rm =3D ref->next;
@@ -451,6 +453,13 @@ static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
 			struct ref *ref =3D NULL;
 			const char *merge_status_marker =3D "";
=20
+			if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW) {
+				if (want_status =3D=3D FETCH_HEAD_MERGE)
+					warning(_("reject %s because shallow roots are not allowed to be =
updated"),
+						rm->peer_ref ? rm->peer_ref->name : rm->name);
+				continue;
+			}
+
 			commit =3D lookup_commit_reference_gently(rm->old_sha1, 1);
 			if (!commit)
 				rm->fetch_head_status =3D FETCH_HEAD_NOT_FOR_MERGE;
diff --git a/fetch-pack.c b/fetch-pack.c
index b76581a..64fa5d2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -855,7 +855,17 @@ static struct ref *do_fetch_pack(struct fetch_pack=
_args *args,
 					NULL);
 	else if (args->cloning && shallow && shallow->nr)
 		alternate_shallow_file =3D setup_temporary_shallow(shallow);
-	else
+	else if (!args->cloning && shallow && shallow->nr) {
+		struct extra_have_objects extra;
+		memset(&extra, 0, sizeof(extra));
+		remove_reachable_shallow_points(&extra, shallow);
+		if (extra.nr) {
+			alternate_shallow_file =3D setup_temporary_shallow(&extra);
+			free(shallow->array);
+			*shallow =3D extra;
+		} else
+			alternate_shallow_file =3D NULL;
+	} else
 		alternate_shallow_file =3D NULL;
 	if (get_pack(args, fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
@@ -929,8 +939,11 @@ static int remove_duplicates_in_refs(struct ref **=
ref, int nr)
 }
=20
 static void update_shallow(struct fetch_pack_args *args,
+			   struct ref **sought, int nr_sought,
 			   struct extra_have_objects *shallow)
 {
+	struct extra_have_objects ref;
+	int *status;
 	int i;
=20
 	if (args->depth > 0 && alternate_shallow_file) {
@@ -977,6 +990,24 @@ static void update_shallow(struct fetch_pack_args =
*args,
 		free(extra.array);
 		return;
 	}
+
+	memset(&ref, 0, sizeof(ref));
+	for (i =3D 0; i < nr_sought; i++)
+		add_extra_have(&ref, sought[i]->old_sha1);
+
+	status =3D xcalloc(nr_sought, sizeof(*status));
+
+	/*
+	 * remote is also shallow, check what ref is safe to update
+	 * without updating .git/shallow
+	 */
+	if (mark_new_shallow_refs(&ref, status, NULL, shallow)) {
+		for (i =3D 0; i < nr_sought; i++)
+			if (status[i])
+				sought[i]->status =3D REF_STATUS_REJECT_SHALLOW;
+	}
+	free(status);
+	free(ref.array);
 }
=20
 struct ref *fetch_pack(struct fetch_pack_args *args,
@@ -1000,6 +1031,6 @@ struct ref *fetch_pack(struct fetch_pack_args *ar=
gs,
 	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought,
 				shallow, pack_lockfile);
 	reprepare_packed_git();
-	update_shallow(args, shallow);
+	update_shallow(args, sought, nr_sought, shallow);
 	return ref_cpy;
 }
diff --git a/remote.h b/remote.h
index ff604ff..e519c26 100644
--- a/remote.h
+++ b/remote.h
@@ -109,6 +109,7 @@ struct ref {
 		REF_STATUS_REJECT_FETCH_FIRST,
 		REF_STATUS_REJECT_NEEDS_FORCE,
 		REF_STATUS_REJECT_STALE,
+		REF_STATUS_REJECT_SHALLOW,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT
diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
new file mode 100755
index 0000000..41de74d
--- /dev/null
+++ b/t/t5536-fetch-shallow.sh
@@ -0,0 +1,128 @@
+#!/bin/sh
+
+test_description=3D'fetch/clone from a shallow clone'
+
+. ./test-lib.sh
+
+commit() {
+	echo "$1" >tracked &&
+	git add tracked &&
+	git commit -m "$1"
+}
+
+test_expect_success 'setup' '
+	commit 1 &&
+	commit 2 &&
+	commit 3 &&
+	commit 4 &&
+	git config --global transfer.fsckObjects true
+'
+
+test_expect_success 'setup shallow clone' '
+	git clone --no-local --depth=3D2 .git shallow &&
+	git --git-dir=3Dshallow/.git log --format=3D%s >actual &&
+	cat <<EOF >expect &&
+4
+3
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'clone from shallow clone' '
+	git clone --no-local shallow shallow2 &&
+	(
+	cd shallow2 &&
+	git fsck &&
+	git log --format=3D%s >actual &&
+	cat <<EOF >expect &&
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'fetch from shallow clone' '
+	(
+	cd shallow &&
+	commit 5
+	) &&
+	(
+	cd shallow2 &&
+	git fetch &&
+	git fsck &&
+	git log --format=3D%s origin/master >actual &&
+	cat <<EOF >expect &&
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'fetch --depth from shallow clone' '
+	(
+	cd shallow &&
+	commit 6
+	) &&
+	(
+	cd shallow2 &&
+	git fetch --depth=3D2 &&
+	git fsck &&
+	git log --format=3D%s origin/master >actual &&
+	cat <<EOF >expect &&
+6
+5
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'fetch something upstream has but hidden by client=
s shallow boundaries' '
+	# the blob "1" is available in .git but hidden by the
+	# shallow2/.git/shallow and it should be resent
+	! git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git hash-object=
 --stdin` >/dev/null &&
+	echo 1 > 1.t &&
+	git add 1.t &&
+	git commit -m add-1-back &&
+	(
+	cd shallow2 &&
+	git fetch ../.git +refs/heads/master:refs/remotes/top/master &&
+	git fsck &&
+	git log --format=3D%s top/master >actual &&
+	cat <<EOF >expect &&
+add-1-back
+4
+3
+EOF
+	test_cmp expect actual
+	) &&
+	git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git hash-object -=
-stdin` >/dev/null
+
+'
+
+test_expect_success 'fetch that requires changes in .git/shallow is fi=
ltered' '
+	(
+	cd shallow &&
+	git checkout --orphan no-shallow &&
+	commit no-shallow
+	) &&
+	git init notshallow &&
+	(
+	cd notshallow &&
+	git fetch ../shallow/.git refs/heads/*:refs/remotes/shallow/*&&
+	git for-each-ref --format=3D"%(refname)" >actual.refs &&
+	cat <<EOF >expect.refs &&
+refs/remotes/shallow/no-shallow
+EOF
+	test_cmp expect.refs actual.refs &&
+	git log --format=3D%s shallow/no-shallow >actual &&
+	cat <<EOF >expect &&
+no-shallow
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_done
diff --git a/transport.c b/transport.c
index fa3dc16..d6d14eb 100644
--- a/transport.c
+++ b/transport.c
@@ -514,7 +514,7 @@ static struct ref *get_refs_via_connect(struct tran=
sport *transport, int for_pus
 	get_remote_heads(data->fd[0], NULL, 0, &refs,
 			 for_push ? REF_NORMAL : 0,
 			 &data->extra_have,
-			 transport->cloning ? &data->shallow : NULL);
+			 &data->shallow);
 	data->got_remote_heads =3D 1;
=20
 	return refs;
@@ -546,8 +546,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
 		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
-				 NULL,
-				 transport->cloning ? &data->shallow : NULL);
+				 NULL, &data->shallow);
 		data->got_remote_heads =3D 1;
 	}
=20
@@ -719,6 +718,10 @@ static int print_one_push_status(struct ref *ref, =
const char *dest, int count, i
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 						 "stale info", porcelain);
 		break;
+	case REF_STATUS_REJECT_SHALLOW:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "new shallow roots not allowed", porcelain);
+		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
 						 ref->deletion ? NULL : ref->peer_ref,
@@ -814,6 +817,8 @@ static int git_transport_push(struct transport *tra=
nsport, struct ref *remote_re
 		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL, NULL, =
NULL);
 		data->got_remote_heads =3D 1;
 	}
+	if (data->shallow.nr)
+		die("pushing to a shallow repository is not supported");
=20
 	memset(&args, 0, sizeof(args));
 	args.send_mirror =3D !!(flags & TRANSPORT_PUSH_MIRROR);
--=20
1.8.2.83.gc99314b
