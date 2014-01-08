From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] interpret_branch_name: factor out upstream handling
Date: Wed, 8 Jan 2014 04:34:51 -0500
Message-ID: <20140108093450.GB15720@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 10:34:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0pXO-0006LL-99
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 10:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbaAHJey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 04:34:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:57090 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753919AbaAHJew (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 04:34:52 -0500
Received: (qmail 29605 invoked by uid 102); 8 Jan 2014 09:34:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 03:34:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 04:34:51 -0500
Content-Disposition: inline
In-Reply-To: <20140108093338.GA15659@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240200>

This function checks a few different @{}-constructs. The
early part checks for and dispatches us to helpers for each
construct, but the code for handling @{upstream} is inline.

Let's factor this out into its own function. This makes
interpret_branch_name more readable, and will make it much
simpler to add more constructs in future patches.

While we're at it, let's also break apart the refactored
code into a few helper functions. These will be useful when
we implement similar @{upstream}-like constructs.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 83 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 0c50801..50df5d4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1052,6 +1052,54 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 	return ret - used + len;
 }
 
+static void set_shortened_ref(struct strbuf *buf, const char *ref)
+{
+	char *s = shorten_unambiguous_ref(ref, 0);
+	strbuf_reset(buf);
+	strbuf_addstr(buf, s);
+	free(s);
+}
+
+static const char *get_upstream_branch(const char *branch_buf, int len)
+{
+	char *branch = xstrndup(branch_buf, len);
+	struct branch *upstream = branch_get(*branch ? branch : NULL);
+
+	/*
+	 * Upstream can be NULL only if branch refers to HEAD and HEAD
+	 * points to something different than a branch.
+	 */
+	if (!upstream)
+		die(_("HEAD does not point to a branch"));
+	if (!upstream->merge || !upstream->merge[0]->dst) {
+		if (!ref_exists(upstream->refname))
+			die(_("No such branch: '%s'"), branch);
+		if (!upstream->merge) {
+			die(_("No upstream configured for branch '%s'"),
+				upstream->name);
+		}
+		die(
+			_("Upstream branch '%s' not stored as a remote-tracking branch"),
+			upstream->merge[0]->src);
+	}
+	free(branch);
+
+	return upstream->merge[0]->dst;
+}
+
+static int interpret_upstream_mark(const char *name, int namelen,
+				   int at, struct strbuf *buf)
+{
+	int len;
+
+	len = upstream_mark(name + at, namelen - at);
+	if (!len)
+		return -1;
+
+	set_shortened_ref(buf, get_upstream_branch(name, at));
+	return len + at;
+}
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
@@ -1076,9 +1124,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
 	char *cp;
-	struct branch *upstream;
 	int len = interpret_nth_prior_checkout(name, buf);
-	int tmp_len;
 
 	if (!namelen)
 		namelen = strlen(name);
@@ -1100,36 +1146,11 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	if (len > 0)
 		return reinterpret(name, namelen, len, buf);
 
-	tmp_len = upstream_mark(cp, namelen - (cp - name));
-	if (!tmp_len)
-		return -1;
+	len = interpret_upstream_mark(name, namelen, cp - name, buf);
+	if (len > 0)
+		return len;
 
-	len = cp + tmp_len - name;
-	cp = xstrndup(name, cp - name);
-	upstream = branch_get(*cp ? cp : NULL);
-	/*
-	 * Upstream can be NULL only if cp refers to HEAD and HEAD
-	 * points to something different than a branch.
-	 */
-	if (!upstream)
-		die(_("HEAD does not point to a branch"));
-	if (!upstream->merge || !upstream->merge[0]->dst) {
-		if (!ref_exists(upstream->refname))
-			die(_("No such branch: '%s'"), cp);
-		if (!upstream->merge) {
-			die(_("No upstream configured for branch '%s'"),
-				upstream->name);
-		}
-		die(
-			_("Upstream branch '%s' not stored as a remote-tracking branch"),
-			upstream->merge[0]->src);
-	}
-	free(cp);
-	cp = shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
-	strbuf_reset(buf);
-	strbuf_addstr(buf, cp);
-	free(cp);
-	return len;
+	return -1;
 }
 
 int strbuf_branchname(struct strbuf *sb, const char *name)
-- 
1.8.5.2.500.g8060133
