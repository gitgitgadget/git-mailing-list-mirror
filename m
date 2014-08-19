From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/18] receive-pack: parse feature request a bit earlier
Date: Tue, 19 Aug 2014 15:06:11 -0700
Message-ID: <1408485987-3590-3-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:07:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrYU-0005V3-18
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbaHSWG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:06:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63953 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbaHSWG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:06:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A25733087;
	Tue, 19 Aug 2014 18:06:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EaGn
	Kjw5z9PuQfohpI1Jb1edj3k=; b=ZXajG6LmPZ1vE9/+PpfPF+of4b8nzlPQvt2D
	0pmltLDJy4TNfYZHlo1JviYDKIELOAX+i6omkbXcDKywLjD3J/qLoi6e5ci3nAoH
	CJvx15eOUjSb98XaBFri81qNH/z7zbNHRFy3TH16PiAeNKJqIHm4w1WYUQVdUUCW
	WvbAH1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vy7S05
	sFmcFcKz1VjkSJZjFPTqjlxyxZBzSRlAKmDM2bDbFTl4sgY4Ac9v/bNORB9O3fFg
	L5My5+3XKfJEx6NZW3EhCz/0c4fASCEiuqKqIatt3R1lLAhv4hnpr4Z1PtSgf/Yg
	MNeghSw1DoGcpV1gc1k92b8lbE00rBhlFz7GY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 615E133086;
	Tue, 19 Aug 2014 18:06:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A400F33070;
	Tue, 19 Aug 2014 18:06:48 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1DB0B7FC-27ED-11E4-A8E0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255522>

Ideally, we should have also allowed the first "shallow" to carry
the feature request trailer, but that is water under the bridge
now.  This makes the next step to factor out the queuing of commands
easier to review.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1663beb..43f35c4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -840,7 +840,7 @@ static struct command *read_head_info(struct sha1_array *shallow)
 		unsigned char old_sha1[20], new_sha1[20];
 		struct command *cmd;
 		char *refname;
-		int len, reflen;
+		int len, reflen, linelen;
 
 		line = packet_read_line(0, &len);
 		if (!line)
@@ -853,7 +853,18 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			continue;
 		}
 
-		if (len < 83 ||
+		linelen = strlen(line);
+		if (linelen < len) {
+			const char *feature_list = line + linelen + 1;
+			if (parse_feature_request(feature_list, "report-status"))
+				report_status = 1;
+			if (parse_feature_request(feature_list, "side-band-64k"))
+				use_sideband = LARGE_PACKET_MAX;
+			if (parse_feature_request(feature_list, "quiet"))
+				quiet = 1;
+		}
+
+		if (linelen < 83 ||
 		    line[40] != ' ' ||
 		    line[81] != ' ' ||
 		    get_sha1_hex(line, old_sha1) ||
@@ -863,15 +874,6 @@ static struct command *read_head_info(struct sha1_array *shallow)
 
 		refname = line + 82;
 		reflen = strlen(refname);
-		if (reflen + 82 < len) {
-			const char *feature_list = refname + reflen + 1;
-			if (parse_feature_request(feature_list, "report-status"))
-				report_status = 1;
-			if (parse_feature_request(feature_list, "side-band-64k"))
-				use_sideband = LARGE_PACKET_MAX;
-			if (parse_feature_request(feature_list, "quiet"))
-				quiet = 1;
-		}
 		cmd = xcalloc(1, sizeof(struct command) + reflen + 1);
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
-- 
2.1.0-301-g54593e2
