From: Linus Torvalds <torvalds@osdl.org>
Subject: Add a "git-describe" command
Date: Sat, 24 Dec 2005 13:50:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Dec 24 22:51:21 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqHIG-0003ve-Ps
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 22:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVLXVux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 16:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVLXVux
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 16:50:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750730AbVLXVuw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 16:50:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBOLokDZ027603
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Dec 2005 13:50:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBOLojSO012377;
	Sat, 24 Dec 2005 13:50:46 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14038>


It shows you the most recent tag that is reachable from a particular
commit is.

Maybe this is something that "git-name-rev" should be taught to do, 
instead of having a separate command for it. Regardless, I find it useful.

What it does is to take any random commit, and "name" it by looking up the 
most recent commit that is tagged and reachable from that commit. If the 
match is exact, it will just print out that ref-name directly. Otherwise 
it will print out the ref-name, followed by the 8-character "short SHA".

IOW, with something like Junios current tree, I get:

	[torvalds@g5 git]$ git-describe parent
	refs/tags/v1.0.4-g2414721b

ie the current head of my "parent" branch (ie Junio) is based on v1.0.4, 
but since it has a few commits on top of that, it has added the git hash 
of the thing to the end: "-g" + 8-char shorthand for the commit 
2414721b194453f058079d897d13c4e377f92dc6.

Doing a "git-describe" on a tag-name will just show the full tag path:

	[torvalds@g5 git]$ git-describe v1.0.4
	refs/tags/v1.0.4

unless there are _other_ tags pointing to that commit, in which case it 
will just choose one at random.

This is useful for two things:

 - automatic version naming in Makefiles, for example. We could use it in 
   git itself: when doing "git --version", we could use this to give a 
   much more useful description of exactly what version was installed.

 - for any random commit (say, you use "gitk <pathname>" or 
   "git-whatchanged" to look at what has changed in some file), you can 
   figure out what the last version of the repo was. Ie, say I find a bug 
   in commit 39ca371c45b04cd50d0974030ae051906fc516b6, I just do:

	[torvalds@g5 linux]$ git-describe 39ca371c45b04cd50d0974030ae051906fc516b6
	refs/tags/v2.6.14-rc4-g39ca371c

   and I now know that it was _not_ in v2.6.14-rc4, but was presumably in 
   v2.6.14-rc5.

The latter is useful when you want to see what "version timeframe" a 
commit happened in.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Comments?

			Linus

diff --git a/Makefile b/Makefile
index 3395a9e..47e7898 100644
--- a/Makefile
+++ b/Makefile
@@ -135,7 +135,8 @@ PROGRAMS = \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
-	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X
+	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
+	git-describe$X
 
 # what 'all' will build and 'install' will install.
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS) git$X
diff --git a/describe.c b/describe.c
new file mode 100644
index 0000000..ebfa429
--- /dev/null
+++ b/describe.c
@@ -0,0 +1,118 @@
+#include "cache.h"
+#include "commit.h"
+#include "refs.h"
+
+#define SEEN (1u << 0)
+
+static const char describe_usage[] = "git-describe [--all] <committish>*";
+
+static int all = 0;	/* Default to tags only */
+
+static int names = 0, allocs = 0;
+static struct commit_name {
+	const struct commit *commit;
+	char path[];
+} **name_array = NULL;
+
+static struct commit_name *match(struct commit *cmit)
+{
+	int i = names;
+	struct commit_name **p = name_array;
+
+	while (i-- > 0) {
+		struct commit_name *n = *p++;
+		if (n->commit == cmit)
+			return n;
+	}
+	return NULL;
+}
+
+static void add_to_known_names(const char *path, const struct commit *commit)
+{
+	int idx;
+	int len = strlen(path)+1;
+	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
+
+	name->commit = commit;
+	memcpy(name->path, path, len);
+	idx = names;
+	if (idx >= allocs) {
+		allocs = (idx + 50) * 3 / 2;
+		name_array = xrealloc(name_array, allocs*sizeof(*name_array));
+	}
+	name_array[idx] = name;
+	names = ++idx;
+}
+
+static int get_name(const char *path, const unsigned char *sha1)
+{
+	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	if (!commit)
+		return 0;
+	if (!all && strncmp(path, "refs/tags/", 10))
+		return 0;
+	add_to_known_names(path, commit);
+	return 0;
+}
+
+static int compare_names(const void *_a, const void *_b)
+{
+	struct commit_name *a = *(struct commit_name **)_a;
+	struct commit_name *b = *(struct commit_name **)_b;
+	unsigned long a_date = a->commit->date;
+	unsigned long b_date = b->commit->date;
+	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
+}
+
+static void describe(struct commit *cmit)
+{
+	struct commit_list *list;
+	static int initialized = 0;
+	struct commit_name *n;
+
+	if (!initialized) {
+		initialized = 1;
+		for_each_ref(get_name);
+		qsort(name_array, names, sizeof(*name_array), compare_names);
+	}
+
+	n = match(cmit);
+	if (n) {
+		printf("%s\n", n->path);
+		return;
+	}
+
+	list = NULL;
+	commit_list_insert(cmit, &list);
+	while (list) {
+		struct commit *c = pop_most_recent_commit(&list, SEEN);
+		n = match(c);
+		if (n) {
+			printf("%s-g%.8s\n", n->path, sha1_to_hex(cmit->object.sha1));
+			return;
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		unsigned char sha1[20];
+		struct commit *cmit;
+
+		if (!strcmp(arg, "--all")) {
+			all = 1;
+			continue;
+		}
+		if (get_sha1(arg, sha1) < 0)
+			usage(describe_usage);
+		cmit = lookup_commit_reference(sha1);
+		if (!cmit)
+			usage(describe_usage);
+		describe(cmit);
+	}
+	return 0;
+}
