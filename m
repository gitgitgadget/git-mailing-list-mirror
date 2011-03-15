From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/4] upload-pack: Implement no-done capability
Date: Mon, 14 Mar 2011 17:59:40 -0700
Message-ID: <1300150780-7487-4-git-send-email-spearce@spearce.org>
References: <1300150780-7487-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 02:00:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzIcH-0003TT-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 02:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977Ab1COA7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 20:59:53 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43813 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907Ab1COA7v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 20:59:51 -0400
Received: by yia27 with SMTP id 27so35737yia.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 17:59:50 -0700 (PDT)
Received: by 10.236.195.5 with SMTP id o5mr3178052yhn.147.1300150790598;
        Mon, 14 Mar 2011 17:59:50 -0700 (PDT)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id h30sm5714081yhm.0.2011.03.14.17.59.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 17:59:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.35.ga52fb.dirty
In-Reply-To: <1300150780-7487-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169041>

If the client requests both multi_ack_detailed and no-done then
upload-pack is free to immediately send a PACK following its first
'ACK %s ready' message.  The upload-pack response actually winds
up being:

  ACK %s common
  ... (maybe more) ...
  ACK %s ready
  NAK
  ACK %s
  PACK.... the pack stream ....

For smart HTTP connections this saves one HTTP RPC, reducing
the overall latency for a trivial fetch.  For git:// and ssh://
a no-done option slightly reduces latency by removing one
server->client->server round-trip at the end of the common
ancestor negotiation.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 upload-pack.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2a0f19e..e644dbe 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -27,6 +27,7 @@ static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<
 static unsigned long oldest_have;
 
 static int multi_ack, nr_our_refs;
+static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
 static int shallow_nr;
@@ -431,6 +432,7 @@ static int get_common_commits(void)
 	char last_hex[41];
 	int got_common = 0;
 	int got_other = 0;
+	int sent_ready = 0;
 
 	save_commit_buffer = 0;
 
@@ -440,10 +442,17 @@ static int get_common_commits(void)
 
 		if (!len) {
 			if (multi_ack == 2 && got_common
-					&& !got_other && ok_to_give_up())
+					&& !got_other && ok_to_give_up()) {
+				sent_ready = 1;
 				packet_write(1, "ACK %s ready\n", last_hex);
+			}
 			if (have_obj.nr == 0 || multi_ack)
 				packet_write(1, "NAK\n");
+
+			if (no_done && sent_ready) {
+				packet_write(1, "ACK %s\n", last_hex);
+				return 0;
+			}
 			if (stateless_rpc)
 				exit(0);
 			got_common = 0;
@@ -457,9 +466,10 @@ static int get_common_commits(void)
 				got_other = 1;
 				if (multi_ack && ok_to_give_up()) {
 					const char *hex = sha1_to_hex(sha1);
-					if (multi_ack == 2)
+					if (multi_ack == 2) {
+						sent_ready = 1;
 						packet_write(1, "ACK %s ready\n", hex);
-					else
+					} else
 						packet_write(1, "ACK %s continue\n", hex);
 				}
 				break;
@@ -535,6 +545,8 @@ static void receive_needs(void)
 			multi_ack = 2;
 		else if (strstr(line+45, "multi_ack"))
 			multi_ack = 1;
+		if (strstr(line+45, "no-done"))
+			no_done = 1;
 		if (strstr(line+45, "thin-pack"))
 			use_thin_pack = 1;
 		if (strstr(line+45, "ofs-delta"))
@@ -628,7 +640,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed no-done";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
-- 
1.7.4.1.35.ga52fb.dirty
