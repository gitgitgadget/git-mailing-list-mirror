From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] show-ref: migrate to parse-options
Date: Sat, 20 Jun 2009 21:40:46 -0700
Message-ID: <1245559246-11039-2-git-send-email-bebarino@gmail.com>
References: <1245559246-11039-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 06:46:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIEwb-0006WR-52
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 06:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbZFUEkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 00:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbZFUEkw
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 00:40:52 -0400
Received: from mail-pz0-f197.google.com ([209.85.222.197]:56989 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbZFUEkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 00:40:51 -0400
Received: by pzk35 with SMTP id 35so85687pzk.33
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 21:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0OHx21Yr4Cs1w5Jv7LPWF3S0DXBMdVK7bknTvZBWMqE=;
        b=qnwBimN8wem5LT5oRViEP9+j3v7u+zbapbtIoZUYRTPO0DtuLm7hJibST+OwK5MbK9
         Ood0Aw90mrp8Zm35ylSYeGk1ZM68v+MTu+tizNNCeDeVVszSxkHErx2A0IROnQZQdgmF
         E9CQkeGWtDgd42OFGveE3Mve8A+ZaR6vInhfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nIJSduYwY+Y8Z3iBaIBsyYImAK2eh83SQ4WvkTQ/ZuZ5ywDBkjLBm1pYx2ejHLyHRc
         TBfOTHL/ezVo0SYtkUugwbw+Jq+Gub6s8QTPviPDukgHjh/Mhn1wBdUKLL5ucagczTeS
         g8DbmqfhGQyhtk543COQM1UUv1tX8m7kDdJdw=
Received: by 10.142.133.19 with SMTP id g19mr2064118wfd.126.1245559253669;
        Sat, 20 Jun 2009 21:40:53 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id 28sm164723wfg.25.2009.06.20.21.40.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 21:40:52 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 20 Jun 2009 21:40:50 -0700
X-Mailer: git-send-email 1.6.3.2.316.gda4e
In-Reply-To: <1245559246-11039-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121960>

Also make the docs more consistent with the usage message. While we're
here remove the zero initializers from the static variables as they're
unnecessary.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-show-ref.txt |   15 ++---
 builtin-show-ref.c             |  133 ++++++++++++++++++----------------------
 2 files changed, 67 insertions(+), 81 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 98e294a..f4429bd 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -9,8 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git show-ref' [-q|--quiet] [--verify] [-h|--head] [-d|--dereference]
-	     [-s|--hash] [--abbrev] [--tags] [--heads] [--] <pattern>...
-'git show-ref' --exclude-existing[=pattern]
+	     [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
+	     [--heads] [--] <pattern>...
+'git show-ref' --exclude-existing[=<pattern>] < ref-list
 
 DESCRIPTION
 -----------
@@ -48,7 +49,7 @@ OPTIONS
 	appended.
 
 -s::
---hash::
+--hash[=<n>]::
 
 	Only show the SHA1 hash, not the reference name. When combined with
 	--dereference the dereferenced tag will still be shown after the SHA1.
@@ -59,11 +60,10 @@ OPTIONS
 	Aside from returning an error code of 1, it will also print an error
 	message if '--quiet' was not specified.
 
---abbrev::
---abbrev=len::
+--abbrev[=<n>]::
 
 	Abbreviate the object name.  When using `--hash`, you do
-	not have to say `--hash --abbrev`; `--hash=len` would do.
+	not have to say `--hash --abbrev`; `--hash=n` would do.
 
 -q::
 --quiet::
@@ -71,8 +71,7 @@ OPTIONS
 	Do not print any results to stdout. When combined with '--verify' this
 	can be used to silently check if a reference exists.
 
---exclude-existing::
---exclude-existing=pattern::
+--exclude-existing[=<pattern>]::
 
 	Make 'git-show-ref' act as a filter that reads refs from stdin of the
 	form "^(?:<anything>\s)?<refname>(?:\^\{\})?$" and performs the
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index dc76c50..c46550c 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -4,12 +4,18 @@
 #include "object.h"
 #include "tag.h"
 #include "string-list.h"
+#include "parse-options.h"
 
-static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] < ref-list";
+static const char * const show_ref_usage[] = {
+	"git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [pattern*] ",
+	"git show-ref --exclude-existing[=pattern] < ref-list",
+	NULL
+};
 
-static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0,
-	found_match = 0, verify = 0, quiet = 0, hash_only = 0, abbrev = 0;
+static int deref_tags, show_head, tags_only, heads_only, found_match, verify,
+	   quiet, hash_only, abbrev, exclude_arg;
 static const char **pattern;
+static const char *exclude_existing_arg;
 
 static void show_one(const char *refname, const unsigned char *sha1)
 {
@@ -150,79 +156,60 @@ static int exclude_existing(const char *match)
 	return 0;
 }
 
+static int hash_callback(const struct option *opt, const char *arg, int unset)
+{
+	hash_only = 1;
+	/* Use full length SHA1 if no argument */
+	if (!arg)
+		return 0;
+	return parse_opt_abbrev_cb(opt, arg, unset);
+}
+
+static int exclude_existing_callback(const struct option *opt, const char *arg,
+				     int unset)
+{
+	exclude_arg = 1;
+	*(const char **)opt->value = arg;
+	return 0;
+}
+
+static int help_callback(const struct option *opt, const char *arg, int unset)
+{
+	return -1;
+}
+
+static const struct option show_ref_options[] = {
+	OPT_BOOLEAN(0, "tags", &tags_only, "only show tags (can be combined with heads)"),
+	OPT_BOOLEAN(0, "heads", &heads_only, "only show heads (can be combined with tags)"),
+	OPT_BOOLEAN(0, "verify", &verify, "stricter reference checking, "
+		    "requires exact ref path"),
+	OPT_BOOLEAN('h', "head", &show_head, "show the HEAD reference"),
+	OPT_BOOLEAN('d', "dereference", &deref_tags,
+		    "dereference tags into object IDs"),
+	{ OPTION_CALLBACK, 's', "hash", &abbrev, "n",
+	  "only show SHA1 hash using <n> digits",
+	  PARSE_OPT_OPTARG, &hash_callback },
+	OPT__ABBREV(&abbrev),
+	OPT__QUIET(&quiet),
+	{ OPTION_CALLBACK, 0, "exclude-existing", &exclude_existing_arg,
+	  "pattern", "show refs from stdin that aren't in local repository",
+	  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback },
+	{ OPTION_CALLBACK, 0, "help-all", NULL, NULL, "show usage",
+	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
+	OPT_END()
+};
+
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	argc = parse_options(argc, argv, prefix, show_ref_options,
+			     show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (*arg != '-') {
-			pattern = argv + i;
-			break;
-		}
-		if (!strcmp(arg, "--")) {
-			pattern = argv + i + 1;
-			if (!*pattern)
-				pattern = NULL;
-			break;
-		}
-		if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet")) {
-			quiet = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-h") || !strcmp(arg, "--head")) {
-			show_head = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-d") || !strcmp(arg, "--dereference")) {
-			deref_tags = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-s") || !strcmp(arg, "--hash")) {
-			hash_only = 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--hash=") ||
-		    (!prefixcmp(arg, "--abbrev") &&
-		     (arg[8] == '=' || arg[8] == '\0'))) {
-			if (arg[2] != 'h' && !arg[8])
-				/* --abbrev only */
-				abbrev = DEFAULT_ABBREV;
-			else {
-				/* --hash= or --abbrev= */
-				char *end;
-				if (arg[2] == 'h') {
-					hash_only = 1;
-					arg += 7;
-				}
-				else
-					arg += 9;
-				abbrev = strtoul(arg, &end, 10);
-				if (*end || abbrev > 40)
-					usage(show_ref_usage);
-				if (abbrev < MINIMUM_ABBREV)
-					abbrev = MINIMUM_ABBREV;
-			}
-			continue;
-		}
-		if (!strcmp(arg, "--verify")) {
-			verify = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--tags")) {
-			tags_only = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--heads")) {
-			heads_only = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--exclude-existing"))
-			return exclude_existing(NULL);
-		if (!prefixcmp(arg, "--exclude-existing="))
-			return exclude_existing(arg + 19);
-		usage(show_ref_usage);
-	}
+	if (exclude_arg)
+		return exclude_existing(exclude_existing_arg);
+
+	pattern = argv;
+	if (!*pattern)
+		pattern = NULL;
 
 	if (verify) {
 		if (!pattern)
-- 
1.6.3.2.316.gda4e
