From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Mon, 24 Feb 2014 03:24:59 -0500
Message-ID: <20140224082459.GA32594@sigill.intra.peff.net>
References: <52E080C1.4030402@fb.com>
 <20140123225238.GB2567@sigill.intra.peff.net>
 <52E1A99D.6010809@fb.com>
 <52E1AB78.1000504@fb.com>
 <20140124022822.GC4521@sigill.intra.peff.net>
 <52E1D39B.4050103@fb.com>
 <20140128060954.GA26401@sigill.intra.peff.net>
 <xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 09:25:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHqqd-0007a6-14
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 09:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbaBXIZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 03:25:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:55885 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751761AbaBXIZB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 03:25:01 -0500
Received: (qmail 16761 invoked by uid 102); 24 Feb 2014 08:25:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 02:25:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 03:24:59 -0500
Content-Disposition: inline
In-Reply-To: <xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242575>

On Tue, Jan 28, 2014 at 01:21:43AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The git-repack command always passes `--honor-pack-keep`
> > to pack-objects. This has traditionally been a good thing,
> > as we do not want to duplicate those objects in a new pack,
> > and we are not going to delete the old pack.
> > ...
> > Note that this option just disables the pack-objects
> > behavior. We still leave packs with a .keep in place, as we
> > do not necessarily know that we have duplicated all of their
> > objects.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Intended for the jk/pack-bitmap topic.
> 
> Two comments.

Sorry, this one slipped through the cracks. Here's a re-roll addressing
your comments.

>  - It seems that this adds a configuration variable that cannot be
>    countermanded from the command line. It has to come with either a
>    very good justification in the documentation describing why it is
>    a bad idea to even allow overriding from the command line in a
>    repository that sets it, or a command line option to let the
>    users override it. I personally prefer the latter, because that
>    will be one less thing for users to remember (i.e. "usually you
>    can override the configured default from the command line, but
>    this variable cannot be because of these very good reasons").

It was less "it is a bad idea to override" and more "I cannot conceive
of any good reason to override". And since you can always use "git -c",
I didn't think it was worth cluttering repack's options.

However, I suppose if one were explicitly bitmapping a single invocation
with `git repack -adb`, it might make sense to use it on the command
line. Fixed in the re-roll.

>  - In the context of "pack-objects", the name "--honor-pack-keep"
>    makes sense; it is understood that pack-objects will _not_ remove
>    kept packfile, so "honoring" can only mean "do not attempt to
>    pick objects out of kept packs to add to the pack being
>    generated." and there is no room for --no-honor-pack-keep to be
>    mistaken as "you canremove the ones marked to be kept after
>    saving the still-used objects in it away."
> 
>    But does the same name make sense in the context of "repack"?

I think the distinction you are making is to capture the second second
from the docs:

  If set to false, include objects in `.keep` files when repacking via
  `git repack`. Note that we still do not delete `.keep` packs after
  `pack-objects` finishes.

The best name I could come up with is "--pack-keep-objects", since that
is literally what it is doing. I'm not wild about the name because it is
easy to read "keep" as a verb (and "pack" as a noun). I think it's OK,
but suggestions are welcome.

-- >8 --
From: Vicent Marti <tanoku@gmail.com>
Subject: repack: add `repack.packKeepObjects` config var

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

This patch introduces an option to disable the
`--honor-pack-keep` option.  It is not triggered by default,
even when pack.writeBitmaps is turned on, because its use
depends on your overall packing strategy and use of .keep
files.

Note that this option just disables the pack-objects
behavior. We still leave packs with a .keep in place, as we
do not necessarily know that we have duplicated all of their
objects.

Signed-off-by: Jeff King <peff@peff.net>
---
I added a test, too, mostly to make sure I didn't bungle the option,
since it's negated from its former name.

 Documentation/config.txt     |  5 +++++
 Documentation/git-repack.txt |  8 ++++++++
 builtin/repack.c             | 10 +++++++++-
 t/t7700-repack.sh            | 16 ++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index becbade..8ad081e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2136,6 +2136,11 @@ repack.usedeltabaseoffset::
 	"false" and repack. Access from old Git versions over the
 	native protocol are unaffected by this option.
 
+repack.packKeepObjects::
+	If set to true, makes `git repack` act as if
+	`--pack-keep-objects` was passed. See linkgit:git-repack[1] for
+	details. Defaults to false.
+
 rerere.autoupdate::
 	When set to true, `git-rerere` updates the index with the
 	resulting contents after it cleanly resolves conflicts using
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 002cfd5..0c1ffbd 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -117,6 +117,14 @@ other objects in that pack they already have locally.
 	must be able to refer to all reachable objects. This option
 	overrides the setting of `pack.writebitmaps`.
 
+--pack-keep-objects::
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
index 49f5857..0785a4e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -9,6 +9,7 @@
 #include "argv-array.h"
 
 static int delta_base_offset = 1;
+static int pack_keep_objects;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -22,6 +23,10 @@ static int repack_config(const char *var, const char *value, void *cb)
 		delta_base_offset = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "repack.packkeepobjects")) {
+		pack_keep_objects = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -175,6 +180,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum delta depth")),
 		OPT_STRING(0, "max-pack-size", &max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_BOOL(0, "pack-keep-objects", &pack_keep_objects,
+				N_("repack objects in packs marked with .keep")),
 		OPT_END()
 	};
 
@@ -190,7 +197,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	argv_array_push(&cmd_args, "pack-objects");
 	argv_array_push(&cmd_args, "--keep-true-parents");
-	argv_array_push(&cmd_args, "--honor-pack-keep");
+	if (!pack_keep_objects)
+		argv_array_push(&cmd_args, "--honor-pack-keep");
 	argv_array_push(&cmd_args, "--non-empty");
 	argv_array_push(&cmd_args, "--all");
 	argv_array_push(&cmd_args, "--reflog");
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index b45bd1e..13ca93c 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -35,6 +35,22 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	test -z "$found_duplicate_object"
 '
 
+test_expect_success '--pack-keep-objects duplicates objects' '
+	# build on $objsha1, $packsha1, and .keep state from previous
+	git repack -Adl --pack-keep-objects &&
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
