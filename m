From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v6 3/9] connect: fill the host header in the git protocol with the host and port variables
Date: Tue, 17 May 2016 10:35:48 +0900
Message-ID: <20160517013554.22578-4-mh@glandium.org>
References: <20160517013554.22578-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 03:36:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Tw2-00070z-6W
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 03:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000AbcEQBgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 21:36:23 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35484 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932985AbcEQBgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 21:36:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b2TvO-0005t5-Tf; Tue, 17 May 2016 10:35:54 +0900
X-Mailer: git-send-email 2.8.2.411.ga570dec.dirty
In-Reply-To: <20160517013554.22578-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294832>

The last use of the hostandport variable, besides being strdup'ed before
being split into host and port, is to fill the host header in the git
protocol.

Instead of relying on parse_connect_url() to return a host:port string
that makes sense there, construct one from the host and port variables.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/connect.c b/connect.c
index 0f48cde..0676ee0 100644
--- a/connect.c
+++ b/connect.c
@@ -709,11 +709,24 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 * connect, unless the user has overridden us in
 		 * the environment.
 		 */
-		char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
-		if (target_host)
-			target_host = xstrdup(target_host);
-		else
-			target_host = xstrdup(hostandport);
+		struct strbuf target_host = STRBUF_INIT;
+		char *override_vhost = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
+		if (override_vhost)
+			strbuf_addstr(&target_host, override_vhost);
+		else {
+			/* If the host contains a colon (ipv6 address), it
+			 * needs to be enclosed with square brackets. */
+			const char *colon = strchr(host, ':');
+			if (colon)
+				strbuf_addch(&target_host, '[');
+			strbuf_addstr(&target_host, host);
+			if (colon)
+				strbuf_addch(&target_host, ']');
+			if (port) {
+				strbuf_addch(&target_host, ':');
+				strbuf_addstr(&target_host, port);
+			}
+		}
 
 		transport_check_allowed("git");
 
@@ -734,8 +747,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 		packet_write(fd[1],
 			     "%s %s%chost=%s%c",
 			     prog, path, 0,
-			     target_host, 0);
-		free(target_host);
+			     target_host.buf, 0);
+		strbuf_release(&target_host);
 	} else {
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
-- 
2.8.2.411.ga570dec.dirty
