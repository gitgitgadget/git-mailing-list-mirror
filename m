From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Speed up git tag --contains
Date: Wed, 6 Jul 2011 02:54:52 -0400
Message-ID: <20110706065452.GB927@sigill.intra.peff.net>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 08:55:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeM0j-0007Wk-04
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 08:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab1GFGy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 02:54:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45363
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab1GFGyz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 02:54:55 -0400
Received: (qmail 16358 invoked by uid 107); 6 Jul 2011 06:55:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jul 2011 02:55:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2011 02:54:52 -0400
Content-Disposition: inline
In-Reply-To: <20110706064012.GA927@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176642>

On Wed, Jul 06, 2011 at 02:40:12AM -0400, Jeff King wrote:

> As it is now, I don't think so. Tweaking core.clockskew is slow, as
> shown above. And it's not something people should have to do manually. I
> have a version, which I'll post in a minute, which actually fills in a
> notes tree with the sha1 of commits with bogus timestamps. And then
> that tree can be consulted accurately and automatically.

Here's that patch. I think I did this after our discussion at
GitTogether 2010, and haven't looked at it since. So beware.

Clemens mentioned elsewhere that my skew-detection programs only find
skew in one direction. And I think that may be a problem here. We are
basically finding commits which have a timestamp in the past from their
most recent parent. So that means in a history like this:

  A---B---C--D--E--F

  timestamp(A) = 1
  timestamp(B) = 2
  timestamp(C) = 1
  timestamp(D) = 4
  timestamp(E) = 5

We will see that commit C is bogus, since it is in the past from its
parent. But if a commit skews to the future:

  timestamp(A) = 1
  timestamp(B) = 2
  timestamp(C) = 6
  timestamp(D) = 4
  timestamp(E) = 5

then everything _after_ it will look bogus (D and E, in this case).

>From what we've seen, it seems like skewing into the past is more
common. It seems to come from importing old commits and using their
timestamps as the commit timestamps. It would be nice to find a more
accurate set (I _think_ with future skew like the second example above,
the patch below will not give wrong answers; it will just be overly
pessimal and traverse more commits than it needs to).

---
 .gitignore     |    1 +
 Makefile       |    1 +
 builtin.h      |    1 +
 builtin/skew.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.c       |   20 +++++++++++++++++---
 git.c          |    1 +
 6 files changed, 77 insertions(+), 3 deletions(-)
 create mode 100644 builtin/skew.c

diff --git a/.gitignore b/.gitignore
index acffdfa..503ef8b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -137,6 +137,7 @@
 /git-show-branch
 /git-show-index
 /git-show-ref
+/git-skew
 /git-stage
 /git-stash
 /git-status
diff --git a/Makefile b/Makefile
index f8c72e1..f6ecc27 100644
--- a/Makefile
+++ b/Makefile
@@ -765,6 +765,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/skew.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
diff --git a/builtin.h b/builtin.h
index 0e9da90..0be47ca 100644
--- a/builtin.h
+++ b/builtin.h
@@ -143,5 +143,6 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
+extern int cmd_skew(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/builtin/skew.c b/builtin/skew.c
new file mode 100644
index 0000000..796b02a
--- /dev/null
+++ b/builtin/skew.c
@@ -0,0 +1,56 @@
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "notes-cache.h"
+
+struct notes_cache bogus_timestamps;
+
+static unsigned long check_skew(struct commit *c)
+{
+	struct commit_list *p;
+	unsigned long most_recent;
+
+	if (c->util)
+		return (unsigned long)c->util;
+
+	if (parse_commit(c) < 0)
+		die("unable to parse commit: %s", sha1_to_hex(c->object.sha1));
+
+	most_recent = 0;
+	for (p = c->parents; p; p = p->next) {
+		unsigned long timestamp = check_skew(p->item);
+		if (timestamp > most_recent)
+			most_recent = timestamp;
+	}
+
+	if (c->date + 86400 < most_recent)
+		notes_cache_put(&bogus_timestamps, c->object.sha1, "", 0);
+	else
+		most_recent = c->date;
+
+	c->util = (void *)most_recent;
+	return most_recent;
+}
+
+int cmd_skew(int argc, const char **argv, const char *prefix) {
+	struct rev_info revs;
+	int i;
+
+	git_config(git_default_config, NULL);
+	init_revisions(&revs, prefix);
+	argc = setup_revisions(argc, argv, &revs, NULL);
+
+	notes_cache_init(&bogus_timestamps, "traversal-cutoff-ignore", "v1");
+
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object *o = revs.pending.objects[i].item;
+		if (o->type == OBJ_COMMIT)
+			check_skew((struct commit *)o);
+	}
+
+	if (notes_cache_write(&bogus_timestamps) < 0)
+		die_errno("unable to write notes tree");
+
+	return 0;
+}
diff --git a/commit.c b/commit.c
index 6647609..1bec48b 100644
--- a/commit.c
+++ b/commit.c
@@ -5,7 +5,7 @@
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
-#include "notes.h"
+#include "notes-cache.h"
 
 int core_clock_skew = 86400;
 int save_commit_buffer = 1;
@@ -888,6 +888,19 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 	return 0;
 }
 
+static int has_bogus_timestamp(unsigned char sha1[20])
+{
+	static int initialized;
+	static struct notes_cache bogus;
+
+	if (!initialized) {
+		notes_cache_init(&bogus, "traversal-cutoff-ignore", "v1");
+		initialized = 1;
+	}
+
+	return get_note(&bogus.tree, sha1) != NULL;
+}
+
 static int contains_recurse(struct commit *candidate,
 			    const struct commit_list *want,
 			    unsigned long cutoff)
@@ -908,8 +921,9 @@ static int contains_recurse(struct commit *candidate,
 		return 0;
 
 	/* stop searching if we go too far back in time */
-	if (candidate->date < cutoff)
-		return 0;
+	if (candidate->date < cutoff &&
+	    !has_bogus_timestamp(candidate->object.sha1))
+			return 0;
 
 	/* Otherwise recurse and mark ourselves for future traversals. */
 	for (p = candidate->parents; p; p = p->next) {
diff --git a/git.c b/git.c
index 8828c18..7adeba7 100644
--- a/git.c
+++ b/git.c
@@ -408,6 +408,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "show", cmd_show, RUN_SETUP },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
+		{ "skew", cmd_skew, RUN_SETUP },
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
-- 
1.7.6.20.g45f3f.dirty
