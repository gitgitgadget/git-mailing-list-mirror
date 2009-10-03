From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 5/7] imap-send: provide fall-back random-source
Date: Sat, 3 Oct 2009 16:52:18 -0400
Message-ID: <20091003205217.GC9058@sigill.intra.peff.net>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-4-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-5-git-send-email-kusmabite@gmail.com>
 <20091003095811.GB17873@coredump.intra.peff.net>
 <40aa078e0910031145l2849697ftd2da2f5aaa28d957@mail.gmail.com>
 <20091003204317.GB9058@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: msysgit@googlegroups.com, git@vger.kernel.org, mike@codeweavers.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 22:56:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuBeC-0002On-Re
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 22:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174AbZJCUw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 16:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757155AbZJCUw4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 16:52:56 -0400
Received: from peff.net ([208.65.91.99]:36595 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757131AbZJCUwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 16:52:55 -0400
Received: (qmail 6518 invoked by uid 107); 3 Oct 2009 20:55:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 03 Oct 2009 16:55:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Oct 2009 16:52:18 -0400
Content-Disposition: inline
In-Reply-To: <20091003204317.GB9058@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129505>

On Sat, Oct 03, 2009 at 04:43:17PM -0400, Jeff King wrote:

> The other confusing bit is that the code carefully tracks the "uid"
> (deep within the call chain it munges cb.ctx, which is a pointer to uid)
> which is assigned to the newly created message by the server. This could
> be used by a client to later refer to the same message unambiguously.
> But we never do that, and just throw away the uid value that the server
> gives us.  Again, I suspect this is a holdover from isync wanting to do
> repeated synchronization (and it looks like this x-tuid stuff may be
> about working around servers which don't support certain uid
> operations).
> 
> So that could probably be ripped out, too, with no ill effect.

And here is a patch (on top of the earlier one) to do that.

Even more can be ripped out from the lower levels, too, I'm not sure if
it is worth it. Ripping out the arc4 code is worthwhile, because it
solves a portability problem. Ripping out more isn't really helping us
much. Less code makes it easier to read, but given our lack of tests and
my relatively small knowledge of this code, it is entirely possible I am
introducing new bugs.

---

 imap-send.c |   25 ++++++-------------------
 1 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index d60a0bd..8da7a94 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1149,7 +1149,7 @@ static int imap_make_flags(int flags, char *buf)
 	return d;
 }
 
-static int imap_store_msg(struct store *gctx, struct msg_data *data, int *uid)
+static int imap_store_msg(struct store *gctx, struct msg_data *data)
 {
 	struct imap_store *ctx = (struct imap_store *)gctx;
 	struct imap *imap = ctx->imap;
@@ -1171,26 +1171,14 @@ static int imap_store_msg(struct store *gctx, struct msg_data *data, int *uid)
 	}
 	flagstr[d] = 0;
 
-	if (!uid) {
-		box = gctx->conf->trash;
-		prefix = ctx->prefix;
-		cb.create = 1;
-		if (ctx->trashnc)
-			imap->caps = imap->rcaps & ~(1 << LITERALPLUS);
-	} else {
-		box = gctx->name;
-		prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
-		cb.create = 0;
-	}
-	cb.ctx = uid;
+	box = gctx->name;
+	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
+	cb.create = 0;
 	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box, flagstr);
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
 		return ret;
-	if (!uid)
-		ctx->trashnc = 0;
-	else
-		gctx->count++;
+	gctx->count++;
 
 	return DRV_OK;
 }
@@ -1366,7 +1354,6 @@ int main(int argc, char **argv)
 {
 	struct msg_data all_msgs, msg;
 	struct store *ctx = NULL;
-	int uid = 0;
 	int ofs = 0;
 	int r;
 	int total, n = 0;
@@ -1420,7 +1407,7 @@ int main(int argc, char **argv)
 			break;
 		if (server.use_html)
 			wrap_in_html(&msg);
-		r = imap_store_msg(ctx, &msg, &uid);
+		r = imap_store_msg(ctx, &msg);
 		if (r != DRV_OK)
 			break;
 		n++;
