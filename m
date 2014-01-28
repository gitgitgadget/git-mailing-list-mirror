From: Jeff King <peff@peff.net>
Subject: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Tue, 28 Jan 2014 01:09:54 -0500
Message-ID: <20140128060954.GA26401@sigill.intra.peff.net>
References: <52E080C1.4030402@fb.com>
 <20140123225238.GB2567@sigill.intra.peff.net>
 <52E1A99D.6010809@fb.com>
 <52E1AB78.1000504@fb.com>
 <20140124022822.GC4521@sigill.intra.peff.net>
 <52E1D39B.4050103@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Siddharth Agarwal <sid0@fb.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 07:10:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W81s1-0005NK-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 07:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbaA1GJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 01:09:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:40144 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750866AbaA1GJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 01:09:56 -0500
Received: (qmail 14887 invoked by uid 102); 28 Jan 2014 06:09:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Jan 2014 00:09:56 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jan 2014 01:09:54 -0500
Content-Disposition: inline
In-Reply-To: <52E1D39B.4050103@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241179>

On Thu, Jan 23, 2014 at 06:44:43PM -0800, Siddharth Agarwal wrote:

> On 01/23/2014 06:28 PM, Jeff King wrote:
> >I think your understanding is accurate here. So we want repack to
> >respect keep files for deletion, but we _not_ necessarily want
> >pack-objects to avoid packing an object just because it's in a pack
> >marked by .keep (see my other email).
> 
> Yes, that makes sense and sounds pretty safe.
> 
> So the right solution for us probably is to apply the patch Vicent
> posted, set repack.honorpackkeep to false, and also have a cron job
> that cleans up stale .keep files so that subsequent repacks clean it
> up.

Yes, that matches what we do at GitHub.

Here's Vicent's patch, with documentation and an expanded commit
message. I think it should be suitable for upstream git.

-- >8 --
From: Vicent Marti <tanoku@gmail.com>
Subject: repack: add `repack.honorpackkeep` config var

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
Intended for the jk/pack-bitmap topic.

 Documentation/config.txt | 8 ++++++++
 builtin/repack.c         | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 947e6f8..5036a10 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2128,6 +2128,14 @@ repack.usedeltabaseoffset::
 	"false" and repack. Access from old Git versions over the
 	native protocol are unaffected by this option.
 
+repack.honorPackKeep::
+	If set to false, include objects in `.keep` files when repacking
+	via `git repack`. Note that we still do not delete `.keep` packs
+	after `pack-objects` finishes. This means that we may duplicate
+	objects, but this makes the option safe to use when there are
+	concurrent pushes or fetches. This option is generally only
+	useful if you have set `pack.writeBitmaps`. Defaults to true.
+
 rerere.autoupdate::
 	When set to true, `git-rerere` updates the index with the
 	resulting contents after it cleanly resolves conflicts using
diff --git a/builtin/repack.c b/builtin/repack.c
index a9c4593..585c41d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -9,6 +9,7 @@
 #include "argv-array.h"
 
 static int delta_base_offset = 1;
+static int honor_pack_keep = 1;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -22,6 +23,10 @@ static int repack_config(const char *var, const char *value, void *cb)
 		delta_base_offset = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "repack.honorpackkeep")) {
+		honor_pack_keep = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -190,10 +195,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	argv_array_push(&cmd_args, "pack-objects");
 	argv_array_push(&cmd_args, "--keep-true-parents");
-	argv_array_push(&cmd_args, "--honor-pack-keep");
 	argv_array_push(&cmd_args, "--non-empty");
 	argv_array_push(&cmd_args, "--all");
 	argv_array_push(&cmd_args, "--reflog");
+	if (honor_pack_keep)
+		argv_array_push(&cmd_args, "--honor-pack-keep");
 	if (window)
 		argv_array_pushf(&cmd_args, "--window=%u", window);
 	if (window_memory)
-- 
1.8.5.2.500.g8060133
