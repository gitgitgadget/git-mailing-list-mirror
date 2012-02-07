From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2] tag: add --points-at list option
Date: Mon,  6 Feb 2012 23:01:16 -0800
Message-ID: <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
References: <1328598076-7773-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 08:01:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruf3b-0000Lm-Q5
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 08:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557Ab2BGHBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 02:01:32 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44690 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756554Ab2BGHBa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 02:01:30 -0500
Received: by qadc10 with SMTP id c10so2599071qad.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 23:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=N0mBwb2yRHeI743DNZi/NV4xq8UPxERrSW+/7l0Y6Bk=;
        b=dXPVwcp5SbeLvTa+TEX0CA/OYRU+aXcjk5ni4GAFVujEKYKxGR9vyH0BPu3luoMzrx
         uQciz0vP5Ystrj5Ng7+nr+p3Dx6wpUYjL9IoZpikNeEVi/u5LVPDgTMFiNuqsV2a0ssy
         xMR4W3fUC1s7/9ep7/0F4njq6NbgG3QYl8hKw=
Received: by 10.229.136.144 with SMTP id r16mr8598810qct.62.1328598089542;
        Mon, 06 Feb 2012 23:01:29 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id dm8sm39035448qab.18.2012.02.06.23.01.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 23:01:28 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1328598076-7773-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120206081119.GA3939@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190147>

This filters the list for annotated|signed tags of the given object.
Example,

   john$ git tag -s v1.0-john v1.0
   john$ git tag -l --points-at v1.0
   v1.0-john

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 Documentation/git-tag.txt |    5 ++-
 builtin/tag.c             |   86 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 5ead91e..97bedec 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>]
+'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
 	[--column[=<options>] | --no-column] [<pattern>...]
 'git tag' -v <tagname>...
 
@@ -95,6 +95,9 @@ This option is only applicable when listing tags without annotation lines.
 --contains <commit>::
 	Only list tags which contain the specified commit.
 
+--points-at <object>::
+	Only list annotated or signed tags of the given object.
+
 -m <msg>::
 --message=<msg>::
 	Use the given tag message (instead of prompting).
diff --git a/builtin/tag.c b/builtin/tag.c
index 5fbd62c..a1d3a04 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -20,17 +20,34 @@
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git tag -d <tagname>...",
-	"git tag -l [-n[<num>]] [<pattern>...]",
+	"git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>] \\"
+		"\n\t\t[<pattern>...]",
 	"git tag -v <tagname>...",
 	NULL
 };
 
+struct points_at {
+	struct points_at *next;
+	unsigned char *sha1;
+};
+
 struct tag_filter {
 	const char **patterns;
 	int lines;
 	struct commit_list *with_commit;
+	struct points_at *points_at;
 };
 
+static void free_points_at (struct points_at *points_at)
+{
+	while (points_at) {
+		struct points_at *next = points_at->next;
+		free(points_at->sha1);
+		free(points_at);
+		points_at = next;
+	}
+}
+
 static unsigned int colopts;
 
 static int match_pattern(const char **patterns, const char *ref)
@@ -44,6 +61,29 @@ static int match_pattern(const char **patterns, const char *ref)
 	return 0;
 }
 
+static struct points_at *match_points_at(struct points_at *points_at,
+					 const unsigned char *sha1)
+{
+	char *buf;
+	struct tag *tag;
+	unsigned long size;
+	enum object_type type;
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return NULL;
+	if (type != OBJ_TAG
+	    || (tag = lookup_tag(sha1), !tag)
+	    || parse_tag_buffer(tag, buf, size) < 0) {
+		free(buf);
+		return NULL;
+	}
+	while (points_at && hashcmp(points_at->sha1, tag->tagged->sha1))
+		points_at = points_at->next;
+	free(buf);
+	return points_at;
+}
+
 static int in_commit_list(const struct commit_list *want, struct commit *c)
 {
 	for (; want; want = want->next)
@@ -141,6 +181,10 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 				return 0;
 		}
 
+		if (filter->points_at
+		    && !match_points_at(filter->points_at, sha1))
+			return 0;
+
 		if (!filter->lines) {
 			printf("%s\n", refname);
 			return 0;
@@ -154,16 +198,19 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 }
 
 static int list_tags(const char **patterns, int lines,
-			struct commit_list *with_commit)
+			struct commit_list *with_commit,
+			struct points_at *points_at)
 {
 	struct tag_filter filter;
 
 	filter.patterns = patterns;
 	filter.lines = lines;
 	filter.with_commit = with_commit;
+	filter.points_at = points_at;
 
 	for_each_tag_ref(show_reference, (void *) &filter);
 
+	free_points_at(points_at);
 	return 0;
 }
 
@@ -389,12 +436,33 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
+int parse_opt_points_at(const struct option *opt, const char *arg, int unset)
+{
+	struct points_at *new, **opt_value = (struct points_at **)opt->value;
+	unsigned char *sha1;
+
+	if (!arg)
+		return error(_("missing <object>"));
+	new = xmalloc(sizeof(struct points_at));
+	sha1 = xmalloc(20);
+	if (get_sha1(arg, sha1)) {
+		free(new);
+		free(sha1);
+		return error(_("malformed object name '%s'"), arg);
+	}
+	new->sha1 = sha1;
+	new->next = *opt_value;
+	*opt_value = new;
+	return 0;
+}
+
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf ref = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
+	struct points_at *points_at = NULL;
 	struct ref_lock *lock;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
@@ -432,6 +500,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
+		{
+			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
+			"print only annotated|signed tags of the object",
+			PARSE_OPT_LASTARG_DEFAULT,
+			parse_opt_points_at, (intptr_t)NULL,
+		},
 		OPT_END()
 	};
 
@@ -471,15 +545,17 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			copts.padding = 2;
 			run_column_filter(colopts, &copts);
 		}
-		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit);
+		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit,
+				points_at);
 		if (lines == -1 && colopts & COL_ENABLED)
 			stop_column_filter();
 		return ret;
 	}
 	if (lines != -1)
 		die(_("-n option is only allowed with -l."));
-	if (with_commit)
-		die(_("--contains option is only allowed with -l."));
+	if (with_commit || points_at)
+		die(_("--contains and --points-at options "
+		      "are only allowed with -l."));
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
-- 
1.7.8
