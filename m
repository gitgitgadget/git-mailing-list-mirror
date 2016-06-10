From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/6] lock_ref_for_update(): avoid a symref resolution
Date: Fri, 10 Jun 2016 10:14:49 +0200
Message-ID: <b8c6f36a6291ad5a864d6fc05e3f90da578416b0.1465544913.git.mhagger@alum.mit.edu>
References: <cover.1465544913.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, David Turner <novalis@novalis.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:15:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHbS-0001pi-Cs
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbcFJIPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:15:34 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63207 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251AbcFJIPG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 04:15:06 -0400
X-AuditID: 1207440c-c53ff70000000b85-02-575a77090da4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 90.3A.02949.9077A575; Fri, 10 Jun 2016 04:15:05 -0400 (EDT)
Received: from michael.fritz.box (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A8EpD8028943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 04:15:04 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465544913.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqMtZHhVucHueikXXlW4mi4beK8wW
	T+beZba4vWI+s8WSh6+ZLbqnvGW0+NHSw+zA7vH3/Qcmj52z7rJ7PHzVxe7R1X6EzeNZ7x5G
	j4uXlD0+b5ILYI/itklKLCkLzkzP07dL4M54f+wpU0EPR0XnqaeMDYx72LoYOTkkBEwk+g8c
	Yuxi5OIQEtjKKNF06gk7hHOSSeLt8h6wKjYBXYlFPc1MILaIgJrExLZDLCBFzAKdTBIn9rxh
	AUkIC3hIzFx0iRnEZhFQlZiwdxYjiM0rECXxqvkgO8Q6OYnL0x+ADeUUsJA4fX0CmC0kYC7x
	b3YT+wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcxQsKMZwfjt3Uy
	hxgFOBiVeHgjdkWGC7EmlhVX5h5ilORgUhLl3RkYFS7El5SfUpmRWJwRX1Sak1p8iFGCg1lJ
	hFcMJMebklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQkuBVKwNqFCxKTU+t
	SMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFQXwxMA5AUjxAeytA2nmLCxJzgaIQracYdTmO
	7L+3lkmIJS8/L1VKnHdRKVCRAEhRRmke3ApYUnnFKA70sTCvJsgoHmBCgpv0CmgJE9CS5UfC
	QZaUJCKkpBoYPa0YV8+fuCjh4P51dwInhpYXr2xh3Nn9OPZv8Hs1/Z9n0u/2bVLnOHSuJyU9
	pJsl6EqS8P8zaydoT0vQat3OE+goyb1dWYrz3855Flf3TJcPKFlZdWfd3BiV9cYr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296955>

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
