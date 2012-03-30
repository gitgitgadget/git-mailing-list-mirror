From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 3/4] git-commit-am: Allow automatic rebasing to preserve empty commits
Date: Fri, 30 Mar 2012 15:48:41 -0400
Message-ID: <1333136922-12872-4-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 21:49:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhos-0005UV-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761349Ab2C3TtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:49:08 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:60973 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761338Ab2C3TtG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:49:06 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SDhoj-00011T-Gu; Fri, 30 Mar 2012 15:49:04 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194395>

Using the keep_empy environment variable, this change allows git-commit-am to
apply empty commits to the new branch we are rebasing to

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Jeff King <peff@peff.net>
CC: Phil Hord <phil.hord@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--am.sh |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index c815a24..c1d1b60 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -20,11 +20,21 @@ esac
 
 test -n "$rebase_root" && root_flag=--root
 
-git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-	--src-prefix=a/ --dst-prefix=b/ \
-	--no-renames $root_flag "$revisions" |
-git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
-move_to_original_branch
+if [ -n "$keep_empty" ]
+then
+	# we have to do this the hard way.  git format-patch completly squashes
+	# empty commits and even if it didn't the format doesn't really lend
+	# itself well to recording empty patches.  fortunately, cherry-pick
+	# makes this easy
+	git cherry-pick --keep-empty "$revisions" && move_to_original_branch
+else
+	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+		--src-prefix=a/ --dst-prefix=b/ \
+		--no-renames $root_flag "$revisions" |
+	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
+	move_to_original_branch
+fi
+
 ret=$?
 test 0 != $ret -a -d "$state_dir" && write_basic_state
 exit $ret
-- 
1.7.7.6
