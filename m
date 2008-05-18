From: Alex Riesen <raa.lkml@gmail.com>
Subject: t3701 fails if core.filemode disabled
Date: Sun, 18 May 2008 17:23:37 +0200
Message-ID: <20080518152337.GB3058@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 17:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxkks-0005z3-5u
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 17:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbYERPXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 11:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbYERPXk
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 11:23:40 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:34718 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYERPXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 11:23:39 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyXUdQ==
Received: from tigra.home (Fac65.f.strato-dslnet.de [195.4.172.101])
	by post.webmailer.de (klopstock mo30) (RZmta 16.34)
	with ESMTP id n031c0k4ICUaUG ; Sun, 18 May 2008 17:23:38 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BFF37277BD;
	Sun, 18 May 2008 17:23:37 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A8EBC56D28; Sun, 18 May 2008 17:23:37 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82387>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This is on Cygwin, yes. I have the core.filemode disabled in
~/.gitconfig. How about stopping the test before the failing portion
(only the last two fail, below)?

$ ./t3701-add-interactive.sh -d -v
...
* expecting success:
        git reset --hard &&
        echo content >>file &&
        chmod +x file &&
        printf "n\\ny\\n" | git add -p &&
        git show :file | grep content &&
        git diff file | grep "new mode"

HEAD is now at ddca8ca commit
ddca8caf8c92841fca6311cf3ee839dd304f353d
--
diff --git a/file b/file
index 180b47c..b6f2c08 100644
--- a/file
+++ b/file
@@ -1 +1,2 @@
 baseline
+content
Stage this hunk [y/n/a/d/?]?
* FAIL 9: patch does not affect mode

                git reset --hard &&
                echo content >>file &&
                chmod +x file &&
                printf "n\\ny\\n" | git add -p &&
                git show :file | grep content &&
                git diff file | grep "new mode"


* expecting success:
        git reset --hard &&
        echo content >>file &&
        chmod +x file &&
        printf "y\\nn\\n" | git add -p &&
        git diff --cached file | grep "new mode" &&
        git diff          file | grep "+content"

HEAD is now at ddca8ca commit
ddca8caf8c92841fca6311cf3ee839dd304f353d
--
diff --git a/file b/file
index 180b47c..b6f2c08 100644
--- a/file
+++ b/file
@@ -1 +1,2 @@
 baseline
+content
Stage this hunk [y/n/a/d/?]?
* FAIL 10: stage mode but not hunk

                git reset --hard &&
                echo content >>file &&
                chmod +x file &&
                printf "y\\nn\\n" | git add -p &&
                git diff --cached file | grep "new mode" &&
                git diff          file | grep "+content"


* failed 2 among 10 test(s)
$

 t/t3701-add-interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index f15be93..976ef72 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -66,6 +66,8 @@ test_expect_success 'revert works (commit)' '
 	grep "unchanged *+3/-0 file" output
 '
 
+test "$(git config core.filemode)" = false && test_done
+
 test_expect_success 'patch does not affect mode' '
 	git reset --hard &&
 	echo content >>file &&
-- 
1.5.5.1.354.g902c
