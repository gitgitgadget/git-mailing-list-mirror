From: Mike Hommey <mh@glandium.org>
Subject: [RFC PATCH 2/3] connect: group CONNECT_DIAG_URL handling code
Date: Fri, 29 Apr 2016 09:43:44 +0900
Message-ID: <1461890625-23222-2-git-send-email-mh@glandium.org>
References: <20160428232936.GA8663@glandium.org>
 <1461890625-23222-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 02:44:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avwXL-0000Q1-ER
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 02:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbcD2Anx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 20:43:53 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41650 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872AbcD2Anv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 20:43:51 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1avwX3-00063I-SO; Fri, 29 Apr 2016 09:43:45 +0900
X-Mailer: git-send-email 2.8.1.8.gc23d642.dirty
In-Reply-To: <1461890625-23222-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292962>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

Note this makes http://marc.info/?l=git&m=146183714532394 irrelevant.


diff --git a/connect.c b/connect.c
index 29569b3..ce216cb 100644
--- a/connect.c
+++ b/connect.c
@@ -676,10 +676,20 @@ struct child_process *git_connect(int fd[2], const char *url,
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &hostandport, &path);
-	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
+	if (flags & CONNECT_DIAG_URL) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
-		printf("Diag: hostandport=%s\n", hostandport ? hostandport : "NULL");
+		if (protocol == PROTO_SSH) {
+			char *ssh_host = hostandport;
+			const char *port = NULL;
+			get_host_and_port(&ssh_host, &port);
+			if (!port)
+				port = get_port(ssh_host);
+			printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
+			printf("Diag: port=%s\n", port ? port : "NONE");
+		} else {
+			printf("Diag: hostandport=%s\n", hostandport ? hostandport : "NULL");
+		}
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
@@ -738,19 +748,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 			if (!port)
 				port = get_port(ssh_host);
 
-			if (flags & CONNECT_DIAG_URL) {
-				printf("Diag: url=%s\n", url ? url : "NULL");
-				printf("Diag: protocol=%s\n", prot_name(protocol));
-				printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
-				printf("Diag: port=%s\n", port ? port : "NONE");
-				printf("Diag: path=%s\n", path ? path : "NULL");
-
-				free(hostandport);
-				free(path);
-				free(conn);
-				return NULL;
-			}
-
 			ssh = getenv("GIT_SSH_COMMAND");
 			if (!ssh) {
 				const char *base;
-- 
2.8.1.8.gc23d642.dirty
