From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] show: turn on rename progress
Date: Thu, 24 Mar 2011 10:50:48 -0400
Message-ID: <20110324145047.GB16484@sigill.intra.peff.net>
References: <20110323181756.GA17415@sigill.intra.peff.net>
 <20110323181915.GC17533@sigill.intra.peff.net>
 <7vvcz9cyxd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 15:51:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2lsH-0006yc-2C
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 15:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032Ab1CXOuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 10:50:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34747
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932458Ab1CXOuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 10:50:50 -0400
Received: (qmail 2433 invoked by uid 107); 24 Mar 2011 14:51:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Mar 2011 10:51:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2011 10:50:48 -0400
Content-Disposition: inline
In-Reply-To: <7vvcz9cyxd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169922>

On Wed, Mar 23, 2011 at 02:25:02PM -0700, Junio C Hamano wrote:

> > This makes sense for "show", which is showing a single diff,
> > since the progress reporting will be shown before the pager
> > shows any output.
> >
> > We don't want to do the same for "log", though, because the
> > progress would be interspersed with the various commits.
> 
> I understand that you said q&d, but these days since f222abd (Make 'git
> show' more useful, 2009-07-13), show does walk when it is asked to.
> 
> "git show master maint" will also be affected with this, no?

Ick, I didn't think of that. So yeah, that patch as-is is definitely no
good. I think the most sensible thing to do is to show progress only
until we actually generate some output. That handles both the walking
case and the "git show master maint" case.

Something like this:

diff --git a/builtin/log.c b/builtin/log.c
index 707fd57..d652acc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -265,13 +265,16 @@ static int cmd_log_walk(struct rev_info *rev)
 	 * retain that state information if replacing rev->diffopt in this loop
 	 */
 	while ((commit = get_revision(rev)) != NULL) {
-		if (!log_tree_commit(rev, commit) &&
+		int showed = log_tree_commit(rev, commit);
+		if (showed &&
 		    rev->max_count >= 0)
 			/*
 			 * We decremented max_count in get_revision,
 			 * but we didn't actually show the commit.
 			 */
 			rev->max_count++;
+		if (showed && rev->diffopt.show_rename_progress)
+			rev->diffopt.show_rename_progress = 0;
 		if (!rev->reflog_info) {
 			/* we allow cycles in reflog ancestry */
 			free(commit->buffer);
@@ -416,6 +419,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.always_show_header = 1;
 	rev.no_walk = 1;
+	rev.diffopt.show_rename_progress = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	opt.tweak = show_rev_tweak_rev;

We could also turn it on for "git log" in that case, though it is only
useful if the first commit happens to be the one that is slow.

I should also turn it on for "git diff". I'll prepare a cleaner series
with that in it, too.

What about the degrade-cc-to-c warnings? Are you working on another
revision, or should I re-roll your changes on top of my series, handling
the "one-warning-per-commit" behavior I suggested when stdout and stderr
are combined?

-Peff
