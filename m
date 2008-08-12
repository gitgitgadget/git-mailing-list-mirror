From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: Allow missing objects during packing
Date: Mon, 11 Aug 2008 18:28:59 -0700
Message-ID: <20080812012859.GT26363@spearce.org>
References: <20080811182839.GJ26363@spearce.org> <7vk5enuqfg.fsf@gitster.siamese.dyndns.org> <20080811224404.GQ26363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:30:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSii5-0003kq-3h
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbYHLB3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYHLB3A
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:29:00 -0400
Received: from george.spearce.org ([209.20.77.23]:48042 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbYHLB3A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:29:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6996E38375; Tue, 12 Aug 2008 01:28:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080811224404.GQ26363@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92057>

> Junio C Hamano <gitster@pobox.com> wrote:
> > If the check is only about a thin delta base that is not going to be
> > transmit, I'd agree.  But I do not see how you are distinguishing that
> > case and the case where an object you are actually sending is missing (in
> > which case we would want to error out, wouldn't we?)

Turns out to be pretty simple I think.  We just delay the
error handling for ->type < 0 until write_object().  If we
get this far we know we wanted to include the object but
we really don't have it.  Up until that point its fine
for us to get objects which are missing, we'll just wind
up with a suboptimal pack.

We also don't even need to report the error from sha1_object_info
as it already issues an error message (see sha1_loose_object_info).

--8<--
pack-objects: Allow missing base objects when creating thin packs

If we are building a thin pack and one of the base objects we would
consider for deltification is missing its OK, the other side already
has that base object.  We may be able to get a delta from another
object, or we can simply send the new object whole (no delta).

This allows a shallow clone which may have only commits and trees
(but only partial blobs) to generate a pack for a fetch client,
so the shallow clone only needs to contain objects that are not
in the common base.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-pack-objects.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2dadec1..187cb19 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -243,6 +243,8 @@ static unsigned long write_object(struct sha1file *f,
 		crc32_begin(f);
 
 	type = entry->type;
+	if (type < 0)
+		die("unable to read object %s", sha1_to_hex(entry->idx.sha1));
 
 	/* write limit if limited packsize and not first object */
 	limit = pack_size_limit && nr_written ?
@@ -1096,9 +1098,6 @@ static void check_object(struct object_entry *entry)
 	}
 
 	entry->type = sha1_object_info(entry->idx.sha1, &entry->size);
-	if (entry->type < 0)
-		die("unable to get type of object %s",
-		    sha1_to_hex(entry->idx.sha1));
 }
 
 static int pack_offset_sort(const void *_a, const void *_b)
-- 
1.6.0.rc2.22.g71b99

-- 
Shawn.
