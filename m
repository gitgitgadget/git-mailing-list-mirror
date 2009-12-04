From: Jeff King <peff@peff.net>
Subject: Re: git reset --hard in .git causes a checkout in that directory
Date: Fri, 4 Dec 2009 06:11:58 -0500
Message-ID: <20091204111158.GE27495@coredump.intra.peff.net>
References: <4B17A166.60306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Maarten Lankhorst <m.b.lankhorst@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 12:12:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGW50-0000XB-8o
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 12:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbZLDLLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 06:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755435AbZLDLLy
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 06:11:54 -0500
Received: from peff.net ([208.65.91.99]:46005 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754979AbZLDLLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 06:11:53 -0500
Received: (qmail 18873 invoked by uid 107); 4 Dec 2009 11:16:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 04 Dec 2009 06:16:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2009 06:11:58 -0500
Content-Disposition: inline
In-Reply-To: <4B17A166.60306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134508>

On Thu, Dec 03, 2009 at 12:30:46PM +0100, Maarten Lankhorst wrote:

> When I was working on my code and made a mess that I wanted to undo,
> I accidentally did it in the .git directory, and had a whole clone of
> my last committed tree there.
> 
> It can be triggered easily:
> 
> mkdir test; cd test; git init; touch foo; git add foo; git commit -m
> 'add foo'; cd .git; git reset --hard; [ -f foo ] && echo hello beauty
> 
> Other parts of git could be affected, I haven't checked where exactly
> the bug hides, so I was afraid to send in a patch

Yuck. Thanks for the bug report. This is due to a too-loose check on my
part in 49b9362 (git-reset: refuse to do hard reset in a bare
repository, 2007-12-31).

Junio, I think the following should go to maint (I didn't bother
splitting the --merge and --hard code; --merge is in v1.6.2. I assumed
we don't care about maint releases that far back).

-- >8 --
Subject: [PATCH] reset: improve worktree safety valves

The existing code checked to make sure we were not in a bare
repository when doing a hard reset. However, we should take
this one step further, and make sure we are in a worktree.
Otherwise, we can end up munging files inside of '.git'.

Furthermore, we should do the same check for --merge resets,
which have the same properties. Actually, a merge reset of
HEAD^ would already complain, since further down in the code
we want a worktree. However, it is nicer to check up-front;
then we are sure we cover all cases ("git reset --merge"
would run, even though it wasn't doing anything) and we can
give a more specific message.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-reset.c       |    6 ++++--
 t/t7103-reset-bare.sh |   14 ++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 73e6022..11d1c6e 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -286,8 +286,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
-	if (reset_type == HARD && is_bare_repository())
-		die("hard reset makes no sense in a bare repository");
+	if ((reset_type == HARD || reset_type == MERGE)
+	    && !is_inside_work_tree())
+		die("%s reset requires a work tree",
+		    reset_type_names[reset_type]);
 
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index 42bf518..3ddf0ac 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -11,6 +11,16 @@ test_expect_success 'setup non-bare' '
 	git commit -a -m two
 '
 
+test_expect_success 'hard reset requires a worktree' '
+	(cd .git &&
+	 test_must_fail git reset --hard)
+'
+
+test_expect_success 'merge reset requires a worktree' '
+	(cd .git &&
+	 test_must_fail git reset --merge)
+'
+
 test_expect_success 'setup bare' '
 	git clone --bare . bare.git &&
 	cd bare.git
@@ -20,6 +30,10 @@ test_expect_success 'hard reset is not allowed' '
 	test_must_fail  git reset --hard HEAD^
 '
 
+test_expect_success 'merge reset is not allowed' '
+	test_must_fail git reset --merge HEAD^
+'
+
 test_expect_success 'soft reset is allowed' '
 	git reset --soft HEAD^ &&
 	test "`git show --pretty=format:%s | head -n 1`" = "one"
-- 
1.6.6.rc1.18.ga777f.dirty
