From: Jeff King <peff@peff.net>
Subject: Re: First/oldest entry in reflog dropped
Date: Sun, 21 Nov 2010 00:35:46 -0500
Message-ID: <20101121053545.GA10520@sigill.intra.peff.net>
References: <AANLkTiktGbeSmUB75kn3q=swnw=cHvivX21OkR3sJJDC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 21 06:37:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PK2cA-0007so-T1
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 06:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880Ab0KUFfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 00:35:53 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55045 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab0KUFfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 00:35:53 -0500
Received: (qmail 7123 invoked by uid 111); 21 Nov 2010 05:35:51 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 21 Nov 2010 05:35:51 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Nov 2010 00:35:46 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTiktGbeSmUB75kn3q=swnw=cHvivX21OkR3sJJDC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161858>

On Sat, Nov 20, 2010 at 10:11:34PM -0500, Martin von Zweigbergk wrote:

> Can someone explain the behavior in the execution below?
> 
> # I expected this reflog...
> $ git branch tmp
> $ git reflog show refs/heads/tmp
> b60a214 refs/heads/tmp@{0}: branch: Created from master
> 
> # ... and this one as well...
> $ git update-ref refs/heads/tmp HEAD^
> $ git reflog show refs/heads/tmp
> 7d1a0b8 refs/heads/tmp@{0}:
> b60a214 refs/heads/tmp@{1}: branch: Created from master
> 
> # ... but why is the first entry (i.e. "branch: Created from master")
> # dropped here?
> $ git update-ref refs/heads/tmp HEAD
> $ git reflog show refs/heads/tmp
> b60a214 refs/heads/tmp@{0}:
> 7d1a0b8 refs/heads/tmp@{1}:
> 
> If the ref is updated once more (to e.g. HEAD^^) before being moved back
> to HEAD, the first entry will be shown in the output.
> 
> If this is a bug, it seems to be in reflog, rather than in update-ref,
> because the first entry does exist in .git/logs/refs/heads/tmp.

I think it's a bug in the reflog-walking machinery, which is sort of
bolted onto the regular revision traversal machinery. When we hit
b60a214 the first time, we show it and set the SHOWN flag (since the
normal traversal machinery would not want to show a commit twice). When
we hit it again, simplify_commit() sees that it is SHOWN and tells us to
skip it.

However, the bolted-on reflog-walking machinery does have a way of
handling this. While we are traversing via get_revision(), we notice
that we are doing a reflog walk and call fake_reflog_parent. This
function is responsible for replacing the actual parents of the commit
with a fake list consisting of the previous reflog entry (so we
basically pretend that the history consists of a string of commits, each
one pointing to the previous reflog entry, not the actual parent).

This function _also_ clears some flags, including the SHOWN flag, in
what almost seems like a tacked-on side effect. So if we hit the same
commit twice, we will actually show it again. Which is what makes
reflogs with repeated commits work at all.

However, there is a subtle bug: it clears the flags at the very end of
the function. But through the function, if we see that there are no fake
parents (because we are on the very first reflog entry), we do an early
return. But we not only skip the later "set up parents" code, we also
accidentally skip the "clear SHOWN flag" side-effect code.

So I believe we will always fail to show the very first reflog if it is
a repeated commit.

The fix, AFAICT, is to just move the flag clearing above the early
returns (patch below). But I have to admit I do not quite understand
what the ADDED and SEEN flags are doing here, as this is the first time
I have ever looked at the reflog-walk code. So possibly just the SHOWN
flag should be unconditionally cleared.

This patch clears up your bug, and doesn't break any tests. But I'd
really like to get a second opinion on the significance of those other
flags, or why the flag clearing was at the bottom of the function in the
first place.

-Peff

---
diff --git a/reflog-walk.c b/reflog-walk.c
index 4879615..d5d055b 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -210,44 +210,45 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	add_commit_info(commit, commit_reflog, &info->reflogs);
 	return 0;
 }
 
 void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 {
 	struct commit_info *commit_info =
 		get_commit_info(commit, &info->reflogs, 0);
 	struct commit_reflog *commit_reflog;
 	struct reflog_info *reflog;
 
+	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
+
 	info->last_commit_reflog = NULL;
 	if (!commit_info)
 		return;
 
 	commit_reflog = commit_info->util;
 	if (commit_reflog->recno < 0) {
 		commit->parents = NULL;
 		return;
 	}
 
 	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog = commit_reflog;
 	commit_reflog->recno--;
 	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
 	if (!commit_info->commit) {
 		commit->parents = NULL;
 		return;
 	}
 
 	commit->parents = xcalloc(sizeof(struct commit_list), 1);
 	commit->parents->item = commit_info->commit;
-	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
 void get_reflog_selector(struct strbuf *sb,
 			 struct reflog_walk_info *reflog_info,
 			 enum date_mode dmode,
 			 int shorten)
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
 	struct reflog_info *info;
 	const char *printed_ref;
 
