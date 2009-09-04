From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] apply.c: split check_whitespace() into two
Date: Fri,  4 Sep 2009 03:55:12 -0700
Message-ID: <1252061718-11579-4-git-send-email-gitster@pobox.com>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:55:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWSE-0003iL-9e
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730AbZIDKzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbZIDKzc
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862AbZIDKz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E987D25EED
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QbgR
	X42kjLicxwqmiBj8cXjHebk=; b=BDJTw0pZC+f6NiQyWCekKRSHQ8d5jJPLFjoT
	7mMx+VDzBlbaE+P2gEqFj1lKHuWrExZShpp3c+nZTz9TfFVN1/H0pq4n+NLXFJ3x
	ysT/gzSDgOGi7Zbl9G9YcktsfjpgfY2VckcGTF8xBJxWFRRXsV3PxOe3ChivFmwo
	T5W8hxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=mA0N6M
	gxHi4I1owZutlvQ22kUgOjVbDRGAFW8IzeOCpuNmzPRkZf7tVeIxhc3zsioq89fr
	j6XB1YM31lf7c47v7vVSsgD0jhr27sAGRn5QZVA7G7UxGP3UdFbEjae7WVGoE7v0
	sQ+DGtCiHn6NOrmxohFcBFvPTYqNeV/NiQO9I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E59D125EEC
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65F6A25EEB for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:29 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 75FC2A1C-9941-11DE-9A4C-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127715>

This splits the logic to record the presence of whitespace errors out of
the check_whitespace() function, which checks and then records.  The new
function, record_ws_error(), can be used by the blank-at-eof check that
does not use ws_check() logic to report its findings in the same output
format.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index c5e4048..80ddf55 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1055,23 +1055,29 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 	return -1;
 }
 
-static void check_whitespace(const char *line, int len, unsigned ws_rule)
+static void record_ws_error(unsigned result, const char *line, int len, int linenr)
 {
 	char *err;
-	unsigned result = ws_check(line + 1, len - 1, ws_rule);
+
 	if (!result)
 		return;
 
 	whitespace_error++;
 	if (squelch_whitespace_errors &&
 	    squelch_whitespace_errors < whitespace_error)
-		;
-	else {
-		err = whitespace_error_string(result);
-		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-			patch_input_file, linenr, err, len - 2, line + 1);
-		free(err);
-	}
+		return;
+
+	err = whitespace_error_string(result);
+	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
+		patch_input_file, linenr, err, len, line);
+	free(err);
+}
+
+static void check_whitespace(const char *line, int len, unsigned ws_rule)
+{
+	unsigned result = ws_check(line + 1, len - 1, ws_rule);
+
+	record_ws_error(result, line + 1, len - 2, linenr);
 }
 
 /*
-- 
1.6.4.2.313.g0425f
