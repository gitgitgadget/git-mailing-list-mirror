From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Tue, 8 Mar 2016 08:30:41 -0500
Message-ID: <20160308133041.GA9465@sigill.intra.peff.net>
References: <20160307221539.GA24034@sigill.intra.peff.net>
 <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <20160308121444.GA18535@sigill.intra.peff.net>
 <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
 <20160308132524.GA22866@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 14:30:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adHis-0003GG-1P
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 14:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbcCHNap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 08:30:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:56241 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751441AbcCHNao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 08:30:44 -0500
Received: (qmail 8787 invoked by uid 102); 8 Mar 2016 13:30:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 08:30:43 -0500
Received: (qmail 2125 invoked by uid 107); 8 Mar 2016 13:30:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 08:30:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2016 08:30:41 -0500
Content-Disposition: inline
In-Reply-To: <20160308132524.GA22866@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288434>

On Tue, Mar 08, 2016 at 08:25:24AM -0500, Jeff King wrote:

> > Good news. We have the mechanism in place, I think.
> > get_shallow_commits_by_rev_list() (from 'pu') will produce the right
> > shallow points for sending back to the client if you pass "--not
> > <current shallow points>" to it. It's meant to be used for
> > --shallow-exclude and --shallow-since, but if neither is given (nor
> > --depth) I guess we can run it with current shallow points. I wonder
> > if we can detect some common cases and avoid commit traversing this
> > way though.
> 
> I tried that, but I couldn't quite get it to work. I don't think we need
> any special rev-list, though; we can just find the boundary points of
> that traversal and mark them as new shallows.

By the way, I found a bug during my initial attempts with
get_shallow_commits_by_rev_list(). One of the loops uses "p" to traverse
a linked list, and then re-uses "p" again for another list traversal
inside the body of the loop. When the inner loop finishes, "p" is
left as NULL, and then the outer loop tries to access "p->next", which
segfaults.

I _think_ this is just a mistaken re-use of the variable, and can be
fixed with a new iteration variable for the inner loop, like:

diff --git a/shallow.c b/shallow.c
index 6ceb3f8..d600947 100644
--- a/shallow.c
+++ b/shallow.c
@@ -188,13 +188,14 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	 */
 	for (p = not_shallow_list; p; p = p->next) {
 		struct commit *c = p->item;
+		struct commit_list *parent;
 
 		if (parse_commit(c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
-		for (p = c->parents; p; p = p->next)
-			if (!(p->item->object.flags & not_shallow_flag)) {
+		for (parent = c->parents; parent; parent = parent->next)
+			if (!(parent->item->object.flags & not_shallow_flag)) {
 				c->object.flags |= shallow_flag;
 				commit_list_insert(c, &result);
 				break;

As I said, I didn't end up using this function either way, but you
probably want the fix above for the rest of your series. :)

-Peff
