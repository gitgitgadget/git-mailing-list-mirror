From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v7 3/9] connect: re-derive a host:port string from the separate host and port variables
Date: Sun, 22 May 2016 08:17:26 +0900
Message-ID: <20160521231732.4888-4-mh@glandium.org>
References: <20160521231732.4888-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 01:17:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4G9a-0005cL-41
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 01:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbcEUXRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 19:17:51 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55506 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbcEUXRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 19:17:39 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b4G9E-0001Hl-U8; Sun, 22 May 2016 08:17:32 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160521231732.4888-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295245>

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
index 0cdbeb2..7cdaed1 100644
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
2.8.3.401.ga81c606.dirty
