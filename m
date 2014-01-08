From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/3] shorten_unambiguous_ref(): tighten up pointer arithmetic
Date: Wed,  8 Jan 2014 15:43:40 +0100
Message-ID: <1389192220-13913-4-git-send-email-mhagger@alum.mit.edu>
References: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 15:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0uMy-0005cR-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 15:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbaAHOoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 09:44:23 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44588 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756542AbaAHOoU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 09:44:20 -0500
X-AuditID: 1207440f-b7f306d000006d99-33-52cd6443bdfb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 92.28.28057.3446DC25; Wed,  8 Jan 2014 09:44:19 -0500 (EST)
Received: from michael.fritz.box (p4FDD47EC.dip0.t-ipconnect.de [79.221.71.236])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s08EhhdJ022001
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jan 2014 09:44:18 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqOuccjbIYM1/JYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7o+b+JvWA2Z8XbDrcGxpXs
	XYycHBICJhKL50xlgrDFJC7cW8/WxcjFISRwmVHi7r1GdgjnOJPE7hmP2ECq2AR0JRb1NIN1
	iAioSUxsO8QCYjMLOEhs/tzICGILC/hK7Lp9GyzOIqAqsWflbrA4r4CLxJnvp4DmcABtU5BY
	fV0IJMwp4Cpx8fBysPFCQCVzP1xlncDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrole
	bmaJXmpK6SZGSKDw72DsWi9ziFGAg1GJh7dB5UyQEGtiWXFl7iFGSQ4mJVFe/eizQUJ8Sfkp
	lRmJxRnxRaU5qcWHGCU4mJVEeC/FAeV4UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtS
	i2CyMhwcShK8ZclAjYJFqempFWmZOSUIaSYOThDBBbKBB2hDB0ghb3FBYm5xZjpE0SlGRSlx
	3j6QhABIIqM0D24ALKZfMYoD/SPMOwekigeYDuC6XwENZgIaHBp3CmRwSSJCSqqBcVP/cc9n
	mR4zc9h/m0dxPtt+OuzxOhcjPlEGgymTtxY3rv3jf1H1v4kSz+boVbc/1mzaI/9boPmD89GM
	985r1ZwWRudLHs6qz2bYvdzT7ZjZsd/C/6ZOn3zgpfHJWN6yJSdCBU+f8Dou82fnxXNWx+5W
	RS0+wc9zar78s/0f5P++M6gyM/D+yKbEUpyRaKjFXFScCAB5tTeixAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240216>

As long as we're being pathologically stingy with mallocs, we might as
well do the math right and save 6 (!) bytes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
It is left to the reader to show how another 7 bytes could be saved
(11 bytes on a 64-bit architecture!)

It probably wouldn't kill performance to use a string_list here
instead.

 refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index ef9cdea..63b3a71 100644
--- a/refs.c
+++ b/refs.c
@@ -3351,10 +3351,10 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 		size_t total_len = 0;
 		size_t offset = 0;
 
-		/* the rule list is NULL terminated, count them first */
+		/* the rule list is NUL terminated, count them first */
 		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
-			/* no +1 because strlen("%s") < strlen("%.*s") */
-			total_len += strlen(ref_rev_parse_rules[nr_rules]);
+			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
+			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
 
 		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
 
-- 
1.8.5.2
