From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one action multiple times
Date: Tue, 30 Jul 2013 12:24:32 -0700
Message-ID: <7va9l3x34f.fsf@alter.siamese.dyndns.org>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:24:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4FXG-0001tl-FK
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab3G3TYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:24:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab3G3TYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:24:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EABC2344C8;
	Tue, 30 Jul 2013 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/7HCnP4Bh+1zLMRWXpEpW+peDB4=; b=BhluJ8
	RlB3vGouQD5pjZDh7jirjLC2ti0b4H4j0/QIU/aT05x6FnTojqNOR15Nw4FSTNTY
	d4PvU6VKaGdHyQhX2JeFwZ6QsZ4Oe4CXIwTqirITux20szVjs+xnOGxcyWTqMhji
	yEMl2IEYoDwJcsenxITNuPHqnxF6SIevBDqJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vO9D2Aa1lRKaUAU7MIZ2QGyGImSrLi7N
	/FIwrXZRcU5CR7Dgluim3jhNIIiWINi6YcxsKldyl7kK1uhylDREybsm0kOahvTN
	JUUi7sB7tQY3qfNRbFYps2wPbZ5J+Dboomyp876PoMvUPgn/KQiwPpuRS7xYvVBA
	gDOAAJ+3hrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB5E9344C4;
	Tue, 30 Jul 2013 19:24:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAC93344BE;
	Tue, 30 Jul 2013 19:24:34 +0000 (UTC)
In-Reply-To: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Tue, 30 Jul 2013 20:00:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAC0B766-F94D-11E2-8246-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231380>

Stefan Beller <stefanbeller@googlemail.com> writes:

> As of b04ba2bb (parse-options: deprecate OPT_BOOLEAN, 2011-09-27),
> the OPT_BOOLEAN was deprecated.
> While I am going to replace the OPT_BOOLEAN by the proposed OPT_BOOL or
> the OPT_COUNTUP to keep existing behavior, this commit is actually a
> bug fix!
>
> In line 499 we have:
> 	if (list + delete + verify > 1)
> 		usage_with_options(git_tag_usage, options);
> Now if we give one of the options twice, we'll get the usage information.
> (i.e. 'git tag --verify --verify <tagname>' and
> 'git --delete --delete <tagname>' yield usage information and do not
> do the intended command.)
>
> This could have been fixed by rewriting the line to
> 	if (!!list + !!delete + !!verify > 1)
> 		usage_with_options(git_tag_usage, options);
> or as it happened in this patch by having the parameters not
> counting up for each occurrence, but the OPT_BOOL just setting the
> variables to either 0 if the option is not given or 1 if the option is
> given multiple times.

Makes twisted sort of sense ;-).

> However we could discuss if the negated options do make sense
> here, or if we don't want to allow them here, as this seems valid
> (before and after this patch):
>
> 	git tag --no-verify --delete <tagname>

It probably does not.  As you hinted in your earlier patch, we may
want to introduce a "only can set to true" boolean used solely to
specify these things.  They are disguised as "options", but are in
fact command operation modes that are often mutually exclusive.

For these operation modes that are mutually exclusive, there are
multiple possible implementations:

 * One OPT_BOOL_NONEG per option; the code ensures the mutual
   exclusion with "if (list + delete + verify > 1)";

 * One OPT_BIT per option in a single variable; the code ensures the
   mutual exclusion with count_bits, which may be a lot more
   cumbersome;

 * OPT_SET_INT that updates a single variable to enum; instead of
   making it an error to give two conflicting modes, this would give
   us the last-one-wins rule.

Unlike usual "options", we generally do not want the last-one-wins
semantics for command operation modes, I think.

Perhaps we would want something like this?

-- >8 --
Subject: [PATCH] parse-options: add OPT_CMDMODE()

This can be used to define a set of mutually exclusive "command
mode" options, and automatically catch use of more than one from
that set as an error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 parse-options.h |  3 +++
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index c2cbca2..62e9b1c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -43,8 +43,42 @@ static void fix_filename(const char *prefix, const char **file)
 	*file = xstrdup(prefix_filename(prefix, strlen(prefix), *file));
 }
 
+static int opt_command_mode_error(const struct option *opt,
+				  const struct option *all_opts,
+				  int flags)
+{
+	const struct option *that;
+	struct strbuf message = STRBUF_INIT;
+	struct strbuf that_name = STRBUF_INIT;
+
+	/*
+	 * Find the other option that was used to set the variable
+	 * already, and report that this is not compatible with it.
+	 */
+	for (that = all_opts; that->type != OPTION_END; that++) {
+		if (that == opt ||
+		    that->type != OPTION_CMDMODE ||
+		    that->value != opt->value ||
+		    that->defval != *(int *)opt->value)
+			continue;
+
+		if (that->long_name)
+			strbuf_addf(&that_name, "--%s", that->long_name);
+		else
+			strbuf_addf(&that_name, "-%c", that->short_name);
+		strbuf_addf(&message, ": incompatible with %s", that_name.buf);
+		strbuf_release(&that_name);
+		opterror(opt, message.buf, flags);
+		strbuf_release(&message);
+		return -1;
+	}
+	return opterror(opt, ": incompatible with something else", flags);
+}
+
 static int get_value(struct parse_opt_ctx_t *p,
-		     const struct option *opt, int flags)
+		     const struct option *opt,
+		     const struct option *all_opts,
+		     int flags)
 {
 	const char *s, *arg;
 	const int unset = flags & OPT_UNSET;
@@ -83,6 +117,16 @@ static int get_value(struct parse_opt_ctx_t *p,
 		*(int *)opt->value = unset ? 0 : opt->defval;
 		return 0;
 
+	case OPTION_CMDMODE:
+		/*
+		 * Giving the same mode option twice, although is unnecessary,
+		 * is not a grave error, so let it pass.
+		 */
+		if (*(int *)opt->value && *(int *)opt->value != opt->defval)
+			return opt_command_mode_error(opt, all_opts, flags);
+		*(int *)opt->value = opt->defval;
+		return 0;
+
 	case OPTION_SET_PTR:
 		*(void **)opt->value = unset ? NULL : (void *)opt->defval;
 		return 0;
@@ -143,12 +187,13 @@ static int get_value(struct parse_opt_ctx_t *p,
 
 static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *options)
 {
+	const struct option *all_opts = options;
 	const struct option *numopt = NULL;
 
 	for (; options->type != OPTION_END; options++) {
 		if (options->short_name == *p->opt) {
 			p->opt = p->opt[1] ? p->opt + 1 : NULL;
-			return get_value(p, options, OPT_SHORT);
+			return get_value(p, options, all_opts, OPT_SHORT);
 		}
 
 		/*
@@ -177,6 +222,7 @@ static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *optio
 static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
                           const struct option *options)
 {
+	const struct option *all_opts = options;
 	const char *arg_end = strchr(arg, '=');
 	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
 	int abbrev_flags = 0, ambiguous_flags = 0;
@@ -253,7 +299,7 @@ is_abbreviated:
 				continue;
 			p->opt = rest + 1;
 		}
-		return get_value(p, options, flags ^ opt_flags);
+		return get_value(p, options, all_opts, flags ^ opt_flags);
 	}
 
 	if (ambiguous_option)
@@ -265,18 +311,20 @@ is_abbreviated:
 			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
 			abbrev_option->long_name);
 	if (abbrev_option)
-		return get_value(p, abbrev_option, abbrev_flags);
+		return get_value(p, abbrev_option, all_opts, abbrev_flags);
 	return -2;
 }
 
 static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
 			    const struct option *options)
 {
+	const struct option *all_opts = options;
+
 	for (; options->type != OPTION_END; options++) {
 		if (!(options->flags & PARSE_OPT_NODASH))
 			continue;
 		if (options->short_name == arg[0] && arg[1] == '\0')
-			return get_value(p, options, OPT_SHORT);
+			return get_value(p, options, all_opts, OPT_SHORT);
 	}
 	return -2;
 }
diff --git a/parse-options.h b/parse-options.h
index c378b75..2404e06 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -13,6 +13,7 @@ enum parse_opt_type {
 	OPTION_COUNTUP,
 	OPTION_SET_INT,
 	OPTION_SET_PTR,
+	OPTION_CMDMODE,
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
@@ -130,6 +131,8 @@ struct option {
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (p) }
+#define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_STRING_LIST(s, l, v, a, h) \
-- 
1.8.4-rc0-153-g9820077


... and then "git tag" may become like so.

 builtin/tag.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index af3af3f..d8ae5aa 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -436,18 +436,18 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_lock *lock;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
-	int annotate = 0, force = 0, lines = -1, list = 0,
-		delete = 0, verify = 0;
+	int annotate = 0, force = 0, lines = -1;
+	int cmdmode = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
 	struct option options[] = {
-		OPT_BOOLEAN('l', "list", &list, N_("list tag names")),
+		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
 				N_("print <n> lines of each tag message"),
 				PARSE_OPT_OPTARG, NULL, 1 },
-		OPT_BOOLEAN('d', "delete", &delete, N_("delete tags")),
-		OPT_BOOLEAN('v', "verify", &verify, N_("verify tags")),
+		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete tags"), 'd'),
+		OPT_CMDMODE('v', "verify", &cmdmode, N_("verify tags"), 'v'),
 
 		OPT_GROUP(N_("Tag creation options")),
 		OPT_BOOLEAN('a', "annotate", &annotate,
@@ -489,22 +489,19 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (opt.sign)
 		annotate = 1;
-	if (argc == 0 && !(delete || verify))
-		list = 1;
+	if (argc == 0 && !cmdmode)
+		cmdmode = 'l';
 
-	if ((annotate || msg.given || msgfile || force) &&
-	    (list || delete || verify))
+	if ((annotate || msg.given || msgfile || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
-	if (list + delete + verify > 1)
-		usage_with_options(git_tag_usage, options);
 	finalize_colopts(&colopts, -1);
-	if (list && lines != -1) {
+	if (cmdmode == 'l' && lines != -1) {
 		if (explicitly_enable_column(colopts))
 			die(_("--column and -n are incompatible"));
 		colopts = 0;
 	}
-	if (list) {
+	if (cmdmode == 'l') {
 		int ret;
 		if (column_active(colopts)) {
 			struct column_options copts;
@@ -523,9 +520,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("--contains option is only allowed with -l."));
 	if (points_at.nr)
 		die(_("--points-at option is only allowed with -l."));
-	if (delete)
+	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag);
-	if (verify)
+	if (cmdmode == 'v')
 		return for_each_tag_name(argv, verify_tag);
 
 	if (msg.given || msgfile) {
