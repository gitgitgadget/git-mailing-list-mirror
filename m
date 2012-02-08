From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv3] tag: add --points-at list option
Date: Tue,  7 Feb 2012 22:21:16 -0800
Message-ID: <1328682076-23380-2-git-send-email-tmgrennan@gmail.com>
References: <1328682076-23380-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 07:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv0uT-0004gy-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 07:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab2BHGVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 01:21:34 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49940 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab2BHGVe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 01:21:34 -0500
Received: by vbjk17 with SMTP id k17so139067vbj.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 22:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=dwibnHOjp29mXz9U6i9KzKtZ87K/DWO5XH6Lw7mw8Uw=;
        b=Lp+t3yLU6LXs9yj6ZMu4JxATip21h8eKm4ywQspebNw1iinM10NRVM4G/QTHG/ruuE
         PbWIxtB9aizin86mXybvdaSwoLxq/Eq6mqpBDlthYeiWz5BZopPrXHvcOCEav+2wSZJx
         tPatNKccS7bYUuInQoh0AWpj6ZFxXt62mQE7s=
Received: by 10.220.148.146 with SMTP id p18mr15188665vcv.6.1328682093120;
        Tue, 07 Feb 2012 22:21:33 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id ir2sm286389vdb.9.2012.02.07.22.21.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 22:21:32 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1328682076-23380-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120208002554.GA6035@sigill.intra.peff.net>
References: <20120208002554.GA6035@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190222>

This filters the list for tags of the given object.
Example,

   john$ git tag v1.0-john v1.0
   john$ git tag -l --points-at v1.0
   v1.0-john

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 Documentation/git-tag.txt |    5 +++-
 builtin/tag.c             |   50 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 5ead91e..124ed36 100644
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
+	Only list tags of the given object.
+
 -m <msg>::
 --message=<msg>::
 	Use the given tag message (instead of prompting).
diff --git a/builtin/tag.c b/builtin/tag.c
index 5fbd62c..c5da622 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -16,11 +16,13 @@
 #include "revision.h"
 #include "gpg-interface.h"
 #include "column.h"
+#include "sha1-array.h"
 
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git tag -d <tagname>...",
-	"git tag -l [-n[<num>]] [<pattern>...]",
+	"git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>] \\"
+		"\n\t\t[<pattern>...]",
 	"git tag -v <tagname>...",
 	NULL
 };
@@ -31,6 +33,7 @@ struct tag_filter {
 	struct commit_list *with_commit;
 };
 
+static struct sha1_array points_at;
 static unsigned int colopts;
 
 static int match_pattern(const char **patterns, const char *ref)
@@ -44,6 +47,22 @@ static int match_pattern(const char **patterns, const char *ref)
 	return 0;
 }
 
+static const unsigned char *match_points_at(const unsigned char *sha1)
+{
+	int i;
+	const unsigned char *tagged_sha1 = (unsigned char*)"";
+	struct object *obj = parse_object(sha1);
+
+	if (obj && obj->type == OBJ_TAG)
+		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
+	for (i = 0; i < points_at.nr; i++)
+		if (!hashcmp(points_at.sha1[i], sha1))
+			return sha1;
+		else if (!hashcmp(points_at.sha1[i], tagged_sha1))
+			return tagged_sha1;
+	return NULL;
+}
+
 static int in_commit_list(const struct commit_list *want, struct commit *c)
 {
 	for (; want; want = want->next)
@@ -141,6 +160,9 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 				return 0;
 		}
 
+		if (points_at.nr && !match_points_at(sha1))
+			return 0;
+
 		if (!filter->lines) {
 			printf("%s\n", refname);
 			return 0;
@@ -389,6 +411,23 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
+int parse_opt_points_at(const struct option *opt __attribute__ ((unused)),
+			const char *arg, int unset)
+{
+	unsigned char sha1[20];
+
+	if (unset) {
+		sha1_array_clear(&points_at);
+		return 0;
+	}
+	if (!arg)
+		return error(_("switch 'points-at' requires an object"));
+	if (get_sha1(arg, sha1))
+		return error(_("malformed object name '%s'"), arg);
+	sha1_array_append(&points_at, sha1);
+	return 0;
+}
+
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -432,6 +471,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
+		{
+			OPTION_CALLBACK, 0, "points-at", NULL, "object",
+			"print only tags of the object", 0, parse_opt_points_at
+		},
 		OPT_END()
 	};
 
@@ -478,8 +521,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (lines != -1)
 		die(_("-n option is only allowed with -l."));
-	if (with_commit)
-		die(_("--contains option is only allowed with -l."));
+	if (with_commit || points_at.nr)
+		die(_("--contains and --points-at options "
+		      "are only allowed with -l."));
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
-- 
1.7.8
