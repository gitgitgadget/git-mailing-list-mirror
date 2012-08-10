From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] do not send client agent unless server does first
Date: Fri, 10 Aug 2012 03:57:43 -0400
Message-ID: <20120810075743.GB8399@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:58:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szk6W-0004HF-Eq
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 09:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab2HJH5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 03:57:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60071 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756532Ab2HJH5v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 03:57:51 -0400
Received: (qmail 27192 invoked by uid 107); 10 Aug 2012 07:57:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 03:57:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 03:57:43 -0400
Content-Disposition: inline
In-Reply-To: <20120810075342.GA30072@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203208>

Commit ff5effdf taught both clients and servers of the git
protocol to send an "agent" capability that just advertises
their version for statistics and debugging purposes.
However, the protocol-capabilities.txt document indicates
that the client's advertisement is actually a response, and
should never include capabilities not mentioned in the
server's advertisement.

Adding the unconditional advertisement in the server
programs was OK, then, but the clients broke the protocol.
The server implementation of git-core itself does not care,
but at least one does: the Google Code git server will hang
up with an internal error upon seeing an unknown capability.

Instead, each client must record whether we saw an agent
string from the server, and respond with its agent only if
the server mentioned it first.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c |  7 ++++++-
 builtin/send-pack.c  | 12 +++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index fe56596..bc7a0f9 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -19,6 +19,7 @@ static int prefer_ofs_delta = 1;
 static int no_done;
 static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
+static int agent_supported;
 static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
@@ -328,7 +329,8 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args.include_tag)   strbuf_addstr(&c, " include-tag");
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
-			strbuf_addf(&c, " agent=%s", git_user_agent_sanitized());
+			if (agent_supported)    strbuf_addf(&c, " agent=%s",
+							    git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
 			strbuf_release(&c);
 		} else
@@ -821,6 +823,9 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
+	if (server_supports("agent"))
+		agent_supported = 1;
+
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 5c69995..7d05064 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -252,6 +252,7 @@ int send_pack(struct send_pack_args *args,
 	int status_report = 0;
 	int use_sideband = 0;
 	int quiet_supported = 0;
+	int agent_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -267,6 +268,8 @@ int send_pack(struct send_pack_args *args,
 		use_sideband = 1;
 	if (server_supports("quiet"))
 		quiet_supported = 1;
+	if (server_supports("agent"))
+		agent_supported = 1;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -306,14 +309,17 @@ int send_pack(struct send_pack_args *args,
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 			int quiet = quiet_supported && (args->quiet || !args->progress);
 
-			if (!cmds_sent && (status_report || use_sideband || quiet)) {
+			if (!cmds_sent && (status_report || use_sideband ||
+					   quiet || agent_supported)) {
 				packet_buf_write(&req_buf,
-						 "%s %s %s%c%s%s%s agent=%s",
+						 "%s %s %s%c%s%s%s%s%s",
 						 old_hex, new_hex, ref->name, 0,
 						 status_report ? " report-status" : "",
 						 use_sideband ? " side-band-64k" : "",
 						 quiet ? " quiet" : "",
-						 git_user_agent_sanitized());
+						 agent_supported ? " agent=" : "",
+						 agent_supported ? git_user_agent_sanitized() : ""
+						);
 			}
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
-- 
1.7.12.rc2.4.g7f05cf9
