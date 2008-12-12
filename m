From: Jeff King <peff@peff.net>
Subject: Re: git log --numstat disagrees with git apply --numstat
Date: Thu, 11 Dec 2008 20:52:55 -0500
Message-ID: <20081212015254.GA23128@sigill.intra.peff.net>
References: <20081211235337.GK32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 02:54:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAxEU-0000CS-25
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 02:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbYLLBxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 20:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756852AbYLLBxD
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 20:53:03 -0500
Received: from peff.net ([208.65.91.99]:2060 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756506AbYLLBxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 20:53:01 -0500
Received: (qmail 31359 invoked by uid 111); 12 Dec 2008 01:52:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 11 Dec 2008 20:52:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Dec 2008 20:52:55 -0500
Content-Disposition: inline
In-Reply-To: <20081211235337.GK32487@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102858>

On Thu, Dec 11, 2008 at 03:53:37PM -0800, Shawn O. Pearce wrote:

> I've found a case where git apply --numstat and git log --numstat
> produce different results for the same commit.

"git apply" doesn't actually do the diff; it just calculates based on
what it sees in the patch. So the real issue is "git log -p" and "git
log --numstat" produce different patches. And you can see it by
instrumenting like this:

diff --git a/diff.c b/diff.c
index af822c1..fce93db 100644
--- a/diff.c
+++ b/diff.c
@@ -726,6 +726,8 @@ static void diffstat_consume(void *priv, char *line, unsigned long len)
 	struct diffstat_t *diffstat = priv;
 	struct diffstat_file *x = diffstat->files[diffstat->nr - 1];
 
+	fwrite(line, 1, len, stderr);
+
 	if (line[0] == '+')
 		x->added++;
 	else if (line[0] == '-')

and then comparing what diffstat_consume gets versus the patch,
something like:

    what="9bda5ece org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java"
    git log -p -1 --pretty=format: $what | grep '^[-+@]' >a
    git log --numstat -1 --pretty=format: $what 2>b >/dev/null
    diff -u a b

It looks like it is just a place where two different valid diffs can be
constructed:

    +-
    +-              for (final RevCommit p : c.parents) {
    +-                      if ((p.flags & SEEN) != 0)
     +              for (;;) {
     +                      final RevCommit c = pending.pop();
     +                      if (c == null)
    @@ -67,19 +68,20 @@
     +                              p.flags |= SEEN;
     +                              pending.add(p);
     +                      }
    --              for (final RevCommit p : c.parents) {
    --                      if ((p.flags & SEEN) != 0)
    ++

which is probably just due to different xdi settings being used between
the two codepaths. I haven't looked closely to see which different
options we are feeding to xdiff.

-Peff
