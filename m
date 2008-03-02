From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] git-submodule: Don't blame when git-describe fails
Date: Sun, 02 Mar 2008 08:51:57 -0800
Message-ID: <7vy791oyqa.fsf@gitster.siamese.dyndns.org>
References: <1204469152-24227-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 17:52:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrQk-0000Ea-2A
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 17:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbYCBQwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 11:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbYCBQwQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 11:52:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYCBQwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 11:52:15 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 38B652F73;
	Sun,  2 Mar 2008 11:52:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D9A052F70; Sun,  2 Mar 2008 11:52:05 -0500 (EST)
In-Reply-To: <1204469152-24227-1-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Sun, 2 Mar 2008 22:45:52 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75806>

Ping Yin <pkufranky@gmail.com> writes:

> Avoid 'fatal: cannot describe' message
>
> Signed-off-by: Ping Yin <pkufranky@gmail.com>

I see you reworded the commit log somewhat in your second attempt.  I
would have written it this way, though:

    git-submodule: Avoid 'fatal: cannot describe' message
    
    When "git submodule status" command tries to show the name of the
    submodule HEAD revision more descriptively, but the submodule
    repository lacked a suitable tag to do so, it leaked "fatal: cannot
    describe" message to the UI.  Squelch it.

This however makes me wonder if describe or name-rev already has a
suitable option to fall back on showing a unique abbrev when the thing
cannot be described.

If not already, perhaps it should learn how.  This is untested, does not
come with tests nor documentation, but I'll leave them to interested
readers as exercises ;-)

-- >8 --
describe --always: fall back to showing an abbreviated object name

Some callers may find it useful if "git describe" always gave back a
string that can be used as a shorter name for a commit object, rather than
checking its exit status (while squelching its error message, which could
potentially talk about more grave errors that should not be squelched) and
implementing a fallback themselves.

This teaches describe/name-rev a new option, --always, to use an
abbreviated object name when no tags or refs to use is found.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-describe.c |   20 +++++++++++++++-
 builtin-name-rev.c |   59 ++++++++++++++++++++++++++-------------------------
 2 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 05e309f..c1182a3 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -20,6 +20,7 @@ static int tags;	/* But allow any tags if --tags is specified */
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
 const char *pattern = NULL;
+static int always;
 
 struct commit_name {
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
@@ -146,6 +147,17 @@ static unsigned long finish_depth_computation(
 	return seen_commits;
 }
 
+static void cannot_describe(const unsigned char *sha1) NORETURN;
+
+static void cannot_describe(const unsigned char *sha1)
+{
+	if (always) {
+		printf("%s\n", find_unique_abbrev(sha1, DEFAULT_ABBREV));
+		exit(0);
+	}
+	die("cannot describe '%s'", sha1_to_hex(sha1));
+}
+
 static void describe(const char *arg, int last_one)
 {
 	unsigned char sha1[20];
@@ -225,7 +237,7 @@ static void describe(const char *arg, int last_one)
 	}
 
 	if (!match_cnt)
-		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
+		cannot_describe(cmit->object.sha1);
 
 	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
 
@@ -278,6 +290,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			    "consider <n> most recent tags (default: 10)"),
 		OPT_STRING(0, "match",       &pattern, "pattern",
 			   "only consider tags matching <pattern>"),
+		OPT_BOOLEAN(0, "always",     &always,
+			   "show abbreviated commit object as fallback"),
 		OPT_END(),
 	};
 
@@ -290,11 +304,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 
 	if (contains) {
-		const char **args = xmalloc((6 + argc) * sizeof(char*));
+		const char **args = xmalloc((7 + argc) * sizeof(char*));
 		int i = 0;
 		args[i++] = "name-rev";
 		args[i++] = "--name-only";
 		args[i++] = "--no-undefined";
+		if (always)
+			args[i++] = "--always";
 		if (!all) {
 			args[i++] = "--tags";
 			if (pattern) {
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index f22c8b5..384da4d 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -125,7 +125,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 }
 
 /* returns a static buffer */
-static const char *get_rev_name(struct object *o)
+static const char *get_rev_name(const struct object *o)
 {
 	static char buffer[1024];
 	struct rev_name *n;
@@ -151,6 +151,26 @@ static const char *get_rev_name(struct object *o)
 	}
 }
 
+static void show_name(const struct object *obj,
+		      const char *caller_name,
+		      int always, int allow_undefined, int name_only)
+{
+	const char *name;
+	const unsigned char *sha1 = obj->sha1;
+
+	if (!name_only)
+		printf("%s ", caller_name ? caller_name : sha1_to_hex(sha1));
+	name = get_rev_name(obj);
+	if (name)
+		printf("%s\n", name);
+	else if (allow_undefined)
+		printf("undefined\n");
+	else if (always)
+		printf("%s\n", find_unique_abbrev(sha1, DEFAULT_ABBREV));
+	else
+		die("cannot describe '%s'", sha1_to_hex(sha1));
+}
+
 static char const * const name_rev_usage[] = {
 	"git-name-rev [options] ( --all | --stdin | <commit>... )",
 	NULL
@@ -159,7 +179,7 @@ static char const * const name_rev_usage[] = {
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = { 0, 0, NULL };
-	int all = 0, transform_stdin = 0, allow_undefined = 1;
+	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0;
 	struct name_ref_data data = { 0, 0, NULL };
 	struct option opts[] = {
 		OPT_BOOLEAN(0, "name-only", &data.name_only, "print only names (no SHA-1)"),
@@ -170,6 +190,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "all", &all, "list all commits reachable from all refs"),
 		OPT_BOOLEAN(0, "stdin", &transform_stdin, "read from stdin"),
 		OPT_BOOLEAN(0, "undefined", &allow_undefined, "allow to print `undefined` names"),
+		OPT_BOOLEAN(0, "always",     &always,
+			   "show abbreviated commit object as fallback"),
 		OPT_END(),
 	};
 
@@ -258,35 +280,14 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		int i, max;
 
 		max = get_max_object_index();
-		for (i = 0; i < max; i++) {
-			struct object * obj = get_indexed_object(i);
-			const char *name;
-			if (!obj)
-				continue;
-			if (!data.name_only)
-				printf("%s ", sha1_to_hex(obj->sha1));
-			name = get_rev_name(obj);
-			if (name)
-				printf("%s\n", name);
-			else if (allow_undefined)
-				printf("undefined\n");
-			else
-				die("cannot describe '%s'", sha1_to_hex(obj->sha1));
-		}
+		for (i = 0; i < max; i++)
+			show_name(get_indexed_object(i), NULL,
+				  always, allow_undefined, data.name_only);
 	} else {
 		int i;
-		for (i = 0; i < revs.nr; i++) {
-			const char *name;
-			if (!data.name_only)
-				printf("%s ", revs.objects[i].name);
-			name = get_rev_name(revs.objects[i].item);
-			if (name)
-				printf("%s\n", name);
-			else if (allow_undefined)
-				printf("undefined\n");
-			else
-				die("cannot describe '%s'", sha1_to_hex(revs.objects[i].item->sha1));
-		}
+		for (i = 0; i < revs.nr; i++)
+			show_name(revs.objects[i].item, revs.objects[i].name,
+				  always, allow_undefined, data.name_only);
 	}
 
 	return 0;
