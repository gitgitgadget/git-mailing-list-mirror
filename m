From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 00/12] Hard coded string length cleanup
Date: Fri, 20 Dec 2013 00:32:35 +0100
Message-ID: <52B38213.2070702@web.de>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 20 00:33:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtn5M-0007Sg-9N
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 00:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700Ab3LSXcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Dec 2013 18:32:52 -0500
Received: from mout.web.de ([212.227.17.11]:60306 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756572Ab3LSXcu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 18:32:50 -0500
Received: from [192.168.178.27] ([79.253.137.64]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M2unu-1VcfyR0k4M-00sgSa for <git@vger.kernel.org>;
 Fri, 20 Dec 2013 00:32:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:5ufhoMkQuMlqDfc/2g4qkaLPj/Q4U0dSk+LEx7LVmSq0ilaxK3C
 /DsN/FnzGq2WhOlUTYCnrAqFbpSr6bT7unPfFjwngWoarzD5/87PHR0oz6hrKLYF3n5718M
 QIQHIHLiltlXJasX8qeznd/Os0AByfxUPFkvAAmZ5dC8ZinKV+L3l+yFusfQROc9d16+S1L
 +zXtw8lJJmUL6lruvJaHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239555>

Am 18.12.2013 15:53, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> I reimplemented skip_prefix() again just to realize this function
> already exists. Which reminds me there are a bunch of places that
> could benefit from this function, the same reason that I wanted to
> reimplement it.
>=20
> So this is series to make it more popular (so hopefully I'll see it
> used somewhere and know that it exists) and the code cleaner. The
> pattern "compare a string, then skip the compared part by a hard code=
d
> string length" is almost killed. I left a few in places for those who
> want to contribute :)

Good idea.

Seeing that skip_prefix_defval is mostly used in the form
skip_prefix_defval(foo, prefix, foo) I wonder if it makes sense to
first change skip_prefix to return the full string instead of NULL
if the prefix is not matched.  Would the resulting function cover
most use cases?  And would it still be easily usable?

---
 advice.c                   |  2 ++
 builtin/branch.c           |  6 +++---
 builtin/clone.c            |  6 ++++--
 builtin/commit.c           |  6 ++----
 builtin/fmt-merge-msg.c    |  6 +++---
 builtin/push.c             |  2 --
 builtin/remote.c           | 13 +++----------
 column.c                   |  2 +-
 config.c                   |  2 +-
 credential-cache--daemon.c |  4 ++--
 credential.c               |  2 +-
 git-compat-util.h          |  7 +------
 parse-options.c            | 11 ++++++-----
 strbuf.c                   | 10 ++++++++++
 transport.c                |  6 +++++-
 urlmatch.c                 |  2 +-
 16 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/advice.c b/advice.c
index 3eca9f5..1f85338 100644
--- a/advice.c
+++ b/advice.c
@@ -66,6 +66,8 @@ int git_default_advice_config(const char *var, const =
char *value)
 	const char *k =3D skip_prefix(var, "advice.");
 	int i;
=20
+	if (k =3D=3D var)
+		return 0;
 	for (i =3D 0; i < ARRAY_SIZE(advice_config); i++) {
 		if (strcmp(k, advice_config[i].name))
 			continue;
diff --git a/builtin/branch.c b/builtin/branch.c
index b4d7716..d3694d0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -294,13 +294,13 @@ static char *resolve_symref(const char *src, cons=
t char *prefix)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *dst, *cp;
+	const char *dst;
=20
 	dst =3D resolve_ref_unsafe(src, sha1, 0, &flag);
 	if (!(dst && (flag & REF_ISSYMREF)))
 		return NULL;
-	if (prefix && (cp =3D skip_prefix(dst, prefix)))
-		dst =3D cp;
+	if (prefix)
+		dst =3D skip_prefix(dst, prefix);
 	return xstrdup(dst);
 }
=20
diff --git a/builtin/clone.c b/builtin/clone.c
index f98f529..79f24cd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -578,11 +578,13 @@ static void update_remote_refs(const struct ref *=
refs,
 static void update_head(const struct ref *our, const struct ref *remot=
e,
 			const char *msg)
 {
-	if (our && starts_with(our->name, "refs/heads/")) {
+	const char *head;
+
+	if (our &&
+	    ((head =3D skip_prefix(our->name, "refs/heads/")) !=3D our->name)=
) {
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
-			const char *head =3D skip_prefix(our->name, "refs/heads/");
 			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
 		}
diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..c18a77d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -934,7 +934,7 @@ static int message_is_empty(struct strbuf *sb)
 static int template_untouched(struct strbuf *sb)
 {
 	struct strbuf tmpl =3D STRBUF_INIT;
-	char *start;
+	const char *start;
=20
 	if (cleanup_mode =3D=3D CLEANUP_NONE && sb->len)
 		return 0;
@@ -943,9 +943,7 @@ static int template_untouched(struct strbuf *sb)
 		return 0;
=20
 	stripspace(&tmpl, cleanup_mode =3D=3D CLEANUP_ALL);
-	start =3D (char *)skip_prefix(sb->buf, tmpl.buf);
-	if (!start)
-		start =3D sb->buf;
+	start =3D skip_prefix(sb->buf, tmpl.buf);
 	strbuf_release(&tmpl);
 	return rest_is_empty(sb, start - sb->buf);
 }
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3906eda..ff34c62 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -284,7 +284,7 @@ static void credit_people(struct strbuf *out,
 			  int kind)
 {
 	const char *label;
-	const char *me;
+	const char *me, *p;
=20
 	if (kind =3D=3D 'a') {
 		label =3D "By";
@@ -297,8 +297,8 @@ static void credit_people(struct strbuf *out,
 	if (!them->nr ||
 	    (them->nr =3D=3D 1 &&
 	     me &&
-	     (me =3D skip_prefix(me, them->items->string)) !=3D NULL &&
-	     skip_prefix(me, " <")))
+	     (p =3D skip_prefix(me, them->items->string)) !=3D me &&
+	     starts_with(p, " <")))
 		return;
 	strbuf_addf(out, "\n%c %s ", comment_line_char, label);
 	add_people_count(out, them);
diff --git a/builtin/push.c b/builtin/push.c
index a73982a..2852a46 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -91,8 +91,6 @@ static NORETURN int die_push_simple(struct branch *br=
anch, struct remote *remote
 	const char *short_upstream =3D
 		skip_prefix(branch->merge[0]->src, "refs/heads/");
=20
-	if (!short_upstream)
-		short_upstream =3D branch->merge[0]->src;
 	/*
 	 * Don't show advice for people who explicitly set
 	 * push.default.
diff --git a/builtin/remote.c b/builtin/remote.c
index b3ab4cf..1f5dfbe 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -248,14 +248,7 @@ struct branch_info {
=20
 static struct string_list branch_list;
=20
-static const char *abbrev_ref(const char *name, const char *prefix)
-{
-	const char *abbrev =3D skip_prefix(name, prefix);
-	if (abbrev)
-		return abbrev;
-	return name;
-}
-#define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
+#define abbrev_branch(name) skip_prefix((name), "refs/heads/")
=20
 static int config_read_branches(const char *key, const char *value, vo=
id *cb)
 {
@@ -1326,10 +1319,10 @@ static int prune_remote(const char *remote, int=
 dry_run)
=20
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
-			       abbrev_ref(refname, "refs/remotes/"));
+			       skip_prefix(refname, "refs/remotes/"));
 		else
 			printf_ln(_(" * [pruned] %s"),
-			       abbrev_ref(refname, "refs/remotes/"));
+			       skip_prefix(refname, "refs/remotes/"));
 		warn_dangling_symref(stdout, dangling_msg, refname);
 	}
=20
diff --git a/column.c b/column.c
index 9367ba5..7de051d 100644
--- a/column.c
+++ b/column.c
@@ -337,7 +337,7 @@ int git_column_config(const char *var, const char *=
value,
 		      const char *command, unsigned int *colopts)
 {
 	const char *it =3D skip_prefix(var, "column.");
-	if (!it)
+	if (it =3D=3D var)
 		return 0;
=20
 	if (!strcmp(it, "ui"))
diff --git a/config.c b/config.c
index d969a5a..b787f8d 100644
--- a/config.c
+++ b/config.c
@@ -134,7 +134,7 @@ int git_config_include(const char *var, const char =
*value, void *data)
 		return ret;
=20
 	type =3D skip_prefix(var, "include.");
-	if (!type)
+	if (type =3D=3D var)
 		return ret;
=20
 	if (!strcmp(type, "path"))
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 390f194..21aad75 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -110,13 +110,13 @@ static int read_request(FILE *fh, struct credenti=
al *c,
=20
 	strbuf_getline(&item, fh, '\n');
 	p =3D skip_prefix(item.buf, "action=3D");
-	if (!p)
+	if (p =3D=3D item.buf)
 		return error("client sent bogus action line: %s", item.buf);
 	strbuf_addstr(action, p);
=20
 	strbuf_getline(&item, fh, '\n');
 	p =3D skip_prefix(item.buf, "timeout=3D");
-	if (!p)
+	if (p =3D=3D item.buf)
 		return error("client sent bogus timeout line: %s", item.buf);
 	*timeout =3D atoi(p);
=20
diff --git a/credential.c b/credential.c
index e54753c..466beff 100644
--- a/credential.c
+++ b/credential.c
@@ -41,7 +41,7 @@ static int credential_config_callback(const char *var=
, const char *value,
 	const char *key, *dot;
=20
 	key =3D skip_prefix(var, "credential.");
-	if (!key)
+	if (key =3D=3D var)
 		return 0;
=20
 	if (!value)
diff --git a/git-compat-util.h b/git-compat-util.h
index b73916b..dcb92c4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -354,12 +354,7 @@ extern int starts_with(const char *str, const char=
 *prefix);
 extern int prefixcmp(const char *str, const char *prefix);
 extern int ends_with(const char *str, const char *suffix);
 extern int suffixcmp(const char *str, const char *suffix);
-
-static inline const char *skip_prefix(const char *str, const char *pre=
fix)
-{
-	size_t len =3D strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
-}
+extern const char *skip_prefix(const char *str, const char *prefix);
=20
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
=20
diff --git a/parse-options.c b/parse-options.c
index 7b8d3fa..4ec2fa3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -240,7 +240,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p=
, const char *arg,
 again:
 		rest =3D skip_prefix(arg, long_name);
 		if (options->type =3D=3D OPTION_ARGUMENT) {
-			if (!rest)
+			if (rest =3D=3D arg)
 				continue;
 			if (*rest =3D=3D '=3D')
 				return opterror(options, "takes no value", flags);
@@ -249,7 +249,7 @@ again:
 			p->out[p->cpidx++] =3D arg - 2;
 			return 0;
 		}
-		if (!rest) {
+		if (rest =3D=3D arg) {
 			/* abbreviated? */
 			if (!strncmp(long_name, arg, arg_end - arg)) {
 is_abbreviated:
@@ -289,10 +289,11 @@ is_abbreviated:
 			flags |=3D OPT_UNSET;
 			rest =3D skip_prefix(arg + 3, long_name);
 			/* abbreviated and negated? */
-			if (!rest && starts_with(long_name, arg + 3))
-				goto is_abbreviated;
-			if (!rest)
+			if (rest =3D=3D arg + 3) {
+				if (starts_with(long_name, arg + 3))
+					goto is_abbreviated;
 				continue;
+			}
 		}
 		if (*rest) {
 			if (*rest !=3D '=3D')
diff --git a/strbuf.c b/strbuf.c
index 83caf4a..222df13 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -37,6 +37,16 @@ int suffixcmp(const char *str, const char *suffix)
 		return strcmp(str + len - suflen, suffix);
 }
=20
+const char *skip_prefix(const char *str, const char *prefix)
+{
+	const char *p;
+	for (p =3D str; ; p++, prefix++)
+		if (!*prefix)
+			return p;
+		else if (*p !=3D *prefix)
+			return str;
+}
+
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
diff --git a/transport.c b/transport.c
index 824c5b9..8d3372f 100644
--- a/transport.c
+++ b/transport.c
@@ -191,7 +191,11 @@ static void set_upstreams(struct transport *transp=
ort, struct ref *refs,
=20
 static const char *rsync_url(const char *url)
 {
-	return !starts_with(url, "rsync://") ? skip_prefix(url, "rsync:") : u=
rl;
+	if (!starts_with(url, "rsync://")) {
+		const char *rest =3D skip_prefix(url, "rsync:");
+		url =3D (rest =3D=3D url) ? NULL : rest;
+	}
+	return url;
 }
=20
 static struct ref *get_refs_via_rsync(struct transport *transport, int=
 for_push)
diff --git a/urlmatch.c b/urlmatch.c
index ec87cba..51b5d23 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -484,7 +484,7 @@ int urlmatch_config_entry(const char *var, const ch=
ar *value, void *cb)
 	int retval;
=20
 	key =3D skip_prefix(var, collect->section);
-	if (!key || *(key++) !=3D '.') {
+	if ((key =3D=3D var) || (*(key++) !=3D '.')) {
 		if (collect->cascade_fn)
 			return collect->cascade_fn(var, value, cb);
 		return 0; /* not interested */
--=20
1.8.5.2
