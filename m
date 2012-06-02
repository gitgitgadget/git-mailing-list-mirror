From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] include agent identifier in capability string
Date: Sat, 2 Jun 2012 15:05:03 -0400
Message-ID: <20120602190503.GD14369@sigill.intra.peff.net>
References: <20120602184948.GA14269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 21:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SatdS-00007i-B6
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 21:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965652Ab2FBTFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 15:05:07 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41295
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965616Ab2FBTFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 15:05:06 -0400
Received: (qmail 16688 invoked by uid 107); 2 Jun 2012 19:05:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jun 2012 15:05:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2012 15:05:04 -0400
Content-Disposition: inline
In-Reply-To: <20120602184948.GA14269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199059>

Instead of having the client advertise a particular version
number in the git protocol, we have managed extensions and
backwards compatibility by having clients and servers
advertise capabilities that they support. This is far more
robust than having each side consult a table of
known versions, and provides sufficient information for the
protocol interaction to complete.

However, it does not allow servers to keep statistics on
which client versions are being used. This information is
not necessary to complete the network request (the
capabilities provide enough information for that), but it
may be helpful to conduct a general survey of client
versions in use.

We already send the client version in the user-agent header
for http requests; adding it here allows us to gather
similar statistics for non-http requests.

Signed-off-by: Jeff King <peff@peff.net>
---
Two important changes from the previous round:

  1. We sanitize the agent string to remove non-printable characters and
     whitespace (they are replaced with '.'). This generally shouldn't
     happen, but is a defensive measure against breaking the protocol.

  2. The server half of the connection will advertise their versions in
     the capability strings, too.

 builtin/fetch-pack.c   |  2 ++
 builtin/receive-pack.c |  6 ++++--
 builtin/send-pack.c    |  7 +++++--
 upload-pack.c          |  7 +++++--
 version.c              | 21 +++++++++++++++++++++
 version.h              |  1 +
 6 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 149db88..fe56596 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -10,6 +10,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "transport.h"
+#include "version.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -327,6 +328,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args.include_tag)   strbuf_addstr(&c, " include-tag");
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
+			strbuf_addf(&c, " agent=%s", git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
 			strbuf_release(&c);
 		} else
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0afb8b2..fbfa128 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -12,6 +12,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "connected.h"
+#include "version.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -121,10 +122,11 @@ static void show_ref(const char *path, const unsigned char *sha1)
 	if (sent_capabilities)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	else
-		packet_write(1, "%s %s%c%s%s\n",
+		packet_write(1, "%s %s%c%s%s agent=%s\n",
 			     sha1_to_hex(sha1), path, 0,
 			     " report-status delete-refs side-band-64k quiet",
-			     prefer_ofs_delta ? " ofs-delta" : "");
+			     prefer_ofs_delta ? " ofs-delta" : "",
+			     git_user_agent_sanitized());
 	sent_capabilities = 1;
 }
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index d5d7105..c4d4211 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -8,6 +8,7 @@
 #include "send-pack.h"
 #include "quote.h"
 #include "transport.h"
+#include "version.h"
 
 static const char send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
@@ -306,11 +307,13 @@ int send_pack(struct send_pack_args *args,
 			int quiet = quiet_supported && (args->quiet || !args->progress);
 
 			if (!cmds_sent && (status_report || use_sideband || args->quiet)) {
-				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s",
+				packet_buf_write(&req_buf,
+						 "%s %s %s%c%s%s%s agent=%s",
 						 old_hex, new_hex, ref->name, 0,
 						 status_report ? " report-status" : "",
 						 use_sideband ? " side-band-64k" : "",
-						 quiet ? " quiet" : "");
+						 quiet ? " quiet" : "",
+						 git_user_agent_sanitized());
 			}
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
diff --git a/upload-pack.c b/upload-pack.c
index bb08e2e..2e90ccb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -11,6 +11,7 @@
 #include "list-objects.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "version.h"
 
 static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
 
@@ -734,9 +735,11 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	}
 
 	if (capabilities)
-		packet_write(1, "%s %s%c%s%s\n", sha1_to_hex(sha1), refname_nons,
+		packet_write(1, "%s %s%c%s%s agent=%s\n",
+			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
-			     stateless_rpc ? " no-done" : "");
+			     stateless_rpc ? " no-done" : "",
+			     git_user_agent_sanitized());
 	else
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
 	capabilities = NULL;
diff --git a/version.c b/version.c
index f98d5a6..6106a80 100644
--- a/version.c
+++ b/version.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "version.h"
+#include "strbuf.h"
 
 const char git_version_string[] = GIT_VERSION;
 
@@ -15,3 +16,23 @@ const char *git_user_agent(void)
 
 	return agent;
 }
+
+const char *git_user_agent_sanitized(void)
+{
+	static const char *agent = NULL;
+
+	if (!agent) {
+		struct strbuf buf = STRBUF_INIT;
+		int i;
+
+		strbuf_addstr(&buf, git_user_agent());
+		strbuf_trim(&buf);
+		for (i = 0; i < buf.len; i++) {
+			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
+				buf.buf[i] = '.';
+		}
+		agent = buf.buf;
+	}
+
+	return agent;
+}
diff --git a/version.h b/version.h
index fd9cdd6..6911a4f 100644
--- a/version.h
+++ b/version.h
@@ -4,5 +4,6 @@
 extern const char git_version_string[];
 
 const char *git_user_agent(void);
+const char *git_user_agent_sanitized(void);
 
 #endif /* VERSION_H */
-- 
1.7.7.7.32.g4b73117
