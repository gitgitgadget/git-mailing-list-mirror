From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/23] get_expanded_map(): avoid memory leak
Date: Wed, 30 Oct 2013 06:32:57 +0100
Message-ID: <1383111192-23780-9-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:34:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOQF-0005r4-7l
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab3J3FeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:34:14 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60319 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763Ab3J3FeK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:34:10 -0400
X-AuditID: 1207440f-b7f306d000006d99-ca-52709a514aad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id FA.FF.28057.15A90725; Wed, 30 Oct 2013 01:34:10 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIJ014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:07 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqBs0qyDI4O9MJovpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE74+yNh2wF/zkqDjy6xdrA2MbexcjJISFgItGy7yUjhC0mceHeerYuRi4OIYHLjBL3lr5n
	gXCuMEmsnnGFFaSKTUBXYlFPMxOILSKgJjGx7RBYEbPARGaJ49MXsYAkhAXsJf5/uckGYrMI
	qEq8O3kCrIFXwEVi98sXzBDrFCRuNE8FG8op4CrxaddNsJOEgGqa2j+zT2DkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJHD5dzB2rZc5xCjAwajEw2vwID9IiDWx
	rLgy9xCjJAeTkihv2pSCICG+pPyUyozE4oz4otKc1OJDjBIczEoivNOPA5XzpiRWVqUW5cOk
	pDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4lWcCDRUsSk1PrUjLzClBSDNxcIIILpAN
	PEAbeEAKeYsLEnOLM9Mhik4xKkqJ8yqAJARAEhmleXADYCnmFaM40D/CEO08wPQE1/0KaDAT
	0OA9LHkgg0sSEVJSDYxynZc8+Pcsm3QsUU/t88WOUim2zpAnF6pX+4QrXsiu/XKtqLDsaCzP
	mkpjsYSDj7jrLsjfurfiRarB+2CjiMvuh4U8602n8QqJV5uIME9105raq2rz4v+8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236961>

The old code could leak *expn_name if match_name_with_pattern()
succeeded but ignore_symref_update() returned true.  So make sure that
*expn_name is freed in any case.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 0d082cd..e42daa8 100644
--- a/remote.c
+++ b/remote.c
@@ -1567,9 +1567,9 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 	struct ref *ret = NULL;
 	struct ref **tail = &ret;
 
-	char *expn_name;
-
 	for (ref = remote_refs; ref; ref = ref->next) {
+		char *expn_name = NULL;
+
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
 		if (match_name_with_pattern(refspec->src, ref->name,
@@ -1578,12 +1578,12 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 			struct ref *cpy = copy_ref(ref);
 
 			cpy->peer_ref = alloc_ref(expn_name);
-			free(expn_name);
 			if (refspec->force)
 				cpy->peer_ref->force = 1;
 			*tail = cpy;
 			tail = &cpy->next;
 		}
+		free(expn_name);
 	}
 
 	return ret;
-- 
1.8.4.1
