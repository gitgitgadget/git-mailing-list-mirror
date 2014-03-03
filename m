From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Mon, 3 Mar 2014 15:04:20 -0500
Message-ID: <20140303200420.GA20675@sigill.intra.peff.net>
References: <20140226101353.GA25711@sigill.intra.peff.net>
 <xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
 <20140227112734.GC29668@sigill.intra.peff.net>
 <xmqqy50wzb2b.fsf@gitster.dls.corp.google.com>
 <20140228085546.GA11709@sigill.intra.peff.net>
 <xmqqob1ruld8.fsf@gitster.dls.corp.google.com>
 <20140301054350.GA20397@sigill.intra.peff.net>
 <xmqqeh2jrvz8.fsf@gitster.dls.corp.google.com>
 <20140303181558.GA16523@sigill.intra.peff.net>
 <xmqqeh2joyc5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:04:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKZ6W-0007k0-MG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 21:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbaCCUEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 15:04:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:60577 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754255AbaCCUEW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 15:04:22 -0500
Received: (qmail 6349 invoked by uid 102); 3 Mar 2014 20:04:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Mar 2014 14:04:22 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Mar 2014 15:04:20 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh2joyc5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243265>

On Mon, Mar 03, 2014 at 11:51:06AM -0800, Junio C Hamano wrote:

> > Yes. Do you need a re-roll from me? I think the last version I sent +
> > the squash to tie the default to bitmap-writing makes the most sense.
> 
> I have 9e20b390 (repack: add `repack.packKeptObjects` config var,
> 2014-02-26); I do not recall I've squashed anything into it, though.
> 
> Do you mean this one?
> 
> Here's the interdiff for doing the fallback:
> [...]

Yes. Though I just noticed that the commit message needs updating if
that is squashed in. Here is the whole patch, with that update.

And I am dropping Vicent as the author, since I think there are now
literally zero lines of his left. ;)

-- >8 --
Subject: [PATCH] repack: add `repack.packKeptObjects` config var

The git-repack command always passes `--honor-pack-keep`
to pack-objects. This has traditionally been a good thing,
as we do not want to duplicate those objects in a new pack,
and we are not going to delete the old pack.

However, when bitmaps are in use, it is important for a full
repack to include all reachable objects, even if they may be
duplicated in a .keep pack. Otherwise, we cannot generate
the bitmaps, as the on-disk format requires the set of
objects in the pack to be fully closed.

Even if the repository does not generally have .keep files,
a simultaneous push could cause a race condition in which a
.keep file exists at the moment of a repack. The repack may
try to include those objects in one of two situations:

  1. The pushed .keep pack contains objects that were
     already in the repository (e.g., blobs due to a revert of
     an old commit).

  2. Receive-pack updates the refs, making the objects
     reachable, but before it removes the .keep file, the
     repack runs.

In either case, we may prefer to duplicate some objects in
the new, full pack, and let the next repack (after the .keep
file is cleaned up) take care of removing them.

This patch introduces both a command-line and config option
to disable the `--honor-pack-keep` option.  By default, it
is triggered when pack.writeBitmaps (or `--write-bitmap-index`
is turned on), but specifying it explicitly can override the
behavior (e.g., in cases where you prefer .keep files to
bitmaps, but only when they are present).

Note that this option just disables the pack-objects
behavior. We still leave packs with a .keep in place, as we
do not necessarily know that we have duplicated all of their
objects.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt     |  7 +++++++
 Documentation/git-repack.txt |  8 ++++++++
 builtin/repack.c             | 13 ++++++++++++-
 t/t7700-repack.sh            | 18 +++++++++++++++++-
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index becbade..a8ddc7f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2136,6 +2136,13 @@ repack.usedeltabaseoffset::
 	"false" and repack. Access from old Git versions over the
 	native protocol are unaffected by this option.
 
+repack.packKeptObjects::
+	If set to true, makes `git repack` act as if
+	`--pack-kept-objects` was passed. See linkgit:git-repack[1] for
+	details. Defaults to `false` normally, but `true` if a bitmap
+	index is being written (either via `--write-bitmap-index` or
+	`pack.writeBitmaps`).
+
 rerere.autoupdate::
 	When set to true, `git-rerere` updates the index with the
 	resulting contents after it cleanly resolves conflicts using
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 002cfd5..4786a78 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -117,6 +117,14 @@ other objects in that pack they already have locally.
 	must be able to refer to all reachable objects. This option
 	overrides the setting of `pack.writebitmaps`.
 
+--pack-kept-objects::
+	Include objects in `.keep` files when repacking.  Note that we
+	still do not delete `.keep` packs after `pack-objects` finishes.
+	This means that we may duplicate objects, but this makes the
+	option safe to use when there are concurrent pushes or fetches.
+	This option is generally only useful if you are writing bitmaps
+	with `-b` or `pack.writebitmaps`, as it ensures that the
+	bitmapped packfile has the necessary objects.
 
 Configuration
 -------------
diff --git a/builtin/repack.c b/builtin/repack.c
index 49f5857..6b0b62d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -9,6 +9,7 @@
 #include "argv-array.h"
 
 static int delta_base_offset = 1;
+static int pack_kept_objects = -1;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -22,6 +23,10 @@ static int repack_config(const char *var, const char *value, void *cb)
 		delta_base_offset = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "repack.packkeptobjects")) {
+		pack_kept_objects = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -175,6 +180,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum delta depth")),
 		OPT_STRING(0, "max-pack-size", &max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
+				N_("repack objects in packs marked with .keep")),
 		OPT_END()
 	};
 
@@ -183,6 +190,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
 
+	if (pack_kept_objects < 0)
+		pack_kept_objects = write_bitmap;
+
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
 
@@ -190,7 +200,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	argv_array_push(&cmd_args, "pack-objects");
 	argv_array_push(&cmd_args, "--keep-true-parents");
-	argv_array_push(&cmd_args, "--honor-pack-keep");
+	if (!pack_kept_objects)
+		argv_array_push(&cmd_args, "--honor-pack-keep");
 	argv_array_push(&cmd_args, "--non-empty");
 	argv_array_push(&cmd_args, "--all");
 	argv_array_push(&cmd_args, "--reflog");
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index b45bd1e..b1eed5c 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -21,7 +21,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
 		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
-	git repack -A -d -l &&
+	git repack --no-pack-kept-objects -A -d -l &&
 	git prune-packed &&
 	for p in .git/objects/pack/*.idx; do
 		idx=$(basename $p)
@@ -35,6 +35,22 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	test -z "$found_duplicate_object"
 '
 
+test_expect_success 'writing bitmaps can duplicate .keep objects' '
+	# build on $objsha1, $packsha1, and .keep state from previous
+	git repack -Adl &&
+	test_when_finished "found_duplicate_object=" &&
+	for p in .git/objects/pack/*.idx; do
+		idx=$(basename $p)
+		test "pack-$packsha1.idx" = "$idx" && continue
+		if git verify-pack -v $p | egrep "^$objsha1"; then
+			found_duplicate_object=1
+			echo "DUPLICATE OBJECT FOUND"
+			break
+		fi
+	done &&
+	test "$found_duplicate_object" = 1
+'
+
 test_expect_success 'loose objects in alternate ODB are not repacked' '
 	mkdir alt_objects &&
 	echo `pwd`/alt_objects > .git/objects/info/alternates &&
-- 
1.8.5.2.500.g8060133
