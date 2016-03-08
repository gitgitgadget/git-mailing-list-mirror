From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Tue, 8 Mar 2016 07:14:44 -0500
Message-ID: <20160308121444.GA18535@sigill.intra.peff.net>
References: <20160307221539.GA24034@sigill.intra.peff.net>
 <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 13:14:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adGXO-00016t-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 13:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbcCHMOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 07:14:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:56187 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932068AbcCHMOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 07:14:48 -0500
Received: (qmail 5028 invoked by uid 102); 8 Mar 2016 12:14:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 07:14:47 -0500
Received: (qmail 1523 invoked by uid 107); 8 Mar 2016 12:15:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 07:15:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2016 07:14:44 -0500
Content-Disposition: inline
In-Reply-To: <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288427>

On Mon, Mar 07, 2016 at 03:47:53PM -0800, Junio C Hamano wrote:

> > Is this user error to call "git fetch" without "--depth" in the
> > subsequent cases? Or should git remember that we are in a shallow repo,
> > and presume that the user by default wants to keep things shallow?
> 
> Hmph, you shouldn't, and I somehow thought that you do not, have to
> explicitly say things like "--deepen" to break the original
> shallowness, but your example illustrates that the logic to do so is
> not well thought out.  A new side branch will prevent you from
> hitting an already-known shallow cut-off and traverse down to the
> root.
> 
> Giving a random "depth" in subsequent fetch would however not work
> very well, I suspect, as that is very prone to make the part of the
> history the user originally obtained, and presumably used to build
> her own history, into an island that is unconnected to the updated
> tip of the history.  

Yeah, if we just recorded the original "--depth=1", each fetch would
make its own little island. Eventually your "shallow" file would bloat.
I'm not sure what that would do for the performance of subsequent
operations.

> I also do not offhand think of a good way to use the topology or
> timestamp to figure out the best "depth" to truncate the side branch
> at.  The server side may be able to figure out that things before 'F'
> in your picture is not relevant for a client that has the shallow
> cut-off at 067f265, but the side branch can be forked arbitrarily
> long in the past, or it may not even share the ancient part of the
> history and has its own root commit.

Right. I think conceptually that we want a graph cut, across all
branches. But you can't compute that cut at the time of the original
shallow clone, as we might not even have the side branches yet. So it
has to be computed at the time of the subsequent fetch.

You could make an arbitrary cut across all branches based on the
timestamp of the --shallow bottom. That would create new shallow bottoms
on any parallel lines of development that are brought in, from "around
the same time". But I'm uncomfortable relying on timestamps, and I
suspect there are some pretty bad corner cases with skew.

What if we instead marked the parent of a shallow commit UNINTERESTING?
Something like:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index abed871..fc7a469 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2780,6 +2780,9 @@ static void get_object_list(int ac, const char **av)
 				unsigned char sha1[20];
 				if (get_sha1_hex(line + 10, sha1))
 					die("not an SHA-1 '%s'", line + 10);
+				handle_revision_arg(xstrfmt("^%s^", line + 10),
+						    &revs, flags,
+						    REVARG_CANNOT_BE_FILENAME);
 				register_shallow(sha1);
 				use_bitmap_index = 0;
 				continue;

In this case it means we pull in all of that side branch, down to the
fork point. If it went back to ancient history (or even had its own root
commit), then so be it; that's what the user asked for.  But I think
this would cover the common case of people shallow-cloning and fetching
a normal workflow.

There are two problems, though:

  1. We use UNINTERESTING for two things in pack-objects: to avoid
     sending the commits, but also to assume that the user has the
     objects, for making thin-pack deltas.

     We want only the former, but not the latter (if you apply my patch
     and try a fetch, you'll see that the client is missing bases from
     the resulting pack).

  2. We've effectively re-shallowed the client at the fork point. We
     have to tell them that somehow, or they're going to complain that
     we didn't send them all of the objects.

So I think the solution to both is that we need to do a _separate_
traversal with all of the positive tips we're going to send, and the
parents of any shallow commits the client has, to find their fork points
(i.e., merge bases). And then we add those fork points to the shallow
list (grafting out their parents), and communicate them to the client to
add to its shallow setup.

-Peff
