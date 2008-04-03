From: Jeff King <peff@peff.net>
Subject: Re: [REQ] Better error reporting when git rebase cannot rebase
Date: Thu, 3 Apr 2008 05:57:22 -0400
Message-ID: <20080403095722.GA6673@coredump.intra.peff.net>
References: <47F3A9CA.9090307@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jake Goulding <goulding@vivisimo.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 11:58:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhMCw-000444-D5
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 11:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbYDCJ51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 05:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbYDCJ51
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 05:57:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1279 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbYDCJ50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 05:57:26 -0400
Received: (qmail 7898 invoked by uid 111); 3 Apr 2008 09:57:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 03 Apr 2008 05:57:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Apr 2008 05:57:22 -0400
Content-Disposition: inline
In-Reply-To: <47F3A9CA.9090307@vivisimo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78740>

On Wed, Apr 02, 2008 at 11:44:10AM -0400, Jake Goulding wrote:

> Right now, if you have modified files in the working directory and  
> attempt to do a git rebase, you will see messages like:
>
> $ git rebase origin/master
> Makefile: needs update

I agree that message is terrible. I have long since lost my git
virginity, and it makes sense to me now, but I remember getting confused
by it quite a bit early on.

Unfortunately I am not sure of the best way to fix this message. It
happens at a very low level in read-cache.c, and so it shows up in
several different places. I am not even sure of all the places you can
see it, so coming up with different text that makes more sense is
non-trivial.

> However, it isn't always clear that that means the rebase *did not work*.
> This has bitten a few of my developers a few times when they think that a 
> rebase worked and that they need to perform some sort of "update" to the 
> files in question.

But this is, I think, a slightly separate issue, which is that rebase
just bails without saying why. And that's easy to fix. How about this?

-- >8 --
rebase: warn about uncommitted changes before bailing

If refreshing the index reports modified files, we used to
just bail without saying anything else, leaving the user
only with the cryptic "foo: needs update" message. Let's
also tell them that we are canceling the rebase.

Signed-off-by: Jeff King <peff@peff.net>
---
The message is patterned off the one below it. Maybe "uncommitted" is
not the right word; technically the changes are _unstaged_. And the
message for the index and head differing says the index is "not up to
date"; perhaps that should say "uncommitted changes".

 git-rebase.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9b13b83..045b8ac 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -282,7 +282,10 @@ else
 fi
 
 # The tree must be really really clean.
-git update-index --refresh || exit
+if ! git update-index --refresh; then
+	echo >&2 cannot rebase: you have uncommitted changes
+	exit 1
+fi
 diff=$(git diff-index --cached --name-status -r HEAD --)
 case "$diff" in
 ?*)	echo "cannot rebase: your index is not up-to-date"
-- 
1.5.5.rc2.170.g6aa60.dirty
