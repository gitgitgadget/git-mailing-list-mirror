Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 26182 invoked by uid 107); 20 Oct 2009 15:59:24 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 20 Oct 2009 11:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbZJTPzh (ORCPT <rfc822;peff@peff.net>);
	Tue, 20 Oct 2009 11:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbZJTPzh
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 11:55:37 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:63002 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbZJTPzh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 11:55:37 -0400
Received: by gv-out-0910.google.com with SMTP id r4so599016gve.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 08:55:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :message-id:x-mailer:to;
        bh=9XvR2wE/CV7Ehlybwbeix693mVXD1j/iime/Ji3X7tE=;
        b=aAIZtn7Y59LfsYUlXWjYiWWo8zYS7yeKF9yJQpEqgNsoynj3CgQQlweKVKArvjQEP1
         L2DVdz5w59fXt1oU3DOt7b4j5aLk9uVepzkJ2PMf65a5U8qne7VARkkTUXfV8z+Pa+xZ
         MeKEKxk/KUK9aLZwCtWhDPqi5imrUCFWA6jlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:message-id:x-mailer:bcc;
        b=vCcI0rJpMUztP2mVfmA3LaaoEJc+YO73KReLAXRcocHiLkzERkoqs1pFo3Odq32xSu
         MBj5YTLon++j5xhexxN9BZbKhSME3Hev1CTJxEn+xn/hoCBYDNk5eQ3LAjLldPybuqz7
         8ZYinibHGvDj0KW6Uuv164cokSOAVCzXWz6Iw=
Received: by 10.86.214.34 with SMTP id m34mr3912513fgg.6.1256054140100;
        Tue, 20 Oct 2009 08:55:40 -0700 (PDT)
Received: from localhost.localdomain ([132.208.137.8])
        by mx.google.com with ESMTPS id e20sm137295fga.25.2009.10.20.08.55.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Oct 2009 08:55:38 -0700 (PDT)
From:	Jean Privat <jean@pryen.org>
To:	git@vger.kernel.org
Subject: [PATCH v2.5] new --dirty option for git describe
Date:	Tue, 20 Oct 2009 11:56:19 -0400
Message-Id: <1256054179-11449-1-git-send-email-jean@pryen.org>
X-Mailer: git-send-email 1.6.5
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

With the --dirty option, git describe works on HEAD but append "-dirty"
if the working tree is dirty. If the working tree is clean, nothing
is appended.

$ git describe --dirty
v1.6.5-15-gc274db7
$ echo >> Makefile
$ git describe --dirty
v1.6.5-15-gc274db7-dirty

--dirty can also be used to specify what is append if the working
tree is dirty.

$ git describe --dirty=.mod
v1.6.5-15-gc274db7.mod

Many build scripts use `git describe` to produce a version number based
on the description of HEAD (on which is based the working tree) + saying
that if the working tree is dirty or no.
This patch helps the writing of such scripts since `git describe --dirty`
do directly the intended thing.

Alternatives specifications:

1 Describe the working tree by default and describe HEAD only if "HEAD"
  is explicitly specified
Pro: does the right thing by default (both for users and for scripts)
Pro: is coherent with other git commands that works on the working tree
     by default
Con: breaks existing scripts (since the world is not ideal)

2 Use --worktree instead of --dirty
Pro: does what it says: "git describe --worktree" will describe the
     working three
Con: is incoherent with other commands that do not require a --worktree
     option to work on the working tree
Con: unusable with an optional value: "git describe --worktree=.mod"
     is quite unintuitive.

3 Use --dirty as in this patch
Pro: make sense to specify an optional value (what the dirty mark is)
Pro: do not have any of the big cons of previous alternatives
     * does not break scripts
     * is not inconsistent with other git commands
Pro: has an easy fallback to alternative 1 if the world become suddenly
     ideal, or at least allows some kind of future transition plan if
     people *really* bother:
     1- ask that scripts use either "git describe HEAD" or
        "git describe --dirty" (no more "git describe")
     2- change default
     Once the transition is done, the role of the --dirty option will
     just be the way to specify an alternative mark (and a noop if alone)

Signed-off-by: Jean Privat <jean@pryen.org>

---

I tried to integrate the points of view of both Junio and Shawn.
However, I am not sure that what I propose is the right solution.

Changes since v2:
No more line breaks (I hope)

Changes since v1:
use --dirty (alternative 3) instead of defaulting on workdir (alternative 1)

-J-
---
 Documentation/git-describe.txt |    6 ++++++
 builtin-describe.c             |   25 ++++++++++++++++++++++++-
 t/t6120-describe.sh            |   15 +++++++++++++++
 3 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index b231dbb..5253d86 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -9,6 +9,7 @@ git-describe - Show the most recent tag that is reachable from a commit
 SYNOPSIS
 --------
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] <committish>...
+'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
 
 DESCRIPTION
 -----------
@@ -27,6 +28,11 @@ OPTIONS
 <committish>...::
 	Committish object names to describe.
 
+--dirty[=<mark>]::
+	Describe the working tree.
+	It means describe HEAD and appends <mark> (`-dirty` by
+	default) if the working tree is dirty.
+
 --all::
 	Instead of using only the annotated tags, use any ref
 	found in `.git/refs/`.  This option enables matching
diff --git a/builtin-describe.c b/builtin-describe.c
index df67a73..84af981 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -5,12 +5,14 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "diff.h"
 
 #define SEEN		(1u<<0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
 	"git describe [options] <committish>*",
+	"git describe [options] --dirty",
 	NULL
 };
 
@@ -23,6 +25,13 @@ static int max_candidates = 10;
 static int found_names;
 static const char *pattern;
 static int always;
+static const char *dirty;
+
+/* diff-index command arguments to check if working tree is dirty. */
+static const char *diff_index_args[] = {
+	"diff-index", "--quiet", "HEAD", "--", NULL
+};
+
 
 struct commit_name {
 	struct tag *tag;
@@ -208,6 +217,8 @@ static void describe(const char *arg, int last_one)
 		display_name(n);
 		if (longformat)
 			show_suffix(0, n->tag ? n->tag->tagged->sha1 : sha1);
+		if (dirty)
+			printf("%s", dirty);
 		printf("\n");
 		return;
 	}
@@ -265,7 +276,10 @@ static void describe(const char *arg, int last_one)
 	if (!match_cnt) {
 		const unsigned char *sha1 = cmit->object.sha1;
 		if (always) {
-			printf("%s\n", find_unique_abbrev(sha1, abbrev));
+			printf("%s", find_unique_abbrev(sha1, abbrev));
+			if (dirty)
+				printf("%s", dirty);
+			printf("\n");
 			return;
 		}
 		die("cannot describe '%s'", sha1_to_hex(sha1));
@@ -300,6 +314,8 @@ static void describe(const char *arg, int last_one)
 	display_name(all_matches[0].name);
 	if (abbrev)
 		show_suffix(all_matches[0].depth, cmit->object.sha1);
+	if (dirty)
+		printf("%s", dirty);
 	printf("\n");
 
 	if (!last_one)
@@ -324,6 +340,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			   "only consider tags matching <pattern>"),
 		OPT_BOOLEAN(0, "always",     &always,
 			   "show abbreviated commit object as fallback"),
+		{OPTION_STRING, 0, "dirty",       &dirty, "mark",
+			   "append <mark> on dirty working tree (default: \"-dirty\")",
+			   PARSE_OPT_OPTARG, NULL, "-dirty"},
 		OPT_END(),
 	};
 
@@ -360,7 +379,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	}
 
 	if (argc == 0) {
+		if (dirty && !cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1, diff_index_args, prefix))
+			dirty = NULL;
 		describe("HEAD", 1);
+	} else if (dirty) {
+		die("--dirty is incompatible with committishes");
 	} else {
 		while (argc-- > 0) {
 			describe(*argv++, argc == 0);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 8c7e081..ee38f34 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -123,6 +123,21 @@ test_expect_success 'rename tag Q back to A' '
 test_expect_success 'pack tag refs' 'git pack-refs'
 check_describe A-* HEAD
 
+check_describe "A-*[0-9a-f]" --dirty
+
+test_expect_success 'set-up dirty working tree' '
+	echo >>file
+'
+
+check_describe "A-*[0-9a-f]-dirty" --dirty
+
+check_describe "A-*[0-9a-f].mod" --dirty=.mod
+
+test_expect_success 'describe --dirty HEAD' '
+	git describe --dirty HEAD
+	test $? != 0
+'
+
 test_expect_success 'set-up matching pattern tests' '
 	git tag -a -m test-annotated test-annotated &&
 	echo >>file &&
-- 
1.6.5

