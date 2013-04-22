From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/33] t3211: demonstrate loss of peeled refs if a packed ref is deleted
Date: Mon, 22 Apr 2013 21:52:28 +0200
Message-ID: <1366660361-21831-21-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:02:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMw1-0007GU-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab3DVUBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:52 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:63879 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755111Ab3DVUBn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:43 -0400
X-AuditID: 1207440d-b7fd06d000000905-9a-51759554806c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.0E.02309.45595715; Mon, 22 Apr 2013 15:53:56 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOX008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:55 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqBsytTTQ4OUHQYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6YsuIYW8E09or/m7rYGhjf
	sHYxcnJICJhI7Ny0jB3CFpO4cG89WxcjF4eQwGVGiW1/f7BDOBeYJNZ0/gfrYBPQlVjU08wE
	YosIqElMbDvEAmIzCzhIbP7cyAhiCwtES8yY0ARWwyKgKtH9vhNsA6+Aq8S345vYILYpSBzf
	vg2snhMofrrjBNgcIQEXiRUHp7JMYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83
	s0QvNaV0EyMkWHh3MP5fJ3OIUYCDUYmHV8C9NFCINbGsuDL3EKMkB5OSKC/HFKAQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEV7RfKAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFM
	VoaDQ0mCNwNkqGBRanpqRVpmTglCmomDE0RwgWzgAdoQCVLIW1yQmFucmQ5RdIpRUUqc120S
	UEIAJJFRmgc3ABbXrxjFgf4R5vUAaecBpgS47ldAg5mABmcmlIAMLklESEk1MGpNDV48mb96
	6YnULM2ogksvTCbaJiwLVv9+W9umQ09f7fLaZUV6ATzHm4rmN6uU75q6wYdh3yMWmaM3M068
	kpsyP2muqrr7plnr177Ya3T9pij/y1D709uT5yRHH3T7e77/1T1vIwO+NUtdzeO3ixXNaV3q
	51x88mXHoR+Nrp83yp+IuPjRKkqJpTgj0VCLuag4EQAIFZkwxgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222081>

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
