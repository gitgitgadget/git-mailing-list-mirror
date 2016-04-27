From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/29] ref_transaction_create(): disallow recursive pruning
Date: Wed, 27 Apr 2016 18:57:32 +0200
Message-ID: <615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSoP-0004DJ-LY
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbcD0Q6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:32 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43117 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753475AbcD0Q63 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:29 -0400
X-AuditID: 1207440d-bb3ff7000000090b-58-5720efb41346
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 1D.8E.02315.4BFE0275; Wed, 27 Apr 2016 12:58:28 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6S022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:26 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLvlvUK4wYll8hbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyru/exFfTxVHRsfcbawPiJs4uRk0NCwESiad4N
	5i5GLg4hga2MEq8WfWeEcI4zSRzsO8YKUsUmoCuxqKeZCcQWEXCQWL7yFztIEbNAE5PE9+VN
	LCAJYQFviTuv14DZLAKqEj9b37GB2LwCURJfXm1ghVgnJ3F5+gOwOKeAhcSX1reMILaQgLnE
	kger2Scw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERJkvDsY/6+T
	OcQowMGoxMNbIKEQLsSaWFZcmXuIUZKDSUmUd8lZoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
	3ulvgHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQles3dAjYJFqemp
	FWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKIgvBsYBSIoHaO+ftyB7iwsSc4GiEK2nGBWl
	xHldQRICIImM0jy4sbDU8YpRHOhLYd4gkO08wLQD1/0KaDAT0ODLh2RBBpckIqSkGoBpxuhH
	+/zmDXKSVxhmb/tyavql1+sk51fXLHgdcn3Jxulpj7/6i34qvlYV9bScvTX3lMzVoHNRfK0n
	sgS+mzuteXJJsUtoXe30yyVdlnsLeH9kp35ik5Et0M7f4yL0LU/F3rW/cfL5G7fk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292767>

It is nonsensical (and a little bit dangerous) to use REF_ISPRUNING
without REF_NODEREF. Forbid it explicitly. Change the one REF_ISPRUNING
caller to pass REF_NODEREF too.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This also makes later patches a bit clearer.

 refs.c               | 3 +++
 refs/files-backend.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index ba14105..5dc2473 100644
--- a/refs.c
+++ b/refs.c
@@ -790,6 +790,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
+	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
+		die("BUG: REF_ISPRUNING set without REF_NODEREF");
+
 	if (new_sha1 && !is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		strbuf_addf(err, "refusing to update ref with bad name '%s'",
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9faf17c..8fcbd7d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2116,7 +2116,7 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, NULL, &err) ||
+				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
-- 
2.8.1
