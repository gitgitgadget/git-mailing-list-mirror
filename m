From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/4] fetch-pack: Implement no-done capability
Date: Mon, 14 Mar 2011 17:59:39 -0700
Message-ID: <1300150780-7487-3-git-send-email-spearce@spearce.org>
References: <1300150780-7487-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 01:59:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzIc4-0003Mb-8Y
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 01:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934Ab1COA7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 20:59:50 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45156 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907Ab1COA7s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 20:59:48 -0400
Received: by yxs7 with SMTP id 7so36294yxs.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 17:59:48 -0700 (PDT)
Received: by 10.91.22.10 with SMTP id z10mr3999295agi.196.1300150788213;
        Mon, 14 Mar 2011 17:59:48 -0700 (PDT)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id r8sm8828388ane.39.2011.03.14.17.59.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 17:59:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.35.ga52fb.dirty
In-Reply-To: <1300150780-7487-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169040>

If enabled on the connection "multi_ack_detailed no-done" as a
pair allows the remote upload-pack process to send a PACK down
to the client as soon as a "ACK %s ready" message was also sent.

Over git:// and ssh:// where a bi-directional stream is in place
this has very little difference over the classical version that
waits for the client to send a "done\n" line by itself.  It does
slightly reduce the latency involved to start the pack stream as
there is one less round-trip from client->server required.

Over smart HTTP this avoids needing to send a final RPC that has
all of the prior common objects.  Instead the server is able to
return a pack as soon as its ready to.  For many common users the
smart HTTP fetch is now just 2 requests: GET .../info/refs, and
a POST .../git-upload-pack to not only negotiate but also receive
the pack stream.  Only users who have more than 32 local unshared
commits with the remote will need additional requests to negotiate
a common merge base.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin/fetch-pack.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 5173dc9..59fbda5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -14,6 +14,7 @@ static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
 static int prefer_ofs_delta = 1;
+static int no_done = 0;
 static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
@@ -225,6 +226,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	const unsigned char *sha1;
 	unsigned in_vain = 0;
 	int got_continue = 0;
+	int got_ready = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
 
@@ -262,6 +264,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 			struct strbuf c = STRBUF_INIT;
 			if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
 			if (multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
+			if (no_done)            strbuf_addstr(&c, " no-done");
 			if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
 			if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
 			if (args.use_thin_pack) strbuf_addstr(&c, " thin-pack");
@@ -379,8 +382,10 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 					retval = 0;
 					in_vain = 0;
 					got_continue = 1;
-					if (ack == ACK_ready)
+					if (ack == ACK_ready) {
 						rev_list = NULL;
+						got_ready = 1;
+					}
 					break;
 					}
 				}
@@ -394,8 +399,10 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		}
 	}
 done:
-	packet_buf_write(&req_buf, "done\n");
-	send_request(fd[1], &req_buf);
+	if (!got_ready || !no_done) {
+		packet_buf_write(&req_buf, "done\n");
+		send_request(fd[1], &req_buf);
+	}
 	if (args.verbose)
 		fprintf(stderr, "done\n");
 	if (retval != 0) {
@@ -698,6 +705,11 @@ static struct ref *do_fetch_pack(int fd[2],
 		if (args.verbose)
 			fprintf(stderr, "Server supports multi_ack_detailed\n");
 		multi_ack = 2;
+		if (server_supports("no-done")) {
+			if (args.verbose)
+				fprintf(stderr, "Server supports no-done\n");
+			no_done = 1;
+		}
 	}
 	else if (server_supports("multi_ack")) {
 		if (args.verbose)
-- 
1.7.4.1.35.ga52fb.dirty
