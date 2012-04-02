From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH v3 2/4] remote-curl: send the refs to fetch-pack on stdin
Date: Mon, 02 Apr 2012 17:14:44 +0200
Message-ID: <4F79C264.1060508@gmx.net>
References: <4F79C195.6090905@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 17:14:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEixY-0005JX-Qm
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 17:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab2DBPOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 11:14:16 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:37852 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753048Ab2DBPOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 11:14:15 -0400
Received: (qmail invoked by alias); 02 Apr 2012 15:14:13 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.163.38]
  by mail.gmx.net (mp039) with SMTP; 02 Apr 2012 17:14:13 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX192UmVmqC52nsM8xjdHZ5G8/5ROejwobIGCXP+K6M
	nl5UCM4rUknAi0
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F79C195.6090905@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194518>

Now that we can throw an arbitrary number of refs at fetch-pack using
its --stdin option, we use it in the remote-curl helper to bypass the
OS command line length limit.

Signed-off-by: Ivan Todoroski <grnch@gmx.net>
---
 remote-curl.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index d159fe7f34..a728edfa7f 100644
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
+	struct strbuf preamble = STRBUF_INIT;
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
@@ -651,23 +657,27 @@ static int fetch_git(struct discovery *heads,
 		argv[argc++] = depth_arg;
 	}
 	argv[argc++] = url;
+	argv[argc++] = NULL;
+
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
