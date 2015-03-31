From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] remote.c: drop "remote" pointer from "struct branch"
Date: Tue, 31 Mar 2015 13:35:55 -0400
Message-ID: <20150331173555.GB18912@peff.net>
References: <20150331173339.GA17732@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 19:36:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd054-0004IY-8N
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbbCaRf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:35:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:40413 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751562AbbCaRf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:35:57 -0400
Received: (qmail 16750 invoked by uid 102); 31 Mar 2015 17:35:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 12:35:57 -0500
Received: (qmail 25555 invoked by uid 107); 31 Mar 2015 17:36:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:36:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 13:35:55 -0400
Content-Disposition: inline
In-Reply-To: <20150331173339.GA17732@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266534>

When we create each branch struct, we fill in the
"remote_name" field from the config, and then fill in the
actual "remote" field based on that name. However, it turns
out that nobody really cares about this field. The only two
sites that access it are:

  1. git-merge, which uses it to notice when the branch does
     not have a remote defined. But we can easily replace this
     with looking at remote_name instead.

  2. remote.c itself, when setting up the @{upstream} merge
     config. But we don't need to save the "remote" for
     that; we can just look it up for the duration of the
     operation.

Getting rid of it drops one potential source of confusion:
is the value the match for "remote_name", or is it the
remote we would fetch from when on that branch (i.e., does
it fall back to "origin")?

When we add pushremote_name, this question would get even
more confusing, as pushremotes have a more complicated
lookup procedure. It would be nice for the code to be
consistent between the remote and pushremote, and this takes
us one step closer.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c |  2 +-
 remote.c        | 14 ++++++++------
 remote.h        |  1 -
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3b0f8f9..1840317 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -955,7 +955,7 @@ static int setup_with_upstream(const char ***argv)
 
 	if (!branch)
 		die(_("No current branch."));
-	if (!branch->remote)
+	if (!branch->remote_name)
 		die(_("No remote for the current branch."));
 	if (!branch->merge_nr)
 		die(_("No default upstream defined for the current branch."));
diff --git a/remote.c b/remote.c
index fcd868d..d5fd605 100644
--- a/remote.c
+++ b/remote.c
@@ -1633,15 +1633,20 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 
 static void set_merge(struct branch *ret)
 {
+	struct remote *remote;
 	char *ref;
 	unsigned char sha1[20];
 	int i;
 
+	if (!ret->remote_name || !ret->merge_nr)
+		return;
+	remote = remote_get(ret->remote_name);
+
 	ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));
 	for (i = 0; i < ret->merge_nr; i++) {
 		ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
 		ret->merge[i]->src = xstrdup(ret->merge_name[i]);
-		if (!remote_find_tracking(ret->remote, ret->merge[i]) ||
+		if (!remote_find_tracking(remote, ret->merge[i]) ||
 		    strcmp(ret->remote_name, "."))
 			continue;
 		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
@@ -1661,11 +1666,8 @@ struct branch *branch_get(const char *name)
 		ret = current_branch;
 	else
 		ret = make_branch(name, 0);
-	if (ret && ret->remote_name) {
-		ret->remote = remote_get(ret->remote_name);
-		if (ret->merge_nr)
-			set_merge(ret);
-	}
+	if (ret)
+	       set_merge(ret);
 	return ret;
 }
 
diff --git a/remote.h b/remote.h
index 02d66ce..4bb6672 100644
--- a/remote.h
+++ b/remote.h
@@ -203,7 +203,6 @@ struct branch {
 	const char *refname;
 
 	const char *remote_name;
-	struct remote *remote;
 
 	const char **merge_name;
 	struct refspec **merge;
-- 
2.4.0.rc0.363.gf9f328b
