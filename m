From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Wed, 27 Oct 2010 10:11:45 -0700
Message-ID: <20101027171145.GA6921@sigill.intra.peff.net>
References: <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705123923.GC21146@sigill.intra.peff.net>
 <20101014185945.GA14634@burratino>
 <20101016143226.GA20515@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, tytso@mit.edu,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Oct 27 19:11:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB9Wh-0001xP-PR
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 19:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab0J0RK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 13:10:58 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36916 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab0J0RK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 13:10:57 -0400
Received: (qmail 17947 invoked by uid 111); 27 Oct 2010 17:10:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 27 Oct 2010 17:10:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Oct 2010 10:11:45 -0700
Content-Disposition: inline
In-Reply-To: <20101016143226.GA20515@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160102>

On Sat, Oct 16, 2010 at 04:32:26PM +0200, Clemens Buchacher wrote:

> On Thu, Oct 14, 2010 at 01:59:45PM -0500, Jonathan Nieder wrote:
> > 
> > project # skewed        maximum skew    notes
> > ------- --------        ------------    -----
> > gtk+    13              13 hrs          worst example seems to be tz related
> 
> It really is kind of fun.
> 
> wine                    1       14 days

Thanks both of you for the extra data points. If you don't mind, would
you consider running my updated git-skew below on your test cases (or
tweaking your skew detectors, since you both seem to be getting a '#
skewed' column that mine didn't output). Specifically, I am interested
in long runs of skewed commits, since one potential solution would be to
just accept a fixed number of slop commits (rather than accepting
commits within a certain slop time).

For the kernel the longest run looks to be about 80 commits. This should
yield much better performance than handling the worst skew by time
(which was 100 days, during which many more than 80 commits are usually
used).

Patch below. NB: thinking on this more, I think my program's results are
slightly inaccurate. There are corner skew cases we can miss by the use
of marking commits SEEN (i.e., skew you would see if you got to a commit
by another path). However, the problem gets intractably large if you
don't mark commits (you end up traversing every possible path through
the graph).

---
 .gitignore     |    1 +
 Makefile       |    1 +
 builtin.h      |    1 +
 builtin/skew.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git.c          |    1 +
 5 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 builtin/skew.c

diff --git a/.gitignore b/.gitignore
index 20560b8..d696c78 100644
--- a/.gitignore
+++ b/.gitignore
@@ -132,6 +132,7 @@
 /git-show-branch
 /git-show-index
 /git-show-ref
+/git-skew
 /git-stage
 /git-stash
 /git-status
diff --git a/Makefile b/Makefile
index 1f1ce04..25f94b0 100644
--- a/Makefile
+++ b/Makefile
@@ -739,6 +739,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/skew.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
diff --git a/builtin.h b/builtin.h
index f2a25a0..e01ac4c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -140,5 +140,6 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
+extern int cmd_skew(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/builtin/skew.c b/builtin/skew.c
new file mode 100644
index 0000000..169a9f4
--- /dev/null
+++ b/builtin/skew.c
@@ -0,0 +1,62 @@
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+unsigned long worst_skew = 0;
+unsigned char worst_skew_sha1[20];
+unsigned long worst_run = 0;
+unsigned char worst_run_sha1[20];
+
+static void check_skew_recurse(struct commit *c, unsigned long when, int counter)
+{
+	struct commit_list *p;
+
+	if (c->object.flags & SEEN)
+		return;
+	c->object.flags |= SEEN;
+
+	if (parse_commit(c) < 0)
+		return;
+
+	if (c->date > when) {
+		unsigned long skew = c->date - when;
+		if (skew > worst_skew) {
+			worst_skew = skew;
+			hashcpy(worst_skew_sha1, c->object.sha1);
+		}
+		if (++counter > worst_run) {
+			worst_run = counter;
+			hashcpy(worst_run_sha1, c->object.sha1);
+		}
+	}
+	else
+		counter = 0;
+
+	for (p = c->parents; p; p = p->next)
+		check_skew_recurse(p->item, c->date < when ? c->date : when, counter);
+}
+
+static void check_skew(struct commit *c)
+{
+	check_skew_recurse(c, time(NULL), 0);
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
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object *o = revs.pending.objects[i].item;
+		if (o->type == OBJ_COMMIT)
+			check_skew((struct commit *)o);
+	}
+
+	printf("worst skew: %lu (%s)\n", worst_skew, sha1_to_hex(worst_skew_sha1));
+	printf("longest run: %lu (%s)\n", worst_run, sha1_to_hex(worst_run_sha1));
+	return 0;
+}
diff --git a/git.c b/git.c
index 0409ac9..1041858 100644
--- a/git.c
+++ b/git.c
@@ -405,6 +405,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "verify-pack", cmd_verify_pack },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+		{ "skew", cmd_skew, RUN_SETUP },
 	};
 	int i;
 	static const char ext[] = STRIP_EXTENSION;
-- 
1.7.3.2.216.g61ab7.dirty
