From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] repack: add --keep-unreachable option
Date: Mon, 13 Jun 2016 00:36:28 -0400
Message-ID: <20160613043628.GB3902@sigill.intra.peff.net>
References: <20160613043313.GA29422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 06:36:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCJc3-00086Z-M7
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 06:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbcFMEgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 00:36:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:53596 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750702AbcFMEgb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 00:36:31 -0400
Received: (qmail 23548 invoked by uid 102); 13 Jun 2016 04:36:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:36:31 -0400
Received: (qmail 10039 invoked by uid 107); 13 Jun 2016 04:36:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:36:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 00:36:28 -0400
Content-Disposition: inline
In-Reply-To: <20160613043313.GA29422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297151>

The usual way to do a full repack (and what is done by
git-gc) is to run "repack -Ad --unpack-unreachable=<when>",
which will loosen any unreachable objects newer than
"<when>", and drop any older ones.

This is a safer alternative to "repack -ad", because
"<when>" becomes a grace period during which we will not
drop any new objects that are about to be referenced.
However, it isn't perfectly safe. It's always possible that
a process is about to reference an old object. Even if that
process were to take care to update the timestamp on the
object, there is no atomicity with a simultaneously running
"repack" process.

So while unlikely, there is a small race wherein we may drop
an object that is in the process of being referenced. If you
do automated repacking on a large number of active
repositories, you may hit it eventually, and the result is a
corrupted repository.

It would be nice to fix that race in the long run, but it's
complicated.  In the meantime, there is a much simpler
strategy for automated repository maintenance: do not drop
objects at all. We already have a "--keep-unreachable"
option in pack-objects; we just need to plumb it through
from git-repack.

Note that this _isn't_ plumbed through from git-gc, so at
this point it's strictly a tool for people doing their own
advanced repository maintenance strategy.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-repack.txt         |  6 ++++++
 builtin/repack.c                     |  9 +++++++++
 t/t7701-repack-unpack-unreachable.sh | 15 +++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index cde7b44..68702ea 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -134,6 +134,12 @@ other objects in that pack they already have locally.
 	the write of any objects that would be immediately pruned by
 	a follow-up `git prune`.
 
+-k::
+--keep-unreachable::
+	When used with `-ad`, any unreachable objects from existing
+	packs will be appended to the end of the packfile instead of
+	being removed.
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 858db38..573e66c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -146,6 +146,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int pack_everything = 0;
 	int delete_redundant = 0;
 	const char *unpack_unreachable = NULL;
+	int keep_unreachable = 0;
 	const char *window = NULL, *window_memory = NULL;
 	const char *depth = NULL;
 	const char *max_pack_size = NULL;
@@ -175,6 +176,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("write bitmap index")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
 				N_("with -A, do not loosen objects older than this")),
+		OPT_BOOL('k', "keep-unreachable", &keep_unreachable,
+				N_("with -a, repack unreachable objects")),
 		OPT_STRING(0, "window", &window, N_("n"),
 				N_("size of the window used for delta compression")),
 		OPT_STRING(0, "window-memory", &window_memory, N_("bytes"),
@@ -196,6 +199,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (delete_redundant && repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
+	if (keep_unreachable &&
+	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
+		die(_("--keep-unreachable and -A are incompatible"));
+
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
@@ -239,6 +246,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			} else if (pack_everything & LOOSEN_UNREACHABLE) {
 				argv_array_push(&cmd.args,
 						"--unpack-unreachable");
+			} else if (keep_unreachable) {
+				argv_array_push(&cmd.args, "--keep-unreachable");
 			} else {
 				argv_array_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
 			}
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index b66e383..f13df43 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -122,4 +122,19 @@ test_expect_success 'keep packed objects found only in index' '
 	git cat-file blob :file
 '
 
+test_expect_success 'repack -k keeps unreachable packed objects' '
+	# create packed-but-unreachable object
+	sha1=$(echo unreachable-packed | git hash-object -w --stdin) &&
+	pack=$(echo $sha1 | git pack-objects .git/objects/pack/pack) &&
+	git prune-packed &&
+
+	# -k should keep it
+	git repack -adk &&
+	git cat-file -p $sha1 &&
+
+	# and double check that without -k it would have been removed
+	git repack -ad &&
+	test_must_fail git cat-file -p $sha1
+'
+
 test_done
-- 
2.9.0.rc2.149.gd580ccd
