From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCH-master] tag: add --points-at list option
Date: Wed,  8 Feb 2012 15:03:43 -0800
Message-ID: <1328742223-24419-2-git-send-email-tmgrennan@gmail.com>
References: <1328742223-24419-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 00:04:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvGYS-0003d8-4o
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 00:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521Ab2BHXD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 18:03:57 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:35956 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757462Ab2BHXD4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 18:03:56 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id va7so1428149obc.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 15:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=42UUFTwcLdg9SnUOcfZQ8jUTMpJC5P3VC+l33BUs1PU=;
        b=nO1riU8y/G3x/tuj3aTx68M16HTm7MOLvil76eDvuqzdYHeHg2H5/3g+Ut5gPCiIjp
         BMY0B/jl0hxre4VGvnZULlVabvdftX5UF9c2XX4tc4YlNFAnzpZJZnfKAbpPfquD7PF4
         0xA0ZnwZeqWf4ccFafFCXeBhBz3SPuiInIZQ8=
Received: by 10.182.202.69 with SMTP id kg5mr27910028obc.35.1328742235919;
        Wed, 08 Feb 2012 15:03:55 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id s6sm886257obq.0.2012.02.08.15.03.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Feb 2012 15:03:55 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1328742223-24419-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120208205857.GA22479@sigill.intra.peff.net>
References: <20120208205857.GA22479@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190264>

This filters the list for tags of the given object.
Example,

   john$ git tag v1.0-john v1.0
   john$ git tag -l --points-at v1.0
   v1.0-john
   v1.0

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 Documentation/git-tag.txt |    6 ++++-
 builtin/tag.c             |   50 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t7004-tag.sh            |   39 +++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 53ff5f6..8d32b9a 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>...]
+'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
+	[<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -86,6 +87,9 @@ OPTIONS
 --contains <commit>::
 	Only list tags which contain the specified commit.
 
+--points-at <object>::
+	Only list tags of the given object.
+
 -m <msg>::
 --message=<msg>::
 	Use the given tag message (instead of prompting).
diff --git a/builtin/tag.c b/builtin/tag.c
index 31f02e8..27c3557 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -15,11 +15,13 @@
 #include "diff.h"
 #include "revision.h"
 #include "gpg-interface.h"
+#include "sha1-array.h"
 
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git tag -d <tagname>...",
-	"git tag -l [-n[<num>]] [<pattern>...]",
+	"git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>] "
+		"\n\t\t[<pattern>...]",
 	"git tag -v <tagname>...",
 	NULL
 };
@@ -30,6 +32,8 @@ struct tag_filter {
 	struct commit_list *with_commit;
 };
 
+static struct sha1_array points_at;
+
 static int match_pattern(const char **patterns, const char *ref)
 {
 	/* no pattern means match everything */
@@ -41,6 +45,24 @@ static int match_pattern(const char **patterns, const char *ref)
 	return 0;
 }
 
+static const unsigned char *match_points_at(const char *refname,
+					    const unsigned char *sha1)
+{
+	const unsigned char *tagged_sha1 = NULL;
+	struct object *obj;
+
+	if (sha1_array_lookup(&points_at, sha1) >= 0)
+		return sha1;
+	obj = parse_object(sha1);
+	if (!obj)
+		die(_("malformed object at '%s'"), refname);
+	if (obj->type == OBJ_TAG)
+		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
+	if (tagged_sha1 && sha1_array_lookup(&points_at, tagged_sha1) >= 0)
+		return tagged_sha1;
+	return NULL;
+}
+
 static int in_commit_list(const struct commit_list *want, struct commit *c)
 {
 	for (; want; want = want->next)
@@ -105,6 +127,9 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 				return 0;
 		}
 
+		if (points_at.nr && !match_points_at(refname, sha1))
+			return 0;
+
 		if (!filter->lines) {
 			printf("%s\n", refname);
 			return 0;
@@ -375,6 +400,23 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
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
@@ -417,6 +459,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
+		{
+			OPTION_CALLBACK, 0, "points-at", NULL, "object",
+			"print only tags of the object", 0, parse_opt_points_at
+		},
 		OPT_END()
 	};
 
@@ -448,6 +494,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("-n option is only allowed with -l."));
 	if (with_commit)
 		die(_("--contains option is only allowed with -l."));
+	if (points_at.nr)
+		die(_("--points-at option is only allowed with -l."));
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e93ac73..f61e398 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1269,4 +1269,43 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -v -s
 '
 
+# check points-at
+
+test_expect_success '--points-at cannot be used in non-list mode' '
+	test_must_fail git tag --points-at=v4.0 foo
+'
+
+test_expect_success '--points-at finds lightweight tags' '
+	echo v4.0 >expect &&
+	git tag --points-at v4.0 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--points-at finds annotated tags of commits' '
+	git tag -m "v4.0, annotated" annotated-v4.0 v4.0 &&
+	echo annotated-v4.0 >expect &&
+	git tag -l --points-at v4.0 "annotated*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--points-at finds annotated tags of tags' '
+	git tag -m "describing the v4.0 tag object" \
+		annotated-again-v4.0 annotated-v4.0 &&
+	cat >expect <<-\EOF &&
+	annotated-again-v4.0
+	annotated-v4.0
+	EOF
+	git tag --points-at=annotated-v4.0 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'multiple --points-at are OR-ed together' '
+	cat >expect <<-\EOF &&
+	v2.0
+	v3.0
+	EOF
+	git tag --points-at=v2.0 --points-at=v3.0 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.8
