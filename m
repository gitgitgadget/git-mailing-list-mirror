From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4] clone: add --single-branch to fetch only one branch
Date: Sat,  7 Jan 2012 21:45:59 +0700
Message-ID: <1325947559-20080-1-git-send-email-pclouds@gmail.com>
References: <1325833869-20078-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 15:47:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjXYf-0003on-9L
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 15:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab2AGOrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jan 2012 09:47:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48552 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab2AGOr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 09:47:29 -0500
Received: by iaeh11 with SMTP id h11so4221656iae.19
        for <git@vger.kernel.org>; Sat, 07 Jan 2012 06:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zhZDQg4xRRxN81KV5mDvksy9e+hMqLZnfuSWeqBQ3tc=;
        b=TQKCL6jUpQkCSb+ZvT4lM4KWIJpA12Jqvag6/sJIHB2N0g480Iopgy/9SM34fR3Qda
         aywZUTKreStj3yv9LlOKhwdpIst4kkVHEXyaRlSC3tTjxXqkXDENiL0p11dciG72zZlK
         +TASWetDZCkeh8xZ7SLXS26FSf053tsqM0QlU=
Received: by 10.50.155.166 with SMTP id vx6mr2251391igb.16.1325947649160;
        Sat, 07 Jan 2012 06:47:29 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.50.211])
        by mx.google.com with ESMTPS id rc7sm3994726igb.0.2012.01.07.06.47.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Jan 2012 06:47:28 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 07 Jan 2012 21:46:58 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1325833869-20078-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188080>

When --single-branch is given, only one branch, either HEAD or one
specified by --branch, will be fetched. Also only tags that point to
the downloaded history are fetched.

This helps most in shallow clones, where it can reduce the download to
minimum and that is why it is enabled by default when --depth is given.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The fourth round does not limit --single-branch to shallow clones any
 more. I did not see that the patch finally comes close to what Carlos
 tried to do [1], the patch that reminded me of the tag issue in shallo=
w
 clone Shawn mentioned a while ago.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/187639

 Documentation/git-clone.txt |   11 ++++++-
 builtin/clone.c             |   52 ++++++++++++++++++++++++++++--
 t/t5500-fetch-pack.sh       |   72 +++++++++++++++++++++++++++++++++++=
+++++++-
 3 files changed, 129 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4b8b26b..0931a3e 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository=
>]
 	  [--separate-git-dir <git dir>]
-	  [--depth <depth>] [--recursive|--recurse-submodules] [--] <reposito=
ry>
+	  [--depth <depth>] [--[no-]single-branch]
+	  [--recursive|--recurse-submodules] [--] <repository>
 	  [<directory>]
=20
 DESCRIPTION
@@ -179,6 +180,14 @@ objects from the source repository into a pack in =
the cloned repository.
 	with a long history, and would want to send in fixes
 	as patches.
=20
+--single-branch::
+	Clone only the history leading to the tip of a single branch,
+	either specified by the `--branch` option or the primary
+	branch remote's `HEAD` points at. When creating a shallow
+	clone with the `--depth` option, this is the default, unless
+	`--no-single-branch` is given to fetch the histories near the
+	tips of all branches.
+
 --recursive::
 --recurse-submodules::
 	After the clone is created, initialize all submodules within,
diff --git a/builtin/clone.c b/builtin/clone.c
index 86db954..9dcc5fe 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -37,7 +37,7 @@ static const char * const builtin_clone_usage[] =3D {
 	NULL
 };
=20
-static int option_no_checkout, option_bare, option_mirror;
+static int option_no_checkout, option_bare, option_mirror, option_sing=
le_branch =3D -1;
 static int option_local, option_no_hardlinks, option_shared, option_re=
cursive;
 static char *option_template, *option_depth;
 static char *option_origin =3D NULL;
@@ -48,6 +48,7 @@ static int option_verbosity;
 static int option_progress;
 static struct string_list option_config;
 static struct string_list option_reference;
+static const char *src_ref_prefix =3D "refs/heads/";
=20
 static int opt_parse_reference(const struct option *opt, const char *a=
rg, int unset)
 {
@@ -92,6 +93,8 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_BOOL(0, "single-branch", &option_single_branch,
+		    "clone only one branch, HEAD or --branch"),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, "gitdir",
 		   "separate git dir from working tree"),
 	OPT_STRING_LIST('c', "config", &option_config, "key=3Dvalue",
@@ -427,8 +430,28 @@ static struct ref *wanted_peer_refs(const struct r=
ef *refs,
 	struct ref *local_refs =3D head;
 	struct ref **tail =3D head ? &head->next : &local_refs;
=20
-	get_fetch_map(refs, refspec, &tail, 0);
-	if (!option_mirror)
+	if (option_single_branch) {
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
+		if (!remote_head && option_branch)
+			warning(_("Could not find remote branch %s to clone."),
+				option_branch);
+		else
+			get_fetch_map(remote_head, refspec, &tail, 0);
+	} else
+		get_fetch_map(refs, refspec, &tail, 0);
+
+	if (!option_mirror && !option_single_branch)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
=20
 	return local_refs;
@@ -448,6 +471,21 @@ static void write_remote_refs(const struct ref *lo=
cal_refs)
 	clear_extra_refs();
 }
=20
+static void write_followtags(const struct ref *refs, const char *msg)
+{
+	const struct ref *ref;
+	for (ref =3D refs; ref; ref =3D ref->next) {
+		if (prefixcmp(ref->name, "refs/tags/"))
+			continue;
+		if (!suffixcmp(ref->name, "^{}"))
+			continue;
+		if (!has_sha1_file(ref->old_sha1))
+			continue;
+		update_ref(msg, ref->name, ref->old_sha1,
+			   NULL, 0, DIE_ON_ERR);
+	}
+}
+
 static int write_one_config(const char *key, const char *value, void *=
data)
 {
 	return git_config_set_multivar(key, value ? value : "true", "^$", 0);
@@ -478,7 +516,6 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
-	char *src_ref_prefix =3D "refs/heads/";
 	int err =3D 0;
=20
 	struct refspec *refspec;
@@ -498,6 +535,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
+	if (option_single_branch =3D=3D -1)
+		option_single_branch =3D option_depth ? 1 : 0;
+
 	if (option_mirror)
 		option_bare =3D 1;
=20
@@ -645,6 +685,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		if (option_depth)
 			transport_set_option(transport, TRANS_OPT_DEPTH,
 					     option_depth);
+		if (option_single_branch)
+			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
=20
 		transport_set_verbosity(transport, option_verbosity, option_progress=
);
=20
@@ -663,6 +705,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		clear_extra_refs();
=20
 		write_remote_refs(mapped_refs);
+		if (option_single_branch)
+			write_followtags(refs, reflog_msg.buf);
=20
 		remote_head =3D find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =3D
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 9bf69e9..7e85c71 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -114,8 +114,19 @@ pull_to_client 2nd "refs/heads/B" $((64*3))
=20
 pull_to_client 3rd "refs/heads/A" $((1*3))
=20
+test_expect_success 'single branch clone' '
+	git clone --single-branch "file://$(pwd)/." singlebranch
+'
+
+test_expect_success 'single branch object count' '
+	GIT_DIR=3Dsinglebranch/.git git count-objects -v |
+		grep "^in-pack:" > count.singlebranch &&
+	echo "in-pack: 198" >expected &&
+	test_cmp expected count.singlebranch
+'
+
 test_expect_success 'clone shallow' '
-	git clone --depth 2 "file://$(pwd)/." shallow
+	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
 '
=20
 test_expect_success 'clone shallow object count' '
@@ -248,4 +259,63 @@ test_expect_success 'clone shallow object count' '
 	grep "^count: 52" count.shallow
 '
=20
+test_expect_success 'clone shallow without --no-single-branch' '
+	git clone --depth 1 "file://$(pwd)/." shallow2
+'
+
+test_expect_success 'clone shallow object count' '
+	(
+		cd shallow2 &&
+		git count-objects -v
+	) > count.shallow2 &&
+	grep "^in-pack: 6" count.shallow2
+'
+
+test_expect_success 'clone shallow with --branch' '
+	git clone --depth 1 --branch A "file://$(pwd)/." shallow3
+'
+
+test_expect_success 'clone shallow object count' '
+	echo "in-pack: 12" > count3.expected &&
+	GIT_DIR=3Dshallow3/.git git count-objects -v |
+		grep "^in-pack" > count3.actual &&
+	test_cmp count3.expected count3.actual
+'
+
+test_expect_success 'clone shallow with nonexistent --branch' '
+	git clone --depth 1 --branch Z "file://$(pwd)/." shallow4 &&
+	GIT_DIR=3Dshallow4/.git git rev-parse HEAD >actual &&
+	git rev-parse HEAD >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'clone shallow with detached HEAD' '
+	git checkout HEAD^ &&
+	git clone --depth 1 "file://$(pwd)/." shallow5 &&
+	git checkout - &&
+	GIT_DIR=3Dshallow5/.git git rev-parse HEAD >actual &&
+	git rev-parse HEAD^ >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'shallow clone pulling tags' '
+	git tag -a -m A TAGA1 A &&
+	git tag -a -m B TAGB1 B &&
+	git tag TAGA2 A &&
+	git tag TAGB2 B &&
+	git clone --depth 1 "file://$(pwd)/." shallow6 &&
+
+	cat >taglist.expected <<\EOF &&
+TAGB1
+TAGB2
+EOF
+	GIT_DIR=3Dshallow6/.git git tag -l >taglist.actual &&
+	test_cmp taglist.expected taglist.actual &&
+
+	echo "in-pack: 7" > count6.expected &&
+	GIT_DIR=3Dshallow6/.git git count-objects -v |
+		grep "^in-pack" > count6.actual &&
+	test_cmp count6.expected count6.actual
+'
+
 test_done
--=20
1.7.8.36.g69ee2
