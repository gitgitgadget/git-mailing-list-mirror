From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v8 3/9] connect: re-derive a host:port string from the separate host and port variables
Date: Fri, 27 May 2016 11:27:50 +0900
Message-ID: <20160527022756.22904-4-mh@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
Cc: git@vger.kernel.org, tboegi@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 04:28:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67Vl-0005KM-3L
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbcE0C2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:28:22 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40424 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932235AbcE0C2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:28:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b67VE-0005yL-N7; Fri, 27 May 2016 11:27:56 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160527022756.22904-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295716>

The last uses of the hostandport variable, besides being strdup'ed
before being split into host and port, is to fill the host header in the
git protocol and to test whether to proxy the request.

Instead of relying on parse_connect_url() to return a host:port string
that makes sense there, re-derive one from the host and port variables.
This will allow to refactor parse_connect_url() to return separate host
and port strings.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index d5af65f..3d7bd8e 100644
--- a/connect.c
+++ b/connect.c
@@ -695,18 +695,32 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 * connect, unless the user has overridden us in
 		 * the environment.
 		 */
-		char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
-		if (target_host)
-			target_host = xstrdup(target_host);
-		else
-			target_host = xstrdup(hostandport);
+		struct strbuf target_host = STRBUF_INIT;
+		struct strbuf virtual_host = STRBUF_INIT;
+		const char *colon = strchr(host, ':');
+		char *override_vhost = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
+
+		/* If the host contains a colon (ipv6 address), it needs to
+		 * be enclosed with square brackets. */
+		if (colon)
+			strbuf_addch(&target_host, '[');
+		strbuf_addstr(&target_host, host);
+		if (colon)
+			strbuf_addch(&target_host, ']');
+		if (port) {
+			strbuf_addch(&target_host, ':');
+			strbuf_addstr(&target_host, port);
+		}
+
+		strbuf_addstr(&virtual_host, override_vhost ? override_vhost
+							    : target_host.buf);
 
 		transport_check_allowed("git");
 
 		/* These underlying connection commands die() if they
 		 * cannot connect.
 		 */
-		if (git_use_proxy(hostandport))
+		if (git_use_proxy(target_host.buf))
 			conn = git_proxy_connect(fd, host, port);
 		else
 			git_tcp_connect(fd, host, port, flags);
@@ -720,8 +734,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		packet_write(fd[1],
 			     "%s %s%chost=%s%c",
 			     prog, path, 0,
-			     target_host, 0);
-		free(target_host);
+			     virtual_host.buf, 0);
+		strbuf_release(&virtual_host);
+		strbuf_release(&target_host);
 	} else {
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
-- 
2.8.3
