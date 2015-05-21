From: Jeff King <peff@peff.net>
Subject: [PATCH v3 04/14] remote.c: hoist branch.*.remote lookup out of
 remote_get_1
Date: Thu, 21 May 2015 00:45:16 -0400
Message-ID: <20150521044516.GD23409@peff.net>
References: <20150521044429.GA5857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:45:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIMG-0008Mn-92
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbbEUEpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:45:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:33677 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753181AbbEUEpS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:45:18 -0400
Received: (qmail 2284 invoked by uid 102); 21 May 2015 04:45:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:45:18 -0500
Received: (qmail 31160 invoked by uid 107); 21 May 2015 04:45:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:45:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:45:16 -0400
Content-Disposition: inline
In-Reply-To: <20150521044429.GA5857@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269545>

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
index c298a43..0d2976b 100644
--- a/remote.c
+++ b/remote.c
@@ -692,6 +692,18 @@ static int valid_remote_nick(const char *name)
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
@@ -703,13 +715,8 @@ static struct remote *remote_get_1(const char *name, const char *pushremote_name
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
2.4.1.528.g00591e3
