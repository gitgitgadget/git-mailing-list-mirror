From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2] git-branch: display sha1 on branch deletion
Date: Fri, 12 Dec 2008 17:20:07 -0600
Message-ID: <UfCPFu_boLV0ycLKLmOno8GTqmtC4RSZZ9O6aRLGYjmSZOdKv6ywhCjApnplTHLxUIzO8KJ5Mww@cipher.nrlssc.navy.mil>
References: <AeIdfC6dcUaLaDHDaAdSq8Mxz6QoUdeypSUI24erUEyAHVz4HeTSCw@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sat Dec 13 00:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBHKQ-0004Nq-Gg
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 00:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbYLLXUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 18:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbYLLXUd
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 18:20:33 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50101 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbYLLXUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 18:20:32 -0500
Received: by mail.nrlssc.navy.mil id mBCNKICP002589; Fri, 12 Dec 2008 17:20:18 -0600
In-Reply-To: <AeIdfC6dcUaLaDHDaAdSq8Mxz6QoUdeypSUI24erUEyAHVz4HeTSCw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 12 Dec 2008 23:20:17.0779 (UTC) FILETIME=[31E3EC30:01C95CB0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102968>

Make it easier to recover from a mistaken branch deletion by displaying the
sha1 of the branch's tip commit.

Update t3200.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-branch.c  |    3 ++-
 t/t3200-branch.sh |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 494cbac..02fa38f 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -165,7 +165,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			ret = 1;
 		} else {
 			struct strbuf buf = STRBUF_INIT;
-			printf("Deleted %sbranch %s.\n", remote, argv[i]);
+			printf("Deleted %sbranch %s (%s).\n", remote, argv[i],
+				find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			strbuf_addf(&buf, "branch.%s", argv[i]);
 			if (git_config_rename_section(buf.buf, NULL) < 0)
 				warning("Update of config-file failed");
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 25e9971..61a2010 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -194,7 +194,8 @@ test_expect_success 'test deleting branch deletes branch config' \
 
 test_expect_success 'test deleting branch without config' \
     'git branch my7 s &&
-     test "$(git branch -d my7 2>&1)" = "Deleted branch my7."'
+     sha1=$(git rev-parse my7 | cut -c 1-7) &&
+     test "$(git branch -d my7 2>&1)" = "Deleted branch my7 ($sha1)."'
 
 test_expect_success 'test --track without .fetch entries' \
     'git branch --track my8 &&
-- 
1.6.0.4.794.g35fad
