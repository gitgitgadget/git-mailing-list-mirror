From: Bram Geron <bgeron@bgeron.nl>
Subject: Re: [BUG] Git clone of a bundle fails, but works (somewhat) when run with strace
Date: Wed, 28 May 2014 15:59:37 +0000 (UTC)
Message-ID: <loom.20140528T171956-380@post.gmane.org>
References: <511E8D84.6060601@gmail.com> <kfmclb$4ro$2@ger.gmane.org> <kfmide$4ro$3@ger.gmane.org> <20130216040109.GA31630@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 18:05:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpgM1-0008Jm-H6
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 18:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbaE1QFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 12:05:17 -0400
Received: from plane.gmane.org ([80.91.229.3]:41116 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbaE1QFP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 12:05:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WpgLg-0007pw-1i
	for git@vger.kernel.org; Wed, 28 May 2014 18:05:04 +0200
Received: from dynamic200-212.cs.bham.ac.uk ([147.188.200.212])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 May 2014 18:05:04 +0200
Received: from bgeron by dynamic200-212.cs.bham.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 May 2014 18:05:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 147.188.200.212 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250291>

Jeff King <peff <at> peff.net> writes:
> [..]
> Secondly, I do get the same warning about HEAD:
> 
>   $ git clone repo.bundle repofrombundle
>   Cloning into 'repofrombundle'...
>   Receiving objects: 100% (3/3), done.
>   warning: remote HEAD refers to nonexistent ref, unable to checkout.
> 
> but that warning makes sense. You did not create a bundle that contains
> HEAD, therefore when we clone it, we do not know what to point HEAD to.
> You probably wanted "git bundle create ../repo.bundle --all" which
> includes both "master" and "HEAD".

I'd like to revive this discussion and submit a patch, as I just spent
significant time wondering why git clone failed. It's been a while, so I'll
summarize: when you make a git bundle without including HEAD explicitly,
then clone from that bundle, Git throws a warning and leaves you with a
broken HEAD.

I do not agree that the warning makes sense. It implies that HEAD exists but
is invalid. In reality, no ref is referred to by HEAD in the first place.
Furthermore, .git/HEAD in the clone is "autocorrected" to be
refs/heads/master, so the error message is even more misleading.

It's like saying "Our CEO's guitar is actually an air guitar", then
explaining where he stores his guitar, when I don't work in a company in the
first place.

> It would be slightly more accurate to say "the remote HEAD does not
> exist", rather than "refers to nonexistent ref".  It would perhaps be
> nicer still for "git clone" to make a guess about the correct HEAD when
> one is not present (especially in the single-branch case, it is easy to
> make the right guess).

Seems sensible at first sight, though it seems orthogonal to the warning
message.

> Patches welcome. In the meantime, you can clone with "-b master" to tell
> it explicitly, or you can "git checkout master" inside the newly-cloned
> repository.

Alright :) See below.

Cheers, Bram


>From bc799b12b659d7ab20df7fe420d5f1f1c90450aa Mon Sep 17 00:00:00 2001
From: Bram Geron <bgeron@bgeron.nl>
Date: Wed, 28 May 2014 15:54:37 +0100
Subject: [PATCH] Clearer error message when cloning a bundle without a HEAD
 ref.

---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9b3c04d..e3c1447 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -623,7 +623,7 @@ static int checkout(void)
 
 	head = resolve_refdup("HEAD", sha1, 1, NULL);
 	if (!head) {
-		warning(_("remote HEAD refers to nonexistent ref, "
+		warning(_("no HEAD in remote or HEAD refers to nonexistent ref, "
 			  "unable to checkout.\n"));
 		return 0;
 	}
-- 
1.9.1
