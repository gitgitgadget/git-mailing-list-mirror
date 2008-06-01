From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Make "git-remote prune" delete refs according to fetch specs
Date: Sat, 31 May 2008 23:58:05 -0400
Message-ID: <20080601035805.GB32176@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 05:59:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2eit-0004ep-OP
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 05:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbYFAD6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 23:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755029AbYFAD6V
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 23:58:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41602 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbYFAD6I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 23:58:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K2ehe-00051z-SS; Sat, 31 May 2008 23:57:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9EDA320FBAE; Sat, 31 May 2008 23:58:05 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83426>

A remote may be configured to fetch into tracking branches that
do not match the remote name.  For example a user may have created
extra remotes that will fetch to the same tracking branch namespace,
but from different URLs:

  [remote "origin"]
	url = git://git.kernel.org/pub/scm/git/git.git
    fetch = refs/heads/*:refs/remotes/origin/*

  [remote "alt"]
	url = git://repo.or.cz/alt-git.git
    fetch = refs/heads/*:refs/remotes/origin/*

When running `git remote prune alt` we expect stale branches to
be removed from "refs/remotes/origin/*" and not from the unused
namespace of "refs/remotes/alt/*".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-remote.c  |   21 ++-------------------
 t/t5505-remote.sh |   18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index c76fe2e..e5cfc88 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -419,27 +419,10 @@ static int show_or_prune(int argc, const char **argv, int prune)
 					states.remote->name);
 
 		if (prune) {
-			struct strbuf buf;
-			int prefix_len;
-
-			strbuf_init(&buf, 0);
-			if (states.remote->fetch_refspec_nr == 1 &&
-					states.remote->fetch->pattern &&
-					!strcmp(states.remote->fetch->src,
-						states.remote->fetch->dst))
-				/* handle --mirror remote */
-				strbuf_addstr(&buf, "refs/heads/");
-			else
-				strbuf_addf(&buf, "refs/remotes/%s/", *argv);
-			prefix_len = buf.len;
-
 			for (i = 0; i < states.stale.nr; i++) {
-				strbuf_setlen(&buf, prefix_len);
-				strbuf_addstr(&buf, states.stale.items[i].path);
-				result |= delete_ref(buf.buf, NULL);
+				const char *refname = states.stale.items[i].util;
+				result |= delete_ref(refname, NULL);
 			}
-
-			strbuf_release(&buf);
 			goto cleanup_states;
 		}
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a37b6f5..0d7ed1f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -164,6 +164,24 @@ test_expect_success 'add --mirror && prune' '
 	 git rev-parse --verify refs/heads/side)
 '
 
+test_expect_success 'add alt && prune' '
+	(mkdir alttst &&
+	 cd alttst &&
+	 git init &&
+	 git remote add -f origin ../one &&
+	 git config remote.alt.url ../one &&
+	 git config remote.alt.fetch "+refs/heads/*:refs/remotes/origin/*") &&
+	(cd one &&
+	 git branch -m side side2) &&
+	(cd alttst &&
+	 git rev-parse --verify refs/remotes/origin/side &&
+	 ! git rev-parse --verify refs/remotes/origin/side2 &&
+	 git fetch alt &&
+	 git remote prune alt &&
+	 ! git rev-parse --verify refs/remotes/origin/side &&
+	 git rev-parse --verify refs/remotes/origin/side2)
+'
+
 cat > one/expect << EOF
   apis/master
   apis/side
-- 
1.5.6.rc0.158.g7c7a1
