From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/19] receive-pack: parse feature request a bit earlier
Date: Fri, 22 Aug 2014 13:30:07 -0700
Message-ID: <1408739424-31429-3-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:31:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvUD-0007DD-DS
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbaHVUa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:30:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62533 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaHVUaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:30:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16F503312D;
	Fri, 22 Aug 2014 16:30:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=YvV7
	kUlKkZ4WTkQaRwDazPn8Xww=; b=g7iW3vaFd/gYQX8E8ReEj+jJBV4PK5zOo+BY
	VB0PMZjJk+sn4LDaobBi3jiK/NttatL4s4fRDBbA75Kri8qbcht4P2VW7lvaFMlJ
	rdBhqCiZG8bCwwsW1WnD1pyUp/pt+MWTpyT18707Tv6VwBsLwfPnqIgkuMrKRYqh
	8w0uCSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Q+Llm+
	N8LusfvC4zcFaJvdTWGwKFt6Nhh+2awjhCoUai16BunrEtbtYcvprnxlQfew7br0
	DCj+yyKHhJokGlm8yg5bfe2NqXv5X6EAwVCcWQE0UJJJUhRAPqUm2+4uJQMOjH3f
	e7cSBUz5zo8XcLdJfrH106ytZEEud56PL8Mxc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0DCD03312C;
	Fri, 22 Aug 2014 16:30:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F42533123;
	Fri, 22 Aug 2014 16:30:47 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 32C826D4-2A3B-11E4-BA5F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255703>

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
2.1.0-304-g950f846
