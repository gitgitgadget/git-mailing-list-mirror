From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] read_revision_from_stdin(): use strbuf
Date: Fri, 20 Nov 2009 03:25:13 -0800
Message-ID: <1258716315-2213-2-git-send-email-gitster@pobox.com>
References: <1258716315-2213-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 12:25:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBRcM-0004Rj-Rx
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 12:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbZKTLZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 06:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZKTLZO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 06:25:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZKTLZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 06:25:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 654529FE43
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5bqk
	nFFss3xAGFKHsmwAQM2eNM0=; b=h4J6hPzmd4vwboETB1MYEmMtGyRxLTVp9W+U
	Tp61IeVLRRxQ6lKiGOcIYYfw6ugao5O/cgVsPMe/txaiUlrhWz68Vt+PCtnPcrmE
	MdOiQRCKX+3sFMa7dBpWUJgt0Ky/2SLpopPCzzS60gGoWpHF/vClThA+6ZGvonLK
	ZVVH4dM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=i4TluA
	OZ+eoboKyvvRtr06uAfT9YK35nJC4MutrBm0a18uAGMTJiWa9iQcR562Jo9KptAM
	wbnXR+uXj6lYdc2VC4teNGYAvX+pHLFhWSM2KyEqx9xjjSNIcDmhH/yL1VzOfqo5
	m9MU5wicanphZDRDF/ULjuzGS1q/zR8OoNx0Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 622D29FE42
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D98779FE40 for
 <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:18 -0500 (EST)
X-Mailer: git-send-email 1.6.5.3.342.g14bb9
In-Reply-To: <1258716315-2213-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6263B728-D5C7-11DE-A9BF-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133335>

It is so 2005 (and Linus ;-) to have a fixed 1000-byte buffer that
reads from the user.  Let's use strbuf to unlimit the input length.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 45c5de8..f5b735f 100644
--- a/revision.c
+++ b/revision.c
@@ -955,19 +955,21 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 
 static void read_revisions_from_stdin(struct rev_info *revs)
 {
-	char line[1000];
+	struct strbuf sb;
 
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		int len = strlen(line);
-		if (len && line[len - 1] == '\n')
-			line[--len] = '\0';
+	strbuf_init(&sb, 1000);
+	while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
+		int len = sb.len;
+		if (len && sb.buf[len - 1] == '\n')
+			sb.buf[--len] = '\0';
 		if (!len)
 			break;
-		if (line[0] == '-')
+		if (sb.buf[0] == '-')
 			die("options not supported in --stdin mode");
-		if (handle_revision_arg(line, revs, 0, 1))
-			die("bad revision '%s'", line);
+		if (handle_revision_arg(sb.buf, revs, 0, 1))
+			die("bad revision '%s'", sb.buf);
 	}
+	strbuf_release(&sb);
 }
 
 static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
-- 
1.6.5.3.342.g14bb9
