From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] pull: suppress error when no remoteref is found
Date: Fri, 17 Jan 2014 20:00:20 +0000
Message-ID: <509ac5f3245546def79575174c52de2d0416fe24.1389988820.git.john@keeping.me.uk>
References: <20140117192619.GP7608@serenity.lan>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Siddharth Agarwal <sid0@fb.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 21:00:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4Fau-0003Lq-8u
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 21:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbaAQUAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 15:00:40 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:46389 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbaAQUAj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 15:00:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 58859606500;
	Fri, 17 Jan 2014 20:00:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AWjHTB9YJCBd; Fri, 17 Jan 2014 20:00:37 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id BCDAD6064C9;
	Fri, 17 Jan 2014 20:00:29 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.226.g0d60d77
In-Reply-To: <20140117192619.GP7608@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240620>

Commit 48059e4 (pull: use merge-base --fork-point when appropriate,
2013-12-08) incorrectly assumes that get_remote_merge_branch will either
yield a non-empty string or return an error, but there are circumstances
where it will yield an empty string.

The previous code then invoked git-rev-list with no arguments, which
results in an error suppressed by redirecting stderr to /dev/null.  Now
we invoke git-merge-base with an empty branch name, which also results
in an error.  Suppress this in the same way.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index f210d0a..0a5aa2c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -229,7 +229,7 @@ test true = "$rebase" && {
 	test -n "$curr_branch" &&
 	. git-parse-remote &&
 	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
-	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch)
+	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch 2>/dev/null)
 }
 orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
-- 
1.8.5.226.g0d60d77
