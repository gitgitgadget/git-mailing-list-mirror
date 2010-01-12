From: Jeff King <peff@peff.net>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Tue, 12 Jan 2010 13:25:50 -0500
Message-ID: <20100112182550.GA15696@coredump.intra.peff.net>
References: <loom.20100111T185144-655@post.gmane.org>
 <7v7hrojukz.fsf@alter.siamese.dyndns.org>
 <20100112162355.GB25092@coredump.intra.peff.net>
 <7vhbqr2nxt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gareth Adams <gareth.adams@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUlRT-0002gw-H7
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 19:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab0ALS0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 13:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430Ab0ALS0A
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 13:26:00 -0500
Received: from peff.net ([208.65.91.99]:59801 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149Ab0ALSZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 13:25:59 -0500
Received: (qmail 10144 invoked by uid 107); 12 Jan 2010 18:30:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 13:30:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 13:25:50 -0500
Content-Disposition: inline
In-Reply-To: <7vhbqr2nxt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136745>

On Tue, Jan 12, 2010 at 10:11:26AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. If we had the oft-discussed-but-never-agreed-upon shorthand for
> > "the upstream of" then we wouldn't need a special merge option. You
> > could just do:
> >
> >   git merge %HEAD ;# (or git merge %, IIRC the proposal correctly)
> 
> I don't think "whatever _HEAD_ tracks" makes sense at the semantic level
> (i.e. you don't do "branch.HEAD.merge") but a syntax for "whatever the
> named _branch_ tracks" with "if a branch is not named, the current branch
> is implied" (i.e. the one in parentheses) would.

The patch that Dscho provided would actually convert HEAD@{upstream}
into the upstream of whatever HEAD pointed at. Which I think makes
sense. We don't do it for reflogs, but that is because it is useful to
distinguish between the reflog for a symref and the thing it points to.
But since one would presumably not make such a configuration for a
symref, that distinction is not useful.

> It is an entirely different matter what the special syntax to trigger that
> "upstream-ness" should be.  I vaguely recall @{upstream} or @{u} were the
> concensus?

Ah, right. I remembered hating "%" even as I typed it, but I had
forgotten about the followup discussion. Looking at it again, I note:

  1. The last posted patch still has a misplaced free() (patch below),
     but I think otherwise is not buggy.

  2. We don't complain on "git show @{usptream}" and we probably should.
     I remember there being some complications because the contents of
     @{} were passed to approxidate, but I think we can get around that
     by letting approxidate complain if _nothing_ in the date was
     useful. So "git show @{2.weeks.and.7.hot.dogs.ago}" would still
     work, but "git show @{totally.bogus.input}" would complain.

  3. I have actually been running with Dscho's patch for the last couple
     of months, and I don't remember using it once. So perhaps it is not
     as useful as I might have thought. :)

Anyway, fixup patch is below. I don't expect you to pick up the topic or
anything, but since I went to the trouble to find the bug once upon a
time, I thought I would post the fix for anybody who does want to pick
it up.

diff --git a/sha1_name.c b/sha1_name.c
index b73b93e..da90ebe 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -275,9 +275,9 @@ static char *substitute_branch_name(const char **string, int *len)
 		char *ref = xstrndup(*string, *len - ret);
 		struct branch *tracking = branch_get(*ref ? ref : NULL);
 
-		free(ref);
 		if (!tracking)
 			die ("No tracking branch found for '%s'", ref);
+		free(ref);
 		if (tracking->merge && tracking->merge[0]->dst) {
 			*string = xstrdup(tracking->merge[0]->dst);
 			*len = strlen(*string);
