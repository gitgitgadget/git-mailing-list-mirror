From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/5] notes: fix handling of colon-separated values
Date: Sun,  4 Nov 2012 08:07:09 +0100
Message-ID: <1352012830-13591-5-git-send-email-mhagger@alum.mit.edu>
References: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:08:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUuJK-0001EE-PM
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 08:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab2KDHHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 02:07:38 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:47086 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752004Ab2KDHHg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 02:07:36 -0500
X-AuditID: 1207440d-b7f236d000000943-df-509614379f1a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.09.02371.73416905; Sun,  4 Nov 2012 02:07:35 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA477Hw7028486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 02:07:34 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqGsuMi3AoG+1mUXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE74+rre4wF
	H9krXu7laWA8zNbFyMkhIWAiceTDFEYIW0ziwr31QHEuDiGBy4wSM5oWM0M4Z5gkbjxYyg5S
	xSagK7Gop5kJxBYRkJX4fngjWDezQK7E4ne3gWo4OIQFnCRafhuChFkEVCV27d/PDBLmFXCR
	+LSDB2KXnMSHPY/AJnIKuEpsuNLGAlIiBFTS+bZ+AiPvAkaGVYxyiTmlubq5iZk5xanJusXJ
	iXl5qUW6Rnq5mSV6qSmlmxghgcO7g/H/OplDjAIcjEo8vD9XTA0QYk0sK67MPcQoycGkJMrr
	KTAtQIgvKT+lMiOxOCO+qDQntfgQowQHs5II75bPQOW8KYmVValF+TApaQ4WJXFetSXqfkIC
	6YklqdmpqQWpRTBZGQ4OJQneVcJAQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB
	MRFfDIwKkBQP0N4KkHbe4oLEXKAoROspRl2Oo2/mPmQUYsnLz0uVEuc1AikSACnKKM2DWwFL
	E68YxYE+FuYtB6niAaYYuEmvgJYwAS3ZfmkKyJKSRISUVAOjyDkG+5+r9r4S/XrZS7Go/XbW
	hBkvpYKPH3tUNFlJYo3x8zuObPvqurfNWH3moqVA0veftyK/MXw577Bkj4Vr/LxH7c9t/DZ0
	TBGfxe/m8qnj+KkNbeKcSraBdoqx7p85j5g51/IpdV0Lq8lb4xxfW9f/ldNLV7na 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209017>

The substrings output by strbuf_split() include the ':' delimiters.
When processing GIT_NOTES_DISPLAY_REF and GIT_NOTES_REWRITE_REF, strip
off the delimiter character *before* checking whether the substring is
empty rather than after, so that empty strings within the list are
also skipped.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes.c b/notes.c
index 62f8f6f..63b2a09 100644
--- a/notes.c
+++ b/notes.c
@@ -951,10 +951,10 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	split = strbuf_split(&globbuf, ':');
 
 	for (i = 0; split[i]; i++) {
+		if (split[i]->len && split[i]->buf[split[i]->len-1] == ':')
+			strbuf_setlen(split[i], split[i]->len-1);
 		if (!split[i]->len)
 			continue;
-		if (split[i]->buf[split[i]->len-1] == ':')
-			strbuf_setlen(split[i], split[i]->len-1);
 		string_list_add_refs_by_glob(list, split[i]->buf);
 	}
 
-- 
1.8.0
