From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] upload-pack: More aggressively send 'ACK %s ready'
Date: Mon, 14 Mar 2011 16:48:39 -0700
Message-ID: <1300146519-26508-2-git-send-email-spearce@spearce.org>
References: <1300146519-26508-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 00:48:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzHVL-0006QM-86
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 00:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab1CNXsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 19:48:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55395 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab1CNXsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 19:48:45 -0400
Received: by gyf1 with SMTP id 1so16389gyf.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 16:48:44 -0700 (PDT)
Received: by 10.101.18.20 with SMTP id v20mr3940447ani.139.1300146524850;
        Mon, 14 Mar 2011 16:48:44 -0700 (PDT)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id c17sm2721621anc.35.2011.03.14.16.48.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 16:48:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.9.5.g6bd7.dirty
In-Reply-To: <1300146519-26508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169036>

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
1.7.0.9.5.g6bd7.dirty
