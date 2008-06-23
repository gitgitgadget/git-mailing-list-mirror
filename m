From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 13:26:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806231312130.6440@racer>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 14:29:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAlAz-00055E-QB
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 14:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYFWM2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 08:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbYFWM2o
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 08:28:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:49918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752683AbYFWM2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 08:28:43 -0400
Received: (qmail invoked by alias); 23 Jun 2008 12:28:41 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp002) with SMTP; 23 Jun 2008 14:28:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18N0Z1k7MENPUw7lD3hZla468UBTauunxfWVaBcH3
	dQeBT+MuGND1Ht
X-X-Sender: gene099@racer
In-Reply-To: <20080623082223.GA12130@artemis.madism.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85856>

Hi,

On Mon, 23 Jun 2008, Pierre Habouzit wrote:

> This "PARSE_OPT_IGNORE_UNRECOGNIZED" thing has been discussed many times 
> in the past, but it just doesn't fly.
> 
> Though to help migrations we can probably introduce a new parse option
> construct that would be a callback that is responsible for dealing with
> "things" the upper level parser doesn't know about, something where the
> callback could be:
> 
> enum {
>     FLAG_ERROR = -1,
>     FLAG_NOT_FOR_ME,
>     FLAG_IS_FOR_ME,
>     FLAG_AND_VALUE_ARE_FOR_ME,
> }
> 
> int (*parse_opt_unknown_cb)(int shortopt, const char *longopt,
>                             const char *value, void *priv);

I believe that this is what Junio was talking about when he mentioned 
callbacks.

However, I think it buys us more trouble than it saves us.

Thinking about the recursive approach again, I came up with this POC:

-- snip --
[PATCH] parse-options: make it possible to have option "subtables"

Some programs share an awful lot of options, such as for the diff
machinery.  Allow an option table to recurse into another option
table with the new OPTION_OPTIONS() directive.

The subtable is expected to store the values into a struct whose address
is passed as 2nd parameter to OPTION_OPTIONS().

Subtables can recurse into subtables, too.

Example:

	#define null ((struct diff_options *)NULL)
	struct option diff__options[] = {
		OPT_INTEGER('l', NULL, &null->rename_limit,
			"set rename limit"),
		[...]
	};

	struct option diff_files__options[] = {
		[...]
		OPTION_OPTIONS(diff__options, &revopt.diff_options),
		[...]
	};

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 parse-options.c      |   42 ++++++++++++++++++++++++++++++++++++++++++
 parse-options.h      |    5 +++++
 test-parse-options.c |   16 ++++++++++++++++
 3 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b8bde2b..c13c503 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
+#include "cache.h"
 
 #define OPT_SHORT 1
 #define OPT_UNSET 2
@@ -247,6 +248,41 @@ void check_typos(const char *arg, const struct option *options)
 	}
 }
 
+struct growable_options {
+	int nr, alloc;
+	struct option *options;
+};
+
+static void *add_base_var(void *value, void *base_var)
+{
+	return (void *)(((char *)base_var) +
+			(((char *)value) - ((char *)NULL)));
+}
+
+static void expand_option_tables(const struct option *options, void *base_var,
+		struct growable_options *result, int add_option_end)
+{
+	for (; options->type != OPTION_END; options++) {
+		if (options->type == OPTION_OPTIONS)
+			expand_option_tables(options->option_table,
+					add_base_var(options->value, base_var),
+					result, 0);
+		else {
+			ALLOC_GROW(result->options,
+					result->nr + 1, result->alloc);
+			result->options[result->nr] = *options;
+			if (base_var)
+				result->options[result->nr].value =
+					add_base_var(options->value, base_var);
+			result->nr++;
+		}
+	}
+	if (add_option_end) {
+		ALLOC_GROW(result->options, result->nr + 1, result->alloc);
+		result->options[result->nr++].type = OPTION_END;
+	}
+}
+
 static NORETURN void usage_with_options_internal(const char * const *,
                                                  const struct option *, int);
 
@@ -254,6 +290,10 @@ int parse_options(int argc, const char **argv, const struct option *options,
                   const char * const usagestr[], int flags)
 {
 	struct optparse_t args = { argv + 1, argv, argc - 1, 0, NULL };
+	struct growable_options growable_options = { 0, 0, NULL };
+
+	expand_option_tables(options, NULL, &growable_options, 1);
+	options = growable_options.options;
 
 	for (; args.argc; args.argc--, args.argv++) {
 		const char *arg = args.argv[0];
@@ -298,6 +338,8 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			usage_with_options(usagestr, options);
 	}
 
+	free(growable_options.options);
+
 	memmove(args.out + args.cpidx, args.argv, args.argc * sizeof(*args.out));
 	args.out[args.cpidx + args.argc] = NULL;
 	return args.cpidx + args.argc;
diff --git a/parse-options.h b/parse-options.h
index 4ee443d..be6e858 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -15,6 +15,8 @@ enum parse_opt_type {
 	OPTION_STRING,
 	OPTION_INTEGER,
 	OPTION_CALLBACK,
+	/* recursing into another options table */
+	OPTION_OPTIONS,
 };
 
 enum parse_opt_flags {
@@ -83,6 +85,7 @@ struct option {
 	int flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
+	struct option *option_table;
 };
 
 #define OPT_END()                   { OPTION_END }
@@ -99,6 +102,8 @@ struct option {
 	  parse_opt_approxidate_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
+#define OPT_OPTIONS(table, base_var) \
+	{ OPTION_OPTIONS, 0, NULL, base_var, NULL, NULL, 0, NULL, 0, table }
 
 /* parse_options() will filter out the processed options and leave the
  * non-option argments in argv[].
diff --git a/test-parse-options.c b/test-parse-options.c
index 2a79e72..5032e71 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -18,8 +18,21 @@ int length_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+struct some_struct {
+	int an_int;
+	char *a_string;
+};
+#define some_struct_null ((struct some_struct *)NULL)
+struct option an_option_table[] = {
+	OPT_GROUP("An option table"),
+	OPT_INTEGER('Y', NULL, &some_struct_null->an_int, "an integer"),
+	OPT_STRING(0, "a-string", &some_struct_null->a_string,
+		"a-string", "get another string"),
+};
+
 int main(int argc, const char **argv)
 {
+	struct some_struct some = { 0, NULL };
 	const char *usage[] = {
 		"test-parse-options <options>",
 		NULL
@@ -42,6 +55,7 @@ int main(int argc, const char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_SET_PTR(0, "default-string", &string,
 			"set string to default", (unsigned long)"default"),
+		OPT_OPTIONS(an_option_table, (void *)&some),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
 		OPT_GROUP("Standard options"),
@@ -62,6 +76,8 @@ int main(int argc, const char **argv)
 	printf("verbose: %d\n", verbose);
 	printf("quiet: %s\n", quiet ? "yes" : "no");
 	printf("dry run: %s\n", dry_run ? "yes" : "no");
+	printf("an int: %d\n", some.an_int);
+	printf("a string: %s\n", some.a_string);
 
 	for (i = 0; i < argc; i++)
 		printf("arg %02d: %s\n", i, argv[i]);
-- 
1.5.6.127.g3fb9f
-- snap --


Maybe this is food for thought.

Ciao,
Dscho
