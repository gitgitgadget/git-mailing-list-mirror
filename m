From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 02/12] Convert starts_with() to skip_prefix() for option
 parsing
Date: Fri, 20 Dec 2013 11:43:14 +0100
Message-ID: <52B41F42.7050204@web.de>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com> <1387378437-20646-3-git-send-email-pclouds@gmail.com> <52B3E8D4.1030805@viscovery.net> <20131220070449.GA29717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 20 11:43:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtxYH-0002BH-ON
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 11:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab3LTKnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 05:43:24 -0500
Received: from mout.web.de ([212.227.15.14]:63556 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab3LTKnU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 05:43:20 -0500
Received: from [192.168.178.27] ([79.253.155.62]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lrrva-1VVR9s2fDq-013iO7 for <git@vger.kernel.org>;
 Fri, 20 Dec 2013 11:43:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131220070449.GA29717@sigill.intra.peff.net>
X-Provags-ID: V03:K0:Ql5BkCWGs7ihmPQmMG1UX+8seaf/Mi1oIn7JaI/ZmBQ9hPOp/vD
 o/xmszu4ipLxbuWYPnNWwYB/+U+wtUH905/W3Ij/G9LxvYpIetDuznCC7CphBR6O1j51nQ1
 LzBP9bVUlzHmGf0tLPp8LFmj71DnfM3GmDGqTGM7w0ur4p0lxYn5gyZ0G3GgxLUJQfM8WH/
 mCEiGijbqQa1ET4V8WLLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239569>

Am 20.12.2013 08:04, schrieb Jeff King:
> On Fri, Dec 20, 2013 at 07:51:00AM +0100, Johannes Sixt wrote:
> 
>>>   	for (i = 1; i < argc && *argv[i] == '-'; i++) {
>>>   		const char *arg = argv[i];
>>> +		const char *optarg;
>>>   
>>> -		if (starts_with(arg, "--upload-pack=")) {
>>> -			args.uploadpack = arg + 14;
>>> +		if ((optarg = skip_prefix(arg, "--upload-pack=")) != NULL) {
>>> +			args.uploadpack = optarg;
>>
>> Quite frankly, I do not think this is an improvement. The old code is
>> *MUCH* easier to understand because "starts_with" is clearly a predicate
>> that is either true or false, but the code with "skip_prefix" is much
>> heavier on the eye with its extra level of parenthesis. That it removes a
>> hard-coded constant does not count much IMHO because it is very clear
>> where the value comes from.
> 
> Yeah, I agree that is unfortunate. Maybe we could have the best of both
> worlds, like:
> 
>    if (starts_with(arg, "--upload-pack=", &optarg))
>            ... use optarg ...
> 
> Probably we do not want to call it just "starts_with", as quite a few
> callers to do not care about what comes next, and would just pass NULL.
> 
> I cannot seem to think of a good name, though, as the "with" means that
> obvious things like "starts_with_value" naturally parse as a single
> (nonsensical) sentence.  Something like "parse_prefix" would work, but
> it is not as clearly a predicate as "starts_with" (but we have at least
> gotten rid of the extra parentheses).
> 
> Elsewhere in the thread, the concept was discussed of returning the full
> string to mean "did not match", which makes some other idioms simpler
> (but IMHO makes the simple cases like this even harder to read). My
> proposal splits the "start of string" out parameter from the boolean
> return, so it handles both cases naturally:
> 
>    /* here we care if we saw the prefix, as above */
>    if (parse_prefix(foo, prefix, &the_rest))
>        ...
> 
>    /*
>     * and here we do not care, and just want to optionally strip the
>     * prefix, and take the full value otherwise; we just have to ignore
>     * the return value in this case.
>     */
>    parse_prefix(foo, prefix, &foo);

It adds a bit of redundancy, but overall I like it.  It fits the common
case very well and looks nice.  The patch below converts all calls of
skip_prefix as well as the usage of starts_with and a magic number in
builtin/fetch-pack.c.

I wonder how many of the 400+ uses of starts_with remain after a
parse_prefix crusade.  If only a few remain then it may make sense
to unite the two functions under a common name.

---
 advice.c                   |  5 ++++-
 builtin/branch.c           |  6 +++---
 builtin/clone.c            | 13 ++++++++-----
 builtin/commit.c           |  6 ++----
 builtin/fetch-pack.c       | 14 +++++++-------
 builtin/fmt-merge-msg.c    |  4 ++--
 builtin/push.c             |  7 +++----
 builtin/remote.c           |  4 +---
 column.c                   |  5 +++--
 config.c                   |  3 +--
 credential-cache--daemon.c |  6 ++----
 credential.c               |  3 +--
 git-compat-util.h          |  1 +
 parse-options.c            | 11 ++++++-----
 strbuf.c                   | 12 +++++++++---
 transport.c                |  6 +++++-
 urlmatch.c                 |  3 +--
 17 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/advice.c b/advice.c
index 3eca9f5..75fae9c 100644
--- a/advice.c
+++ b/advice.c
@@ -63,9 +63,12 @@ void advise(const char *advice, ...)
 
 int git_default_advice_config(const char *var, const char *value)
 {
-	const char *k = skip_prefix(var, "advice.");
+	const char *k;
 	int i;
 
+	if (!parse_prefix(var, "advice.", &k))
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
 		if (strcmp(k, advice_config[i].name))
 			continue;
diff --git a/builtin/branch.c b/builtin/branch.c
index b4d7716..dae0d82 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -294,13 +294,13 @@ static char *resolve_symref(const char *src, const char *prefix)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *dst, *cp;
+	const char *dst;
 
 	dst = resolve_ref_unsafe(src, sha1, 0, &flag);
 	if (!(dst && (flag & REF_ISSYMREF)))
 		return NULL;
-	if (prefix && (cp = skip_prefix(dst, prefix)))
-		dst = cp;
+	if (prefix)
+		parse_prefix(dst, prefix, &dst);
 	return xstrdup(dst);
 }
 
diff --git a/builtin/clone.c b/builtin/clone.c
index f98f529..e62fa26 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -578,11 +578,12 @@ static void update_remote_refs(const struct ref *refs,
 static void update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
-	if (our && starts_with(our->name, "refs/heads/")) {
+	const char *head;
+
+	if (our && parse_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
-			const char *head = skip_prefix(our->name, "refs/heads/");
 			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
 		}
@@ -696,9 +697,11 @@ static void write_refspec_config(const char* src_ref_prefix,
 					strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
 						branch_top->buf, option_branch);
 			} else if (remote_head_points_at) {
-				strbuf_addf(&value, "+%s:%s%s", remote_head_points_at->name,
-						branch_top->buf,
-						skip_prefix(remote_head_points_at->name, "refs/heads/"));
+				const char *name = remote_head_points_at->name;
+				const char *head = NULL;
+				parse_prefix(name, "refs/heads/", &head);
+				strbuf_addf(&value, "+%s:%s%s",
+					    name, branch_top->buf, head);
 			}
 			/*
 			 * otherwise, the next "git fetch" will
diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..e9bff59 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -934,7 +934,7 @@ static int message_is_empty(struct strbuf *sb)
 static int template_untouched(struct strbuf *sb)
 {
 	struct strbuf tmpl = STRBUF_INIT;
-	char *start;
+	const char *start = sb->buf;
 
 	if (cleanup_mode == CLEANUP_NONE && sb->len)
 		return 0;
@@ -943,9 +943,7 @@ static int template_untouched(struct strbuf *sb)
 		return 0;
 
 	stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
-	start = (char *)skip_prefix(sb->buf, tmpl.buf);
-	if (!start)
-		start = sb->buf;
+	parse_prefix(start, tmpl.buf, &start);
 	strbuf_release(&tmpl);
 	return rest_is_empty(sb, start - sb->buf);
 }
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 8b8978a2..d673986 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -46,14 +46,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	args.uploadpack = "git-upload-pack";
 
 	for (i = 1; i < argc && *argv[i] == '-'; i++) {
-		const char *arg = argv[i];
+		const char *optarg, *arg = argv[i];
 
-		if (starts_with(arg, "--upload-pack=")) {
-			args.uploadpack = arg + 14;
+		if (parse_prefix(arg, "--upload-pack=", &optarg)) {
+			args.uploadpack = optarg;
 			continue;
 		}
-		if (starts_with(arg, "--exec=")) {
-			args.uploadpack = arg + 7;
+		if (parse_prefix(arg, "--exec=", &optarg)) {
+			args.uploadpack = optarg;
 			continue;
 		}
 		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
@@ -89,8 +89,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.verbose = 1;
 			continue;
 		}
-		if (starts_with(arg, "--depth=")) {
-			args.depth = strtol(arg + 8, NULL, 0);
+		if (parse_prefix(arg, "--depth=", &optarg)) {
+			args.depth = strtol(optarg, NULL, 0);
 			continue;
 		}
 		if (!strcmp("--no-progress", arg)) {
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3906eda..ce889e3 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -297,8 +297,8 @@ static void credit_people(struct strbuf *out,
 	if (!them->nr ||
 	    (them->nr == 1 &&
 	     me &&
-	     (me = skip_prefix(me, them->items->string)) != NULL &&
-	     skip_prefix(me, " <")))
+	     parse_prefix(me, them->items->string, &me) &&
+	     starts_with(me, " <")))
 		return;
 	strbuf_addf(out, "\n%c %s ", comment_line_char, label);
 	add_people_count(out, them);
diff --git a/builtin/push.c b/builtin/push.c
index a73982a..f040e82 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -88,11 +88,10 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	 * them the big ugly fully qualified ref.
 	 */
 	const char *advice_maybe = "";
-	const char *short_upstream =
-		skip_prefix(branch->merge[0]->src, "refs/heads/");
+	const char *short_upstream = branch->merge[0]->src;
+
+	parse_prefix(short_upstream, "refs/heads/", &short_upstream);
 
-	if (!short_upstream)
-		short_upstream = branch->merge[0]->src;
 	/*
 	 * Don't show advice for people who explicitly set
 	 * push.default.
diff --git a/builtin/remote.c b/builtin/remote.c
index b3ab4cf..30d1987 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -250,9 +250,7 @@ static struct string_list branch_list;
 
 static const char *abbrev_ref(const char *name, const char *prefix)
 {
-	const char *abbrev = skip_prefix(name, prefix);
-	if (abbrev)
-		return abbrev;
+	parse_prefix(name, prefix, &name);
 	return name;
 }
 #define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
diff --git a/column.c b/column.c
index 9367ba5..dfb2392 100644
--- a/column.c
+++ b/column.c
@@ -336,8 +336,9 @@ static int column_config(const char *var, const char *value,
 int git_column_config(const char *var, const char *value,
 		      const char *command, unsigned int *colopts)
 {
-	const char *it = skip_prefix(var, "column.");
-	if (!it)
+	const char *it;
+
+	if (!parse_prefix(var, "column.", &it))
 		return 0;
 
 	if (!strcmp(it, "ui"))
diff --git a/config.c b/config.c
index d969a5a..ee42010 100644
--- a/config.c
+++ b/config.c
@@ -133,8 +133,7 @@ int git_config_include(const char *var, const char *value, void *data)
 	if (ret < 0)
 		return ret;
 
-	type = skip_prefix(var, "include.");
-	if (!type)
+	if (!parse_prefix(var, "include.", &type))
 		return ret;
 
 	if (!strcmp(type, "path"))
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 390f194..3823a38 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -109,14 +109,12 @@ static int read_request(FILE *fh, struct credential *c,
 	const char *p;
 
 	strbuf_getline(&item, fh, '\n');
-	p = skip_prefix(item.buf, "action=");
-	if (!p)
+	if (!parse_prefix(item.buf, "action=", &p))
 		return error("client sent bogus action line: %s", item.buf);
 	strbuf_addstr(action, p);
 
 	strbuf_getline(&item, fh, '\n');
-	p = skip_prefix(item.buf, "timeout=");
-	if (!p)
+	if (!parse_prefix(item.buf, "timeout=", &p))
 		return error("client sent bogus timeout line: %s", item.buf);
 	*timeout = atoi(p);
 
diff --git a/credential.c b/credential.c
index e54753c..fd148a0 100644
--- a/credential.c
+++ b/credential.c
@@ -40,8 +40,7 @@ static int credential_config_callback(const char *var, const char *value,
 	struct credential *c = data;
 	const char *key, *dot;
 
-	key = skip_prefix(var, "credential.");
-	if (!key)
+	if (!parse_prefix(var, "credential.", &key))
 		return 0;
 
 	if (!value)
diff --git a/git-compat-util.h b/git-compat-util.h
index b73916b..0a8354a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -350,6 +350,7 @@ extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_lis
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
+extern int parse_prefix(const char *str, const char *prefix, const char **rest);
 extern int starts_with(const char *str, const char *prefix);
 extern int prefixcmp(const char *str, const char *prefix);
 extern int ends_with(const char *str, const char *suffix);
diff --git a/parse-options.c b/parse-options.c
index 7b8d3fa..1e25203 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -238,7 +238,8 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 			continue;
 
 again:
-		rest = skip_prefix(arg, long_name);
+		rest = NULL;
+		parse_prefix(arg, long_name, &rest);
 		if (options->type == OPTION_ARGUMENT) {
 			if (!rest)
 				continue;
@@ -287,12 +288,12 @@ is_abbreviated:
 				continue;
 			}
 			flags |= OPT_UNSET;
-			rest = skip_prefix(arg + 3, long_name);
 			/* abbreviated and negated? */
-			if (!rest && starts_with(long_name, arg + 3))
-				goto is_abbreviated;
-			if (!rest)
+			if (!parse_prefix(arg + 3, long_name, &rest)) {
+				if (starts_with(long_name, arg + 3))
+					goto is_abbreviated;
 				continue;
+			}
 		}
 		if (*rest) {
 			if (*rest != '=')
diff --git a/strbuf.c b/strbuf.c
index 83caf4a..b78bc44 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,15 +1,21 @@
 #include "cache.h"
 #include "refs.h"
 
-int starts_with(const char *str, const char *prefix)
+int parse_prefix(const char *str, const char *prefix, const char **rest)
 {
 	for (; ; str++, prefix++)
-		if (!*prefix)
+		if (!*prefix) {
+			*rest = str;
 			return 1;
-		else if (*str != *prefix)
+		} else if (*str != *prefix)
 			return 0;
 }
 
+int starts_with(const char *str, const char *prefix)
+{
+	return parse_prefix(str, prefix, &str);
+}
+
 int prefixcmp(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
diff --git a/transport.c b/transport.c
index 824c5b9..775f2b1 100644
--- a/transport.c
+++ b/transport.c
@@ -191,7 +191,11 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 
 static const char *rsync_url(const char *url)
 {
-	return !starts_with(url, "rsync://") ? skip_prefix(url, "rsync:") : url;
+	const char *rest = NULL;
+	if (starts_with(url, "rsync://"))
+		return url;
+	parse_prefix(url, "rsync:", &rest);
+	return rest;
 }
 
 static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
diff --git a/urlmatch.c b/urlmatch.c
index ec87cba..dfd1fa7 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -483,8 +483,7 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 	int user_matched = 0;
 	int retval;
 
-	key = skip_prefix(var, collect->section);
-	if (!key || *(key++) != '.') {
+	if (!parse_prefix(var, collect->section, &key) || *(key++) != '.') {
 		if (collect->cascade_fn)
 			return collect->cascade_fn(var, value, cb);
 		return 0; /* not interested */
-- 
1.8.5.2
