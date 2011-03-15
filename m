From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/4 v1] upload-pack: More aggressively send 'ACK %s ready'
Date: Mon, 14 Mar 2011 17:59:38 -0700
Message-ID: <1300150780-7487-2-git-send-email-spearce@spearce.org>
References: <1300150780-7487-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 01:59:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzIc3-0003Mb-MD
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 01:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab1COA7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 20:59:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52149 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234Ab1COA7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 20:59:46 -0400
Received: by gyf1 with SMTP id 1so32244gyf.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 17:59:46 -0700 (PDT)
Received: by 10.90.9.26 with SMTP id 26mr3967509agi.50.1300150785913;
        Mon, 14 Mar 2011 17:59:45 -0700 (PDT)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id c39sm8665858anc.7.2011.03.14.17.59.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 17:59:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.35.ga52fb.dirty
In-Reply-To: <1300150780-7487-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169039>

If a client is merely following the remote (and has not made any
new commits itself), all "have %s" lines sent by the client will be
common to the server.  As all lines are common upload-pack never
calls ok_to_give_up() and does not compute if it has a good cut
point in the commit graph.

Without this computation the following client is going to send all
tagged commits, as these were determined to be COMMON_REF during the
initial advertisement, but the client does not parse their history
to transitively pass the COMMON flag and empty its queue of commits.

For git.git with 339 commit tags, it takes clients 11 rounds of
negotation to fully send all tagged commits and exhaust its queue
of things to send as common.  This is pretty slow for a client that
has not done any local development activity.

Force computing ok_to_give_up() and send "ACK %s ready" at the end
of the current round if this round only contained common objects
and ok_to_give_up() was therefore not called.  This may allow the
client to break early, avoiding transmission of the COMMON_REFs.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Unchanged from v1.

 upload-pack.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b40a43f..2a0f19e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -429,6 +429,8 @@ static int get_common_commits(void)
 	static char line[1000];
 	unsigned char sha1[20];
 	char last_hex[41];
+	int got_common = 0;
+	int got_other = 0;
 
 	save_commit_buffer = 0;
 
@@ -437,16 +439,22 @@ static int get_common_commits(void)
 		reset_timeout();
 
 		if (!len) {
+			if (multi_ack == 2 && got_common
+					&& !got_other && ok_to_give_up())
+				packet_write(1, "ACK %s ready\n", last_hex);
 			if (have_obj.nr == 0 || multi_ack)
 				packet_write(1, "NAK\n");
 			if (stateless_rpc)
 				exit(0);
+			got_common = 0;
+			got_other = 0;
 			continue;
 		}
 		strip(line, len);
 		if (!prefixcmp(line, "have ")) {
 			switch (got_sha1(line+5, sha1)) {
 			case -1: /* they have what we do not */
+				got_other = 1;
 				if (multi_ack && ok_to_give_up()) {
 					const char *hex = sha1_to_hex(sha1);
 					if (multi_ack == 2)
@@ -456,6 +464,7 @@ static int get_common_commits(void)
 				}
 				break;
 			default:
+				got_common = 1;
 				memcpy(last_hex, sha1_to_hex(sha1), 41);
 				if (multi_ack == 2)
 					packet_write(1, "ACK %s common\n", last_hex);
-- 
1.7.4.1.35.ga52fb.dirty
