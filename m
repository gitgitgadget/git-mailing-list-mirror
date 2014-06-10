From: Jeff King <peff@peff.net>
Subject: Re: Disk waste with packs and .keep files
Date: Tue, 10 Jun 2014 14:53:21 -0400
Message-ID: <20140610185321.GA25845@sigill.intra.peff.net>
References: <vpqmwdljhu8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:53:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuRAv-00016r-28
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 20:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbaFJSx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 14:53:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:41184 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752993AbaFJSxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 14:53:22 -0400
Received: (qmail 9089 invoked by uid 102); 10 Jun 2014 18:53:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 13:53:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 14:53:21 -0400
Content-Disposition: inline
In-Reply-To: <vpqmwdljhu8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251215>

On Tue, Jun 10, 2014 at 10:21:03AM +0200, Matthieu Moy wrote:

> Since a few weeks however, Git started wasting my disk space: instead of
> creating small .pack files next to the big .keep-ed pack files, it seems
> to create redundant, big .pack files (i.e. I get N pack files of similar
> size). "git verify-pack" confirms that, for example, the object
> corresponding to the root commit is contained in each of the .pack file.
>
> I don't have a reproducible way to get the situation so I didn't bisect,
> but "git log --grep .keep" points me to this which seems related:
> 
>   commit ee34a2beadb94a9595f09af719e3c09b485ca797
>   Author: Jeff King <peff@peff.net>
>   Date:   Mon Mar 3 15:04:20 2014 -0500
> 
>     repack: add `repack.packKeptObjects` config var

Eek. Does anybody have a brown paper bag I can borrow?

-- >8 --
Subject: repack: do not accidentally pack kept objects by default

Commit ee34a2b (repack: add `repack.packKeptObjects` config
var, 2014-03-03) added a flag which could duplicate kept
objects, but did not mean to turn it on by default. Instead,
the option is tied by default to the decision to write
bitmaps, like:

  if (pack_kept_objects < 0)
	  pack_kept_objects = write_bitmap;

after which we expect pack_kept_objects to be a boolean 0 or
1.  However, that assignment neglects that write_bitmap is
_also_ a tri-state with "-1" as the default, and with
neither option given, we accidentally turn the option on.

This patch is the minimal fix to restore the desired
behavior for the default state. However, the real fix will
be more involved.

The decision to turn on bitmaps via config is actually made
in pack-objects itself (which is why we need write_bitmap as
a tri-state here; we only pass the override option if the
user gave us a command-line option). To tie the options
together correctly, we need to either pass the "don't know"
tristate down to pack-objects (which would also read
repack.packKeptObjects), or pull the reading of
pack.writebitmaps up to the repack level.

Signed-off-by: Jeff King <peff@peff.net>
---
I think the latter makes the most sense, and it was a mistake to read
the option in pack-objects in the first place. We _never_ want to
write bitmaps when packing to stdout, or even when doing a non-complete
repack. We had to teach pack-objects special logic to turn bitmaps off
in that case, but the right solution instead is that pack-objects should
always respect the --write-bitmap-index flag on the command line, and
the callers should drive that decision (and really only "repack -[aA]"
would want to use it). And then the fix here will just come out
naturally from that.

I'll work up a series, but we may want to fast-track this patch for
maint. It's a fairly big regression in v2.0. We didn't notice because
it's only an optimization issue, not a correctness one, and I guess not
that many people use .keep packs.

 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6b0b62d..17bc8da 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -191,7 +191,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				git_repack_usage, 0);
 
 	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmap;
+		pack_kept_objects = write_bitmap > 0;
 
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
-- 
2.0.0.729.g520999f
