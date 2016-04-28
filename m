From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 3/4] git_connect: allow a file descriptor to be allocated for stderr
Date: Thu, 28 Apr 2016 23:12:38 +0900
Message-ID: <1461852759-28429-4-git-send-email-mh@glandium.org>
References: <1461852759-28429-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 16:13:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmgo-00012r-2j
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 16:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbcD1OMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 10:12:49 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45578 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbcD1OMp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 10:12:45 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1avmgJ-0007PN-Is; Thu, 28 Apr 2016 23:12:39 +0900
X-Mailer: git-send-email 2.8.1.5.g18c8a48
In-Reply-To: <1461852759-28429-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292890>

It can be useful to the caller of git_connect() to get access to stderr,
so add a flag that makes start_command allocate a file descriptor for
it.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 2 ++
 connect.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/connect.c b/connect.c
index 919bf9e..9feedd8 100644
--- a/connect.c
+++ b/connect.c
@@ -764,6 +764,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->env = local_repo_env;
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
+		if (flags & CONNECT_WANT_STDERR)
+			conn->err = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
 			int putty = 0, tortoiseplink = 0;
diff --git a/connect.h b/connect.h
index 01f14cd..fb3331b 100644
--- a/connect.h
+++ b/connect.h
@@ -5,6 +5,7 @@
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
 #define CONNECT_IPV6          (1u << 3)
+#define CONNECT_WANT_STDERR   (1u << 4)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
-- 
2.8.1.5.g18c8a48
