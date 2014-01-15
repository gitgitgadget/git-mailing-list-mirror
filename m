From: Jeff King <peff@peff.net>
Subject: Re: revision: propagate flag bits from tags to pointees
Date: Wed, 15 Jan 2014 16:56:41 -0500
Message-ID: <20140115215641.GB16401@sigill.intra.peff.net>
References: <52CFF27C.1090108@gmail.com>
 <20140115094945.GD14335@sigill.intra.peff.net>
 <xmqq1u092f2k.fsf@gitster.dls.corp.google.com>
 <xmqqwqi10z6i.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Francis Moreau <francis.moro@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 22:57:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3YSN-0003gc-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 22:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbaAOV4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 16:56:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:33135 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753334AbaAOV4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 16:56:43 -0500
Received: (qmail 17506 invoked by uid 102); 15 Jan 2014 21:56:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 15:56:43 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 16:56:41 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwqi10z6i.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240483>

On Wed, Jan 15, 2014 at 12:26:13PM -0800, Junio C Hamano wrote:

> With the previous fix 895c5ba3 (revision: do not peel tags used in
> range notation, 2013-09-19), handle_revision_arg() that processes
> command line arguments for the "git log" family of commands no
> longer directly places the object pointed by the tag in the pending
> object array when it sees a tag object.  We used to place pointee
> there after copying the flag bits like UNINTERESTING and
> SYMMETRIC_LEFT.
> 
> This change meant that any flag that is relevant to later history
> traversal must now be propagated to the pointed objects (most often
> these are commits) while starting the traversal, which is partly
> done by handle_commit() that is called from prepare_revision_walk().
> We did propagate UNINTERESTING, but did not do so for others, most
> notably SYMMETRIC_LEFT.  This caused "git log --left-right v1.0..."
> (where "v1.0" is a tag) to start losing the "leftness" from the
> commit the tag points at.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Looks good to me. As per my previous mail, I _think_ you could squash
in:

diff --git a/revision.c b/revision.c
index f786b51..2db906c 100644
--- a/revision.c
+++ b/revision.c
@@ -316,13 +316,10 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 * Blob object? You know the drill by now..
 	 */
 	if (object->type == OBJ_BLOB) {
-		struct blob *blob = (struct blob *)object;
 		if (!revs->blob_objects)
 			return NULL;
-		if (flags & UNINTERESTING) {
-			mark_blob_uninteresting(blob);
+		if (flags & UNINTERESTING)
 			return NULL;
-		}
 		add_pending_object(revs, object, "");
 		return NULL;
 	}

but that is not very much code reduction (and mark_blob_uninteresting is
very cheap). So it may not be worth the risk that my analysis is wrong.
:)

-Peff
