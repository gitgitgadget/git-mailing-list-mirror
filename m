From: Jeff King <peff@peff.net>
Subject: Re: Can `git blame` show the date that each line was merged?
Date: Tue, 4 Jun 2013 11:56:05 -0400
Message-ID: <20130604155605.GA15953@sigill.intra.peff.net>
References: <CAJELnLEiK1C9PeimSwDoJoy=wFbFF0+KoK3jhXSAV4b2DsBKqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 17:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujtat-0007as-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 17:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271Ab3FDP4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 11:56:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:42099 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755366Ab3FDP4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 11:56:09 -0400
Received: (qmail 25471 invoked by uid 102); 4 Jun 2013 15:56:54 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Jun 2013 10:56:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2013 11:56:05 -0400
Content-Disposition: inline
In-Reply-To: <CAJELnLEiK1C9PeimSwDoJoy=wFbFF0+KoK3jhXSAV4b2DsBKqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226370>

On Tue, Jun 04, 2013 at 09:39:45AM -0400, Matt McClure wrote:

> Can `git blame` show the date that each line was merged to the current
> branch rather than the date it was committed?

Not exactly. Git does not record when a commit entered a particular
branch (or what the "ours" branch was called during a merge).  If you
follow a topic branch workflow in which an integrator merges each branch
into master, then following the first parent of each merge will show the
commits directly on master.

You can see this in action in git.git, which follows such a workflow, by
doing "git log --first-parent", which shows only the commits created
directly on master (mostly merges of topics, with a few trivial fixups
interspersed).

Similarly, you should be able to do "git blame --first-parent foo.c" to
pass blame only along the first-parent lines. Unfortunately, while
"blame" uses the regular revision code to parse its options, it does its
own traversal and does not respect each option. However, the patch to
teach it about --first-parent is pretty trivial:

diff --git a/builtin/blame.c b/builtin/blame.c
index 57a487e..0fb67af 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1199,6 +1199,8 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit)
 {
 	int cnt;
 	struct commit_list *l = first_scapegoat(revs, commit);
+	if (revs->first_parent_only)
+		return l ? 1 : 0;
 	for (cnt = 0; l; l = l->next)
 		cnt++;
 	return cnt;

(though I suspect it would interact oddly with the "--reverse" option,
and we would want to either declare them mutually exclusive or figure
out some sane semantics).

> Aside: in some trial and error I notice this oddity:
> 
>     $ git blame --merges
>     usage: git blame [options] [rev-opts] [rev] [--] file
> 
>         [rev-opts] are documented in git-rev-list(1)
>     ...

Your problem is not the presence of "--merges" here, but that you forgot
the necessary "file" argument. Try "git blame --merges foo.c".

However, this suffers from the same problem as --first-parent, in that
it is accepted but not respected. Doing so would not be impossible, but
it is a little more than the two-liner above.

-Peff
