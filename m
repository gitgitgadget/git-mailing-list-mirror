From: Jeff King <peff@peff.net>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Wed, 9 Nov 2011 17:20:32 -0500
Message-ID: <20111109222032.GB31535@sigill.intra.peff.net>
References: <4EB9C7D1.30201@nextest.com>
 <20111109220128.GA31535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 23:20:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROGVb-00043B-4s
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 23:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab1KIWUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 17:20:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38799
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab1KIWUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 17:20:34 -0500
Received: (qmail 19131 invoked by uid 107); 9 Nov 2011 22:20:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Nov 2011 17:20:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2011 17:20:32 -0500
Content-Disposition: inline
In-Reply-To: <20111109220128.GA31535@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185173>

On Wed, Nov 09, 2011 at 05:01:28PM -0500, Jeff King wrote:

> In the latter case, we would either need a new specifier (like
> "--reflog-since"), or to rewrite the commit timestamp when we rewrite
> the parent pointers.
> 
> The latter has a certain elegance to it (we are making a pretend linear
> history graph out of the reflog, so faking the timestamps to be sensible
> and in order is a logical thing to do) but I worry about lying too much
> in the output. Something like "git log -g --format=%cd" would now have
> the fake timestamp in the output. But then, we already show the fake
> parents in the output, so I don't know that this is any worse.

This patch (which is below) turns out to be absurdly simple. And it
actually still prints the original commit timestamp, because we end up
reparsing it out of the commit object during the pretty-print phase.

So I think the only decision is whether "--since" should respect the
commit timestamps (and be used as a sort of "grep" filter for
timestamps), or whether it should be respecting the fake history we
create when doing a reflog walk.

I think I am leaning towards the latter. It seems to me to be the more
likely guess for what the user would want. And there is real benefit to
doing it in git, since we can stop the traversal early. In the
"grep-like" case, doing it inside git is not really any more efficient
than filtering in a pipeline, like:

  git log -g --format='%ct %H' |
  awk '{ print $2 if $1 < SOME_TIMESTAMP }'

Of course we could still offer both (with a "--reflog-since" type of
option). We'd also need to turn off the optimization for "--since", and
then check whether "--until" has a similar bug (and offer
"--reflog-until").

diff --git a/reflog-walk.c b/reflog-walk.c
index 5d81d39..2e5b270 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -231,6 +231,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog = commit_reflog;
 	commit_reflog->recno--;
+	commit->date = reflog->timestamp;
 	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
 	if (!commit_info->commit) {
 		commit->parents = NULL;
