From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: [PATCH] git-cvsserver: run post-update hook *after* update.
Date: Thu, 29 Jan 2009 13:58:02 -0800
Message-ID: <1233266282-8010-1-git-send-email-stefan.karpinski@gmail.com>
References: <7viqo61mfq.fsf@gitster.siamese.dyndns.org>
Cc: Stefan Karpinski <stefan.karpinski@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>,
	Michael Witten <mfwitten@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 22:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSev5-0000RK-6b
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 22:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbZA2V6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 16:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbZA2V6H
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 16:58:07 -0500
Received: from zion.cs.ucsb.edu ([128.111.52.118]:59776 "EHLO zion.cs.ucsb.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbZA2V6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 16:58:05 -0500
Received: by zion.cs.ucsb.edu (Postfix, from userid 401)
	id BADE59D1F5D; Thu, 29 Jan 2009 13:58:02 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.3.g08dd8
In-Reply-To: <7viqo61mfq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107733>

CVS server was running the hook before the update action was
actually done. This performs the update before the hook is called.

The original commit that introduced the current incorrect behavior
was 394d66d "git-cvsserver runs hooks/post-update". The error in
ordering of the hook call appears to have gone unnoticed, but since
git-cvsserver is supposed to emulate receive-pack, it stands to
reason that the hook should be run *after* the update. Since this
behavior is inconsistent with recieve-pack, users are either:

  1) not using post-update hooks with git-cvsserver;
  2) using post-update hooks that don't care whether they are
     called before or after the actual update occurs;
  3) using post-update hooks *only* with git-cvsserver, and
     relying on the hook being called just before the update.

This patch would affect only users in case 3. These users are
depending on fairly obviously wrong behavior, and moreover they can
simply change their current post-update into post-recieve hooks,
and their systems will work correctly again.

Signed-off-by: Stefan Karpinski <stefan.karpinski@gmail.com>
---
I'm CCing Andy Parkins, Michael Witten, and Junio Hamano, who
authored the other three commits implementing or affecting hooks in
git-cvsserver (394d66d, cdf6328, b2741f6). If you could please take
a look at this patch and comment on if it's harmful or not, it
would be much appreciated.

 git-cvsserver.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index c1e09ea..d2e6003 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1413,14 +1413,14 @@ sub req_ci
 		close $pipe || die "bad pipe: $! $?";
 	}
 
+    $updater->update();
+
 	### Then hooks/post-update
 	$hook = $ENV{GIT_DIR}.'hooks/post-update';
 	if (-x $hook) {
 		system($hook, "refs/heads/$state->{module}");
 	}
 
-    $updater->update();
-
     # foreach file specified on the command line ...
     foreach my $filename ( @committedfiles )
     {
-- 
1.6.0.3.3.g08dd8
