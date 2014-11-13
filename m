From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 20:36:16 +0700
Message-ID: <20141113133615.GA28346@lanh>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 13 14:36:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XouZG-0007p2-2X
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 14:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933146AbaKMNgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 08:36:03 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58758 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932941AbaKMNgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 08:36:00 -0500
Received: by mail-pa0-f49.google.com with SMTP id lj1so15043790pab.8
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 05:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2av6Ye2LApSq8CHzLLyL1G3Lmx9yMi+pPbkS8U0reiI=;
        b=NpDPoAbYuiG+DG8b4naLnfd1A6GvlkivFS9qRuqGU56ZvR6yHFHAFEDiVFQMw1d0LB
         3JzT+tvaJ1WdcLSSLi5e6+Li0WaDREM25OJ4rp9T+aXSQf0wnqIyM/5BpZkvSX6PyIRp
         ldKg6hTb2EzTdKPr/sFEbua4MyEE5UU6AkglO3Bcsx8ZbOi2D+kPP/df0T+MrbYBfnY0
         ryaxZZErU6jgnopN2BHYZ6D67YHHVNgxsI2BkB4AWniz394hBFaIXG06uTWd7RCFJz4j
         cSSJGAxa/SVzsrUvkirG+Flpi/CZ1Ru1KHcnq/k4QxUrVXFiQHSZ0XcVFuSxD06aSo1v
         Dxbw==
X-Received: by 10.68.197.170 with SMTP id iv10mr2528917pbc.135.1415885760276;
        Thu, 13 Nov 2014 05:36:00 -0800 (PST)
Received: from lanh ([115.73.253.1])
        by mx.google.com with ESMTPSA id fy8sm4805541pdb.84.2014.11.13.05.35.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2014 05:35:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 13 Nov 2014 20:36:16 +0700
Content-Disposition: inline
In-Reply-To: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 12:32:40PM +0000, Graeme Geldenhuys wrote:
> [alias]
>     deploy = !sh -c 'git archive --prefix=$1/ -o deploy_$1.zip HEAD 
> $(git diff --name-only -D $2)' -
> 
> This works very well. The only problem we have so far is that if we 
> have files with spaces in the name (eg: SQL update scripts), then the 
> command breaks.
> 
> Does anybody have an idea on how this can be resolved?  Any help would 
> be much appreciated.

I wonder if it's overkill to do something like this patch ("git
archive" may need some more updates for it to work though). With it
you can do:

  git diff --name-only ... | git archive ... HEAD -- ":(file)-"

The good thing is it works for other commands as well. But is it
really a good thing..

-- 8<--
Subject: [PATCH] pathspec: support :(file)

This pathspec magic must be used alone. It reads the actual pathspec
from a given file whose path is specified after :(file). E.g.

  git ls-files :(file)foo

list files specified by pathspec in file "foo". Reading from stdin is
possible to:

  git ls-fiels :(file)-

TODO: specify line terminator..
---
 pathspec.c | 38 ++++++++++++++++++++++++++++++++++++++
 pathspec.h |  4 +++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 9304ee3..ba34f9b 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "pathspec.h"
+#include "argv-array.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -72,6 +73,7 @@ static struct pathspec_magic {
 	{ PATHSPEC_GLOB,   '\0', "glob" },
 	{ PATHSPEC_ICASE,  '\0', "icase" },
 	{ PATHSPEC_EXCLUDE, '!', "exclude" },
+	{ PATHSPEC_FROMFILE, 0, "file" },
 };
 
 static void prefix_short_magic(struct strbuf *sb, int prefixlen,
@@ -235,6 +237,9 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	} else if (magic & PATHSPEC_FROMTOP) {
 		match = xstrdup(copyfrom);
 		prefixlen = 0;
+	} else if ((magic & PATHSPEC_FROMFILE) && !strcmp(copyfrom, "-")) {
+		match = xstrdup(copyfrom);
+		prefixlen = 0;
 	} else {
 		match = prefix_path_gently(prefix, prefixlen, &prefixlen, copyfrom);
 		if (!match)
@@ -354,6 +359,31 @@ static void NORETURN unsupported_magic(const char *pattern,
 	    pattern, sb.buf);
 }
 
+static void pathspec_fromfile(struct pathspec *pathspec,
+			      unsigned magic_mask, unsigned flags,
+			      const char *prefix, const char *path)
+{
+	struct strbuf buf, nbuf;
+	int line_termination = '\n'; /* FIXME: support :(file:<line terminator>) */
+	struct argv_array av = ARGV_ARRAY_INIT;
+	FILE *fp = !strcmp(path, "-") ? stdin : fopen(path, "r");
+
+	if (!fp)
+		die_errno(_("fail to open %s"), path);
+
+	strbuf_init(&buf, 0);
+	strbuf_init(&nbuf, 0);
+	while (strbuf_getline(&buf, fp, line_termination) != EOF)
+		argv_array_push(&av, buf.buf);
+	strbuf_release(&buf);
+	strbuf_release(&nbuf);
+	if (fp != stdin)
+		fclose(fp);
+	parse_pathspec(pathspec, magic_mask | PATHSPEC_FROMFILE,
+		       flags, prefix, av.argv);
+	/* cannot free av because pathspec keeps references to it */
+}
+
 /*
  * Given command line arguments and a prefix, convert the input to
  * pathspec. die() if any magic in magic_mask is used.
@@ -427,6 +457,14 @@ void parse_pathspec(struct pathspec *pathspec,
 					  item[i].magic & magic_mask,
 					  short_magic);
 
+		if (item[i].magic & PATHSPEC_FROMFILE) {
+			if (n != 1)
+				die(_(":(file) can only be used alone"));
+			pathspec_fromfile(pathspec,
+					  magic_mask | PATHSPEC_FROMFILE,
+					  flags, prefix, item[i].match);
+			return;
+		}
 		if ((flags & PATHSPEC_SYMLINK_LEADING_PATH) &&
 		    has_symlink_leading_path(item[i].match, item[i].len)) {
 			die(_("pathspec '%s' is beyond a symbolic link"), entry);
diff --git a/pathspec.h b/pathspec.h
index 0c11262..84de102 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -8,13 +8,15 @@
 #define PATHSPEC_GLOB		(1<<3)
 #define PATHSPEC_ICASE		(1<<4)
 #define PATHSPEC_EXCLUDE	(1<<5)
+#define PATHSPEC_FROMFILE	(1<<6)
 #define PATHSPEC_ALL_MAGIC	  \
 	(PATHSPEC_FROMTOP	| \
 	 PATHSPEC_MAXDEPTH	| \
 	 PATHSPEC_LITERAL	| \
 	 PATHSPEC_GLOB		| \
 	 PATHSPEC_ICASE		| \
-	 PATHSPEC_EXCLUDE)
+	 PATHSPEC_EXCLUDE	| \
+	 PATHSPEC_FROMFILE)
 
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
-- 
2.1.0.rc0.78.gc0d8480

-- 8< --
