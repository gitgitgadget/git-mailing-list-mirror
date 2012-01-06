From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] Limit refs to fetch to minimum in shallow clones
Date: Fri,  6 Jan 2012 14:11:09 +0700
Message-ID: <1325833869-20078-1-git-send-email-pclouds@gmail.com>
References: <1325743516-14940-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 08:11:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj3xZ-0004Z8-IX
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 08:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab2AFHLX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 02:11:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51709 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab2AFHLW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 02:11:22 -0500
Received: by iaeh11 with SMTP id h11so2188527iae.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 23:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Pq0zx6JdftO0R0xftVT713s7tOseAwYu3FrMhHVcPhU=;
        b=EAILib9lPuZ4YPy2rPB0yXgwEi4iU/Tsm99WPoQWpAtSaJQ4Shak3jc2pqwc2mE3Mm
         1gzsNjzbkQRbbYL8oL/g7Ev4rVn1aeJAcyqVTp5iQxA41XQVDDDUOuKRqwvUq93taORy
         rUY/Kq8RTzJdCYqkfzfuXwn/Fb8Zt1a/OMcZc=
Received: by 10.50.202.105 with SMTP id kh9mr6548253igc.3.1325833882078;
        Thu, 05 Jan 2012 23:11:22 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id gh9sm128057740igb.3.2012.01.05.23.11.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Jan 2012 23:11:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 06 Jan 2012 14:11:10 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1325743516-14940-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188011>

The main purpose of shallow clones is to reduce download by only
fetching objects up to a certain depth from the given refs. The number
of objects depend on how many refs to follow. So:

 - Only fetch HEAD or the ref specified by --branch
 - Only fetch tags that reference to downloaded objects

More tags/branches can be fetched later using git-fetch as usual.

The old behaviour can still be called with --no-single-branch

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  - add --no-single-branch so t5500 works without big changes.
  - die() if we cannot find suitable branch to fetch (and suggest --no-=
single-branch)
  - and a bit more tests to exercise new code

  --branch=3D<tag> (or something similar) has to wait until my other
  patch gets in a good shape (or gets dropped)

 There may be something slightly wrong with shallow code. I expect it
 to fetch only 3 objects (1 commit, 1 tree, 1 blob) with --depth=3D1
 in my new test but it fetches 6 (one more commit).

 Documentation/git-clone.txt |   12 ++++++++-
 builtin/clone.c             |   54 +++++++++++++++++++++++++++++++++++=
+++----
 t/t5500-fetch-pack.sh       |   34 ++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4b8b26b..58f21d6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository=
>]
 	  [--separate-git-dir <git dir>]
-	  [--depth <depth>] [--recursive|--recurse-submodules] [--] <reposito=
ry>
+	  [--depth <depth> [--[no-]single-branch]]
+	  [--recursive|--recurse-submodules] [--] <repository>
 	  [<directory>]
=20
 DESCRIPTION
@@ -179,6 +180,15 @@ objects from the source repository into a pack in =
the cloned repository.
 	with a long history, and would want to send in fixes
 	as patches.
=20
+--single-branch::
+--no-single-branch::
+	These options are only valid when --depth is given.
+	 `--single-branch` only fetches one branch (either HEAD or
+	specified by --branch) and tags that point to the downloaded
+	history. `--no-single-branch` fetches all branches and tags
+	like in normal clones. `--single-branch` is implied by
+	default.
+
 --recursive::
 --recurse-submodules::
 	After the clone is created, initialize all submodules within,
diff --git a/builtin/clone.c b/builtin/clone.c
index efe8b6c..3424e1c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -37,7 +37,7 @@ static const char * const builtin_clone_usage[] =3D {
 	NULL
 };
=20
-static int option_no_checkout, option_bare, option_mirror;
+static int option_no_checkout, option_bare, option_mirror, option_sing=
le_branch =3D 1;
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
+		    "do not limit fetched refs in shallow clones"),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, "gitdir",
 		   "separate git dir from working tree"),
 	OPT_STRING_LIST('c', "config", &option_config, "key=3Dvalue",
@@ -427,9 +430,29 @@ static struct ref *wanted_peer_refs(const struct r=
ef *refs,
 	struct ref *local_refs =3D head;
 	struct ref **tail =3D head ? &head->next : &local_refs;
=20
-	get_fetch_map(refs, refspec, &tail, 0);
-	if (!option_mirror)
-		get_fetch_map(refs, tag_refspec, &tail, 0);
+	if (!(option_depth && option_single_branch)) {
+		get_fetch_map(refs, refspec, &tail, 0);
+		if (!option_mirror)
+			get_fetch_map(refs, tag_refspec, &tail, 0);
+	} else {
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
+		if (!remote_head)
+			die(_("Remote branch \"%s\" not found. Nothing to clone.\n"
+			      "Try --no-single-branch to fetch all refs."),
+			    option_branch ? option_branch : "HEAD");
+		get_fetch_map(remote_head, refspec, &tail, 0);
+	}
=20
 	return local_refs;
 }
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
@@ -642,9 +679,12 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
=20
 		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
=20
-		if (option_depth)
+		if (option_depth) {
 			transport_set_option(transport, TRANS_OPT_DEPTH,
 					     option_depth);
+			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS,
+					     option_single_branch ? "1" : NULL);
+		}
=20
 		transport_set_verbosity(transport, option_verbosity, option_progress=
);
=20
@@ -663,6 +703,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		clear_extra_refs();
=20
 		write_remote_refs(mapped_refs);
+		if (option_depth && option_single_branch)
+			write_followtags(refs, reflog_msg.buf);
=20
 		remote_head =3D find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =3D
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index bafcca7..c76a53b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -115,7 +115,7 @@ pull_to_client 2nd "B" $((64*3))
 pull_to_client 3rd "A" $((1*3))
=20
 test_expect_success 'clone shallow' '
-	git clone --depth 2 "file://$(pwd)/." shallow
+	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
 '
=20
 test_expect_success 'clone shallow object count' '
@@ -248,4 +248,36 @@ test_expect_success 'clone shallow object count' '
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
+test_expect_success 'shallow clone pulling tags' '
+	git tag -a -m A TAGA1 A &&
+	git tag -a -m B TAGB1 B &&
+	git tag TAGA2 A &&
+	git tag TAGB2 B &&
+	git clone --depth 1 "file://$(pwd)/." shallow3 &&
+
+	cat >taglist.expected <<\EOF &&
+TAGB1
+TAGB2
+EOF
+	GIT_DIR=3Dshallow3/.git git tag -l >taglist.actual &&
+	test_cmp taglist.expected taglist.actual &&
+
+	echo "in-pack: 7" > count3.expected &&
+	GIT_DIR=3Dshallow3/.git git count-objects -v |
+		grep "^in-pack" > count3.actual &&
+	test_cmp count3.expected count3.actual
+'
+
 test_done
--=20
1.7.3.1.256.g2539c.dirty
