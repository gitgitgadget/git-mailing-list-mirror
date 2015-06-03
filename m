From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/4] read_loose_refs(): simplify function logic
Date: Wed,  3 Jun 2015 15:51:58 +0200
Message-ID: <ab21b4940709f6cfe11a663e4fa4e342e4f1ca41.1433339279.git.mhagger@alum.mit.edu>
References: <cover.1433339279.git.mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 15:52:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z095l-0005nx-0h
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 15:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbbFCNwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 09:52:17 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63180 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755169AbbFCNwK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 09:52:10 -0400
X-AuditID: 1207440d-f79026d000000bad-03-556f0688b595
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DE.F3.02989.8860F655; Wed,  3 Jun 2015 09:52:08 -0400 (EDT)
Received: from michael.fritz.box (p4FC96DFC.dip0.t-ipconnect.de [79.201.109.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t53Dq153005566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Jun 2015 09:52:07 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433339279.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqNvBlh9q0L5RxuJMX7hF15VuJouG
	3ivMFrdXzGe2+NHSw2yxeXM7iwObx9/3H5g8Fmwq9Wg6c5TZ41nvHkaPi5eUPT5vkgtgi+K2
	SUosKQvOTM/Tt0vgzpj4+wxrwWmuik2T7rI1ML5m72Lk5JAQMJHY1r+FCcIWk7hwbz1bFyMX
	h5DAZUaJFZ9nQTknmCS+nnjMAlLFJqArsainGaxDREBNYmLbIbA4s8BmRonOh0FdjBwcwgJO
	Epf/1oOEWQRUJS5fmABWwisQJbFq2xOoxXIS54//ZAYp5xSwkNhzQxvEFBIwlzh/Un4CI+8C
	RoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCHhxbuD8f86mUOMAhyMSjy8
	DmF5oUKsiWXFlbmHGCU5mJREedd8AQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4X35DijHm5JY
	WZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgbWXNDxUSLEpNT61Iy8wpQUgz
	cXCCDOeSEilOzUtJLUosLcmIB0VFfDEwLkBSPEB740DaeYsLEnOBohCtpxgVpcR5Z4AkBEAS
	GaV5cGNhSeMVozjQl8K8S0CqeIAJB677FdBgJqDB7QI5IINLEhFSUg2MLYyCYTN2+k3ivPOq
	q+D6rnXcAdfPzHrsxpa6ptX83upfFxUSFdQFvgspfdzIs61kZo7l07o5ZXaRVvapwY5FkX/2
	d7wXP2x5Ysfi5cqqj8K4jGckXntV2BMpt3bGDeufaccYU/ac72co7H+5Zp1n58nM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270687>

Make it clearer that there are two possible ways to read the
reference, but that we handle read errors uniformly regardless of
which way it was read.

This refactoring also makes the following change easier to implement.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 47e4e53..6736424 100644
--- a/refs.c
+++ b/refs.c
@@ -1308,19 +1308,24 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					 create_dir_entry(refs, refname.buf,
 							  refname.len, 1));
 		} else {
+			int read_ok;
+
 			if (*refs->name) {
 				hashclr(sha1);
 				flag = 0;
-				if (resolve_gitlink_ref(refs->name, refname.buf, sha1) < 0) {
-					hashclr(sha1);
-					flag |= REF_ISBROKEN;
-				}
-			} else if (read_ref_full(refname.buf,
-						 RESOLVE_REF_READING,
-						 sha1, &flag)) {
+				read_ok = !resolve_gitlink_ref(refs->name,
+							       refname.buf, sha1);
+			} else {
+				read_ok = !read_ref_full(refname.buf,
+							 RESOLVE_REF_READING,
+							 sha1, &flag);
+			}
+
+			if (!read_ok) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
+
 			if (check_refname_format(refname.buf,
 						 REFNAME_ALLOW_ONELEVEL)) {
 				hashclr(sha1);
-- 
2.1.4
