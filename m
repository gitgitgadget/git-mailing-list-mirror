From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/3] submodule: Reimplement `module_list` shell function in C
Date: Thu, 03 Sep 2015 11:57:16 -0700
Message-ID: <xmqqio7rjppv.fsf@gitster.mtv.corp.google.com>
References: <1441230146-26921-1-git-send-email-sbeller@google.com>
	<1441230146-26921-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 20:57:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXZhb-0000zG-36
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 20:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbbICS5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 14:57:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33486 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbICS5S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 14:57:18 -0400
Received: by pacex6 with SMTP id ex6so49840474pac.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=SEjWJDS/JaHN+cJdkqoYYyl5e9wEr1ukr211G8V5FXI=;
        b=Dv6gpdM6zgbFIwhbrutqYD3Wfiah0zqFGkNio+/w3HGxj0CWGWOe2tmhxB0ef9HT7d
         sUos7Yp2Z+VEV+rrA2J3yWCLBaJSiqfNhIbnI1A2Lss4I8tB0KtPo56zFBN7FzHGx0oq
         ts4wFGDHsTY6VIBUKCp2KBk4TneZG/nwIEeo16dk2u3xdbJ33ukt9QBSqUNU3XVRbPdH
         RtZq5+9r8W/QKibfe2jC5CswzBd6jPvEGfwVSD/mciIlRAwGQo3sYBDGXxMeiqXQD5IV
         DMgPROEKmlpTQJj5d0A8iBa0mERXS7wT0yykWPxXaoOlCnpzirFORX1IPjSjwaSZ5zi8
         qo8g==
X-Received: by 10.68.107.100 with SMTP id hb4mr48832416pbb.93.1441306637901;
        Thu, 03 Sep 2015 11:57:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id ts1sm26063025pbc.74.2015.09.03.11.57.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 03 Sep 2015 11:57:17 -0700 (PDT)
In-Reply-To: <1441230146-26921-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 2 Sep 2015 14:42:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277238>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> new file mode 100644
> index 0000000..e97403e
> --- /dev/null
> +++ b/builtin/submodule--helper.c
> @@ -0,0 +1,124 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "quote.h"
> +#include "pathspec.h"
> +#include "dir.h"
> +#include "utf8.h"
> +
> +static const struct cache_entry **ce_entries;
> +static int ce_alloc, ce_used;

It is customary to use X_alloc, X_nr for an array X_something that
is managed by ALLOC_GROW(), I think.  I'd also suggest wrapping
these in a struct and passing it between module_list_compute() and
its callers.

> +	for (i = 0; i < active_nr; i++) {
> +		const struct cache_entry *ce = active_cache[i];
> +
> +		if (!S_ISGITLINK(ce->ce_mode) ||
> +		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
> +				    max_prefix_len, ps_matched,
> +				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
> +			continue;

I may have said this already, but unlike tree entries, the index
entries will never be a directory.  S_ISDIR() check here is
meaningless [*1*].

More importantly when you make this call, you already know that
S_ISGITLINK(ce->ce_mode) is true.  Otherwise you wouldn't be calling
match_pathspec() in the first place.

So this should be:

		if (!S_ISGITLINK(ce->ce_mode) ||
		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
				    max_prefix_len, ps_matched, 1))

I think.

I'll attach a suggested changes on top to be squashed in.

> +struct cmd_struct {
> +	const char *cmd;
> +	int (*fn)(int, const char **, const char *);
> +};
> +
> +static struct cmd_struct commands[] = {
> +	{"list", module_list},
> +};
> +
> +int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	if (argc < 2)
> +		die(_("fatal: submodule--helper subcommand must be "
> +		      "called with a subcommand"));
> +
> +	for (i = 0; i < ARRAY_SIZE(commands); i++)
> +		if (!strcmp(argv[1], commands[i].cmd))
> +			return commands[i].fn(argc - 1, argv + 1, prefix);
> +
> +	die(_("fatal: '%s' is not a valid submodule--helper "
> +	      "subcommand"), argv[1]);
> +}

Nice and clean code structure.  I like it ;-).

[Footnote]

*1* It is a benign bug, as a ce that is S_ISGITLINK() always
satisfies S_ISDIR() by chance.  But it is a bug nevertheless.

builtin/ls-files.c and dir.h, the former of which you copied
this code from, may want be corrected.  These mistakes were
introduced by ae8d0824 (pathspec: pass directory indicator to
match_pathspec_item(), 2014-01-24).  Further, I suspect these
mistakes were copied from ce_to_dtype() in cache.h, whose mistake
was introduced by d6b8fc30 (gitignore(5): Allow "foo/" in ignore
list to match directory "foo", 2008-01-31).

That commit mistakenly copied S_ISDIR() check from create_ce_mode(),
but create_ce_mode() is fed st.st_mode and checking for S_ISDIR() is
a correct thing to use there.

In short, there are three hits from "git grep 'S_ISDIR(ce'" that
checks if ce->ce_mode is S_ISDIR() || S_ISGITLINK(); they all should
check only for S_ISGITLINK().


 builtin/submodule--helper.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e97403e..10db4e6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -6,12 +6,16 @@
 #include "dir.h"
 #include "utf8.h"
 
-static const struct cache_entry **ce_entries;
-static int ce_alloc, ce_used;
+struct module_list {
+	const struct cache_entry **entries;
+	int alloc, nr;
+};
+#define MODULE_LIST_INIT { NULL, 0, 0 }
 
 static int module_list_compute(int argc, const char **argv,
-				const char *prefix,
-				struct pathspec *pathspec)
+			       const char *prefix,
+			       struct pathspec *pathspec,
+			       struct module_list *list)
 {
 	int i, result = 0;
 	char *max_prefix, *ps_matched = NULL;
@@ -36,12 +40,11 @@ static int module_list_compute(int argc, const char **argv,
 
 		if (!S_ISGITLINK(ce->ce_mode) ||
 		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
-				    max_prefix_len, ps_matched,
-				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
+				    max_prefix_len, ps_matched, 1))
 			continue;
 
-		ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
-		ce_entries[ce_used++] = ce;
+		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
+		list->entries[list->nr++] = ce;
 		while (i + 1 < active_nr &&
 		       !strcmp(ce->name, active_cache[i + 1]->name))
 			/*
@@ -64,6 +67,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_list_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -80,13 +84,13 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_list_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec) < 0) {
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
 		printf("#unmatched\n");
 		return 1;
 	}
 
-	for (i = 0; i < ce_used; i++) {
-		const struct cache_entry *ce = ce_entries[i];
+	for (i = 0; i < list.nr; i++) {
+		const struct cache_entry *ce = list.entries[i];
 
 		if (ce_stage(ce))
 			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
