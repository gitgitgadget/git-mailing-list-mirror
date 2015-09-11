From: Jeff King <peff@peff.net>
Subject: Re: [Feature Request] git blame showing only revisions from git
 rev-list --first-parent
Date: Fri, 11 Sep 2015 10:01:33 -0400
Message-ID: <20150911140133.GA14311@sigill.intra.peff.net>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Connolly <stephen.alan.connolly@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 16:01:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaOtZ-0004CG-AW
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 16:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbbIKOBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 10:01:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:57718 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752167AbbIKOBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 10:01:36 -0400
Received: (qmail 20038 invoked by uid 102); 11 Sep 2015 14:01:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Sep 2015 09:01:35 -0500
Received: (qmail 4141 invoked by uid 107); 11 Sep 2015 14:01:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Sep 2015 10:01:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2015 10:01:33 -0400
Content-Disposition: inline
In-Reply-To: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277659>

On Fri, Sep 11, 2015 at 11:47:30AM +0100, Stephen Connolly wrote:

> A command line option to `git blame HEAD -- path` that instructs that
> the revisions of blame be the revisions where the change was applied
> to the current branch not the revision where the change first
> originated (i.e. limit commits to `git rev-list --first-parent HEAD`)
> 
> I can get what I want with the following:
> 
> git rev-list --first-parent HEAD | awk '{print p " " $0}{p=$0}' >
> tmpfile && git blame -b -S tmpfile HEAD -- path && rm tmpfile
> 
> But that is a rather ugly command. Could we have something built in to
> git blame to make this much easier for users?

I agree this would be a useful feature. Though blame takes rev-list
options, it doesn't use the stock rev-list traversal internally, so it
has to handle first-parent itself.

I'm not too familiar with the code, but this _seems_ to work for me:

diff --git a/builtin/blame.c b/builtin/blame.c
index 21321be..2e03d47 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1375,6 +1375,10 @@ static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit
 static int num_scapegoats(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list *l = first_scapegoat(revs, commit);
+	if (!l)
+		return 0;
+	if (revs->first_parent_only)
+		return 1;
 	return commit_list_count(l);
 }
 

I suspect it doesn't work at all with `--reverse`. I also have the
nagging feeling that this could be handled inside revision.c with
parent-rewriting, but I don't really know.

But "git blame --first-parent <file>" seems to behave sanely in git.git
with this.

-Peff
