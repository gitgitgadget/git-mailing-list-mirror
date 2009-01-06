From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH (topgit) 2/2] tg-patch: fix pagination
Date: Tue,  6 Jan 2009 18:16:39 +0300
Message-ID: <7c756270cdd997037616e1601121347b73b2bc77.1231254832.git.kirr@landau.phys.spbu.ru>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 16:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKDfr-0006PP-E8
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 16:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbZAFPPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 10:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbZAFPP3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 10:15:29 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1371 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbZAFPPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 10:15:25 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id D3F7117B69F; Tue,  6 Jan 2009 18:15:23 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LKDfb-0003wB-HR; Tue, 06 Jan 2009 18:16:39 +0300
X-Mailer: git-send-email 1.6.1.48.ge9b8
In-Reply-To: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104690>

Previously, when I was invoking `tg patch` the following used to happen:

1. .topmsg content was sent directly to _terminal_
2. for each file in the patch, its diff was generated with `git diff`
   and sent to *PAGER*
3. trailing 'tg: ...' was sent to terminal again

So the problem is that while `tg patch >file` works as expected, plain
`tg patch` does not -- in pager there is only a part of the whole patch
(first file diff) and header and trailer are ommitted.

I've finally decided to fix this inconvenience, and the way it works is
like in git -- we just hook `setup_pager` function in commands which
need to be paginated.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 tg-patch.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index a704375..dc699d2 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -24,6 +24,9 @@ done
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
+
+setup_pager
+
 git cat-file blob "$name:.topmsg"
 echo
 [ -n "$(git grep '^[-]--' "$name" -- ".topmsg")" ] || echo '---'
-- 
1.6.1.48.ge9b8
