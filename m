From: Jeff King <peff@peff.net>
Subject: [PATCH 09/12] sha1_name: refactor interpret_upstream_mark
Date: Fri, 1 May 2015 18:55:01 -0400
Message-ID: <20150501225501.GI1534@peff.net>
References: <20150501224414.GA25551@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 00:55:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJps-0004Nd-JQ
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbbEAWzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:55:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:53120 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750823AbbEAWzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:55:03 -0400
Received: (qmail 24097 invoked by uid 102); 1 May 2015 22:55:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 17:55:03 -0500
Received: (qmail 21111 invoked by uid 107); 1 May 2015 22:55:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 18:55:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 18:55:01 -0400
Content-Disposition: inline
In-Reply-To: <20150501224414.GA25551@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268194>

Now that most of the logic for our local get_upstream_branch
has been pushed into the generic branch_get_upstream, we can
fold the remainder into interpret_upstream_mark.

Furthermore, what remains is generic to any branch-related
"@{foo}" we might add in the future, and there's enough
boilerplate that we'd like to reuse it. Let's parameterize
the two operations (parsing the mark and computing its
value) so that we can reuse this for "@{push}" in the near
future.

Signed-off-by: Jeff King <peff@peff.net>
---
More function pointer cleverness. Here it seems more justified to me,
because we may eventually grow the list of interpret_branch_mark()
users (e.g., for the concept discussed previously as @{publish}).

 sha1_name.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 1005f45..506e0c9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1061,35 +1061,36 @@ static void set_shortened_ref(struct strbuf *buf, const char *ref)
 	free(s);
 }
 
-static const char *get_upstream_branch(const char *branch_buf, int len)
-{
-	char *branch = xstrndup(branch_buf, len);
-	struct branch *upstream = branch_get(*branch ? branch : NULL);
-	struct strbuf err = STRBUF_INIT;
-	const char *ret;
-
-	free(branch);
-
-	ret = branch_get_upstream(upstream, &err);
-	if (!ret)
-		die("%s", err.buf);
-
-	return ret;
-}
-
-static int interpret_upstream_mark(const char *name, int namelen,
-				   int at, struct strbuf *buf)
+static int interpret_branch_mark(const char *name, int namelen,
+				 int at, struct strbuf *buf,
+				 int (*get_mark)(const char *, int),
+				 const char *(*get_data)(struct branch *,
+							 struct strbuf *))
 {
 	int len;
+	struct branch *branch;
+	struct strbuf err = STRBUF_INIT;
+	const char *value;
 
-	len = upstream_mark(name + at, namelen - at);
+	len = get_mark(name + at, namelen - at);
 	if (!len)
 		return -1;
 
 	if (memchr(name, ':', at))
 		return -1;
 
-	set_shortened_ref(buf, get_upstream_branch(name, at));
+	if (at) {
+		char *name_str = xmemdupz(name, at);
+		branch = branch_get(name_str);
+		free(name_str);
+	} else
+		branch = branch_get(NULL);
+
+	value = get_data(branch, &err);
+	if (!value)
+		die("%s", err.buf);
+
+	set_shortened_ref(buf, value);
 	return len + at;
 }
 
@@ -1140,7 +1141,8 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 		if (len > 0)
 			return reinterpret(name, namelen, len, buf);
 
-		len = interpret_upstream_mark(name, namelen, at - name, buf);
+		len = interpret_branch_mark(name, namelen, at - name, buf,
+					    upstream_mark, branch_get_upstream);
 		if (len > 0)
 			return len;
 	}
-- 
2.4.0.rc3.477.gc25258d
