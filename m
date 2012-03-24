From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: [PATCH/RFC 2/2] remote-curl: send the refs to fetch-pack on stdin
Date: Sat, 24 Mar 2012 21:54:16 +0100
Message-ID: <4F6E3478.3090505@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 21:54:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBXyM-0006AP-K0
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 21:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab2CXUx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 16:53:58 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:34444 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753622Ab2CXUx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 16:53:58 -0400
Received: (qmail invoked by alias); 24 Mar 2012 20:53:56 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.174.228]
  by mail.gmx.net (mp033) with SMTP; 24 Mar 2012 21:53:56 +0100
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX188b6tzk6I8U20oPz6x6SSc126l373tmHn4ZUbBnh
	+ygzCMzcGO/wkB
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120321201722.GA15021@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193848>


>From 723a561946824ee367f57f0d9b9d336a6bc28d13 Mon Sep 17 00:00:00 2001
From: Ivan Todoroski <grnch@gmx.net>
Date: Sat, 24 Mar 2012 15:53:36 +0100
Subject: [PATCH/RFC 2/2] remote-curl: send the refs to fetch-pack on stdin

---
 remote-curl.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index d159fe7f34..9fdfca9f32 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -531,12 +531,13 @@ static int post_rpc(struct rpc_state *rpc)
 	return err;
 }
 
-static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
+static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
+		int nr_fetch, struct ref **to_fetch)
 {
 	const char *svc = rpc->service_name;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process client;
-	int err = 0;
+	int err = 0, i;
 
 	memset(&client, 0, sizeof(client));
 	client.in = -1;
@@ -545,6 +546,13 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	client.argv = rpc->argv;
 	if (start_command(&client))
 		exit(1);
+
+	/* push the refs to fetch-pack via stdin, if requested */
+	if (to_fetch) {
+		for (i = 0; i < nr_fetch; i++)
+			packet_write(client.in, "%s\n", to_fetch[i]->name);
+		packet_flush(client.in);
+	}
 	if (heads)
 		write_or_die(client.in, heads->buf, heads->len);
 
@@ -633,6 +641,7 @@ static int fetch_git(struct discovery *heads,
 	argv = xmalloc((15 + nr_heads) * sizeof(char*));
 	argv[argc++] = "fetch-pack";
 	argv[argc++] = "--stateless-rpc";
+	argv[argc++] = "--stdin";
 	argv[argc++] = "--lock-pack";
 	if (options.followtags)
 		argv[argc++] = "--include-tag";
@@ -655,7 +664,6 @@ static int fetch_git(struct discovery *heads,
 		struct ref *ref = to_fetch[i];
 		if (!ref->name || !*ref->name)
 			die("cannot fetch by sha1 over smart http");
-		argv[argc++] = ref->name;
 	}
 	argv[argc++] = NULL;
 
@@ -664,7 +672,7 @@ static int fetch_git(struct discovery *heads,
 	rpc.argv = argv;
 	rpc.gzip_request = 1;
 
-	err = rpc_service(&rpc, heads);
+	err = rpc_service(&rpc, heads, nr_heads, to_fetch);
 	if (rpc.result.len)
 		safe_write(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
@@ -783,7 +791,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 	rpc.service_name = "git-receive-pack",
 	rpc.argv = argv;
 
-	err = rpc_service(&rpc, heads);
+	err = rpc_service(&rpc, heads, 0, NULL);
 	if (rpc.result.len)
 		safe_write(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
-- 
1.7.9.4.16.gd24fa.dirty
