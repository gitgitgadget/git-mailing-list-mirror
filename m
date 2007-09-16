From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Don't configure remote "." to fetch everything to itself
Date: Sun, 16 Sep 2007 02:32:11 -0400
Message-ID: <20070916063210.GB6487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 08:32:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWng3-00085O-Mr
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 08:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbXIPGcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 02:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbXIPGcQ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 02:32:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44717 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbXIPGcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 02:32:15 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWnfv-0005cz-JY; Sun, 16 Sep 2007 02:32:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3960820FBAE; Sun, 16 Sep 2007 02:32:11 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58299>

When we are talking about a remote URI of "." we are really talking
about *this* repository that we are fetching into or pushing out of.
There are no matching tracking branches for this repository; we
do not attempt to map a ref back to ourselves as this would either
create an infinite cycle (for example "fetch = +refs/*:refs/mine/*")
or it causes problems when we attempt to push back to ourselves.

So we really cannot setup a remote like this:

  [remote "."]
    url = .
    fetch = +refs/*:refs/*

In the case of `git push . B:T` to fast-forward branch T to B's
current commit git-send-pack will update branch T to B, assuming that
T is the remote tracking branch for B.  This update is performed
immediately before git-send-pack asks git-receive-pack to perform
the same update, and git-receive-pack then fails because T is not
where git-send-pack told it to expect T to be at.

In the case of `git fetch .` we really should do the same thing as
`git fetch $otherrepo`, that is load .git/FETCH_HEAD with the commit
of HEAD, so that `git pull .` will report "Already up-to-date".
We have always behaved like this before on this insane request and
we should at least continue to behave the same way.  With the above
(bad) remote configuration we were instead getting fetch errors
about funny refs, e.g. "refs/stash".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This fixes the "push to yourself" breakage I mentioned yesterday.

 remote.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index df91b2f..73a34c9 100644
--- a/remote.c
+++ b/remote.c
@@ -356,10 +356,6 @@ struct remote *remote_get(const char *name)
 		add_uri(ret, name);
 	if (!ret->uri)
 		return NULL;
-	if (!strcmp(name, ".")) {
-		// we always fetch "refs/*:refs/*", which is trivial
-		add_fetch_refspec(ret, "refs/*:refs/*");
-	}
 	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
 	ret->push = parse_ref_spec(ret->push_refspec_nr, ret->push_refspec);
 	return ret;
-- 
1.5.3.1.1000.g7319b
