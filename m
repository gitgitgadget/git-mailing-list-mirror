From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v6 2/9] connect: only match the host with core.gitProxy
Date: Tue, 17 May 2016 10:35:47 +0900
Message-ID: <20160517013554.22578-3-mh@glandium.org>
References: <20160517013554.22578-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 03:36:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Tvm-0006uf-0m
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 03:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932995AbcEQBgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 21:36:06 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35500 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932981AbcEQBgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 21:36:03 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b2TvO-0005t3-S7; Tue, 17 May 2016 10:35:54 +0900
X-Mailer: git-send-email 2.8.2.411.ga570dec.dirty
In-Reply-To: <20160517013554.22578-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294826>

Currently, core.gitProxy doesn't actually match purely on domain names
as documented: it also matches ports.

So a core.gitProxy value like "script for kernel.org" doesn't make the
script called for an url like git://kernel.org:port/path, while it is
called for git://kernel.org/path.

This per-port behavior seems like an oversight rather than a deliberate
choice, so, make git://kernel.org:port/path call the gitProxy script in
the case described above.

However, if people have been relying on this behavior, git now fails
with an error message inviting for a configuration change.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c              | 20 +++++++++++++++++---
 t/t5532-fetch-proxy.sh |  8 +++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index d3448c2..0f48cde 100644
--- a/connect.c
+++ b/connect.c
@@ -490,6 +490,8 @@ static void git_tcp_connect(int fd[2], const char *host, const char *port,
 }
 
 
+static char *get_port(char *host);
+
 static char *git_proxy_command;
 
 static int git_proxy_command_options(const char *var, const char *value,
@@ -517,10 +519,14 @@ static int git_proxy_command_options(const char *var, const char *value,
 			/* matches everybody */
 			matchlen = strlen(value);
 		else {
-			hostlen = strlen(for_pos + 5);
+			struct strbuf host = STRBUF_INIT;
+			char *port;
+			strbuf_addstr(&host, for_pos + 5);
+			port = get_port(host.buf);
+			hostlen = strlen(host.buf);
 			if (rhost_len < hostlen)
 				matchlen = -1;
-			else if (!strncmp(for_pos + 5,
+			else if (!strncmp(host.buf,
 					  rhost_name + rhost_len - hostlen,
 					  hostlen) &&
 				 ((rhost_len == hostlen) ||
@@ -528,6 +534,14 @@ static int git_proxy_command_options(const char *var, const char *value,
 				matchlen = for_pos - value;
 			else
 				matchlen = -1;
+			if (matchlen > 0 && port)
+				die("core.gitProxy only supports \"for "
+				    "host/domain\", not \"for host:port\".\n"
+				    "Please change your configuration "
+				    "accordingly.\nPlease note that the port "
+				    "is given as second argument to the proxy "
+				    "script.\n");
+			strbuf_release(&host);
 		}
 		if (0 <= matchlen) {
 			/* core.gitproxy = none for kernel.org */
@@ -706,7 +720,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		/* These underlying connection commands die() if they
 		 * cannot connect.
 		 */
-		if (git_use_proxy(hostandport))
+		if (git_use_proxy(host))
 			conn = git_proxy_connect(fd, host, port);
 		else
 			git_tcp_connect(fd, host, port, flags);
diff --git a/t/t5532-fetch-proxy.sh b/t/t5532-fetch-proxy.sh
index 51c9669..efa80f8 100755
--- a/t/t5532-fetch-proxy.sh
+++ b/t/t5532-fetch-proxy.sh
@@ -33,7 +33,9 @@ test_expect_success 'setup proxy script' '
 
 test_expect_success 'setup local repo' '
 	git remote add fake git://example.com/remote &&
-	git config core.gitproxy ./proxy
+	git remote add fake_b git://example.org/remote &&
+	git config core.gitproxy "./proxy for example.com" &&
+	git config --add core.gitproxy "./proxy for example.org:9418"
 '
 
 test_expect_success 'fetch through proxy works' '
@@ -43,4 +45,8 @@ test_expect_success 'fetch through proxy works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'core.gitProxy with port fails' '
+	test_must_fail git fetch fake_b
+'
+
 test_done
-- 
2.8.2.411.ga570dec.dirty
