From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Improve output of %p and %P format in git-rev-list --pretty=format:
Date: Wed, 28 Mar 2007 22:11:23 +0200
Message-ID: <20070328201123.GB2588@steel.home>
References: <20070328000828.GA13273@coredump.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:11:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWeUU-0006Cr-Kn
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 22:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965743AbXC1UL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 16:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965744AbXC1UL1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 16:11:27 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:25633 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965743AbXC1UL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 16:11:26 -0400
Received: from tigra.home (Fcb18.f.strato-dslnet.de [195.4.203.24])
	by post.webmailer.de (fruni mo18) (RZmta 5.4)
	with ESMTP id F0533dj2SJvV3y ; Wed, 28 Mar 2007 22:11:25 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E0BB3277B6;
	Wed, 28 Mar 2007 22:11:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 26B94D24E; Wed, 28 Mar 2007 22:11:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070328000828.GA13273@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg7nw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43383>

Remove the terminating space from the space-separated list of parents.
Also fix the test t6006: it wrongly assumed that the initial commit
has a parent and was not executable.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

The test even hardcoded parents of the initial commit to the
initial commit itself, which does not make any sense at all.

 commit.c                   |    5 +++--
 t/t6006-rev-list-format.sh |    8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index a92958c..94b3713 100644
--- a/commit.c
+++ b/commit.c
@@ -852,13 +852,14 @@ static long format_commit_message(const struct commit *commit,
 	for (i = 0, p = commit->parents;
 			p && i < sizeof(parents) - 1;
 			p = p->next)
-		i += snprintf(parents + i, sizeof(parents) - i - 1, "%s ",
+		i += snprintf(parents + i, sizeof(parents) - i - 1, " %s" + !i,
 			sha1_to_hex(p->item->object.sha1));
 	interp_set_entry(table, IPARENTS, parents);
+	*parents = '\0';
 	for (i = 0, p = commit->parents;
 			p && i < sizeof(parents) - 1;
 			p = p->next)
-		i += snprintf(parents + i, sizeof(parents) - i - 1, "%s ",
+		i += snprintf(parents + i, sizeof(parents) - i - 1, " %s" + !i,
 			find_unique_abbrev(p->item->object.sha1,
 				DEFAULT_ABBREV));
 	interp_set_entry(table, IPARENTS_ABBREV, parents);
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index cf096c3..ce9c7dc 100644
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -39,11 +39,11 @@ EOF
 
 test_format parents %P%n%p <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
-86c75cfd708a0e5868dc876ed5b8bb66c80b4873 
-86c75cf 
+86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+86c75cf
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cf 
-86c75cf 
+
+
 EOF
 
 # we don't test relative here
-- 
1.5.1.rc2.18.g157b4
