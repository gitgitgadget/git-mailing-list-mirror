From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/33] peel_ref(): use function get_packed_ref()
Date: Mon, 22 Apr 2013 21:52:16 +0200
Message-ID: <1366660361-21831-9-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:53:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoA-0004ng-F9
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab3DVTxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:41 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:49128 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755107Ab3DVTxk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:40 -0400
X-AuditID: 12074411-b7f286d0000008e8-f3-51759543a261
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9D.6A.02280.34595715; Mon, 22 Apr 2013 15:53:39 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOL008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:38 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqOs8tTTQ4HWHkEXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfM6Uws2MRa8f3ifZYGxkUs
	XYycHBICJhI7r/1mhrDFJC7cW88GYgsJXGaUmLcmv4uRC8i+wCRx5NBZVpAEm4CuxKKeZiYQ
	W0RATWJi2yGwQcwCDhKbPzcygtjCAs4Sp3euAqtnEVCV+LXpCTuIzSvgInHt8G9GiGUKEse3
	bwOzOQVcJU53nGCBWOwiseLgVJYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6uVm
	luilppRuYoQEiuAOxhkn5Q4xCnAwKvHwCriXBgqxJpYVV+YeYpTkYFIS5eWYAhTiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwiuaD5TjTUmsrEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwZoAMFSxKTU+tSMvMKUFIM3FwgggukA08QBsiQQp5iwsSc4sz0yGKTjEqSonzVk8C
	SgiAJDJK8+AGwGL6FaM40D/CvB4g7TzAdADX/QpoMBPQ4MyEEpDBJYkIKakGxhVKjUZXl33M
	190Qc2D/RYbwXfPmdGjom61xfBd84M03+dabMjta5KrtP3dbepQYNV7XsA7p2HX5zA0zxwUq
	G+VvN7nlmh+YLjLrotf+V6kfFh5pjGg/9Ngq0Vvc5d9W/srS6Qtcd6nu7/setu30jMPsV049
	WeOaXlOwsFNAkPvGjHMJBvn8h5RYijMSDbWYi4oTAe0ciEbEAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222054>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 91a2940..09b68e4 100644
--- a/refs.c
+++ b/refs.c
@@ -1282,10 +1282,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = find_ref(dir, refname);
+		struct ref_entry *r = get_packed_ref(refname);
 
-		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
+		if (r && (r->flag & REF_KNOWS_PEELED)) {
 			hashcpy(sha1, r->u.value.peeled);
 			return 0;
 		}
-- 
1.8.2.1
