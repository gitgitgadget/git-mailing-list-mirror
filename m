From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 4/4] git_connect: add a flag to consider the path part of ssh urls relative
Date: Thu, 28 Apr 2016 23:12:39 +0900
Message-ID: <1461852759-28429-5-git-send-email-mh@glandium.org>
References: <1461852759-28429-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 16:13:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmgc-00012r-AS
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 16:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbcD1OMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 10:12:45 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45594 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310AbcD1OMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 10:12:44 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1avmgJ-0007PP-Kn; Thu, 28 Apr 2016 23:12:39 +0900
X-Mailer: git-send-email 2.8.1.5.g18c8a48
In-Reply-To: <1461852759-28429-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292887>

In Mercurial ssh urls, the path part of the url is relative to the home
directory of the account being logged to instead of being absolute.

Add a flag allowing git_connect() to handle this kind of usecase.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 10 +++++++---
 connect.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 9feedd8..0df6297 100644
--- a/connect.c
+++ b/connect.c
@@ -592,7 +592,7 @@ static char *get_port(char *host)
  * The caller must free() the returned strings.
  */
 static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
-				       char **ret_path)
+				       char **ret_path, int relative_ssh)
 {
 	char *url;
 	char *host, *path;
@@ -642,7 +642,10 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	end = path; /* Need to \0 terminate host here */
 	if (separator == ':')
 		path++; /* path starts after ':' */
-	if (protocol == PROTO_GIT || protocol == PROTO_SSH) {
+	if (protocol == PROTO_SSH && relative_ssh) {
+		if (path[0] == separator)
+			path++;
+	} else if (protocol == PROTO_GIT || protocol == PROTO_SSH) {
 		if (path[1] == '~')
 			path++;
 	}
@@ -712,7 +715,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
-	protocol = parse_connect_url(url, &hostandport, &path);
+	protocol = parse_connect_url(url, &hostandport, &path,
+	                             flags & CONNECT_RELATIVE_SSH);
 	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
diff --git a/connect.h b/connect.h
index fb3331b..1377028 100644
--- a/connect.h
+++ b/connect.h
@@ -6,6 +6,7 @@
 #define CONNECT_IPV4          (1u << 2)
 #define CONNECT_IPV6          (1u << 3)
 #define CONNECT_WANT_STDERR   (1u << 4)
+#define CONNECT_RELATIVE_SSH  (1u << 5)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
-- 
2.8.1.5.g18c8a48
