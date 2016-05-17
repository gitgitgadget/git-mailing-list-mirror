From: Jeff King <peff@peff.net>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Tue, 17 May 2016 08:13:31 -0400
Message-ID: <20160517121330.GA7346@sigill.intra.peff.net>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
 <20160513103621.GA12329@dcvr.yhbt.net>
 <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
 <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
 <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
 <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
	Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 14:13:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2dsd-0005fY-Um
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 14:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbcEQMNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 08:13:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:40666 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932580AbcEQMNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 08:13:34 -0400
Received: (qmail 18869 invoked by uid 102); 17 May 2016 12:13:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 08:13:33 -0400
Received: (qmail 13319 invoked by uid 107); 17 May 2016 12:13:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 08:13:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2016 08:13:31 -0400
Content-Disposition: inline
In-Reply-To: <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294865>

On Tue, May 17, 2016 at 10:07:16AM +0200, Lars Schneider wrote:

> I think that is pretty much the problem. Here is what is happening:
> 
> 1.  git-p4 imports all changelists for the "main" branch
> 
> 2.  git-p4 starts to import a second branch and creates a fast-import
>     "progress checkpoint". This triggers:
> 
>     --> fast-import.c: cycle_packfile
>     --> fast-import.c: end_packfile
>     --> fast-import.c: loosen_small_pack
> 
>     At this point we have no packfile anymore.
> 
> 3.  git-p4 sends the command "commit refs/remotes/p4/depot/branch2"
>     to fast-import in order to create a new branch. This triggers:
> 
>     --> fast-import.c: parse_new_commit
>     --> fast-import.c: load_branch
>     --> fast-import.c: load_tree
> 
>     "load_tree" calls "find_object" and the result has a "pack_id" of 0.
>     I think this indicates that the object is in the packfile. Shouldn't
>     the "pack_id" be "MAX_PACK_ID" instead?
> 
>         myoe = find_object(sha1);
>         if (myoe && myoe->pack_id != MAX_PACK_ID) {

Thanks for the analysis. I think this is definitely the problem.  After
fast-import finalizes a packfile (either at the end of the program or
due to a checkpoint), it never discards its internal mapping of objects
to pack locations. It _has_ to keep such a mapping before the pack is
finalized, because git's regular object database doesn't know about it.
But afterwards, it should be able to rely on the object database.

Retaining the mapping at the end of the program is obviously OK because
we won't make any more lookups in it.

Retaining it at a checkpoint when we keep the packfile is OK, because we
can (usually) still access that packfile (the exception would be if
somebody runs "git repack" while fast-import is running).

But obviously a checkpoint where we throw away the pack needs to clear
that mapping.

The patch below probably makes your case work, but there are a lot of
open questions:

  1. Should we always discard the mapping, even when not loosening
     objects? I can't think of a real downside to always using git's
     object lookups.

  2. Can we free memory associated with object_entry structs at this
     point? They won't be accessible via the hash, but might other bits
     of the code have kept pointers to them?

     I suspect it may screw up the statistics that fast-import prints at
     the end, but that's a minor point.

  3. I notice that a few other structs (branch and tag) hold onto the
     pack_id, which will now point to a pack we can't access. Does this
     matter? I don't think so, because checkpoint() seems to dump the
     branches and tags.

  4. In general, should we be loosening objects at checkpoints at all?

     I guess it is probably more efficient than creating a bunch of
     little packs. And it should probably not happen much at all outside
     of tests (i.e., callers should generally checkpoint after an
     appreciable amount of work is done).

diff --git a/fast-import.c b/fast-import.c
index 0e8bc6a..9bfbfb0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -597,6 +597,22 @@ static struct object_entry *insert_object(unsigned char *sha1)
 	return e;
 }
 
+static void clear_object_table(void)
+{
+	unsigned int h;
+	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
+		/*
+		 * We can't individually free objects here
+		 * because they are allocated from a pool.
+		 */
+		object_table[h] = NULL;
+	}
+	/*
+	 * XXX maybe free object_entry_pool here,
+	 * or might something still be referencing them?
+	 */
+}
+
 static unsigned int hc_str(const char *s, size_t len)
 {
 	unsigned int r = 0;
@@ -1035,6 +1051,9 @@ discard_pack:
 	pack_data = NULL;
 	running = 0;
 
+	/* The objects are now available via git's regular lookups. */
+	clear_object_table();
+
 	/* We can't carry a delta across packfiles. */
 	strbuf_release(&last_blob.data);
 	last_blob.offset = 0;
