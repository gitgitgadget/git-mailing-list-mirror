From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/22] receive-pack: parse feature request a bit earlier
Date: Fri,  5 Sep 2014 13:54:50 -0700
Message-ID: <1409950510-10209-3-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xk-0005bR-CN
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbaIEUzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57793 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbaIEUzT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1DF83662C;
	Fri,  5 Sep 2014 16:55:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vtP3
	D+6d12z9+bu/6rA1nvLCsN8=; b=ZEZ5icsn512BSKfnl9BQwgOq4ybl6ODd4Ov9
	XZRNn6unY8dix6dmdbD1mFdIuuniKsXfedPSKtrvZSDGPZQPncnShVd1LKQHx4C+
	SYd+VU+Jemgnc6jnVtqPSj6QdGMRGpausFnh05f2gRINDOZVZSOS1r6RR7jtYuaA
	3Td3Gsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=s4qTs9
	xX8Wc7uI0wJm8B+Wp8haXx3tzjy2FFL8pm6pO1kkTYFYRcgeOoayUc9DYkQ8LjNP
	UPZhwrFpU+exCSapnK0xiIY3+yuxkhsvXvLiQkEtPBSVbmYO66DrTsnk45/DzlUM
	O43Jkh7Jil92Tn1Dxn/hWDomMLUaQsHyJQFtQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DDA43662B;
	Fri,  5 Sep 2014 16:55:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4945D36629;
	Fri,  5 Sep 2014 16:55:17 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F0DAC8E4-353E-11E4-8034-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256520>

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
2.1.0-399-g2df620b
