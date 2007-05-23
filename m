From: skimo@liacs.nl
Subject: [PATCH 20/22] checkout_submodule: checkout submodule on forced checkout of submodule dir
Date: Thu, 24 May 2007 00:23:09 +0200
Message-ID: <11799589933969-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFp-0003VS-EY
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758704AbXEWWX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757806AbXEWWXt
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:23:49 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33764 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756792AbXEWWXk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:40 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNLHH011615;
	Thu, 24 May 2007 00:23:27 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 868AD7DDB2; Thu, 24 May 2007 00:23:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48196>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 entry.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/entry.c b/entry.c
index f3e0c59..9c093ac 100644
--- a/entry.c
+++ b/entry.c
@@ -82,10 +82,20 @@ static int checkout_submodule(struct cache_entry *ce, const char *path, const st
 	const char *args[10];
 	int argc;
 	int err;
+	struct stat st;
+	char *gitdir;
 
-	if (!state->submodules && !is_checkedout_submodule(ce->name))
+	if (!state->force && !is_checkedout_submodule(ce->name))
 		return 0;
 
+	gitdir = mkpath("%s/.git", ce->name);
+	if (lstat(gitdir, &st)) {
+		if (clone_submodule(ce->name))
+			return -1;
+		if (attach_submodule(ce->name))
+			return -1;
+	}
+
 	argc = 0;
 	args[argc++] = "checkout";
 	if (state->force)
@@ -220,6 +230,13 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 
 	if (!lstat(path, &st)) {
 		unsigned changed = ce_match_stat(ce, &st, 1);
+		/*
+		 *  If submodule has not been checked out, then force
+		 *  forces a check-out.
+		 */
+		if (state->force && S_ISGITLINK(ntohl(ce->ce_mode)) &&
+		    !is_checkedout_submodule(ce->name))
+			changed = 1;
 		if (!changed)
 			return 0;
 		if (!state->force) {
-- 
1.5.2.784.g5532e
