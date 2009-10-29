From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 05/26] Move "get_ack()" back to fetch-pack
Date: Wed, 28 Oct 2009 17:00:27 -0700
Message-ID: <1256774448-7625-6-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3IRp-0000RN-KY
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbZJ2AAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585AbZJ2AAt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:00:49 -0400
Received: from george.spearce.org ([209.20.77.23]:36224 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbZJ2AAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:47 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1C64B38239; Thu, 29 Oct 2009 00:00:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 20B593821F
	for <git@vger.kernel.org>; Thu, 29 Oct 2009 00:00:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131513>

In 41cb7488 Linus moved this function to connect.c for reuse inside
of the git-clone-pack command.  That was 2005, but in 2006 Junio
retired git-clone-pack in commit efc7fa53.  Since then the only
caller has been fetch-pack.  Since this ACK/NAK exchange is only
used by the fetch-pack/upload-pack protocol we should keep move
it back to a private detail of fetch-pack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch-pack.c |   21 +++++++++++++++++++++
 cache.h              |    1 -
 connect.c            |   21 ---------------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 783c2b0..7c09d46 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -157,6 +157,27 @@ static const unsigned char *get_rev(void)
 	return commit->object.sha1;
 }
 
+static int get_ack(int fd, unsigned char *result_sha1)
+{
+	static char line[1000];
+	int len = packet_read_line(fd, line, sizeof(line));
+
+	if (!len)
+		die("git fetch-pack: expected ACK/NAK, got EOF");
+	if (line[len-1] == '\n')
+		line[--len] = 0;
+	if (!strcmp(line, "NAK"))
+		return 0;
+	if (!prefixcmp(line, "ACK ")) {
+		if (!get_sha1_hex(line+4, result_sha1)) {
+			if (strstr(line+45, "continue"))
+				return 2;
+			return 1;
+		}
+	}
+	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
+}
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
diff --git a/cache.h b/cache.h
index a5eeead..4e283be 100644
--- a/cache.h
+++ b/cache.h
@@ -856,7 +856,6 @@ extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int path_match(const char *path, int nr, char **match);
-extern int get_ack(int fd, unsigned char *result_sha1);
 struct extra_have_objects {
 	int nr, alloc;
 	unsigned char (*array)[20];
diff --git a/connect.c b/connect.c
index 7945e38..839a103 100644
--- a/connect.c
+++ b/connect.c
@@ -107,27 +107,6 @@ int server_supports(const char *feature)
 		strstr(server_capabilities, feature) != NULL;
 }
 
-int get_ack(int fd, unsigned char *result_sha1)
-{
-	static char line[1000];
-	int len = packet_read_line(fd, line, sizeof(line));
-
-	if (!len)
-		die("git fetch-pack: expected ACK/NAK, got EOF");
-	if (line[len-1] == '\n')
-		line[--len] = 0;
-	if (!strcmp(line, "NAK"))
-		return 0;
-	if (!prefixcmp(line, "ACK ")) {
-		if (!get_sha1_hex(line+4, result_sha1)) {
-			if (strstr(line+45, "continue"))
-				return 2;
-			return 1;
-		}
-	}
-	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
-}
-
 int path_match(const char *path, int nr, char **match)
 {
 	int i;
-- 
1.6.5.2.181.gd6f41
