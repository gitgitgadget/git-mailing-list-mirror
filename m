From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 21/21] show_head_ref(): check the result of resolve_ref_namespace()
Date: Wed, 23 Mar 2016 11:04:38 +0100
Message-ID: <fad78ec03e73aa60ddac12b1f738b7180efcfeff.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:06:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiffM-0002rw-VI
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbcCWKFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:05:25 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49356 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754610AbcCWKFU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:05:20 -0400
X-AuditID: 1207440f-d9fff70000007e44-21-56f26a5f49ae
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 99.C5.32324.F5A62F65; Wed, 23 Mar 2016 06:05:20 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1Q018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:18 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqJuQ9SnMoOE1m0XXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zxcyr1g5sHn/ff2Dy2DnrLrvHs949jB4XLyl77F+6jc3j8ya5ALYo
	bpukxJKy4Mz0PH27BO6Mi10zWAoWsVV8eTWZqYGxm7WLkYNDQsBEonm3ZxcjF4eQwFZGif1/
	prBAOCeZJH78ec/UxcjJwSagK7GopxnMFhFQk5jYdgisiFlgAaPExsWLmUESwgLBEjfvv2EG
	mcoioCrRNVcNJMwrECXROWknG4gtIaAkseHBBbA5nAIWEidPLmUEsYUEzCW2P1jLNIGRZwEj
	wypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2MkGDi38HYtV7mEKMAB6MSD2/h
	uY9hQqyJZcWVuYcYJTmYlER5zwd9ChPiS8pPqcxILM6ILyrNSS0+xCjBwawkwnssEyjHm5JY
	WZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQWgSTleHgUJLgfQPSKFiUmp5akZaZU4KQZuLg
	BBnOJSVSnJqXklqUWFqSEQ+KgPhiYAyApHiA9h4C21tckJgLFIVoPcWoy7Hgx+21TEIsefl5
	qVLivN4gRQIgRRmleXArYKnjFaM40MfCvDsygKp4gGkHbtIroCVMQEsW+oAtKUlESEk1MM5U
	XMPF2x54ZlGr/vbUnze3zotNtJl4XeSFajb3uU+zV7heiY/Yem32pdviGz4cX7PN/B73+dus
	25xjjsrZqBb//tqSPDH/dkCTddjeBaFc526qWQmp3d2zYeWVZwZHJT9zHD9x14Cb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289614>

Only use the result of resolve_ref_namespace() if it is non-NULL.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 http-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 8870a26..2148814 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -484,9 +484,9 @@ static int show_head_ref(const char *refname, const struct object_id *oid,
 		const char *target = resolve_ref_unsafe(refname,
 							RESOLVE_REF_READING,
 							unused.hash, NULL);
-		const char *target_nons = strip_namespace(target);
 
-		strbuf_addf(buf, "ref: %s\n", target_nons);
+		if (target)
+			strbuf_addf(buf, "ref: %s\n", strip_namespace(target));
 	} else {
 		strbuf_addf(buf, "%s\n", oid_to_hex(oid));
 	}
-- 
2.8.0.rc3
