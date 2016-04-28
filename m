From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] pack-objects: warn on split packs disabling bitmaps
Date: Thu, 28 Apr 2016 07:28:55 +0000
Message-ID: <20160428072854.GA5252@dcvr.yhbt.net>
References: <20160427215324.GA22165@dcvr.yhbt.net>
 <xmqqfuu67j9t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 09:29:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avgNi-0004id-AH
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 09:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbcD1H26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 03:28:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36663 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbcD1H25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 03:28:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271361F980;
	Thu, 28 Apr 2016 07:28:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqfuu67j9t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292853>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > +++ b/Documentation/git-pack-objects.txt
> > @@ -110,7 +110,8 @@ base-name::
> >  --max-pack-size=<n>::
> >  	Maximum size of each output pack file. The size can be suffixed with
> >  	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
> > -	If specified,  multiple packfiles may be created.
> > +	If specified, multiple packfiles may be created, which also
> > +	prevents the creation of a bitmap index.
> 
> This is a good update, judging with the yardstick I set in the
> previous paragraph in this review.

Thanks for the review; made some adjustments and have v2 below.

> > --- a/Documentation/git-repack.txt
> > +++ b/Documentation/git-repack.txt
> > @@ -106,7 +106,8 @@ other objects in that pack they already have locally.
> >  --max-pack-size=<n>::
> >  	Maximum size of each output pack file. The size can be suffixed with
> >  	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
> > -	If specified,  multiple packfiles may be created.
> > +	If specified, multiple packfiles may be created, causing
> > +	`--write-bitmap-index` and `repack.writeBitmaps` to be ignored.
> 
> And this is not.  Just say "bitmap index is not created".

Ah, I've now synced the same --max-pack-size doc from
git-pack-objects.txt you liked into v2 below.

I worded my original differently between pack-objects and repack
since I figured repack is more likely used by end users;
and perhaps warranted an explanation that didn't require
describing the actual problem...

But I suppose "repack" isn't commonly called anymore, either.

> > @@ -115,7 +116,9 @@ other objects in that pack they already have locally.
> >  	Write a reachability bitmap index as part of the repack. This
> >  	only makes sense when used with `-a` or `-A`, as the bitmaps
> >  	must be able to refer to all reachable objects. This option
> > -	overrides the setting of `pack.writeBitmaps`.
> > +	overrides the setting of `repack.writeBitmaps`.  This option
> > +	has no effect if a multiple packfiles are created due to
> > +	reaching `pack.packSizeLimit` or `--max-pack-size`.
> 
> Dropping "due to ..." makes it perfect.

Done, along with:

	s/effect if a multiple/effect when multiple/

"if a" was definitely a typo, "if" is probably alright, but
I suspect "when" is even better.

-------------8<-------------
Subject: [PATCH] pack-objects: warn on split packs disabling bitmaps

It can be tempting for a server admin to want a stable set of
long-lived packs for dumb clients; but also want to enable
bitmaps to serve smart clients more quickly.

Unfortunately, such a configuration is impossible;
so at least warn users of this incompatibility since
commit 21134714787a02a37da15424d72c0119b2b8ed71
("pack-objects: turn off bitmaps when we split packs").

Tested the warning by inspecting the output of:

	make -C t t5310-pack-bitmaps.sh GIT_TEST_OPTS=-v

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/config.txt           | 12 ++++++++----
 Documentation/git-pack-objects.txt |  3 ++-
 Documentation/git-repack.txt       |  8 +++++---
 builtin/pack-objects.c             |  9 ++++++++-
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3d8bc97..3ea3372 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2165,8 +2165,11 @@ pack.packSizeLimit::
 	The maximum size of a pack.  This setting only affects
 	packing to a file when repacking, i.e. the git:// protocol
 	is unaffected.  It can be overridden by the `--max-pack-size`
-	option of linkgit:git-repack[1]. The minimum size allowed is
-	limited to 1 MiB. The default is unlimited.
+	option of linkgit:git-repack[1].  Reaching this limit results
+	in the creation of multiple packfiles; which in turn prevents
+	bitmaps from being created.
+	The minimum size allowed is limited to 1 MiB.
+	The default is unlimited.
 	Common unit suffixes of 'k', 'm', or 'g' are
 	supported.
 
@@ -2566,8 +2569,9 @@ repack.writeBitmaps::
 	objects to disk (e.g., when `git repack -a` is run).  This
 	index can speed up the "counting objects" phase of subsequent
 	packs created for clones and fetches, at the cost of some disk
-	space and extra time spent on the initial repack.  Defaults to
-	false.
+	space and extra time spent on the initial repack.  This has
+	no effect if multiple packfiles are created.
+	Defaults to false.
 
 rerere.autoUpdate::
 	When set to true, `git-rerere` updates the index with the
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index bbea529..19cdcd0 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -110,7 +110,8 @@ base-name::
 --max-pack-size=<n>::
 	Maximum size of each output pack file. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
-	If specified,  multiple packfiles may be created.
+	If specified, multiple packfiles may be created, which also
+	prevents the creation of a bitmap index.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index af230d0..b9c02ce 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -106,7 +106,8 @@ other objects in that pack they already have locally.
 --max-pack-size=<n>::
 	Maximum size of each output pack file. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
-	If specified,  multiple packfiles may be created.
+	If specified, multiple packfiles may be created, which also
+	prevents the creation of a bitmap index.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
 
@@ -115,7 +116,8 @@ other objects in that pack they already have locally.
 	Write a reachability bitmap index as part of the repack. This
 	only makes sense when used with `-a` or `-A`, as the bitmaps
 	must be able to refer to all reachable objects. This option
-	overrides the setting of `pack.writeBitmaps`.
+	overrides the setting of `repack.writeBitmaps`.  This option
+	has no effect if multiple packfiles are created.
 
 --pack-kept-objects::
 	Include objects in `.keep` files when repacking.  Note that we
@@ -123,7 +125,7 @@ other objects in that pack they already have locally.
 	This means that we may duplicate objects, but this makes the
 	option safe to use when there are concurrent pushes or fetches.
 	This option is generally only useful if you are writing bitmaps
-	with `-b` or `pack.writeBitmaps`, as it ensures that the
+	with `-b` or `repack.writeBitmaps`, as it ensures that the
 	bitmapped packfile has the necessary objects.
 
 Configuration
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a27de5b..b6664ce 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -759,6 +759,10 @@ static off_t write_reused_pack(struct sha1file *f)
 	return reuse_packfile_offset - sizeof(struct pack_header);
 }
 
+static const char no_split_warning[] = N_(
+"disabling bitmap writing, packs are split due to pack.packSizeLimit"
+);
+
 static void write_pack_file(void)
 {
 	uint32_t i = 0, j;
@@ -813,7 +817,10 @@ static void write_pack_file(void)
 			fixup_pack_header_footer(fd, sha1, pack_tmp_name,
 						 nr_written, sha1, offset);
 			close(fd);
-			write_bitmap_index = 0;
+			if (write_bitmap_index) {
+				warning(_(no_split_warning));
+				write_bitmap_index = 0;
+			}
 		}
 
 		if (!pack_to_stdout) {
-- 
EW
