From: Jeff King <peff@peff.net>
Subject: Re: with reuse-delta patches, fetching with bitmaps segfaults due to
 possibly incomplete bitmap traverse
Date: Sat, 22 Mar 2014 08:56:27 -0400
Message-ID: <20140322125626.GA22890@sigill.intra.peff.net>
References: <532CFC6F.8000008@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, bmaurer@fb.com,
	Aaron Kushner <akushner@fb.com>
To: Siddharth Agarwal <sid0@fb.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 13:56:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRLTs-0004oK-45
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 13:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbaCVM4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 08:56:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:44661 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750738AbaCVM43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 08:56:29 -0400
Received: (qmail 12851 invoked by uid 102); 22 Mar 2014 12:56:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Mar 2014 07:56:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Mar 2014 08:56:27 -0400
Content-Disposition: inline
In-Reply-To: <532CFC6F.8000008@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244768>

On Fri, Mar 21, 2014 at 07:58:55PM -0700, Siddharth Agarwal wrote:

> At Facebook we've found that fetch speed is a bottleneck for our Git repos,
> so we've been looking to deploy bitmaps to speed up fetches. We've been
> trying out git-next with the top two patches from
> https://github.com/peff/git/commits/jk/bitmap-reuse-delta, but the following
> is reproducible with tip of that branch, currently 81cdec2.

Is it also reproducible just with the tip of "next"? Note that the
patches in jk/bitmap-reuse-delta have not been widely deployed (in
particular, we are not yet using them at GitHub, and we track segfaults
on our servers closely and have not seen any related to this).

Those patches allocate extra "fake" entries in the entry->delta fields,
which are not accounted for in to_pack.nr_objects. It's entirely
possible that those entries are related to the bug you are seeing.

> I dug into this a bit and it looks like at this point:
> 
> https://github.com/peff/git/blob/81cdec28fa24fdc613ab7c3406c1c67975dbf22f/builtin/pack-objects.c#L700
> 
> at some object that add_family_to_write_order is called for, wo_end exceeds
> to_pack.nr_objects by over 1000 objects. More precisely, at the point it
> crashes, wo_end is 218081 while to_pack.nr_objects is 201614. (This means
> wo_end overshot to_pack.nr_objects some time ago.)

Hmm, yeah, that confirms my suspicion. In the earlier loops, we call
add_to_write_order, which only adds the object in question, and can
never exceed to_pack.nr_objects. In this final loop, we call
add_family_to_write_order, which is going to add any deltas that were
not already included.

The patch below may fix your problem, but I have a feeling it is not the
right thing to do. The point of 81cdec28 is to try to point to a delta
entry as if it were a "preferred base" (i.e., something we know that the
other side has already). We perhaps want to add these entries to the
actual packing list, and skip them as we do with normal preferred_base
objects.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9fc5321..ca1b0f7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1437,6 +1437,7 @@ static void check_object(struct object_entry *entry)
 			entry->delta = xcalloc(1, sizeof(*entry->delta));
 			hashcpy(entry->delta->idx.sha1, base_ref);
 			entry->delta->preferred_base = 1;
+			entry->delta->filled = 1;
 			unuse_pack(&w_curs);
 			return;
 		}

-Peff
