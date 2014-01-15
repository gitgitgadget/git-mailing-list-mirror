From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] interpret_branch_name: factor out upstream handling
Date: Wed, 15 Jan 2014 03:26:33 -0500
Message-ID: <20140115082632.GA19132@sigill.intra.peff.net>
References: <20140115082528.GA18974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 09:26:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3LoG-0000k9-8I
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 09:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbaAOI0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 03:26:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:60908 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751632AbaAOI0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 03:26:35 -0500
Received: (qmail 8953 invoked by uid 102); 15 Jan 2014 08:26:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 02:26:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 03:26:33 -0500
Content-Disposition: inline
In-Reply-To: <20140115082528.GA18974@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240438>

This function checks a few different @{}-constructs. The
early part checks for and dispatches us to helpers for each
construct, but the code for handling @{upstream} is inline.

Let's factor this out into its own function. This makes
interpret_branch_name more readable, and will make it much
simpler to further refactor the function in future patches.

While we're at it, let's also break apart the refactored
code into a few helper functions. These will be useful if we
eventually implement similar @{upstream}-like constructs.

Signed-off-by: Jeff King <peff@peff.net>
---
This is identical to the cleanup I posted recently for the @{publish}
topic, though I did tweak the commit message a bit to make more sense in
the context of this series.

 sha1_name.c | 83 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index a5578f7..5db742b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1046,6 +1046,54 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
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
@@ -1070,9 +1118,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
 	char *cp;
-	struct branch *upstream;
 	int len = interpret_nth_prior_checkout(name, buf);
-	int tmp_len;
 
 	if (!namelen)
 		namelen = strlen(name);
@@ -1094,36 +1140,11 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
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
