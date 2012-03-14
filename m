From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] {fetch,receive}-pack: skip sha-1 integrity test on objects from new pack
Date: Wed, 14 Mar 2012 21:40:55 +0700
Message-ID: <1331736055-21019-1-git-send-email-pclouds@gmail.com>
References: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 15:43:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7pQS-0003i5-7S
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab2CNOne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 10:43:34 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:39470 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab2CNOnc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:43:32 -0400
Received: by dadp12 with SMTP id p12so3053187dad.11
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/SHB+aS30Zd2NesJ0jpE3zzukgxuHFRMzIWQKdr3MaI=;
        b=1CWPdZ/GLkPwmMSvr0K5njBzTnDlT569lYbDOpoKsPik73D/XHOujswtv/nhGZ0w6y
         Nn6Cc/qOnIkmDXSDXSLd3T9QvWr0kIsTykbyT4S0jb8t8rlmLsenmTNYzjZhNjP3QgGG
         xkMcBaTqYPI1kgwz8G+wXqZILdZexxCX+bKeYKfNSnuJSpTjfllpRui+EXkapsUeNuvd
         s2LnZ3X6RwMn72RFQIqzfrHknjWzuhDtegLnxVto5z+v723rll8DV955skQU0+BbXWz8
         ZYVIanJ4VuxcccvPvGunAtCoqin3dTp0Wx/MxazM6xkwgYAeNOfzhT3kH9w2LMDBzeDc
         obqQ==
Received: by 10.68.131.1 with SMTP id oi1mr3408585pbb.102.1331736212190;
        Wed, 14 Mar 2012 07:43:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.47.192])
        by mx.google.com with ESMTPS id 6sm2525919pbv.5.2012.03.14.07.43.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 07:43:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 14 Mar 2012 21:41:10 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193118>

When we fetch or push, usually "git rev-list --verify-objects --not
--all --stdin" is used to make sure that all objects between existing
refs and new refs are good. This means no gaps in between, all objects
are well-formed, object content agrees with its sha-1 signature.

=46or the last one, --verify-objects calls check_sha1_signature() via
parse_object(). check_sha1_signature() is an expensive operation,
especially when new refs are far away from existing ones because all
objects in between are re-hashed. Because objects coming from the new
pack are already hashed by index-pack, we can trust their
integrity. The only objects left to check are existing ones in repo
but has no connection to any current refs.

Pass the new pack id down to--verify-objects and skip
check_sha1_signature() on objects from that pack.

As an (extreme) example, a repository is created with only one commit:
e83c516 (Initial revision of "git", the information manager from hell
- 2005-04-07). The rest of git.git is fetched on top. Without the
patch:

$ time git fetch file:///home/pclouds/w/git/.git
remote: Counting objects: 125656, done.
remote: Compressing objects: 100% (33280/33280), done.
remote: Total 125656 (delta 92585), reused 123464 (delta 90682)
Receiving objects: 100% (125656/125656), 34.60 MiB | 8.47 MiB/s, done.
Resolving deltas: 100% (92585/92585), done.
=46rom file:///home/pclouds/t/test/
 * branch            HEAD       -> FETCH_HEAD

real    1m30.437s
user    1m31.338s
sys     0m1.687s

With the patch:

$ time git fetch file:///home/pclouds/w/git/.git
remote: Counting objects: 125656, done.
remote: Compressing objects: 100% (33280/33280), done.
remote: Total 125656 (delta 92585), reused 123464 (delta 90682)
Receiving objects: 100% (125656/125656), 34.60 MiB | 7.86 MiB/s, done.
Resolving deltas: 100% (92585/92585), done.
=46rom file:///home/pclouds/t/test/
 * branch            HEAD       -> FETCH_HEAD

real    0m52.182s
user    0m53.151s
sys     0m1.465s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Another try. Exclude all objects reachable from refs and the new pack
 from --verify-objects tests.
=20
 I keep CHECK_CONNECT_QUIET change because it seems a good change
 anyway. transport.[ch] changes are dropped because we can detect pack
 case based on pack_lockfile.

 builtin/fetch.c        |   12 +++++++-----
 builtin/receive-pack.c |    7 +++----
 builtin/rev-list.c     |   20 ++++++++++++++++++--
 connected.c            |   31 +++++++++++++++++++++++--------
 connected.h            |    5 ++++-
 revision.c             |    5 +++++
 revision.h             |    3 +++
 7 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 65f5f9b..cc84d04 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -368,7 +368,7 @@ static int iterate_ref_map(void *cb_data, unsigned =
char sha1[20])
 }
=20
 static int store_updated_refs(const char *raw_url, const char *remote_=
name,
-		struct ref *ref_map)
+			      struct ref *ref_map, const char *pack_lockfile)
 {
 	FILE *fp;
 	struct commit *commit;
@@ -389,7 +389,7 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 		url =3D xstrdup("foreign");
=20
 	rm =3D ref_map;
-	if (check_everything_connected(iterate_ref_map, 0, &rm)) {
+	if (check_everything_connected(iterate_ref_map, 0, pack_lockfile, &rm=
)) {
 		rc =3D error(_("%s did not send all necessary objects\n"), url);
 		goto abort;
 	}
@@ -516,7 +516,8 @@ static int quickfetch(struct ref *ref_map)
 	 */
 	if (depth)
 		return -1;
-	return check_everything_connected(iterate_ref_map, 1, &rm);
+	return check_everything_connected(iterate_ref_map,
+					  CHECK_CONNECT_QUIET, NULL, &rm);
 }
=20
 static int fetch_refs(struct transport *transport, struct ref *ref_map=
)
@@ -526,8 +527,9 @@ static int fetch_refs(struct transport *transport, =
struct ref *ref_map)
 		ret =3D transport_fetch_refs(transport, ref_map);
 	if (!ret)
 		ret |=3D store_updated_refs(transport->url,
-				transport->remote->name,
-				ref_map);
+					  transport->remote->name,
+					  ref_map,
+					  transport->pack_lockfile);
 	transport_unlock_pack(transport);
 	return ret;
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0afb8b2..01d37f6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -40,6 +40,7 @@ static int auto_gc =3D 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
+static const char *pack_lockfile;
=20
 static enum deny_action parse_deny_action(const char *var, const char =
*value)
 {
@@ -669,7 +670,7 @@ static void set_connectivity_errors(struct command =
*commands)
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 		struct command *singleton =3D cmd;
 		if (!check_everything_connected(command_singleton_iterator,
-						0, &singleton))
+						0, pack_lockfile, &singleton))
 			continue;
 		cmd->error_string =3D "missing necessary objects";
 	}
@@ -705,7 +706,7 @@ static void execute_commands(struct command *comman=
ds, const char *unpacker_erro
=20
 	cmd =3D commands;
 	if (check_everything_connected(iterate_receive_command_list,
-				       0, &cmd))
+				       0, pack_lockfile, &cmd))
 		set_connectivity_errors(commands);
=20
 	if (run_receive_hook(commands, pre_receive_hook, 0)) {
@@ -797,8 +798,6 @@ static const char *parse_pack_header(struct pack_he=
ader *hdr)
 	}
 }
=20
-static const char *pack_lockfile;
-
 static const char *unpack(void)
 {
 	struct pack_header hdr;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4c4d404..21d714b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -180,8 +180,24 @@ static void finish_object(struct object *obj,
 	struct rev_list_info *info =3D cb_data;
 	if (obj->type =3D=3D OBJ_BLOB && !has_sha1_file(obj->sha1))
 		die("missing blob object '%s'", sha1_to_hex(obj->sha1));
-	if (info->revs->verify_objects && !obj->parsed && obj->type !=3D OBJ_=
COMMIT)
-		parse_object(obj->sha1);
+	if (info->revs->verify_objects &&
+	    !obj->parsed && obj->type !=3D OBJ_COMMIT) {
+		const char *safe_pack =3D info->revs->safe_pack;
+		struct object_info oi;
+		int safe =3D 0;
+		memset(&oi, 0, sizeof(oi));
+		if (*safe_pack &&
+		    sha1_object_info_extended(obj->sha1, &oi) >=3D 0 &&
+		    oi.whence =3D=3D OI_PACKED) {
+			const char *pack =3D oi.u.packed.pack->pack_name;
+			int len =3D strlen(pack);
+			assert(strncmp(pack + len - 51, "/pack-", 6) =3D=3D 0);
+			assert(strcmp(pack + len - 5, ".pack") =3D=3D 0);
+			safe =3D !memcmp(safe_pack, pack + len - 45, 40);
+		}
+		if (!safe)
+			parse_object(obj->sha1);
+	}
 }
=20
 static void show_object(struct object *obj,
diff --git a/connected.c b/connected.c
index d762423..af81049 100644
--- a/connected.c
+++ b/connected.c
@@ -14,28 +14,43 @@
  *
  * Returns 0 if everything is connected, non-zero otherwise.
  */
-int check_everything_connected(sha1_iterate_fn fn, int quiet, void *cb=
_data)
+int check_everything_connected(sha1_iterate_fn fn, unsigned int flags,
+			       const char *pack_lockfile, void *cb_data)
 {
 	struct child_process rev_list;
-	const char *argv[] =3D {"rev-list", "--verify-objects",
-			      "--stdin", "--not", "--all", NULL, NULL};
+	const char *argv[] =3D {"rev-list", "--verify-objects", "--stdin",
+			      "--not", "--all", NULL, NULL, NULL, NULL };
 	char commit[41];
 	unsigned char sha1[20];
-	int err =3D 0;
+	int err =3D 0, ac =3D 5;
+	struct strbuf packfile =3D STRBUF_INIT;
=20
 	if (fn(cb_data, sha1))
 		return err;
=20
-	if (quiet)
-		argv[5] =3D "--quiet";
+	if (flags & CHECK_CONNECT_QUIET)
+		argv[ac++] =3D "--quiet";
+	if (pack_lockfile) {
+		strbuf_addstr(&packfile, pack_lockfile);
+		/* xxx/pack-%40s.keep */
+		assert(strcmp(packfile.buf + packfile.len - 5, ".keep") =3D=3D 0);
+		assert(strncmp(packfile.buf + packfile.len - 51, "/pack-", 6) =3D=3D=
 0);
+		strbuf_setlen(&packfile, packfile.len - 5);
+		strbuf_remove(&packfile, 0, packfile.len - 40);
+		argv[ac++] =3D "--safe-pack";
+		argv[ac++] =3D packfile.buf;
+	}
+	assert(ac < ARRAY_SIZE(argv) && argv[ac] =3D=3D NULL);
=20
 	memset(&rev_list, 0, sizeof(rev_list));
 	rev_list.argv =3D argv;
 	rev_list.git_cmd =3D 1;
 	rev_list.in =3D -1;
 	rev_list.no_stdout =3D 1;
-	rev_list.no_stderr =3D quiet;
-	if (start_command(&rev_list))
+	rev_list.no_stderr =3D flags & CHECK_CONNECT_QUIET;
+	err =3D start_command(&rev_list);
+	strbuf_release(&packfile);
+	if (err)
 		return error(_("Could not run 'git rev-list'"));
=20
 	sigchain_push(SIGPIPE, SIG_IGN);
diff --git a/connected.h b/connected.h
index 7e4585a..ed0b559 100644
--- a/connected.h
+++ b/connected.h
@@ -1,6 +1,8 @@
 #ifndef CONNECTED_H
 #define CONNECTED_H
=20
+#define CHECK_CONNECT_QUIET  1
+
 /*
  * Take callback data, and return next object name in the buffer.
  * When called after returning the name for the last object, return -1
@@ -15,6 +17,7 @@ typedef int (*sha1_iterate_fn)(void *, unsigned char =
[20]);
  *
  * Return 0 if Ok, non zero otherwise (i.e. some missing objects)
  */
-extern int check_everything_connected(sha1_iterate_fn, int quiet, void=
 *cb_data);
+extern int check_everything_connected(sha1_iterate_fn, unsigned int fl=
ags,
+				      const char *pack_lockfile, void *cb_data);
=20
 #endif /* CONNECTED_H */
diff --git a/revision.c b/revision.c
index 819ff01..1c2d017 100644
--- a/revision.c
+++ b/revision.c
@@ -1451,6 +1451,11 @@ static int handle_revision_opt(struct rev_info *=
revs, int argc, const char **arg
 		revs->tree_objects =3D 1;
 		revs->blob_objects =3D 1;
 		revs->verify_objects =3D 1;
+	} else if (!strcmp(arg, "--safe-pack")) {
+		if (strlen(argv[1]) !=3D 40)
+			die("--safe-pack requires an SHA-1 as pack id, not %s", argv[1]);
+		strcpy(revs->safe_pack, argv[1]);
+		return 2;
 	} else if (!strcmp(arg, "--unpacked")) {
 		revs->unpacked =3D 1;
 	} else if (!prefixcmp(arg, "--unpacked=3D")) {
diff --git a/revision.h b/revision.h
index b8e9223..2790910 100644
--- a/revision.h
+++ b/revision.h
@@ -168,6 +168,9 @@ struct rev_info {
 	int count_left;
 	int count_right;
 	int count_same;
+
+	/* --verify-objects */
+	char safe_pack[41];
 };
=20
 #define REV_TREE_SAME		0
--=20
1.7.8.36.g69ee2
