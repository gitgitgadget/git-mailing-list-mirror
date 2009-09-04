From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] apply --whitespace=fix: detect new blank lines at eof
 correctly
Date: Fri,  4 Sep 2009 03:55:11 -0700
Message-ID: <1252061718-11579-3-git-send-email-gitster@pobox.com>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:55:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWSD-0003iL-Ic
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205AbZIDKza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbZIDKz3
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737AbZIDKzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39A2F43D26
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uMuW
	ss7ExicUrU5SEKsfB+NNstY=; b=jUprGfXzxauM2aV+WMuMHrNWa6mnbgZ87xY5
	gOfcigb2U6owfN1J21xdmbb/ciITYzesgOYB3Pf63tOIIJkMhBg+VNctoBRwWaQ/
	2R2miIgwut+IVBDdoDpH3v8wnmzB2UDPJiCQ3hFxrvo/aAzE1Ek/OTHVV5CGuMNk
	P82O024=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QLMY6u
	oK+QweyGdT05UusUlX1yj1Innk1+KT0Oqcvy03IO4a1qQJSr4fi7X2fu2peYTy3j
	bH94uegcscWKa/ATWbZWra07TB+Z57oQ7Vgx09oJeApNU47A7ZwDw/oEAIIo0d1p
	SXxEIOjNi6kIV6GrHU2tjGZmS1H38Vfr3sgic=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 357C243D25
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6B67443D24 for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:27 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 74F38E76-9941-11DE-8AB7-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127712>

The command tries to strip blank lines at the end of the file added by a
patch.  However, if the original ends with blank lines, often the patch
hunk ends like this:

    @@ -l,5 +m,7 @@$
    _context$
    _context$
    -deleted$
    +$
    +$
    +$
    _$
    _$

where _ stands for SP and $ shows a end-of-line.  This example patch adds
three trailing blank lines, but the code fails to notice it, because it
only pays attention to added blank lines at the very end of the hunk.  In
this example, the three added blank lines do not appear textually at the
end in the patch, even though you can see that they are indeed added at
the end, if you rearrange the diff like this:

    @@ -l,5 +m,7 @@$
    _context$
    _context$
    -deleted$
    _$
    _$
    +$
    +$
    +$

Fix this by not resetting the number of (candidate) added blank lines at
the end when the loop sees a context line that is empty.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c          |    6 ++++++
 t/t4124-apply-ws-rule.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 5b5bde4..c5e4048 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1913,6 +1913,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 		int len = linelen(patch, size);
 		int plen, added;
 		int added_blank_line = 0;
+		int is_blank_context = 0;
 
 		if (!len)
 			break;
@@ -1945,8 +1946,11 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 			*new++ = '\n';
 			add_line_info(&preimage, "\n", 1, LINE_COMMON);
 			add_line_info(&postimage, "\n", 1, LINE_COMMON);
+			is_blank_context = 1;
 			break;
 		case ' ':
+			if (plen && patch[1] == '\n')
+				is_blank_context = 1;
 		case '-':
 			memcpy(old, patch + 1, plen);
 			add_line_info(&preimage, old, plen,
@@ -1986,6 +1990,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 		}
 		if (added_blank_line)
 			new_blank_lines_at_end++;
+		else if (is_blank_context)
+			;
 		else
 			new_blank_lines_at_end = 0;
 		patch += len;
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 6898722..ba2b7f9 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -177,4 +177,16 @@ test_expect_success 'blank at EOF with --whitespace=fix (2)' '
 	test_cmp expect one
 '
 
+test_expect_success 'blank at EOF with --whitespace=fix (3)' '
+	{ echo a; echo b; echo; } >one &&
+	git add one &&
+	{ echo a; echo c; echo; } >expect &&
+	{ cat expect; echo; echo; } >one &&
+	git diff -- one >patch &&
+
+	git checkout one &&
+	git apply --whitespace=fix patch &&
+	test_cmp expect one
+'
+
 test_done
-- 
1.6.4.2.313.g0425f
