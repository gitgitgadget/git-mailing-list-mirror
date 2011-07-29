From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC/PATCH] ls-files: fix pathspec display on error
Date: Fri, 29 Jul 2011 15:03:30 +0200
Message-ID: <20110729130330.GA31941@toss.lan>
References: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
 <b535c21e1becdf8aeeb1d3f8ddaa7f5415830844.1311767679.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	rrt@sc3d.org, john@szakmeister.net
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 29 15:03:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmmj8-0006Ar-E8
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 15:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525Ab1G2NDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 09:03:37 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:60558 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756469Ab1G2NDg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 09:03:36 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 0890D130063;
	Fri, 29 Jul 2011 15:03:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b535c21e1becdf8aeeb1d3f8ddaa7f5415830844.1311767679.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178147>

The following sequence of commands reveals an issue with error
reporting of relative paths:

 $ mkdir sub
 $ cd sub
 $ git ls-files --error-unmatch ../bbbbb
 error: pathspec 'b' did not match any file(s) known to git.
 $ git commit --error-unmatch ../bbbbb
 error: pathspec 'b' did not match any file(s) known to git.

This bug is visible only if the normalized path (i.e., the relative
path from the repository root) is longer than the prefix.
Otherwise, the code skips over the normalized path and reads from
an unused memory location which still contains a leftover of the
original command line argument.

So instead, use the existing facilities to deal with relative paths
correctly.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
On Wed, Jul 27, 2011 at 01:56:14PM +0200, Michael J Gruber wrote:
>
> So, I couldn't reproduce because it depends on the length of the dirname.
> This may be fallout from efad1a5 (ls-files: allow relative pathspec, 2010-06-03)

Since that was me I had a look. I don't think this is a regression,
however.  We have had this bug probably forever. Fortunately, it's
easy to fix with what we already have.

Clemens

 builtin/checkout.c |    2 +-
 builtin/commit.c   |    2 +-
 builtin/ls-files.c |   11 ++++++++---
 cache.h            |    2 +-
 quote.c            |    8 ++++++--
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d647a31..a3380d9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -231,7 +231,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
 	}
 
-	if (report_path_error(ps_matched, pathspec, 0))
+	if (report_path_error(ps_matched, pathspec, NULL, -1))
 		return 1;
 
 	/* "checkout -m path" to recreate conflicted state */
diff --git a/builtin/commit.c b/builtin/commit.c
index e1af9b1..a16d00b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -272,7 +272,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 			item->util = item; /* better a valid pointer than a fake one */
 	}
 
-	return report_path_error(m, pattern, prefix ? strlen(prefix) : 0);
+	return report_path_error(m, pattern, prefix, -1);
 }
 
 static void add_remove_files(struct string_list *list)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1570123..72b986f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -388,11 +388,14 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 	}
 }
 
-int report_path_error(const char *ps_matched, const char **pathspec, int prefix_len)
+int report_path_error(const char *ps_matched, const char **pathspec,
+		const char *prefix, int prefix_len)
 {
 	/*
 	 * Make sure all pathspec matched; otherwise it is an error.
 	 */
+	struct strbuf sb = STRBUF_INIT;
+	const char *name;
 	int num, errors = 0;
 	for (num = 0; pathspec[num]; num++) {
 		int other, found_dup;
@@ -417,10 +420,12 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 		if (found_dup)
 			continue;
 
+		name = quote_path_relative(pathspec[num], -1, &sb, prefix);
 		error("pathspec '%s' did not match any file(s) known to git.",
-		      pathspec[num] + prefix_len);
+		      name);
 		errors++;
 	}
+	strbuf_release(&sb);
 	return errors;
 }
 
@@ -611,7 +616,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	if (ps_matched) {
 		int bad;
-		bad = report_path_error(ps_matched, pathspec, prefix_len);
+		bad = report_path_error(ps_matched, pathspec, prefix, prefix_len);
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
 
diff --git a/cache.h b/cache.h
index 9e12d55..86518fb 100644
--- a/cache.h
+++ b/cache.h
@@ -1188,7 +1188,7 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
-int report_path_error(const char *ps_matched, const char **pathspec, int prefix_offset);
+int report_path_error(const char *ps_matched, const char **pathspec, const char *prefix, int prefix_len);
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
diff --git a/quote.c b/quote.c
index 63d3b01..532fd3b 100644
--- a/quote.c
+++ b/quote.c
@@ -325,8 +325,12 @@ static const char *path_relative(const char *in, int len,
 
 	if (len < 0)
 		len = strlen(in);
-	if (prefix && prefix_len < 0)
-		prefix_len = strlen(prefix);
+	if (prefix_len < 0) {
+		if (prefix)
+			prefix_len = strlen(prefix);
+		else
+			prefix_len = 0;
+	}
 
 	off = 0;
 	i = 0;
-- 
1.7.3.1.105.g84915
