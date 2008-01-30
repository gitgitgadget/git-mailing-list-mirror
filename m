From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/7] Refactor send-pack/receive-pack capability handshake for extension
Date: Wed, 30 Jan 2008 01:22:09 -0500
Message-ID: <20080130062209.GE15838@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:23:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6Lv-0001Yk-SY
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 07:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbYA3GWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 01:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbYA3GWW
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 01:22:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58709 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbYA3GWM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 01:22:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JK6Ko-0000BA-Na; Wed, 30 Jan 2008 01:22:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 49FE120FBAE; Wed, 30 Jan 2008 01:22:09 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72033>

This refactors the capability selection in send-pack to be more
like how fetch-pack handles the transmission to the remote peer,
so we can easily add additional capability strings to the push
protocol as needed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-send-pack.c |   17 ++++++++---------
 receive-pack.c      |    3 ++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8afb1d0..63fbcd2 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -378,10 +378,10 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 {
 	struct ref *ref;
 	int new_refs;
-	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
 	int flags = MATCH_REFS_NONE;
+	int pushing = 0;
 	int ret;
 
 	if (args.send_all)
@@ -395,7 +395,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
-		ask_for_status_report = 1;
+		expect_status_report = 1;
 	if (server_supports("delete-refs"))
 		allow_deleting_refs = 1;
 
@@ -477,18 +477,17 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 
-			if (ask_for_status_report) {
+			if (!pushing)
 				packet_write(out, "%s %s %s%c%s",
 					old_hex, new_hex, ref->name, 0,
-					"report-status");
-				ask_for_status_report = 0;
-				expect_status_report = 1;
-			}
+					(expect_status_report ? " report-status" : "")
+				);
 			else
 				packet_write(out, "%s %s %s",
 					old_hex, new_hex, ref->name);
+			pushing++;
 		}
-		ref->status = expect_status_report ?
+		ref->status = pushing && expect_status_report ?
 			REF_STATUS_EXPECTING_REPORT :
 			REF_STATUS_OK;
 	}
@@ -502,7 +501,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	}
 	close(out);
 
-	if (expect_status_report)
+	if (pushing && expect_status_report)
 		ret = receive_status(in, remote_refs);
 	else
 		ret = 0;
diff --git a/receive-pack.c b/receive-pack.c
index 3267495..7380395 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -318,7 +318,8 @@ static void read_head_info(void)
 		refname = line + 82;
 		reflen = strlen(refname);
 		if (reflen + 82 < len) {
-			if (strstr(refname + reflen + 1, "report-status"))
+			const char *reqcap = refname + reflen + 1;
+			if (strstr(reqcap, "report-status"))
 				report_status = 1;
 		}
 		cmd = xmalloc(sizeof(struct command) + len - 80);
-- 
1.5.4.rc5.1126.g6ba14
