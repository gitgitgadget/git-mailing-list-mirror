From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] apply --whitespace: warn blank but not necessarily empty
 lines at EOF
Date: Fri,  4 Sep 2009 03:55:14 -0700
Message-ID: <1252061718-11579-6-git-send-email-gitster@pobox.com>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:56:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWTG-00041M-0l
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742AbZIDKzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755893AbZIDKzi
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbZIDKzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3177825EF0
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ct41
	C8koWv0G4pBWhKsuT8Awc+s=; b=jnktFCTcgX86eJVp21CdQOw+41DT2xyzolHb
	61DKXSyRFJCVb85/qoo4ClOdX9OJQTHTRfBEEWjkFjk/Vsu8ztDS+TgJ+MsEAUZH
	IVSYlhGQXWDCMVhU+T5668KnwyTpSLUwQvbPveJaJ0lJ3UXhmTRlw6hXiUolRiYy
	AeHOCc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=S6Oenz
	/GbwSv3GAQIzB7Z9nPOwb2fdbX4DVsE8cZXxIdU1O+Ma2ER5WLpbTKQzlKXhXEYW
	Leq8G6ZD5SN2SX3pX3bHUVawBYoR0tmHl9Z7VQdRhtRq3n8pRLRG2+IAtLx7vaT2
	4qSlKa7QhToXnvB85mexsnCIlsPC+LBf9Up5Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F47425EEF
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A695425EEE for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 78863476-9941-11DE-B328-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127716>

The whitespace error of adding blank lines at the end of file should
trigger if you added a non-empty line at the end, if the contents of the
line is full of whitespaces.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c          |    6 ++++--
 t/t4124-apply-ws-rule.sh |   13 +++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 37d3bc0..6662cc4 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1957,7 +1957,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 			is_blank_context = 1;
 			break;
 		case ' ':
-			if (plen && patch[1] == '\n')
+			if (plen && (ws_rule & WS_BLANK_AT_EOF) &&
+			    ws_blank_line(patch + 1, plen, ws_rule))
 				is_blank_context = 1;
 		case '-':
 			memcpy(old, patch + 1, plen);
@@ -1985,7 +1986,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				      (first == '+' ? 0 : LINE_COMMON));
 			new += added;
 			if (first == '+' &&
-			    added == 1 && new[-1] == '\n')
+			    (ws_rule & WS_BLANK_AT_EOF) &&
+			    ws_blank_line(patch + 1, plen, ws_rule))
 				added_blank_line = 1;
 			break;
 		case '@': case '\\':
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 89b71e1..b3c3b2c 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -215,4 +215,17 @@ test_expect_success 'blank at EOF with --whitespace=error' '
 	grep "new blank line at EOF" error
 '
 
+test_expect_success 'blank but not empty at EOF' '
+	{ echo a; echo b; echo c; } >one &&
+	git add one &&
+	echo "   " >>one &&
+	cat one >expect &&
+	git diff -- one >patch &&
+
+	git checkout one &&
+	git apply --whitespace=warn patch 2>error &&
+	test_cmp expect one &&
+	grep "new blank line at EOF" error
+'
+
 test_done
-- 
1.6.4.2.313.g0425f
