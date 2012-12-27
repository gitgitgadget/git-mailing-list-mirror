From: Jeff King <peff@peff.net>
Subject: Re: "fatal: git-write-tree: error building trees" from `git stash`
Date: Thu, 27 Dec 2012 14:05:42 -0500
Message-ID: <20121227190542.GB28811@sigill.intra.peff.net>
References: <1356631626.13818.126.camel@umgah.localdomain>
 <7vsj6rl456.fsf@alter.siamese.dyndns.org>
 <1356634556.13818.136.camel@umgah.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Thu Dec 27 20:06:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToImJ-0006FK-JH
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 20:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935Ab2L0TFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 14:05:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37214 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795Ab2L0TFo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 14:05:44 -0500
Received: (qmail 14057 invoked by uid 107); 27 Dec 2012 19:06:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Dec 2012 14:06:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Dec 2012 14:05:42 -0500
Content-Disposition: inline
In-Reply-To: <1356634556.13818.136.camel@umgah.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212212>

On Thu, Dec 27, 2012 at 01:55:56PM -0500, Alex Vandiver wrote:

> On Thu, 2012-12-27 at 10:51 -0800, Junio C Hamano wrote:
> > > $ git stash
> > > foo: needs merge
> > > foo: needs merge
> > > foo: unmerged (aeaa7e5e87cf309a7368d5d92a71c1f9e6a8c9e7)
> > > foo: unmerged (a77fa514de2720c72c1a861de098595959a2c97a)
> > > foo: unmerged (4a622d2b991f1a19ba7be313a46dc6f03692cd0a)
> > > fatal: git-write-tree: error building trees
> > > Cannot save the current index state
> > 
> > This is totally expected, isn't it?
> > 
> > You do not save state in the middle of a conflict with "git stash"
> > (instead, you would "git stash" away your own work in progress
> > before you start operation that may create and leave conflicts).
> 
> Apologies for not being clear.  While being unable to stash is not
> unexpected, perhaps, "Cannot stash while resolving conflicts" or similar
> would be more understandable to the end user than the above.

Yeah, I think the outcome is reasonable, but that message is just
horrible. Something like this might be better:

diff --git a/git-stash.sh b/git-stash.sh
index 688e259..7ea425c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -217,6 +217,12 @@ save_stash () {
 
 	stash_msg="$*"
 
+	if ! git diff-index --cached --diff-filter=U --quiet HEAD; then
+		echo >&2 "fatal: unable to stash unmerged entries:"
+		git diff-index --cached --diff-filter=U --name-status HEAD
+		exit 1
+	fi
+
 	git update-index -q --refresh
 	if no_changes
 	then

but I suspect it is not sufficient:

  1. There are other code paths that will end up in write-tree which
     should probably be protected, too.

  2. Unmerged entries are only one reason that write-tree might fail.
     It's OK not to catch them all (since ultimately write-tree will
     complain if need be), but we may want to also handle intent-to-add
     entries with a nicer message.

-Peff
