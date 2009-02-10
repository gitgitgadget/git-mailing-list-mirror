From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 14:11:18 -0500
Message-ID: <20090210191118.GA26651@coredump.intra.peff.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net> <7vwsbynv0o.fsf@gitster.siamese.dyndns.org> <20090210181052.GA19634@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 20:14:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWy3B-0000aO-F8
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 20:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbZBJTLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 14:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757386AbZBJTLY
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 14:11:24 -0500
Received: from peff.net ([208.65.91.99]:60384 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613AbZBJTLW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 14:11:22 -0500
Received: (qmail 16611 invoked by uid 107); 10 Feb 2009 19:11:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 14:11:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 14:11:18 -0500
Content-Disposition: inline
In-Reply-To: <20090210181052.GA19634@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109294>

On Tue, Feb 10, 2009 at 01:10:52PM -0500, Jeff King wrote:

>   - I don't think the "mini" status is really related to this. The novel
>     thing here is collating the outputs into a single sorted list. But
>     the "mini" output is not about that at all:
> 
>       1. It doesn't care about full output, so it should be able to exit
>          early from the diff, avoid rename detection, etc, so that it is
>          as quick as possible.
> 
>       2. It doesn't collate the output at all. It is about three
>          separate symbols for the three separate lists.

OK, I realize this is not exactly what the proposed --mini does. But
here is more along the lines of what I was thinking.

Warm cache, it runs in .042s on my git repo, about half of which is the
untracked files check. It takes about .49s on the kernel repo. The
read_directory() bit is not optimized at all, and could probably benefit
from an early return (OTOH, the worst case is still going to need to
look at every path).

I am not particularly interested in a fancy prompt myself, but maybe
this will help somebody else.

The patch relies on the index_differs_from() patch that Stephan
posted earlier today.

---
 .gitignore           |    1 +
 Makefile             |    1 +
 builtin-ministatus.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h            |    1 +
 git.c                |    1 +
 5 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 055eb54..de2249b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -81,6 +81,7 @@ git-mergetool
 git-mktag
 git-mktree
 git-name-rev
+git-ministatus
 git-mv
 git-notes
 git-pack-redundant
diff --git a/Makefile b/Makefile
index a0ca137..9145c7b 100644
--- a/Makefile
+++ b/Makefile
@@ -559,6 +559,7 @@ BUILTIN_OBJS += builtin-merge-base.o
 BUILTIN_OBJS += builtin-merge-file.o
 BUILTIN_OBJS += builtin-merge-ours.o
 BUILTIN_OBJS += builtin-merge-recursive.o
+BUILTIN_OBJS += builtin-ministatus.o
 BUILTIN_OBJS += builtin-mv.o
 BUILTIN_OBJS += builtin-name-rev.o
 BUILTIN_OBJS += builtin-pack-objects.o
diff --git a/builtin-ministatus.c b/builtin-ministatus.c
new file mode 100644
index 0000000..c9f8e7f
--- /dev/null
+++ b/builtin-ministatus.c
@@ -0,0 +1,52 @@
+#include "cache.h"
+#include "diff.h"
+#include "commit.h"
+#include "revision.h"
+#include "dir.h"
+
+static int worktree_is_dirty(void)
+{
+	struct rev_info rev;
+	init_revisions(&rev, "");
+	setup_revisions(0, NULL, &rev, NULL);
+	DIFF_OPT_SET(&rev.diffopt, QUIET);
+	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+	run_diff_files(&rev, 0);
+	return DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
+}
+
+static int have_untracked(void)
+{
+	struct dir_struct dir;
+	int i;
+
+	memset(&dir, 0, sizeof dir);
+	setup_standard_excludes(&dir);
+
+	read_directory(&dir, ".", "", 0, NULL);
+	/* XXX we are probably leaking memory from dir */
+	for (i = 0; i < dir.nr; i++)
+		struct dir_entry *ent = dir.entries[i];
+		if (cache_name_is_other(ent->name, ent->len))
+			return 1;
+	}
+	return 0;
+}
+
+int cmd_ministatus(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 1)
+		die("Sorry, I don't understand any command line options.");
+
+	read_cache();
+	refresh_cache(REFRESH_QUIET);
+
+	if (index_differs_from("HEAD", 0))
+		putchar('+');
+	if (worktree_is_dirty())
+		putchar('*');
+	if (have_untracked())
+		putchar('?');
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index f054fc7..03e6a88 100644
--- a/builtin.h
+++ b/builtin.h
@@ -71,6 +71,7 @@ extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+extern int cmd_ministatus(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 4c0fa44..8bf7e78 100644
--- a/git.c
+++ b/git.c
@@ -323,6 +323,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "ministatus", cmd_ministatus, RUN_SETUP | NEED_WORK_TREE },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
