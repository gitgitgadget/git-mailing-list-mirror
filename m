Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6CC1F935
	for <e@80x24.org>; Thu, 22 Sep 2016 06:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933188AbcIVGUy (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 02:20:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:46508 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933168AbcIVGUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 02:20:50 -0400
Received: (qmail 16260 invoked by uid 109); 22 Sep 2016 06:20:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 06:20:50 +0000
Received: (qmail 6278 invoked by uid 111); 22 Sep 2016 06:21:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 02:21:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 02:20:47 -0400
Date:   Thu, 22 Sep 2016 02:20:47 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: optionally recurse into submodules
Message-ID: <20160922062047.jbxsgfabej26jt5i@sigill.intra.peff.net>
References: <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <1474497772-97986-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1474497772-97986-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 03:42:52PM -0700, Brandon Williams wrote:

> @@ -68,6 +71,21 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
>  static void write_name(const char *name)
>  {
>  	/*
> +	 * NEEDSWORK: To make this thread-safe, full_name would have to be owned
> +	 * by the caller.

I'm not sure if that is quite true. You could simply drop the "static"
here, and pay the malloc cost each time. But if we want to amortize the
allocation, then yeah, somebody else on the stack needs to own it.

That being said, I don't know if it is worth pointing this out as a
NEEDSWORK or not. Most of git is not thread-safe, so I think that's
generally the norm.

> +	 *
> +	 * full_name get reused across output lines to minimize the allocation
> +	 * churn.

Likewise, this kind of strbuf-reuse trickery is common in git. I don't
know if it's worth a comment or not (though I mind this one much less,
because it's a bit more subtle, being across multiple calls rather than
in a single loop).

(To be clear, I actually don't mind either _that_ much; usually the
problem is under-commenting, not over-commenting. I am just trying to
give style pointers since you are new to the project).

> +	static struct strbuf full_name = STRBUF_INIT;
> +	if (submodule_prefix && *submodule_prefix) {
> +		strbuf_reset(&full_name);
> +		strbuf_addstr(&full_name, submodule_prefix);
> +		strbuf_addstr(&full_name, name);
> +		name = full_name.buf;
> +	}

I actually wonder if it would be more obvious if we hoisted out the
prefix copy, too. IOW, have a global:

  /* used to assemble full names in place */
  static struct strbuf prefixed_name = STRBUF_INIT;
  static size_t prefixed_name_base;

then parse --submodule-prefix as:

  strbuf_reset(&prefixed_name);
  strbuf_addstr(&prefixed_name, arg);
  prefixed_name_base = prefixed_name.len;

and then here do:

  if (prefixed_name_base) {
	strbuf_addstr(&prefixed_name, name);
	name = prefixed_name.buf;
  }
  ... do stuff with name ...
  if (prefixed_name_base)
	strbuf_setlen(&prefixed_name, prefixed_name_base);

I dunno. It is slightly more efficient (we do not memcpy the prefix over
and over), but I doubt that matters much in practice. I just wonder if
it makes the buffer reuse a bit more obvious.

> +/**
> + * Recursively call ls-files on a submodule
> + */
> +static void show_gitlink(const struct cache_entry *ce)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	int status;
> +
> +	argv_array_push(&cp.args, "ls-files");
> +	argv_array_push(&cp.args, "--recurse-submodules");
> +	argv_array_pushf(&cp.args, "--submodule-prefix=%s%s/",
> +			 submodule_prefix ? submodule_prefix : "",
> +			 ce->name);
> +	cp.git_cmd = 1;
> +	cp.dir = ce->name;
> +	status = run_command(&cp);
> +	if (status)
> +		exit(status);
> +}

This doesn't propagate the parent argv at all. So if I run:

  git ls-files -z --recurse-submodules

then the paths are all NUL-terminated in the parent, but
newline-terminated in the submodules. Oops.

I see in the second patch you make an effort to pass in some specific
options explicitly. In some ways that is safer (we do not accidentally
pass an argument that needs to be munged). But in some ways it is less
safe (as shown by "-z" above, anything we fail to pass in show_gitlink()
must be explicitly blocked in cmd_ls_files(), or we produce garbage
output). It also means that we have a bunch of boilerplate forwarding
the options along (e.g., your second patch lets through --stage, but why
not other ones like "--deleted"?).

So I dunno. I would have done it more like:

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 03c283e..2a3d65c 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -31,6 +31,7 @@ static int debug_mode;
 static int show_eol;
 static const char *submodule_prefix;
 static int recurse_submodules;
+static struct argv_array recurse_argv = ARGV_ARRAY_INIT;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -170,6 +171,32 @@ static void show_killed_files(struct dir_struct *dir)
 	}
 }
 
+/*
+ * Copy all of the parent arguments, but omit --submodule-prefix, as
+ * we will be adding our own. Other arguments are assumed to behave
+ * reasonably in the submodule, or to be blocked explicitly in
+ * cmd_ls_files().
+ *
+ * We have to make a full copy here, because parse_options will munge our
+ * original.
+ */
+static void store_recurse_argv(const char **argv)
+{
+	for (; *argv; argv++) {
+		const char *arg = *argv;
+
+		/* Yikes, we're reinventing option parsing here. */
+		if (starts_with(arg, "--submodule-prefix="))
+			continue;
+		if (!strcmp(arg, "--submodule-prefix")) {
+			if (argv[1])
+				argv++;
+			continue;
+		}
+		argv_array_push(&recurse_argv, arg);
+	}
+}
+
 /**
  * Recursively call ls-files on a submodule
  */
@@ -177,9 +204,10 @@ static void show_gitlink(const struct cache_entry *ce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
+	int i;
 
-	argv_array_push(&cp.args, "ls-files");
-	argv_array_push(&cp.args, "--recurse-submodules");
+	for (i = 0; i < recurse_argv.argc; i++)
+		argv_array_push(&cp.args, recurse_argv.argv[i]);
 	argv_array_pushf(&cp.args, "--submodule-prefix=%s%s/",
 			 submodule_prefix ? submodule_prefix : "",
 			 ce->name);
@@ -535,6 +563,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
 
+	store_recurse_argv(argv);
+
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
@@ -565,13 +595,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	if (recurse_submodules &&
-	    (show_stage || show_deleted || show_others || show_unmerged ||
-	     show_killed || show_modified || show_resolve_undo ||
-	     show_valid_bit || show_tag || show_eol))
-		die("ls-files --recurse-submodules can only be used in "
-		    "--cached mode");
-
 	if (recurse_submodules && error_unmatch)
 		die("ls-files --recurse-submodules does not support "
 		    "--error-unmatch");

which I admit is somewhat ugly, due to the "yikes" comment above. For
example, I think parse_options() will actually allow a unique prefix
like "--submodule-pre=foo/", which we would not catch. Or worse, we
would accidentally munge the pathspec in:

  git ls-files --recurse-submodules -- --submodule-prefix=foo

(or any case where a non-option looked like "--submodule-prefix=".
Obviously those are pathological, but it's still nasty.

I think we _could_ actually avoid picking out the --submodule-prefix
argument entirely, and instead just add our own at the end to override
it.

I don't think it actually matters that much here.  You _could_ get away
with even leaving the old --submodule-prefix in place, and just adding
our new one at the end to override it. That works, though it does mean
that your argv gets continually longer as you recurse modules. Or I
suppose another way would be to make the prefix option additive, and
then just literally add "--prefix-add=$name" at each level. The option
parser would then build up the real prefix from multiple prefix-add
options.

The final thing I could think of is that we could teach parse_options()
to record a canonicalized copy of all of the options in an argv_array.
So it would normalize "--submodule-pre foo" to "--submodule-prefix=foo",
and that makes our after-the-fact parsing much easier.

But like I said, I dunno. I'm on the fence on which approach is the
least ugly (including your original, to just forward specific options).
They all have their warts. :)

-Peff
