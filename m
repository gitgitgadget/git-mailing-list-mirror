From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] remote.c: hoist branch.*.remote lookup out of
 remote_get_1
Date: Tue, 31 Mar 2015 13:36:13 -0400
Message-ID: <20150331173613.GC18912@peff.net>
References: <20150331173339.GA17732@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 19:36:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd05M-0004Xf-43
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbbCaRgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:36:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:40420 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753949AbbCaRgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:36:15 -0400
Received: (qmail 16796 invoked by uid 102); 31 Mar 2015 17:36:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 12:36:15 -0500
Received: (qmail 25620 invoked by uid 107); 31 Mar 2015 17:36:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:36:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 13:36:13 -0400
Content-Disposition: inline
In-Reply-To: <20150331173339.GA17732@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266536>

We'll want to use this logic as a fallback when looking up
the pushremote, so let's pull it out into its own function.

We don't technically need to make this available outside of
remote.c, but doing so will provide a consistent API with
pushremote_for_branch, which we will add later.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 21 ++++++++++++++-------
 remote.h |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index d5fd605..9555904 100644
--- a/remote.c
+++ b/remote.c
@@ -693,6 +693,18 @@ static int valid_remote_nick(const char *name)
 	return !strchr(name, '/'); /* no slash */
 }
 
+const char *remote_for_branch(struct branch *branch, int *explicit)
+{
+	if (branch && branch->remote_name) {
+		if (explicit)
+			*explicit = 1;
+		return branch->remote_name;
+	}
+	if (explicit)
+		*explicit = 0;
+	return "origin";
+}
+
 static struct remote *remote_get_1(const char *name, const char *pushremote_name)
 {
 	struct remote *ret;
@@ -704,13 +716,8 @@ static struct remote *remote_get_1(const char *name, const char *pushremote_name
 		if (pushremote_name) {
 			name = pushremote_name;
 			name_given = 1;
-		} else {
-			if (current_branch && current_branch->remote_name) {
-				name = current_branch->remote_name;
-				name_given = 1;
-			} else
-				name = "origin";
-		}
+		} else
+			name = remote_for_branch(current_branch, &name_given);
 	}
 
 	ret = make_remote(name, 0);
diff --git a/remote.h b/remote.h
index 4bb6672..2a7e7a6 100644
--- a/remote.h
+++ b/remote.h
@@ -211,6 +211,7 @@ struct branch {
 };
 
 struct branch *branch_get(const char *name);
+const char *remote_for_branch(struct branch *branch, int *explicit);
 
 int branch_has_merge_config(struct branch *branch);
 int branch_merge_matches(struct branch *, int n, const char *);
-- 
2.4.0.rc0.363.gf9f328b
