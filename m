From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/3] server_supports(): parse feature list more carefully
Date: Sun,  8 Jan 2012 22:06:19 +0100
Message-ID: <1326056781-17456-2-git-send-email-drizzd@aon.at>
References: <1326056781-17456-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:15:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk055-0007Mg-4R
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab2AHVOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 16:14:47 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:46072 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754492Ab2AHVOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 16:14:40 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id C0435130052;
	Sun,  8 Jan 2012 22:14:38 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1326056781-17456-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188137>

From: Junio C Hamano <gitster@pobox.com>

We have been carefully choosing feature names used in the protocol
extensions so that the vocabulary does not contain a word that is a
substring of another word, so it is not a real problem, but we have
recently added "quiet" feature word, which would mean we cannot later
add some other word with "quiet" (e.g. "quiet-push"), which is awkward.

Let's make sure that we can eventually be able to do so by teaching the
clients and servers that feature words consist of non whitespace
letters. This parser also allows us to later add features with parameters
e.g. "feature=1.5" (parameter values need to be quoted for whitespaces,
but we will worry about the detauls when we do introduce them).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/receive-pack.c |    5 +++--
 cache.h                |    1 +
 connect.c              |   23 +++++++++++++++++++++--
 upload-pack.c          |   22 +++++++++++++---------
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d2dcb7e..d8ddcaa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -731,9 +731,10 @@ static struct command *read_head_info(void)
 		refname = line + 82;
 		reflen = strlen(refname);
 		if (reflen + 82 < len) {
-			if (strstr(refname + reflen + 1, "report-status"))
+			const char *feature_list = refname + reflen + 1;
+			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
-			if (strstr(refname + reflen + 1, "side-band-64k"))
+			if (parse_feature_request(feature_list, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 		}
 		cmd = xcalloc(1, sizeof(struct command) + len - 80);
diff --git a/cache.h b/cache.h
index 10afd71..9bd8c2d 100644
--- a/cache.h
+++ b/cache.h
@@ -1037,6 +1037,7 @@ struct extra_have_objects {
 };
 extern struct ref **get_remote_heads(int in, struct ref **list, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
+extern const char *parse_feature_request(const char *features, const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
diff --git a/connect.c b/connect.c
index 2ea5c3c..912cdde 100644
--- a/connect.c
+++ b/connect.c
@@ -101,8 +101,27 @@ struct ref **get_remote_heads(int in, struct ref **list,
 
 int server_supports(const char *feature)
 {
-	return server_capabilities &&
-		strstr(server_capabilities, feature) != NULL;
+	return !!parse_feature_request(server_capabilities, feature);
+}
+
+const char *parse_feature_request(const char *feature_list, const char *feature)
+{
+	int len;
+
+	if (!feature_list)
+		return NULL;
+
+	len = strlen(feature);
+	while (*feature_list) {
+		const char *found = strstr(feature_list, feature);
+		if (!found)
+			return NULL;
+		if ((feature_list == found || isspace(found[-1])) &&
+		    (!found[len] || isspace(found[len]) || found[len] == '='))
+			return found;
+		feature_list = found + 1;
+	}
+	return NULL;
 }
 
 enum protocol {
diff --git a/upload-pack.c b/upload-pack.c
index 6f36f62..0d11e21 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -585,6 +585,7 @@ static void receive_needs(void)
 		write_str_in_full(debug_fd, "#S\n");
 	for (;;) {
 		struct object *o;
+		const char *features;
 		unsigned char sha1_buf[20];
 		len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
@@ -616,23 +617,26 @@ static void receive_needs(void)
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
-		if (strstr(line+45, "multi_ack_detailed"))
+
+		features = line + 45;
+
+		if (parse_feature_request(features, "multi_ack_detailed"))
 			multi_ack = 2;
-		else if (strstr(line+45, "multi_ack"))
+		else if (parse_feature_request(features, "multi_ack"))
 			multi_ack = 1;
-		if (strstr(line+45, "no-done"))
+		if (parse_feature_request(features, "no-done"))
 			no_done = 1;
-		if (strstr(line+45, "thin-pack"))
+		if (parse_feature_request(features, "thin-pack"))
 			use_thin_pack = 1;
-		if (strstr(line+45, "ofs-delta"))
+		if (parse_feature_request(features, "ofs-delta"))
 			use_ofs_delta = 1;
-		if (strstr(line+45, "side-band-64k"))
+		if (parse_feature_request(features, "side-band-64k"))
 			use_sideband = LARGE_PACKET_MAX;
-		else if (strstr(line+45, "side-band"))
+		else if (parse_feature_request(features, "side-band"))
 			use_sideband = DEFAULT_PACKET_MAX;
-		if (strstr(line+45, "no-progress"))
+		if (parse_feature_request(features, "no-progress"))
 			no_progress = 1;
-		if (strstr(line+45, "include-tag"))
+		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
 
 		o = lookup_object(sha1_buf);
-- 
1.7.8
