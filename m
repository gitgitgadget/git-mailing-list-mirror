From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 02/23] receive-pack: parse feature request a bit earlier
Date: Mon, 15 Sep 2014 15:24:03 -0700
Message-ID: <1410819864-22967-3-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:24:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehQ-0006GD-NB
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbaIOWYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58318 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538AbaIOWYb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5B9E3B176;
	Mon, 15 Sep 2014 18:24:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Capa
	tWfar0vhjN11w1Fa5llxuMo=; b=n/7JYVbq1Ts++27TwDQR5aCq1zVSGUC9v3ME
	aZRO2NPLDF6vyzIiB3ev06FKZPZTkx9XeYNe20fR6D/ww7c04B74qGs8RQz8ewKr
	nQTkZix9wzOQ1QWgeUvfDZBkTlGko7SRkvdcx9US9qwOCY1sFgdtBN/cyzrWzr8b
	Jl+UFvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FvoXEL
	Cq813BhKNJS+alyLYnzyjZMXcfIGa2e8HdpwH7mj5ILzDA6QS+729MOxWeIP5RTU
	71cCH+H8/95bXF1BZRMX8dqswTDMPJ4FXFj+L1odBD616MF8pfgmdJLEuWCqQip7
	n/5h4g4BZgUKlj/JcbC3cQW62vQMl8ECPggvQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA59A3B174;
	Mon, 15 Sep 2014 18:24:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1C1C93B170;
	Mon, 15 Sep 2014 18:24:30 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0F832D32-3D27-11E4-B2BA-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257089>

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
2.1.0-410-gd72dacd
