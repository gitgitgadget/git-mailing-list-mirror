From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] connect: learn to parse capabilities with values
Date: Fri, 10 Aug 2012 03:58:16 -0400
Message-ID: <20120810075816.GC8399@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:58:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szk73-00057U-5C
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 09:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532Ab2HJH6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 03:58:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60075 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052Ab2HJH6X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 03:58:23 -0400
Received: (qmail 27222 invoked by uid 107); 10 Aug 2012 07:58:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 03:58:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 03:58:16 -0400
Content-Disposition: inline
In-Reply-To: <20120810075342.GA30072@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203209>

We already take care to parse a capability like "foo=bar"
properly, but the code does not provide a good way of
actually finding out what is on the right-hand side of the
"=".

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h   |  2 ++
 connect.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/cache.h b/cache.h
index 06413e1..3811c66 100644
--- a/cache.h
+++ b/cache.h
@@ -1030,7 +1030,9 @@ struct extra_have_objects {
 };
 extern struct ref **get_remote_heads(int in, struct ref **list, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
+extern char *server_feature_value(const char *feature);
 extern const char *parse_feature_request(const char *features, const char *feature);
+extern char *parse_feature_request_value(const char *features, const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
diff --git a/connect.c b/connect.c
index 912cdde..6bd2531 100644
--- a/connect.c
+++ b/connect.c
@@ -104,6 +104,11 @@ int server_supports(const char *feature)
 	return !!parse_feature_request(server_capabilities, feature);
 }
 
+char *server_feature_value(const char *feature)
+{
+	return parse_feature_request_value(server_capabilities, feature);
+}
+
 const char *parse_feature_request(const char *feature_list, const char *feature)
 {
 	int len;
@@ -124,6 +129,33 @@ const char *parse_feature_request(const char *feature_list, const char *feature)
 	return NULL;
 }
 
+/*
+ * Parse features of the form "feature=value".  Returns NULL if the feature
+ * does not exist, the empty string if it exists but does not have an "=", or
+ * the content to the right of the "=" until the first space (or end of
+ * string).  The cannot contain literal spaces; double-quoting or similar
+ * schemes would break compatibility, since older versions of git treat the
+ * space as a hard-delimiter without any context.
+ *
+ * The return value (if non-NULL) is newly allocated on the heap and belongs to
+ * the caller.
+ */
+char *parse_feature_request_value(const char *feature_list, const char *feature)
+{
+	const char *start = parse_feature_request(feature_list, feature);
+	const char *end;
+
+	if (!start || prefixcmp(start, feature))
+		return NULL;
+	start += strlen(feature);
+
+	if (*start == '=')
+		start++;
+	end = strchrnul(start, ' ');
+
+	return xmemdupz(start, end - start);
+}
+
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
-- 
1.7.12.rc2.4.g7f05cf9
