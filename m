From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 1/2 maint] apply --whitespace=fix: fix tab-in-indent
Date: Tue, 30 Nov 2010 09:22:04 +0100
Message-ID: <4CF4B42C.4080104@viscovery.net>
References: <4CF366B1.8070400@viscovery.net> <7vhbezwqan.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chris Webb <chris@arachsys.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 09:22:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNLTc-000116-68
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 09:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab0K3IWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 03:22:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42983 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754111Ab0K3IWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 03:22:10 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PNLTQ-00070f-Ph; Tue, 30 Nov 2010 09:22:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 833761660F;
	Tue, 30 Nov 2010 09:22:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7vhbezwqan.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162479>

From: Johannes Sixt <j6t@kdbg.org>

When the whitespace rule tab-in-indent is enabled, apply --whitespace=fix
replaces tabs by the appropriate amount of blanks. The code used
"dst->len % 8" as the criterion to stop adding blanks. But it forgot that
dst holds more than just the current line. Consequently, the modulus was
computed correctly only for the first added line, but not for the second
and subsequent lines. Fix it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This can go on top of a347b17f or its ancestor.

 t/t4124-apply-ws-rule.sh |   28 ++++++++++++++++++++++++++++
 ws.c                     |    3 ++-
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 61bfc56..40e5842 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -121,6 +121,34 @@ test_expect_success 'whitespace=error-all, no rule (attribute)' '
 
 '
 
+test_expect_success 'spaces inserted by tab-in-indent' '
+
+	git config core.whitespace -trailing,-space,-indent,tab &&
+	rm -f .gitattributes &&
+	test_fix % &&
+	sed -e "s/_/ /g" -e "s/>/	/" <<-\EOF >expect &&
+		An_SP in an ordinary line>and a HT.
+		________A HT (%).
+		________A SP and a HT (@%).
+		_________A SP, a HT and a SP (@%).
+		_______Seven SP.
+		________Eight SP (#).
+		________Seven SP and a HT (@%).
+		________________Eight SP and a HT (@#%).
+		_________Seven SP, a HT and a SP (@%).
+		_________________Eight SP, a HT and a SP (@#%).
+		_______________Fifteen SP (#).
+		________________Fifteen SP and a HT (@#%).
+		________________Sixteen SP (#).
+		________________________Sixteen SP and a HT (@#%).
+		_____a__Five SP, a non WS, two SP.
+		A line with a (!) trailing SP_
+		A line with a (!) trailing HT>
+	EOF
+	test_cmp expect target
+
+'
+
 for t in - ''
 do
 	case "$t" in '') tt='!' ;; *) tt= ;; esac
diff --git a/ws.c b/ws.c
index 7302f8f..e350436 100644
--- a/ws.c
+++ b/ws.c
@@ -363,12 +363,13 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 		fixed = 1;
 	} else if ((ws_rule & WS_TAB_IN_INDENT) && last_tab_in_indent >= 0) {
 		/* Expand tabs into spaces */
+		int start = dst->len;
 		int last = last_tab_in_indent + 1;
 		for (i = 0; i < last; i++) {
 			if (src[i] == '\t')
 				do {
 					strbuf_addch(dst, ' ');
-				} while (dst->len % 8);
+				} while ((dst->len - start) % 8);
 			else
 				strbuf_addch(dst, src[i]);
 		}
-- 
1.7.3.67.gcc234
