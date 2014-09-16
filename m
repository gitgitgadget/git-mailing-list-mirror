From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 06/35] lockfile: unlock file if lockfile permissions cannot be adjusted
Date: Tue, 16 Sep 2014 21:33:27 +0200
Message-ID: <1410896036-12750-7-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:41:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydL-0003Sd-RF
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059AbaIPTlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:41:47 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47043 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755026AbaIPTlq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:41:46 -0400
X-AuditID: 1207440c-f79036d000005e77-0c-541890c072ef
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.8C.24183.0C098145; Tue, 16 Sep 2014 15:34:24 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcA001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:22 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1D0wQSLE4MASLouuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOuL9wKmNBO3vFjI+H2BsYT7F2MXJySAiYSLSu/8oC
	YYtJXLi3nq2LkYtDSOAyo0TnvnfMEM4JJond79rZQKrYBHQlFvU0M4EkRATaGCV2XdzMCuIw
	C3QzSrw/cZoJpEpYIEpi592rYB0sAqoSt1e1gu3jFXCR2L7xEDPEPjmJDbv/M3YxcnBwCrhK
	fN1XAGIKAZUcvOs3gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQ
	wOPZwfhtncwhRgEORiUe3g/3xUOEWBPLiitzDzFKcjApifL+65YIEeJLyk+pzEgszogvKs1J
	LT7EKMHBrCTC+8MXKMebklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQkuC9
	2Q/UKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KjfhiYHSApHiA9n4EaectLkjM
	BYpCtJ5iNOZoaXrby8SxrvNbP5MQS15+XqqUOK8NSKkASGlGaR7cIljKecUoDvS3MO87kCoe
	YLqCm/cKaBUT0KqzPWIgq0oSEVJSDYwpYRIWC3J9ph9WE//d4cf2z2ar6INr1QG1KTfnfF3d
	qukpbOK9Q3Pirq8Xz5j4P65u0WD2yP3T9XGXx+f5sxJuv9DbUPDv17ETp8MW/3qU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257165>

If the call to adjust_shared_perm() fails, lock_file returns -1, which
to the caller looks like any other failure to lock the file.  So in
this case, roll back the lockfile before returning so that the lock
file is deleted immediately and the lockfile object is left in a
predictable state (namely, unlocked).  Previously, the lockfile was
retained until process cleanup in this situation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lockfile.c b/lockfile.c
index b1c4ba0..d4f165d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -153,6 +153,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			int save_errno = errno;
 			error("cannot fix permission bits on %s",
 			      lk->filename);
+			rollback_lock_file(lk);
 			errno = save_errno;
 			return -1;
 		}
-- 
2.1.0
