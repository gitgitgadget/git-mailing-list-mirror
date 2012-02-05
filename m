From: Tom Grennan <tmgrennan@gmail.com>
Subject: [RFC/PATCH] tag: add --points-at list option
Date: Sun,  5 Feb 2012 14:28:07 -0800
Message-ID: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, krh@redhat.com, jasampler@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 23:29:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuAa3-0000eK-2m
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab2BEW3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 17:29:00 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55177 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab2BEW2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 17:28:18 -0500
Received: by vcge1 with SMTP id e1so3576320vcg.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 14:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=c2sbvRRt0zB8xhjWUVMkh0/ww1A3nrjJx9cWnaWcc7Y=;
        b=vFjar3K9yRdSWa65l9CwGcEvYWYcDh9TyNbhlb4OET3OruPPNhWTUwq2mLyOhVvWiT
         W9AquhS9eC+9O1lCbgPTFyhZRFYTK1NSdXxQKnnIyQ3WBadVll0fGorUpuMFPg63aWjQ
         Jhje54owyGHONb7T5i7sduDcuO4OifBm0keBU=
Received: by 10.220.149.212 with SMTP id u20mr8178049vcv.7.1328480897435;
        Sun, 05 Feb 2012 14:28:17 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id eg10sm8993221vdc.7.2012.02.05.14.28.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 14:28:16 -0800 (PST)
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189978>

This filters the list for annotated|signed tags of the given object.
Example,

   john$ git tag -s v1.0-john v1.0
   john$ git tag -l --points-at v1.0
   v1.0-john

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 Documentation/git-tag.txt |    5 +++-
 builtin/tag.c             |   59 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 53ff5f6..b9ec75c 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>...]
+'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>] [<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -86,6 +86,9 @@ OPTIONS
 --contains <commit>::
 	Only list tags which contain the specified commit.
 
+--points-at <object>::
+	Only list annotated or signed tags of the given object.
+
 -m <msg>::
 --message=<msg>::
 	Use the given tag message (instead of prompting).
diff --git a/builtin/tag.c b/builtin/tag.c
index 31f02e8..7568d6c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -19,7 +19,8 @@
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git tag -d <tagname>...",
-	"git tag -l [-n[<num>]] [<pattern>...]",
+	"git tag -l [-n[<num>]] [<pattern>...] \\\n\t\t"
+		"[--contains <commit>] [--points-at <object>]",
 	"git tag -v <tagname>...",
 	NULL
 };
@@ -28,6 +29,7 @@ struct tag_filter {
 	const char **patterns;
 	int lines;
 	struct commit_list *with_commit;
+	const unsigned char *points_at;
 };
 
 static int match_pattern(const char **patterns, const char *ref)
@@ -105,16 +107,28 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 				return 0;
 		}
 
+		buf = read_sha1_file(sha1, &type, &size);
+		if (!buf || !size)
+			return 0;
+
+		if (filter->points_at) {
+			unsigned char tagged_sha1[20];
+			if (memcmp("object ", buf, 7) \
+			    || buf[47] != '\n' \
+			    || get_sha1_hex(buf + 7, tagged_sha1) \
+			    || memcmp(filter->points_at, tagged_sha1, 20)) {
+				free(buf);
+				return 0;
+			}
+		}
+
 		if (!filter->lines) {
 			printf("%s\n", refname);
+			free(buf);
 			return 0;
 		}
 		printf("%-15s ", refname);
 
-		buf = read_sha1_file(sha1, &type, &size);
-		if (!buf || !size)
-			return 0;
-
 		/* skip header */
 		sp = strstr(buf, "\n\n");
 		if (!sp) {
@@ -143,16 +157,20 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 }
 
 static int list_tags(const char **patterns, int lines,
-			struct commit_list *with_commit)
+			struct commit_list *with_commit,
+			unsigned char *points_at)
 {
 	struct tag_filter filter;
 
 	filter.patterns = patterns;
 	filter.lines = lines;
 	filter.with_commit = with_commit;
+	filter.points_at = points_at;
 
 	for_each_tag_ref(show_reference, (void *) &filter);
 
+	if (points_at)
+		free(points_at);
 	return 0;
 }
 
@@ -375,12 +393,28 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
+int parse_opt_points_at(const struct option *opt, const char *arg, int unset)
+{
+	unsigned char *sha1;
+
+	if (!arg)
+		return -1;
+	sha1 = xmalloc(20);
+	if (get_sha1(arg, sha1)) {
+		free(sha1);
+		return error("malformed object name %s", arg);
+	}
+	*(unsigned char **)opt->value = sha1;
+	return 0;
+}
+
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf ref = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
+	unsigned char *points_at;
 	struct ref_lock *lock;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
@@ -417,6 +451,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
+		{
+			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
+			"print only annotated|signed tags of the object",
+			PARSE_OPT_LASTARG_DEFAULT,
+			parse_opt_points_at, (intptr_t)"HEAD",
+		},
 		OPT_END()
 	};
 
@@ -443,11 +483,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_tag_usage, options);
 	if (list)
 		return list_tags(argv, lines == -1 ? 0 : lines,
-				 with_commit);
+				 with_commit, points_at);
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
