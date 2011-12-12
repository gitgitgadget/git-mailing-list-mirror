From: Jeff King <peff@peff.net>
Subject: Re: Git blame only current branch
Date: Mon, 12 Dec 2011 11:55:42 -0500
Message-ID: <20111212165542.GA4802@sigill.intra.peff.net>
References: <e9e35956-a091-4143-8fd4-3516b54263a6@mail>
 <d615954f-bed8-482d-a2e3-e1e741d6dd23@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git discussion list <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 17:55:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra9AL-0007fe-TE
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 17:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab1LLQzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 11:55:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48203
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091Ab1LLQzo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 11:55:44 -0500
Received: (qmail 1592 invoked by uid 107); 12 Dec 2011 17:02:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 12:02:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 11:55:42 -0500
Content-Disposition: inline
In-Reply-To: <d615954f-bed8-482d-a2e3-e1e741d6dd23@mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186916>

On Mon, Dec 12, 2011 at 10:24:47AM -0500, Stephen Bash wrote:

> I'm curious if there's a method to make git blame merge commits that
> introduce code to the given branch rather than commits on the original
> (topic) branch?  For example:

Usually when you are interested in seeing merges like this in git-log,
you would use one of "--first-parent" or "--merges". However, though
"git blame" takes revision arguments, it does its own traversal of the
graph that does not respect those options.

Modifying it to do --first-parent is pretty easy:

diff --git a/builtin/blame.c b/builtin/blame.c
index 80febbe..c19a8cd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1191,6 +1191,8 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit)
 {
 	int cnt;
 	struct commit_list *l = first_scapegoat(revs, commit);
+	if (revs->first_parent_only)
+		return l ? 1 : 0;
 	for (cnt = 0; l; l = l->next)
 		cnt++;
 	return cnt;

With that, "git blame --first-parent" produces reasonable results for
me. But of course I didn't do more than 30 seconds of testing, so it is
entirely possible there are corner cases or unforeseen side effects.

Handling --merges is probably a little trickier, as you need to consider
only some commits as scapegoats, but still traverse through everything
to find the merges.

-Peff
