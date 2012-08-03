From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v1.7.12-rc1
Date: Fri, 3 Aug 2012 12:19:16 -0400
Message-ID: <20120803161916.GA16973@sigill.intra.peff.net>
References: <7v8ve0q4yy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 18:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxKay-0000Xj-E7
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 18:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab2HCQTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 12:19:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50718 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463Ab2HCQTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 12:19:18 -0400
Received: (qmail 26001 invoked by uid 107); 3 Aug 2012 16:19:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 12:19:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 12:19:16 -0400
Content-Disposition: inline
In-Reply-To: <7v8ve0q4yy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202840>

On Mon, Jul 30, 2012 at 03:06:13PM -0700, Junio C Hamano wrote:

>  * git native protocol agents learned to show software version over
>    the wire, so that the server log can be examined to see the vintage
>    distribution of clients.

Hmm. Is this true?

I was just flipping through some old topics of mine, and I noticed that
the final patch of jk/version-string never got applied to the topic
branch. It was posted here:

  http://article.gmane.org/gmane.comp.version-control.git/199059

and you picked up the other patches in the series, but not that one. So
I think it was just a simple mistake.

I've been running with it locally for 2 months and haven't seen any
problem.  Unfortunately it's a bit too non-trivial to be appropriate for
1.7.12 at this point in the cycle, so I guess we will have to let it
cook in the next iteration.

Here's a repost for convenience.

-- >8 --
Subject: [PATCH] include agent identifier in capability string

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
---
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
