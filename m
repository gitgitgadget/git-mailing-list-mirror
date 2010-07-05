From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Mon, 5 Jul 2010 08:39:23 -0400
Message-ID: <20100705123923.GC21146@sigill.intra.peff.net>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Mon Jul 05 14:39:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVkxQ-0004gb-QM
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 14:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758720Ab0GEMj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 08:39:27 -0400
Received: from peff.net ([208.65.91.99]:45772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758649Ab0GEMj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 08:39:26 -0400
Received: (qmail 12264 invoked by uid 107); 5 Jul 2010 12:40:21 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 05 Jul 2010 08:40:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jul 2010 08:39:23 -0400
Content-Disposition: inline
In-Reply-To: <20100705122723.GB21146@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150266>

On Mon, Jul 05, 2010 at 08:27:23AM -0400, Jeff King wrote:

> As you probably guessed from the specificity of the number, I wrote a
> short program to actually traverse and find the worst skew. It takes
> about 5 seconds to run (unsurprisingly, since it is doing the same full
> traversal that we end up doing in the above numbers). So we could
> "autoskew" by setting up the configuration on clone, and then
> periodically updating it as part of "git gc".

This patch doesn't implement auto-detection of skew, but is the program
I used to calculate, and would provide the basis for such
auto-detection. It would be interesting to see average skew numbers for
popular repositories. You can run it as "git skew --all".

diff --git a/.gitignore b/.gitignore
index 14e2b6b..90aff17 100644
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
index 9aca8a1..e673bdf 100644
--- a/Makefile
+++ b/Makefile
@@ -725,6 +725,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/skew.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
diff --git a/builtin.h b/builtin.h
index ed6ee26..5f5dc0a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -141,5 +141,6 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
+extern int cmd_skew(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/builtin/skew.c b/builtin/skew.c
new file mode 100644
index 0000000..1046f5f
--- /dev/null
+++ b/builtin/skew.c
@@ -0,0 +1,50 @@
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+unsigned long worst_skew = 0;
+
+static void check_skew_recurse(struct commit *c, unsigned long when)
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
+		if (skew > worst_skew)
+			worst_skew = skew;
+	}
+
+	for (p = c->parents; p; p = p->next)
+		check_skew_recurse(p->item, c->date < when ? c->date : when);
+}
+
+static void check_skew(struct commit *c)
+{
+	check_skew_recurse(c, time(NULL));
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
+	printf("%lu\n", worst_skew);
+	return 0;
+}
diff --git a/git.c b/git.c
index 265fa09..8a77fe3 100644
--- a/git.c
+++ b/git.c
@@ -399,6 +399,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "verify-pack", cmd_verify_pack },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+		{ "skew", cmd_skew, RUN_SETUP },
 	};
 	int i;
 	static const char ext[] = STRIP_EXTENSION;
