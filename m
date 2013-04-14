From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/33] t3211: demonstrate loss of peeled refs if a packed ref is deleted
Date: Sun, 14 Apr 2013 14:54:35 +0200
Message-ID: <1365944088-10588-21-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTP-0004Wx-FG
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab3DNMzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:50 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:43740 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751989Ab3DNMzs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:48 -0400
X-AuditID: 12074411-b7f286d0000008e8-49-516aa7535021
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 90.8C.02280.357AA615; Sun, 14 Apr 2013 08:55:47 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkH007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:46 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqBu8PCvQYOd9RYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M6YsuIYW8E09or/m7rYGhjfsHYxcnJICJhIzH+7lBnCFpO4cG89WxcjF4eQwGVGiT8t
	u1ggnLNMEpd+zmEEqWIT0JVY1NPM1MXIwSEikC2xe608SJhZwEFi8+dGsBJhgQiJG7/WgQ1l
	EVCVOHx1CguIzSvgKjH9OESNhICCxPHt28BsTpD482PsILaQgIvErM2zWScw8i5gZFjFKJeY
	U5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERJSgjsYZ5yUO8QowMGoxMP7gjErUIg1
	say4MvcQoyQHk5Io78KlQCG+pPyUyozE4oz4otKc1OJDjBIczEoivI6tQDnelMTKqtSifJiU
	NAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpisDAeHkgSvxjKgRsGi1PTUirTMnBKENBMHJ4jgAtnA
	A7ThLch23uKCxNzizHSIolOMilLivB9BEgIgiYzSPLgBsOh/xSgO9I8w71OQKh5g4oDrfgU0
	mAlosM/edJDBJYkIKakGRt2IR1sdTy3XmK/P3+TlGa7q/nrl/SUrBcQ4Wrzb02SfyE9a+2Gd
	YWNWWi+HoeCixo2ZM/xOnvuks3WmiGXsB5171usiXPZbVG69m33gRfmKGZwSlVxCCyvP5f03
	C5PWexT+UK75Y9fOvl0ioXWztye2RhfsPxP2nmX9DtWwH0/CCuec9Zv1WYmlOCPR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221109>

Add a test that demonstrates that the peeled values recorded in
packed-refs are lost if a packed ref is deleted.  (The code in
repack_without_ref() doesn't even attempt to write peeled refs.)  This
will be fixed in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t3211-peel-ref.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index d4d7792..cca1acb 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -61,4 +61,13 @@ test_expect_success 'refs are peeled outside of refs/tags (old packed)' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'peeled refs survive deletion of packed ref' '
+	git pack-refs --all &&
+	cp .git/packed-refs fully-peeled &&
+	git branch yadda &&
+	git pack-refs --all &&
+	git branch -d yadda &&
+	test_cmp fully-peeled .git/packed-refs
+'
+
 test_done
-- 
1.8.2.1
