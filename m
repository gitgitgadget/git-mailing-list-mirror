From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH/RFC v2 2/4] remote-curl: send the refs to fetch-pack on stdin
Date: Tue, 27 Mar 2012 08:26:25 +0200
Message-ID: <4F715D91.5070901@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:26:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPqz-0001ih-Me
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756967Ab2C0GZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 02:25:57 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:41916 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751420Ab2C0GZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:25:57 -0400
Received: (qmail invoked by alias); 27 Mar 2012 06:25:55 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.160.201]
  by mail.gmx.net (mp016) with SMTP; 27 Mar 2012 08:25:55 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX1/yYwF7Lq7yM+gUQYjK4GV+EWt2PTZo84nGM1zX6p
	km1ZbYGmCROPR4
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F715CF7.5070903@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194021>

If a remote repo has too many tags (or branches), cloning it over the
smart HTTP transport can fail because remote-curl.c puts all the refs
from the remote repo on the fetch-pack command line. This can make the
command line longer than the global OS command line limit, causing
fetch-pack to fail.

This is especially a problem on Windows where the command line limit is
orders of magnitude shorter than Linux. There are already real repos out
there that msysGit cannot clone over smart HTTP due to this problem.

To solve this problem we teach remote-curl.c to pipe the refs to
fetch-pack using the new --stdin option, instead of on the fetch-pack
command line.

For a more detailed discussion of the problem see the parent of this
commit, titled "fetch-pack: new --stdin option to read refs from stdin".
---
 remote-curl.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index d159fe7f34..52c21433c7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -290,6 +290,7 @@ static void output_refs(struct ref *refs)
 struct rpc_state {
 	const char *service_name;
 	const char **argv;
+	struct strbuf *stdin_preamble;
 	char *service_url;
 	char *hdr_content_type;
 	char *hdr_accept;
@@ -535,6 +536,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 {
 	const char *svc = rpc->service_name;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf *preamble = rpc->stdin_preamble;
 	struct child_process client;
 	int err = 0;
 
@@ -545,6 +547,8 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	client.argv = rpc->argv;
 	if (start_command(&client))
 		exit(1);
+	if (preamble)
+		write_or_die(client.in, preamble->buf, preamble->len);
 	if (heads)
 		write_or_die(client.in, heads->buf, heads->len);
 
@@ -626,6 +630,7 @@ static int fetch_git(struct discovery *heads,
 	int nr_heads, struct ref **to_fetch)
 {
 	struct rpc_state rpc;
+	struct strbuf preamble;
 	char *depth_arg = NULL;
 	const char **argv;
 	int argc = 0, i, err;
@@ -633,6 +638,7 @@ static int fetch_git(struct discovery *heads,
 	argv = xmalloc((15 + nr_heads) * sizeof(char*));
 	argv[argc++] = "fetch-pack";
 	argv[argc++] = "--stateless-rpc";
+	argv[argc++] = "--stdin";
 	argv[argc++] = "--lock-pack";
 	if (options.followtags)
 		argv[argc++] = "--include-tag";
@@ -651,23 +657,28 @@ static int fetch_git(struct discovery *heads,
 		argv[argc++] = depth_arg;
 	}
 	argv[argc++] = url;
+	argv[argc++] = NULL;
+
+	strbuf_init(&preamble, 4);
 	for (i = 0; i < nr_heads; i++) {
 		struct ref *ref = to_fetch[i];
 		if (!ref->name || !*ref->name)
 			die("cannot fetch by sha1 over smart http");
-		argv[argc++] = ref->name;
+		packet_buf_write(&preamble, "%s\n", ref->name);
 	}
-	argv[argc++] = NULL;
+	packet_buf_flush(&preamble);
 
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-upload-pack",
 	rpc.argv = argv;
+	rpc.stdin_preamble = &preamble;
 	rpc.gzip_request = 1;
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
 		safe_write(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
+	strbuf_release(&preamble);
 	free(argv);
 	free(depth_arg);
 	return err;
-- 
1.7.9.5.4.g4f508
