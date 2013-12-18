From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/12] Convert a lot of starts_with() to skip_prefix()
Date: Wed, 18 Dec 2013 21:53:50 +0700
Message-ID: <1387378437-20646-6-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:54:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIWH-0003dM-C2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab3LROyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:54:36 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38998 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab3LROyf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:35 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so8339759pdj.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YaI2/eAZLHX7k+EQ9WDkSSnH88z1SwAKVzo6iyoLOYw=;
        b=Jok4I9hD9WhIlO0Ys+rMzgkURHOTSqFuyiInz3jcIv5IfGVlyKUoq7JHdet7WHnCKn
         OSPITvifz0+bNvySPhFMsfkBTXcwXM11hPmWvXCd6HIlAkRP6as5L1ALfgP3jzoLhM/w
         DRs1BGII9HUkI54aWDeTKQY5d+l31MKrmUZq29dbhknsfqKjhVoohOIj70UC7w9Zju0v
         JXp8z5NxpV72hBZMT0c13Vr2FZwfPn0v3RQ9/YCkwbxxqIiNtVgdL8s8dtUtjvHRFji9
         FWwhTOLm7EO0XT9HGy8B6csR+0yyley48vdCzu35e4a7omCujezitFPTPWdjHtjpeyF3
         TgBQ==
X-Received: by 10.68.231.166 with SMTP id th6mr34218167pbc.27.1387378474453;
        Wed, 18 Dec 2013 06:54:34 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id wp8sm537717pbc.26.2013.12.18.06.54.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:54:31 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239444>

The purpose is remove hard coded string length. Some could be a few
lines away from the string comparison and easy to be missed when the
string is changed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/for-each-ref.c |  9 +++++----
 builtin/mailinfo.c     |  6 +++---
 builtin/merge.c        |  8 +++++---
 builtin/remote.c       |  3 +--
 commit.c               |  5 +----
 diff.c                 |  9 +++------
 fetch-pack.c           |  9 +++++----
 http-backend.c         |  5 +++--
 http-push.c            |  6 +++---
 http.c                 |  5 +++--
 log-tree.c             |  5 +++--
 pager.c                |  2 +-
 pathspec.c             |  5 +++--
 refs.c                 | 12 +++++++-----
 sha1_name.c            | 12 +++---------
 transport-helper.c     | 15 +++++++--------
 transport.c            | 14 ++++++++------
 17 files changed, 64 insertions(+), 66 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6551e7b..25c1388 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -662,6 +662,7 @@ static void populate_value(struct refinfo *ref)
 		const char *refname;
 		const char *formatp;
 		struct branch *branch =3D NULL;
+		const char *next;
=20
 		if (*name =3D=3D '*') {
 			deref =3D 1;
@@ -674,18 +675,18 @@ static void populate_value(struct refinfo *ref)
 			refname =3D ref->symref ? ref->symref : "";
 		else if (starts_with(name, "upstream")) {
 			/* only local branches may have an upstream */
-			if (!starts_with(ref->refname, "refs/heads/"))
+			if ((next =3D skip_prefix(ref->refname, "refs/heads/")) =3D=3D NULL=
)
 				continue;
-			branch =3D branch_get(ref->refname + 11);
+			branch =3D branch_get(next);
=20
 			if (!branch || !branch->merge || !branch->merge[0] ||
 			    !branch->merge[0]->dst)
 				continue;
 			refname =3D branch->merge[0]->dst;
-		} else if (starts_with(name, "color:")) {
+		} else if ((next =3D skip_prefix(name, "color:")) !=3D NULL) {
 			char color[COLOR_MAXLEN] =3D "";
=20
-			color_parse(name + 6, "--format", color);
+			color_parse(next, "--format", color);
 			v->s =3D xstrdup(color);
 			continue;
 		} else if (!strcmp(name, "flag")) {
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2100e23..daaafbd 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -328,13 +328,13 @@ static int check_header(const struct strbuf *line=
,
 	}
=20
 	/* for inbody stuff */
-	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
+	if (isspace(*skip_prefix_defval(line->buf, ">From", "NOSPACE"))) {
 		ret =3D 1; /* Should this return 0? */
 		goto check_header_out;
 	}
-	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
+	if (isspace(*skip_prefix_defval(line->buf, "[PATCH]", "NOSPACE"))) {
 		for (i =3D 0; header[i]; i++) {
-			if (!memcmp("Subject", header[i], 7)) {
+			if (starts_with(header[i], "Subject")) {
 				handle_header(&hdr_data[i], line);
 				ret =3D 1;
 				goto check_header_out;
diff --git a/builtin/merge.c b/builtin/merge.c
index 590d907..603f80a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -569,10 +569,12 @@ static void parse_branch_merge_options(char *bmo)
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
 	int status;
+	const char *kk, *kkk;
=20
-	if (branch && starts_with(k, "branch.") &&
-		starts_with(k + 7, branch) &&
-		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
+	if (branch &&
+	    (kk =3D skip_prefix(k, "branch.")) !=3D NULL &&
+	    (kkk =3D skip_prefix(kk, branch)) !=3D NULL &&
+	    !strcmp(kkk, ".mergeoptions")) {
 		free(branch_mergeoptions);
 		branch_mergeoptions =3D xstrdup(v);
 		return 0;
diff --git a/builtin/remote.c b/builtin/remote.c
index b3ab4cf..218c8c8 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -259,14 +259,13 @@ static const char *abbrev_ref(const char *name, c=
onst char *prefix)
=20
 static int config_read_branches(const char *key, const char *value, vo=
id *cb)
 {
-	if (starts_with(key, "branch.")) {
+	if ((key =3D skip_prefix(key, "branch.")) !=3D NULL) {
 		const char *orig_key =3D key;
 		char *name;
 		struct string_list_item *item;
 		struct branch_info *info;
 		enum { REMOTE, MERGE, REBASE } type;
=20
-		key +=3D 7;
 		if (ends_with(key, ".remote")) {
 			name =3D xstrndup(key, strlen(key) - 7);
 			type =3D REMOTE;
diff --git a/commit.c b/commit.c
index 5df1df7..eed2ff9 100644
--- a/commit.c
+++ b/commit.c
@@ -1193,10 +1193,7 @@ static void parse_gpg_output(struct signature_ch=
eck *sigc)
 	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 		const char *found, *next;
=20
-		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
-			/* At the very beginning of the buffer */
-			found =3D buf + strlen(sigcheck_gpg_status[i].check + 1);
-		} else {
+		if ((found =3D skip_prefix(buf, sigcheck_gpg_status[i].check + 1)) =3D=
=3D NULL) {
 			found =3D strstr(buf, sigcheck_gpg_status[i].check);
 			if (!found)
 				continue;
diff --git a/diff.c b/diff.c
index 90a1929..d754e2f 100644
--- a/diff.c
+++ b/diff.c
@@ -3388,13 +3388,10 @@ static inline int short_opt(char opt, const cha=
r **argv,
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg)
 {
-	const char *arg =3D argv[0];
-	if (arg[0] !=3D '-' || arg[1] !=3D '-')
-		return 0;
-	arg +=3D strlen("--");
-	if (!starts_with(arg, opt))
+	const char *arg;
+	if ((arg =3D skip_prefix(argv[0], "--")) =3D=3D NULL ||
+	    (arg =3D skip_prefix(arg, opt)) =3D=3D NULL)
 		return 0;
-	arg +=3D strlen(opt);
 	if (*arg =3D=3D '=3D') { /* stuck form: --option=3Dvalue */
 		*optarg =3D arg + 1;
 		return 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index 760ed16..723ff06 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -317,18 +317,19 @@ static int find_common(struct fetch_pack_args *ar=
gs,
=20
 	if (args->depth > 0) {
 		char *line;
+		const char *sha1_str;
 		unsigned char sha1[20];
=20
 		send_request(args, fd[1], &req_buf);
 		while ((line =3D packet_read_line(fd[0], NULL))) {
-			if (starts_with(line, "shallow ")) {
-				if (get_sha1_hex(line + 8, sha1))
+			if ((sha1_str =3D skip_prefix(line, "shallow ")) !=3D NULL) {
+				if (get_sha1_hex(sha1_str, sha1))
 					die("invalid shallow line: %s", line);
 				register_shallow(sha1);
 				continue;
 			}
-			if (starts_with(line, "unshallow ")) {
-				if (get_sha1_hex(line + 10, sha1))
+			if ((sha1_str =3D skip_prefix(line, "unshallow ")) !=3D NULL) {
+				if (get_sha1_hex(sha1_str, sha1))
 					die("invalid unshallow line: %s", line);
 				if (!lookup_object(sha1))
 					die("object not found: %s", line);
diff --git a/http-backend.c b/http-backend.c
index d2c0a62..e780c55 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -221,17 +221,18 @@ static void get_idx_file(char *name)
=20
 static int http_config(const char *var, const char *value, void *cb)
 {
+	const char *p;
 	if (!strcmp(var, "http.getanyfile")) {
 		getanyfile =3D git_config_bool(var, value);
 		return 0;
 	}
=20
-	if (starts_with(var, "http.")) {
+	if ((p =3D skip_prefix(var, "http.")) !=3D NULL) {
 		int i;
=20
 		for (i =3D 0; i < ARRAY_SIZE(rpc_service); i++) {
 			struct rpc_service *svc =3D &rpc_service[i];
-			if (!strcmp(var + 5, svc->config_name)) {
+			if (!strcmp(p, svc->config_name)) {
 				svc->enabled =3D git_config_bool(var, value);
 				return 0;
 			}
diff --git a/http-push.c b/http-push.c
index d4b40c9..5db6f28 100644
--- a/http-push.c
+++ b/http-push.c
@@ -771,9 +771,9 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx=
, int tag_closed)
 			lock->owner =3D xmalloc(strlen(ctx->cdata) + 1);
 			strcpy(lock->owner, ctx->cdata);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TIMEOUT)) {
-			if (starts_with(ctx->cdata, "Second-"))
-				lock->timeout =3D
-					strtol(ctx->cdata + 7, NULL, 10);
+			const char *p;
+			if ((p =3D skip_prefix(ctx->cdata, "Second-")) !=3D NULL)
+				lock->timeout =3D strtol(p, NULL, 10);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
 			lock->token =3D xmalloc(strlen(ctx->cdata) + 1);
 			strcpy(lock->token, ctx->cdata);
diff --git a/http.c b/http.c
index 70eaa26..1120ed2 100644
--- a/http.c
+++ b/http.c
@@ -1098,6 +1098,7 @@ int http_fetch_ref(const char *base, struct ref *=
ref)
 	char *url;
 	struct strbuf buffer =3D STRBUF_INIT;
 	int ret =3D -1;
+	const char *p;
=20
 	options.no_cache =3D 1;
=20
@@ -1106,8 +1107,8 @@ int http_fetch_ref(const char *base, struct ref *=
ref)
 		strbuf_rtrim(&buffer);
 		if (buffer.len =3D=3D 40)
 			ret =3D get_sha1_hex(buffer.buf, ref->old_sha1);
-		else if (starts_with(buffer.buf, "ref: ")) {
-			ref->symref =3D xstrdup(buffer.buf + 5);
+		else if ((p =3D skip_prefix(buffer.buf, "ref: ")) !=3D NULL) {
+			ref->symref =3D xstrdup(p);
 			ret =3D 0;
 		}
 	}
diff --git a/log-tree.c b/log-tree.c
index 642faff..cef7c8d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -96,13 +96,14 @@ static void add_name_decoration(enum decoration_typ=
e type, const char *name, str
 static int add_ref_decoration(const char *refname, const unsigned char=
 *sha1, int flags, void *cb_data)
 {
 	struct object *obj;
+	const char *name;
 	enum decoration_type type =3D DECORATION_NONE;
=20
-	if (starts_with(refname, "refs/replace/")) {
+	if ((name =3D skip_prefix(refname, "refs/replace/")) !=3D NULL) {
 		unsigned char original_sha1[20];
 		if (!read_replace_refs)
 			return 0;
-		if (get_sha1_hex(refname + 13, original_sha1)) {
+		if (get_sha1_hex(name, original_sha1)) {
 			warning("invalid replace ref %s", refname);
 			return 0;
 		}
diff --git a/pager.c b/pager.c
index 345b0bc..175cd9f 100644
--- a/pager.c
+++ b/pager.c
@@ -151,7 +151,7 @@ int decimal_width(int number)
 static int pager_command_config(const char *var, const char *value, vo=
id *data)
 {
 	struct pager_config *c =3D data;
-	if (starts_with(var, "pager.") && !strcmp(var + 6, c->cmd)) {
+	if (!strcmp(skip_prefix_defval(var, "pager.", ""), c->cmd)) {
 		int b =3D git_config_maybe_bool(var, value);
 		if (b >=3D 0)
 			c->want =3D b;
diff --git a/pathspec.c b/pathspec.c
index 52d38a4..e15f215 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -149,14 +149,15 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
 			if (!len)
 				continue;
 			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+				const char *prefix_str;
 				if (strlen(pathspec_magic[i].name) =3D=3D len &&
 				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
 					magic |=3D pathspec_magic[i].bit;
 					break;
 				}
-				if (starts_with(copyfrom, "prefix:")) {
+				if ((prefix_str =3D skip_prefix(copyfrom, "prefix:")) !=3D NULL) {
 					char *endptr;
-					pathspec_prefix =3D strtol(copyfrom + 7,
+					pathspec_prefix =3D strtol(prefix_str,
 								 &endptr, 10);
 					if (endptr - copyfrom !=3D len)
 						die(_("invalid parameter for pathspec magic 'prefix'"));
diff --git a/refs.c b/refs.c
index 3926136..5e378bc 100644
--- a/refs.c
+++ b/refs.c
@@ -1873,11 +1873,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_da=
ta)
=20
 const char *prettify_refname(const char *name)
 {
-	return name + (
-		starts_with(name, "refs/heads/") ? 11 :
-		starts_with(name, "refs/tags/") ? 10 :
-		starts_with(name, "refs/remotes/") ? 13 :
-		0);
+	const char *p;
+	if ((p =3D skip_prefix(name, "refs/heads/")) !=3D NULL ||
+	    (p =3D skip_prefix(name, "refs/tags/")) !=3D NULL ||
+	    (p =3D skip_prefix(name, "refs/remotes/")) !=3D NULL)
+		return p;
+	else
+		return name;
 }
=20
 const char *ref_rev_parse_rules[] =3D {
diff --git a/sha1_name.c b/sha1_name.c
index b1873d8..3fc4ede 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -546,14 +546,10 @@ static int get_sha1_basic(const char *str, int le=
n, unsigned char *sha1)
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
-				if (starts_with(real_ref, "refs/heads/")) {
-					str =3D real_ref + 11;
-					len =3D strlen(real_ref + 11);
-				} else {
+				if ((str =3D skip_prefix(real_ref, "refs/heads/")) =3D=3D NULL)
 					/* detached HEAD */
 					str =3D "HEAD";
-					len =3D 4;
-				}
+				len =3D strlen(str);
 			}
 			if (at_time)
 				warning("Log for '%.*s' only goes "
@@ -909,10 +905,8 @@ static int grab_nth_branch_switch(unsigned char *o=
sha1, unsigned char *nsha1,
 	const char *match =3D NULL, *target =3D NULL;
 	size_t len;
=20
-	if (starts_with(message, "checkout: moving from ")) {
-		match =3D message + strlen("checkout: moving from ");
+	if ((match =3D skip_prefix(message, "checkout: moving from ")) !=3D N=
ULL)
 		target =3D strstr(match, " to ");
-	}
=20
 	if (!match || !target)
 		return 0;
diff --git a/transport-helper.c b/transport-helper.c
index 2010674..601aba8 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -373,10 +373,10 @@ static int fetch_with_fetch(struct transport *tra=
nsport,
 	sendline(data, &buf);
=20
 	while (1) {
+		const char *name;
 		recvline(data, &buf);
=20
-		if (starts_with(buf.buf, "lock ")) {
-			const char *name =3D buf.buf + 5;
+		if ((name =3D skip_prefix(buf.buf, "lock ")) !=3D NULL) {
 			if (transport->pack_lockfile)
 				warning("%s also locked %s", data->name, name);
 			else
@@ -643,16 +643,15 @@ static int push_update_ref_status(struct strbuf *=
buf,
 				   struct ref **ref,
 				   struct ref *remote_refs)
 {
-	char *refname, *msg;
+	const char *refname;
+	char *msg;
 	int status;
=20
-	if (starts_with(buf->buf, "ok ")) {
+	if ((refname =3D skip_prefix(buf->buf, "ok ")) !=3D NULL)
 		status =3D REF_STATUS_OK;
-		refname =3D buf->buf + 3;
-	} else if (starts_with(buf->buf, "error ")) {
+	else if ((refname =3D skip_prefix(buf->buf, "error ")) !=3D NULL)
 		status =3D REF_STATUS_REMOTE_REJECT;
-		refname =3D buf->buf + 6;
-	} else
+	else
 		die("expected ok/error, helper said '%s'", buf->buf);
=20
 	msg =3D strchr(refname, ' ');
diff --git a/transport.c b/transport.c
index 824c5b9..e88c2dc 100644
--- a/transport.c
+++ b/transport.c
@@ -147,9 +147,9 @@ static void set_upstreams(struct transport *transpo=
rt, struct ref *refs,
 {
 	struct ref *ref;
 	for (ref =3D refs; ref; ref =3D ref->next) {
-		const char *localname;
+		const char *localname, *short_local;
 		const char *tmp;
-		const char *remotename;
+		const char *remotename, *short_remote;
 		unsigned char sha[20];
 		int flag =3D 0;
 		/*
@@ -173,18 +173,20 @@ static void set_upstreams(struct transport *trans=
port, struct ref *refs,
 			localname =3D tmp;
=20
 		/* Both source and destination must be local branches. */
-		if (!localname || !starts_with(localname, "refs/heads/"))
+		if (!localname ||
+		    (short_local =3D skip_prefix(localname, "refs/heads/")) =3D=3D N=
ULL)
 			continue;
-		if (!remotename || !starts_with(remotename, "refs/heads/"))
+		if (!remotename ||
+		    (short_remote =3D skip_prefix(remotename, "refs/heads/")) =3D=3D=
 NULL)
 			continue;
=20
 		if (!pretend)
 			install_branch_config(BRANCH_CONFIG_VERBOSE,
-				localname + 11, transport->remote->name,
+				short_local, transport->remote->name,
 				remotename);
 		else
 			printf("Would set upstream of '%s' to '%s' of '%s'\n",
-				localname + 11, remotename + 11,
+				short_local, short_remote,
 				transport->remote->name);
 	}
 }
--=20
1.8.5.1.208.g019362e
