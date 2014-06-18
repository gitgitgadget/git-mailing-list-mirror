From: Jeff King <peff@peff.net>
Subject: [PATCH 09/16] use skip_prefix to avoid repeating strings
Date: Wed, 18 Jun 2014 15:48:29 -0400
Message-ID: <20140618194829.GI22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:48:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLqU-00042h-Rr
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbaFRTsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:48:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:46954 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754109AbaFRTsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:48:30 -0400
Received: (qmail 30313 invoked by uid 102); 18 Jun 2014 19:48:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:48:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:48:29 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252041>

It's a common idiom to match a prefix and then skip past it
with strlen, like:

  if (starts_with(foo, "bar"))
	  foo += strlen("bar");

This avoids magic numbers, but means we have to repeat the
string (and there is no compiler check that we didn't make a
typo in one of the strings).

We can use skip_prefix to handle this case without repeating
ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c      |  4 ++--
 builtin/fmt-merge-msg.c |  6 +++---
 builtin/log.c           | 12 ++++++------
 diff.c                  | 27 +++++++++------------------
 help.c                  |  7 ++++---
 merge-recursive.c       | 15 ++++++++-------
 pretty.c                |  3 +--
 remote-curl.c           | 15 ++++++++-------
 remote.c                |  5 ++---
 sha1_name.c             |  4 +---
 10 files changed, 44 insertions(+), 54 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f1dc56e..463cfee 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -776,8 +776,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
 
-	if (old.path && starts_with(old.path, "refs/heads/"))
-		old.name = old.path + strlen("refs/heads/");
+	if (old.path)
+		skip_prefix(old.path, "refs/heads/", &old.name);
 
 	if (!new->name) {
 		new->name = "HEAD";
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3c19241..ad3bc58 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -100,7 +100,8 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 {
 	int i, len = strlen(line);
 	struct origin_data *origin_data;
-	char *src, *origin;
+	char *src;
+	const char *origin;
 	struct src_data *src_data;
 	struct string_list_item *item;
 	int pulling_head = 0;
@@ -164,8 +165,7 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 		origin = line;
 		string_list_append(&src_data->tag, origin + 4);
 		src_data->head_status |= 2;
-	} else if (starts_with(line, "remote-tracking branch ")) {
-		origin = line + strlen("remote-tracking branch ");
+	} else if (skip_prefix(line, "remote-tracking branch ", &origin)) {
 		string_list_append(&src_data->r_branch, origin);
 		src_data->head_status |= 2;
 	} else {
diff --git a/builtin/log.c b/builtin/log.c
index a7ba211..0f59c25 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -872,7 +872,7 @@ static char *find_branch_name(struct rev_info *rev)
 	int i, positive = -1;
 	unsigned char branch_sha1[20];
 	const unsigned char *tip_sha1;
-	const char *ref;
+	const char *ref, *v;
 	char *full_ref, *branch = NULL;
 
 	for (i = 0; i < rev->cmdline.nr; i++) {
@@ -888,9 +888,9 @@ static char *find_branch_name(struct rev_info *rev)
 	ref = rev->cmdline.rev[positive].name;
 	tip_sha1 = rev->cmdline.rev[positive].item->sha1;
 	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
-	    starts_with(full_ref, "refs/heads/") &&
+	    skip_prefix(full_ref, "refs/heads/", &v) &&
 	    !hashcmp(tip_sha1, branch_sha1))
-		branch = xstrdup(full_ref + strlen("refs/heads/"));
+		branch = xstrdup(v);
 	free(full_ref);
 	return branch;
 }
@@ -1394,10 +1394,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 		if (check_head) {
 			unsigned char sha1[20];
-			const char *ref;
+			const char *ref, *v;
 			ref = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
-			if (ref && starts_with(ref, "refs/heads/"))
-				branch_name = xstrdup(ref + strlen("refs/heads/"));
+			if (ref && skip_prefix(ref, "refs/heads/", &v))
+				branch_name = xstrdup(v);
 			else
 				branch_name = xstrdup(""); /* no branch */
 		}
diff --git a/diff.c b/diff.c
index 97db932..2378ae4 100644
--- a/diff.c
+++ b/diff.c
@@ -3395,12 +3395,10 @@ int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg)
 {
 	const char *arg = argv[0];
-	if (arg[0] != '-' || arg[1] != '-')
+	if (!skip_prefix(arg, "--", &arg))
 		return 0;
-	arg += strlen("--");
-	if (!starts_with(arg, opt))
+	if (!skip_prefix(arg, opt, &arg))
 		return 0;
-	arg += strlen(opt);
 	if (*arg == '=') { /* stuck form: --option=value */
 		*optarg = arg + 1;
 		return 1;
@@ -3429,8 +3427,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 
 	switch (*arg) {
 	case '-':
-		if (starts_with(arg, "-width")) {
-			arg += strlen("-width");
+		if (skip_prefix(arg, "-width", &arg)) {
 			if (*arg == '=')
 				width = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
@@ -3439,8 +3436,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 				width = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
-		} else if (starts_with(arg, "-name-width")) {
-			arg += strlen("-name-width");
+		} else if (skip_prefix(arg, "-name-width", &arg)) {
 			if (*arg == '=')
 				name_width = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
@@ -3449,8 +3445,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 				name_width = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
-		} else if (starts_with(arg, "-graph-width")) {
-			arg += strlen("-graph-width");
+		} else if (skip_prefix(arg, "-graph-width", &arg)) {
 			if (*arg == '=')
 				graph_width = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
@@ -3459,8 +3454,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 				graph_width = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
-		} else if (starts_with(arg, "-count")) {
-			arg += strlen("-count");
+		} else if (skip_prefix(arg, "-count", &arg)) {
 			if (*arg == '=')
 				count = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
@@ -3905,16 +3899,13 @@ static int diff_scoreopt_parse(const char *opt)
 	cmd = *opt++;
 	if (cmd == '-') {
 		/* convert the long-form arguments into short-form versions */
-		if (starts_with(opt, "break-rewrites")) {
-			opt += strlen("break-rewrites");
+		if (skip_prefix(opt, "break-rewrites", &opt)) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'B';
-		} else if (starts_with(opt, "find-copies")) {
-			opt += strlen("find-copies");
+		} else if (skip_prefix(opt, "find-copies", &opt)) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'C';
-		} else if (starts_with(opt, "find-renames")) {
-			opt += strlen("find-renames");
+		} else if (skip_prefix(opt, "find-renames", &opt)) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'M';
 		}
diff --git a/help.c b/help.c
index b0f1a69..79e8007 100644
--- a/help.c
+++ b/help.c
@@ -414,11 +414,12 @@ static int append_similar_ref(const char *refname, const unsigned char *sha1,
 {
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
 	char *branch = strrchr(refname, '/') + 1;
+	const char *remote;
+
 	/* A remote branch of the same name is deemed similar */
-	if (starts_with(refname, "refs/remotes/") &&
+	if (skip_prefix(refname, "refs/remotes/", &remote) &&
 	    !strcmp(branch, cb->base_ref))
-		string_list_append(cb->similar_refs,
-				   refname + strlen("refs/remotes/"));
+		string_list_append(cb->similar_refs, remote);
 	return 0;
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index cab16fa..f848001 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2063,6 +2063,8 @@ void init_merge_options(struct merge_options *o)
 
 int parse_merge_opt(struct merge_options *o, const char *s)
 {
+	const char *arg;
+
 	if (!s || !*s)
 		return -1;
 	if (!strcmp(s, "ours"))
@@ -2071,14 +2073,14 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->recursive_variant = MERGE_RECURSIVE_THEIRS;
 	else if (!strcmp(s, "subtree"))
 		o->subtree_shift = "";
-	else if (starts_with(s, "subtree="))
-		o->subtree_shift = s + strlen("subtree=");
+	else if (skip_prefix(s, "subtree=", &arg))
+		o->subtree_shift = arg;
 	else if (!strcmp(s, "patience"))
 		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
 	else if (!strcmp(s, "histogram"))
 		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
-	else if (starts_with(s, "diff-algorithm=")) {
-		long value = parse_algorithm_value(s + strlen("diff-algorithm="));
+	else if (skip_prefix(s, "diff-algorithm=", &arg)) {
+		long value = parse_algorithm_value(arg);
 		if (value < 0)
 			return -1;
 		/* clear out previous settings */
@@ -2096,9 +2098,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
 		o->renormalize = 0;
-	else if (starts_with(s, "rename-threshold=")) {
-		const char *score = s + strlen("rename-threshold=");
-		if ((o->rename_score = parse_rename_score(&score)) == -1 || *score != 0)
+	else if (skip_prefix(s, "rename-threshold=", &arg)) {
+		if ((o->rename_score = parse_rename_score(&arg)) == -1 || *arg != 0)
 			return -1;
 	}
 	else
diff --git a/pretty.c b/pretty.c
index 4f51287..f24752a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -40,10 +40,9 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
 	const char *fmt;
 	int i;
 
-	if (!starts_with(var, "pretty."))
+	if (!skip_prefix(var, "pretty.", &name))
 		return 0;
 
-	name = var + strlen("pretty.");
 	for (i = 0; i < builtin_formats_len; i++) {
 		if (!strcmp(commit_formats[i].name, name))
 			return 0;
diff --git a/remote-curl.c b/remote-curl.c
index 4493b38..cdcca29 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -791,9 +791,9 @@ static void parse_fetch(struct strbuf *buf)
 	int alloc_heads = 0, nr_heads = 0;
 
 	do {
-		if (starts_with(buf->buf, "fetch ")) {
-			char *p = buf->buf + strlen("fetch ");
-			char *name;
+		const char *p;
+		if (skip_prefix(buf->buf, "fetch ", &p)) {
+			const char *name;
 			struct ref *ref;
 			unsigned char old_sha1[20];
 
@@ -968,6 +968,8 @@ int main(int argc, const char **argv)
 	http_init(remote, url.buf, 0);
 
 	do {
+		const char *arg;
+
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
 				fprintf(stderr, "Error reading command stream\n");
@@ -989,9 +991,8 @@ int main(int argc, const char **argv)
 		} else if (starts_with(buf.buf, "push ")) {
 			parse_push(&buf);
 
-		} else if (starts_with(buf.buf, "option ")) {
-			char *name = buf.buf + strlen("option ");
-			char *value = strchr(name, ' ');
+		} else if (skip_prefix(buf.buf, "option ", &arg)) {
+			char *value = strchr(arg, ' ');
 			int result;
 
 			if (value)
@@ -999,7 +1000,7 @@ int main(int argc, const char **argv)
 			else
 				value = "true";
 
-			result = set_option(name, value);
+			result = set_option(arg, value);
 			if (!result)
 				printf("ok\n");
 			else if (result < 0)
diff --git a/remote.c b/remote.c
index 0e9459c..30d2829 100644
--- a/remote.c
+++ b/remote.c
@@ -488,9 +488,8 @@ static void read_config(void)
 	current_branch = NULL;
 	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
-	    starts_with(head_ref, "refs/heads/")) {
-		current_branch =
-			make_branch(head_ref + strlen("refs/heads/"), 0);
+	    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
+		current_branch = make_branch(head_ref, 0);
 	}
 	git_config(handle_config, NULL);
 	if (branch_pushremote_name) {
diff --git a/sha1_name.c b/sha1_name.c
index 2b6322f..72e6ac6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -911,10 +911,8 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	const char *match = NULL, *target = NULL;
 	size_t len;
 
-	if (starts_with(message, "checkout: moving from ")) {
-		match = message + strlen("checkout: moving from ");
+	if (skip_prefix(message, "checkout: moving from ", &match))
 		target = strstr(match, " to ");
-	}
 
 	if (!match || !target)
 		return 0;
-- 
2.0.0.566.gfe3e6b2
