From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] show: turn on rename progress
Date: Fri, 25 Mar 2011 02:17:44 -0400
Message-ID: <20110325061744.GA6261@sigill.intra.peff.net>
References: <7vzkok6qie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 07:17:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q30LK-0001ct-VZ
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 07:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200Ab1CYGRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 02:17:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39333
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703Ab1CYGRs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 02:17:48 -0400
Received: (qmail 8922 invoked by uid 107); 25 Mar 2011 06:18:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 02:18:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 02:17:44 -0400
Content-Disposition: inline
In-Reply-To: <7vzkok6qie.fsf@alter.siamese.dyndns.org>
 <7v4o6s86kr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169964>

On Thu, Mar 24, 2011 at 04:03:16PM -0700, Junio C Hamano wrote:

> >   [1/4]: pager: save the original stderr when redirecting to pager
> >   [2/4]: progress: use pager's original_stderr if available
> >   [3/4]: show: turn on rename detection progress reporting
> >   [4/4]: diff: turn on rename detection progress reporting
> 
> Thanks, but why does it affect t0101 and many others...?

Because I'm an idiot who, despite manually testing the option-parsing
part of the code a million times, didn't actually run the full suite.

> >  	while ((commit = get_revision(rev)) != NULL) {
> > -		if (!log_tree_commit(rev, commit) &&
> > +		int showed = log_tree_commit(rev, commit);
> > +		if (showed &&
> >  		    rev->max_count >= 0)

Ugh. Of course, it should be:


diff --git a/builtin/log.c b/builtin/log.c
index 4d52e99..b19e10d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -275,7 +275,7 @@ static int cmd_log_walk(struct rev_info *rev)
 	 */
 	while ((commit = get_revision(rev)) != NULL) {
 		int showed = log_tree_commit(rev, commit);
-		if (showed &&
+		if (!showed &&
 		    rev->max_count >= 0)
 			/*
 			 * We decremented max_count in get_revision,

on top.

> After looking at the implementation of log_tree_commit(), shouldn't this
> part be more like this?
> 
> 	int shown = log_tree_commit(rev, commit);
>         if (!shown && rev->max_count >=0)
>         	rev->max_count++;
> 	if (shown)
>         	rev->diffopt.show_rename_progress = 0;

Yes. You shouldn't even need to look at log_tree_commit; you can see in
the hunk of my patch that I accidentally inverted the unrelated
max_count conditional while factoring out the call.

I'll go find a brown paper bag now.

-Peff

PS I assume you can squash in the above, or take your version (I don't
care about the verb tense we use, but re-indenting the max_count
conditional as you did is good style).
