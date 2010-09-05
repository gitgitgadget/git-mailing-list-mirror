From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/17] {fetch,upload}-pack: support narrow repository
Date: Sun,  5 Sep 2010 16:47:33 +1000
Message-ID: <1283669264-15759-7-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:49:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os92U-00082P-Dt
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab0IEGtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:49:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37408 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0IEGtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:49:10 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so1040881pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=bW0ErX9E+UQGQiCqOKzxyHmJlbgAfGHgk6KqBFg1gm4=;
        b=mh2U7YfPlv49iqjgpnQdc1S6vLRdSeUzhyLohHUPHDeD+ABtFrmuW4fG5lSukn6Y43
         Kpsh4qiMdrS4YT1JMntnchmngtxxTfbjtqRlmwY+oq1587PEVrU7os+NevoeByZuw3Wz
         Co21VD/6F4BfZHsYpCMcoQoZCegGiMpARAGA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VqTZtDhwrSpAdPVQAP7etaX8y2WC2gmDwVEnxSCW4uWI/WO3u53OXROcKjX3CepA0I
         eBZNiPISxhlfNaTO13tdq7QU6VkLeOH+K31Rj5b+RBCXaiNnRsXW2SN4mRoRkAKvEsTT
         OWMEC5VuQLateCVFUTJM/fmaVCkKyoC1UUZ44=
Received: by 10.114.24.3 with SMTP id 3mr1173525wax.31.1283669350606;
        Sat, 04 Sep 2010 23:49:10 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id q6sm8036344waj.22.2010.09.04.23.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:49:09 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:48:59 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155432>

If $GIT_DIR/narrow is set, fetch-pack will send "narrow-tree" lines to
upload-pack, where the prefixes are passed to rev-list mechanism to
produce a narrow pack.

"narrow-tree" capability is required for this to work.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-fetch-pack.txt          |    3 ++
 Documentation/technical/pack-protocol.txt |    3 ++
 builtin/fetch-pack.c                      |    9 +++++++
 upload-pack.c                             |   38 +++++++++++++++++++++=
++++++-
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 4a8487c..19b0d92 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -25,6 +25,9 @@ This command degenerates to download everything to co=
mplete the
 asked refs from the remote side when the local side does not
 have a common ancestor commit.
=20
+In narrow repositories, it asks 'git-upload-pack' to send only objects
+within narrow area defined in $GIT_DIR/narrow.
+
=20
 OPTIONS
 -------
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index 369f91d..39474d2 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -215,6 +215,9 @@ discovery phase as 'want' lines. Clients MUST send =
at least one
 obj-id in a 'want' command which did not appear in the response
 obtained through ref discovery.
=20
+If client is requesting narrow clone, it must send 'narrow-tree'
+lines before 'want' lines.
+
 If client is requesting a shallow clone, it will now send a 'deepen'
 line with the depth it is requesting.
=20
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..591e0e4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -37,6 +37,7 @@ static int marked;
=20
 static struct commit_list *rev_list;
 static int non_common_revs, multi_ack, use_sideband;
+const char **narrow_prefix;
=20
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -237,6 +238,12 @@ static int find_common(int fd[2], unsigned char *r=
esult_sha1,
 	for_each_ref(rev_list_insert_ref, NULL);
=20
 	fetching =3D 0;
+	narrow_prefix =3D get_narrow_prefix();
+	if (narrow_prefix) {
+		const char **p =3D narrow_prefix;
+		while (*p)
+			packet_buf_write(&req_buf, "narrow-tree %s\n", *p++);
+	}
 	for ( ; refs ; refs =3D refs->next) {
 		unsigned char *remote =3D refs->old_sha1;
 		const char *remote_hex;
@@ -692,6 +699,8 @@ static struct ref *do_fetch_pack(int fd[2],
=20
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
+	if (narrow_prefix && !server_supports("narrow-tree"))
+		die("Server does not support narrow-tree");
 	if (server_supports("multi_ack_detailed")) {
 		if (args.verbose)
 			fprintf(stderr, "Server supports multi_ack_detailed\n");
diff --git a/upload-pack.c b/upload-pack.c
index cc1983f..f3747e5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -41,6 +41,8 @@ static int use_sideband;
 static int debug_fd;
 static int advertise_refs;
 static int stateless_rpc;
+const char **narrow_prefix;
+int narrow_prefix_nr;
=20
 static void reset_timeout(void)
 {
@@ -118,6 +120,10 @@ static int do_rev_list(int in, int out, void *user=
_data)
 	revs.simplify_history =3D 0;
 	if (use_thin_pack)
 		revs.edge_hint =3D 1;
+	if (narrow_prefix) {
+		revs.prune_data =3D narrow_prefix;
+		narrow_prefix[narrow_prefix_nr] =3D NULL;
+	}
=20
 	for (i =3D 0; i < want_obj.nr; i++) {
 		struct object *o =3D want_obj.objects[i].item;
@@ -154,9 +160,10 @@ static void create_pack_file(void)
 		"corruption on the remote side.";
 	int buffered =3D -1;
 	ssize_t sz;
-	const char *argv[10];
+	const char **argv;
 	int arg =3D 0;
=20
+	argv =3D xmalloc(sizeof(*argv)*(11+narrow_prefix_nr));
 	if (shallow_nr) {
 		memset(&rev_list, 0, sizeof(rev_list));
 		rev_list.proc =3D do_rev_list;
@@ -180,6 +187,11 @@ static void create_pack_file(void)
 		argv[arg++] =3D "--delta-base-offset";
 	if (use_include_tag)
 		argv[arg++] =3D "--include-tag";
+	if (narrow_prefix) {
+		argv[arg++] =3D "--";
+		memcpy(argv+arg, narrow_prefix, narrow_prefix_nr*sizeof(*argv));
+		arg +=3D narrow_prefix_nr;
+	}
 	argv[arg++] =3D NULL;
=20
 	memset(&pack_objects, 0, sizeof(pack_objects));
@@ -307,6 +319,7 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
+	free(argv);
 	if (shallow_nr && finish_async(&rev_list))
 		goto fail;	/* error was already reported */
=20
@@ -500,6 +513,22 @@ static void receive_needs(void)
 		if (debug_fd)
 			write_in_full(debug_fd, line, len);
=20
+		if (!prefixcmp(line, "narrow-tree ")) {
+			char *s;
+			int len;
+			len =3D strlen(line+12);
+			s =3D malloc(len+1);
+			memcpy(s, line+12, len-1);
+			s[len-1] =3D '\0'; /* \n */
+			if (s[len-2] =3D=3D '/')
+				die("trailing slash in narrow prefix not allowed, %s", line);
+
+			narrow_prefix_nr++;
+			narrow_prefix =3D xrealloc(narrow_prefix,
+						 sizeof(*narrow_prefix)*(narrow_prefix_nr+1));
+			narrow_prefix[narrow_prefix_nr-1] =3D s;
+			continue;
+		}
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
@@ -563,6 +592,9 @@ static void receive_needs(void)
 	if (!use_sideband && daemon_mode)
 		no_progress =3D 1;
=20
+	if (narrow_prefix)
+		use_thin_pack =3D 0;
+
 	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
 		return;
 	if (depth > 0) {
@@ -620,7 +652,7 @@ static int send_ref(const char *refname, const unsi=
gned char *sha1, int flag, vo
 {
 	static const char *capabilities =3D "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed narrow-tree";
 	struct object *o =3D parse_object(sha1);
=20
 	if (!o)
@@ -725,6 +757,8 @@ int main(int argc, char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 	if (is_repository_shallow())
 		die("attempt to fetch/clone from a shallow repository");
+	if (get_narrow_prefix())
+		die("attempt to fetch/clone from a narrow repository");
 	if (getenv("GIT_DEBUG_SEND_PACK"))
 		debug_fd =3D atoi(getenv("GIT_DEBUG_SEND_PACK"));
 	upload_pack();
--=20
1.7.1.rc1.69.g24c2f7
