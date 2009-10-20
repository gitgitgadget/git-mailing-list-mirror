From: Jean Privat <jean@pryen.org>
Subject: [PATCH v2] new --dirty option for git describe
Date: Tue, 20 Oct 2009 10:27:11 -0400
Message-ID: <dffdbd190910200727r30e161ffka0b3cf764be26cd8@mail.gmail.com>
References: <1255800990-7806-1-git-send-email-jean@pryen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 16:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Fn5-00084V-Qp
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 16:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbZJTOeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 10:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZJTOeL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 10:34:11 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:60737 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbZJTOeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 10:34:09 -0400
Received: by pzk26 with SMTP id 26so4129441pzk.4
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=B9/bIYRom4MGdqmUMRjgm5hGsNK9rGj29nRnBqVFXBg=;
        b=kWAGyWreiwNBCd0hbOyDWtDt1j9Fb+8vCL3m1HMt6DdIzXd9Y8QLthRCIqV9tyKTzF
         nFOBt3ASu+zB+uEI62Fh1E9ZfyrGuYrLACm84p5zCGv2AE56uMVx+ShLlkQJCduLj855
         9pyYItWg2FbKmk3tcu7F3XLrP5AY404PlE6+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=oLurCGgxaPvvfKCk99Yh65B6XabvuemWeASxjdfNJDdH3f/8JCVg5o6xyU0x/a7sEN
         k/q+fbDoeenh36G1MscuquMdl3PRpJCcig+carjJMu3P1w+KJiSzxlO1V0xfuzOD10gY
         0NGI4IOz6a/SnCkt6SaYZJrM5SuEuee1tfQv4=
Received: by 10.140.128.9 with SMTP id a9mr1646805rvd.152.1256048851909; Tue, 
	20 Oct 2009 07:27:31 -0700 (PDT)
In-Reply-To: <1255800990-7806-1-git-send-email-jean@pryen.org>
X-Google-Sender-Auth: 720de896fa750680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130797>

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
@@ -9,6 +9,7 @@ git-describe - Show the most recent tag that is
reachable from a commit
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
@@ -324,6 +340,9 @@ int cmd_describe(int argc, const char **argv,
const char *prefix)
 			   "only consider tags matching <pattern>"),
 		OPT_BOOLEAN(0, "always",     &always,
 			   "show abbreviated commit object as fallback"),
+		{OPTION_STRING, 0, "dirty",       &dirty, "mark",
+			   "append <mark> on dirty working tree (default: \"-dirty\")",
+			   PARSE_OPT_OPTARG, NULL, "-dirty"},
 		OPT_END(),
 	};

@@ -360,7 +379,11 @@ int cmd_describe(int argc, const char **argv,
const char *prefix)
 	}

 	if (argc == 0) {
+		if (dirty && !cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1,
diff_index_args, prefix))
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
