From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/21] receive-pack: parse feature request a bit earlier
Date: Thu,  4 Sep 2014 13:04:38 -0700
Message-ID: <1409861097-19151-3-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:05:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdHq-0000jh-6f
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372AbaIDUFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60915 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbaIDUFM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4010738159;
	Thu,  4 Sep 2014 16:05:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=e8yE
	YWNgmoqpIoh9F+eyht708X4=; b=RHfeAGdMUrLS5JDbqQvUwB9O6AlUYPCFdCx5
	n66dV1X/c89AiMl5+qrxCTcGFeOl9wjZrA1W8dDW4cr/2pP2g6O3RNNpHXJ6d59t
	l3qTVqN+AaGNQe5k+jeKijPZWhz8k/vUMh1BlXbhHZ0Qc4OOo9zqGkQyJyEdvl6j
	Ipkt4u0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=F30xjl
	9VsF6ZqWau+HpetNBK/ld6ZmV1T2iOpFRT92Fe7H5OVhYxwRinUMESx1e88VUnd1
	UcSdSmy3ZYskhCbtYcuuMOUgY/YAsEFTY30VG9DpgjxUntTbaz/VW8uPPDJdn1pd
	wGpz45/OuLELkV5ghEP/8FgaHtJpi9FIDzrCw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CADC938155;
	Thu,  4 Sep 2014 16:05:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 474033814C;
	Thu,  4 Sep 2014 16:05:08 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C4EF264C-346E-11E4-B469-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256460>

Ideally, we should have also allowed the first "shallow" to carry
the feature request trailer, but that is water under the bridge
now.  This makes the next step to factor out the queuing of commands
easier to review.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1663beb..a91eec8 100644
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
@@ -862,16 +873,7 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			    line);
 
 		refname = line + 82;
-		reflen = strlen(refname);
-		if (reflen + 82 < len) {
-			const char *feature_list = refname + reflen + 1;
-			if (parse_feature_request(feature_list, "report-status"))
-				report_status = 1;
-			if (parse_feature_request(feature_list, "side-band-64k"))
-				use_sideband = LARGE_PACKET_MAX;
-			if (parse_feature_request(feature_list, "quiet"))
-				quiet = 1;
-		}
+		reflen = linelen - 82;
 		cmd = xcalloc(1, sizeof(struct command) + reflen + 1);
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
-- 
2.1.0-399-g1364b4d
