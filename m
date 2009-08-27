From: Jeff King <peff@peff.net>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 17:34:26 -0400
Message-ID: <20090827213426.GD4399@coredump.intra.peff.net>
References: <1251387045053-3527289.post@n2.nabble.com>
 <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
 <20090827164657.GA17090@atjola.homenet>
 <32541b130908271022i6a825198i37e2ec82ed5f833c@mail.gmail.com>
 <20090827204835.GC4399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgmc8-0001vZ-43
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbZH0Ve1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbZH0Ve0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:34:26 -0400
Received: from peff.net ([208.65.91.99]:53411 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516AbZH0Ve0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:34:26 -0400
Received: (qmail 659 invoked by uid 107); 27 Aug 2009 21:34:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 Aug 2009 17:34:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Aug 2009 17:34:26 -0400
Content-Disposition: inline
In-Reply-To: <20090827204835.GC4399@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127215>

On Thu, Aug 27, 2009 at 04:48:35PM -0400, Jeff King wrote:

> And this matching is not really any different than what the fetch code
> does when applying the refspec to what the remote offers. So I don't
> think it should be any significant new code; it's just a matter of
> activating that matching and updating the local tracking refs based on
> what we actually fetched, instead of what the remote advertised.

Sure enough, here is a really simple proof of concept. This is the first
time I have really looked into the fetch code, so I hope I'm not totally
breaking something else. :)

Basically it works like this. Both "git fetch remote" and "git fetch
remote refspec" work by making a "ref map" via get_ref_map. This is a
list of refs, with some refs having a "peer ref" that points to the
local counterpart. Those without a peer are just stored in FETCH_HEAD.
The function works by starting with a list of possible remote refs, and
then applying the refspecs to it.

Calling fetch without explicit refspecs means we will create the map
using the configured refspecs. Calling with commandline refspecs means
we will use those. So what this patch does is to first apply the
commandline refspecs to narrow the list, and then apply the configured
refspecs on top of that to make a new list, and then concatenate the
lists.

So you will end up with "two" refs to fetch, which just happen to match
the same source. One will go to FETCH_HEAD, and one will go to the
tracking ref. I.e.:

  $ git remote add origin ~/compile/git
  $ git fetch origin next
  From /home/peff/compile/git
   * branch            next       -> FETCH_HEAD
   * [new branch]      next       -> origin/next

And it should work the same if you supply a more interesting refspec,
too:

  $ git fetch -v origin next:foo
  From /home/peff/compile/git
   * [new branch]      next       -> foo
   = [up to date]      next       -> origin/next

or even a wildcard:

  $ git fetch -v origin refs/heads/*:refs/foo/*
  From /home/peff/compile/git
   * [new branch]      master     -> refs/foo/master
   * [new branch]      next       -> refs/foo/next
   * [new branch]      master     -> origin/master
   = [up to date]      next       -> origin/next

I haven't thought long enough to be convinced there aren't any bad side
effects, though. I guess if you had non-traditional configured refspecs,
you might be surprised to see them applied in this case. Something like:

  # we usually fetch the remote's master straight into our production
  # branch for deployment
  $ git config remote.origin.fetch refs/heads/master:refs/heads/production

  # but today let's demo it first
  $ git fetch origin master:demo

I don't know if people are actually using refspecs in that way. But we
do need to consider that this is a potentially destructive change.

Anyway, here is the patch.

---
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 817dd6b..d9e44c7 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -119,6 +119,9 @@ static struct ref *get_ref_map(struct transport *transport,
 	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
 	if (ref_count || tags == TAGS_SET) {
+		struct ref *tracking_refs = NULL;
+		struct ref **tracking_tail = &tracking_refs;
+
 		for (i = 0; i < ref_count; i++) {
 			get_fetch_map(remote_refs, &refs[i], &tail, 0);
 			if (refs[i].dst && refs[i].dst[0])
@@ -129,6 +132,12 @@ static struct ref *get_ref_map(struct transport *transport,
 			rm->merge = 1;
 		if (tags == TAGS_SET)
 			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
+
+		for (i = 0; i < transport->remote->fetch_refspec_nr; i++)
+			get_fetch_map(ref_map, &transport->remote->fetch[i],
+					&tracking_tail, 0);
+		*tail = tracking_refs;
+		tail = tracking_tail;
 	} else {
 		/* Use the defaults */
 		struct remote *remote = transport->remote;
