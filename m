From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/5] lock_ref_for_update(): avoid a symref resolution
Date: Tue,  7 Jun 2016 13:50:10 +0200
Message-ID: <dd34c6a5ef249f4ffb8c8cb7238889e84e19f82c.1465299118.git.mhagger@alum.mit.edu>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:51:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFWo-0004Ls-3C
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbcFGLud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:50:33 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61998 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161116AbcFGLuX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 07:50:23 -0400
X-AuditID: 1207440f-8bbff700000008e4-3a-5756b4ffd319
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D2.26.02276.FF4B6575; Tue,  7 Jun 2016 07:50:23 -0400 (EDT)
Received: from michael.fritz.box (p548D6137.dip0.t-ipconnect.de [84.141.97.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u57BoCa4014544
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 7 Jun 2016 07:50:22 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465299118.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPt/S1i4we1f/BbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WF2YPP4+/4Dk8fOWXfZPZ717mH0uHhJ2WPB8/vsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ7w/9pSpoIejovPUU8YGxj1sXYycHBICJhKrj3axdDFycQgJbGWU
	uHtoLyOEc4xJYs2734wgVWwCuhKLepqZQGwRgQiJhlctYEXMAvsYJU6um88CkhAWcJWY1bWQ
	FcRmEVCVmHz8KNgKXoEoicM/DzFDrJOTuDz9AVicU8BC4sS7lWC2kIC5xMWWTYwTGHkWMDKs
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJKf4djF3rZQ4xCnAwKvHwCnwP
	DRdiTSwrrsw9xCjJwaQkyvvQOyxciC8pP6UyI7E4I76oNCe1+BCjBAezkghvwlqgHG9KYmVV
	alE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoRTFaGg0NJgtcaGDtCgkWp6akVaZk5JQhpJg5O
	kOFcUiLFqXkpqUWJpSUZ8aAoiC8GxgFIigdo76vNIHuLCxJzgaIQracYFaXEebeBJARAEhml
	eXBjYYniFaM40JfCvHtBqniASQau+xXQYCagwcuuBYMMLklESEk1MHLKx1+acWK7J9+m+K9l
	F75dWd/5o4JBIlvh7otjf8L9GUqXVhgZMQvvjTQ0nXzybDhPqJOIoOenCSuXnm5t8jBcY5ca
	ku5rybOzOXpzukTLkbWvj+gfNwlPnaz0Xp/nI3NhA9/RnTLSFyVmGx2M+897qO7c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296627>

If we're overwriting a symref with a SHA-1, we need to resolve the value
of the symref (1) to check against update->old_sha1 and (2) to write to
its reflog. However, we've already read the symref itself and know its
referent. So there is no need to read the symref's value through the
symref; we can read the referent directly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 98c8b95..b8d7a9a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3481,7 +3481,7 @@ static int lock_ref_for_update(struct ref_update *update,
 			 * the transaction, so we have to read it here
 			 * to record and possibly check old_sha1:
 			 */
-			if (read_ref_full(update->refname, 0,
+			if (read_ref_full(referent.buf, 0,
 					  lock->old_oid.hash, NULL)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
-- 
2.8.1
