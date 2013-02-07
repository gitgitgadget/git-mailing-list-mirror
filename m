From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/4] grep: obey --textconv for the case rev:path
Date: Thu, 7 Feb 2013 04:26:40 -0500
Message-ID: <20130207092640.GC15727@sigill.intra.peff.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net>
 <20130206223656.GF27507@sigill.intra.peff.net>
 <51136E75.5060002@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:27:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3NlQ-0003HO-Sn
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 10:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab3BGJ0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 04:26:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38508 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755743Ab3BGJ0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 04:26:43 -0500
Received: (qmail 16682 invoked by uid 107); 7 Feb 2013 09:28:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Feb 2013 04:28:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2013 04:26:40 -0500
Content-Disposition: inline
In-Reply-To: <51136E75.5060002@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215683>

On Thu, Feb 07, 2013 at 10:05:57AM +0100, Michael J Gruber wrote:

> >> @@ -265,9 +260,28 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
> >>  	objects[nr].item = obj;
> >>  	objects[nr].name = name;
> >>  	objects[nr].mode = mode;
> >> +	objects[nr].context = context;
> >>  	array->nr = ++nr;
> >>  }
> > 
> > This seems a little gross. Who is responsible for allocating the
> > context? Who frees it? It looks like we duplicate it in cmd_grep. Which
> 
> Well, who is responsible for allocating and freeing name and item? I
> didn't want to introduce a new member which is a struct when all other
> complex members are pointers. Wouldn't that be confusing?

We cheat on those two. "item" is always a pointer to a "struct object",
which lasts forever and never gets freed. When "name" is set by
setup_revisions, it comes from the argv list, which is assumed to last
forever (and when we add pending blobs for a "--objects" traversal, it
is the empty string (literal).

I'd be OK if we had an exterior object_context that could be handled
in the same way. But how do we tell setup_revisions that we are
interested in seeing the object_context from each parsed item, where
does the allocation come from (is it malloc'd by setup_revisions?), and
who is responsible for freeing it when we pop pending objects in
get_revisions and similar?

I don't think it's as clear cut.

I wonder, though...what we really care about here is just the pathname.
But if it is a pending object that comes from a blob revision argument,
won't it always be of the form "treeish:path"? Could we not even resolve
the sha1 again, but instead just parse out the ":path" bit?

That is sort of like what the repeated call to get_sha1_with_context
does in your first patch. Except that we do not actually want to lookup
the sha1, and it is harmful to do so (e.g., if the ref had moved on to a
new tree that does not have that path, get_sha1 would fail, but we do
not even care what is in the tree; we only want the parsing side effects
of get_sha1).

Hmm.

-Peff

PS By the way, while looking at the object_array code (which I have not
   really used much before), I noticed that add_pending_commit_list sets
   the "name" field to the result of sha1_to_hex. Which means that it is
   likely to be completely bogus by the time you read it. I'm not even
   sure where it gets read or if this matters. And obviously it's
   completely unrelated to what we were discussing; just something I
   noticed.
