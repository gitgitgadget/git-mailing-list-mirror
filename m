From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 28/33] refs: inline function do_not_prune()
Date: Sun, 14 Apr 2013 14:54:43 +0200
Message-ID: <1365944088-10588-29-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTY-0004hh-8l
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab3DNM4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:04 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:53354 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752074Ab3DNM4B (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:56:01 -0400
X-AuditID: 12074413-b7f226d000000902-57-516aa760f5e5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 71.E6.02306.067AA615; Sun, 14 Apr 2013 08:56:00 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkP007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:59 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqJuwPCvQ4NMJTYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M5o33+XrWACV0XTtKOMDYxTOLoYOTkkBEwkTs1uYYKwxSQu3FvP1sXIxSEkcJlRYuaO
	GYwQzlkmiS9PulhBqtgEdCUW9TQDdXBwiAhkS+xeKw8SZhZwkNj8uZERJCwsYC1x4Eg9SJhF
	QFXiTvsHsE5eAVeJH1v2sUDsUpA4vn0bI4jNCRSf/vwYO4gtJOAiMWvzbNYJjLwLGBlWMcol
	5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoQElPAOxl0n5Q4xCnAwKvHwvmDMChRi
	TSwrrsw9xCjJwaQkyqu4DCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhNexFSjHm5JYWZValA+T
	kuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgfb0UqFGwKDU9tSItM6cEIc3EwQkiuEA2
	8ABteAtSyFtckJhbnJkOUXSKUVFKnPcjSEIAJJFRmgc3ABb7rxjFgf4R5n0KUsUDTBtw3a+A
	BjMBDfbZmw4yuCQRISXVwLja4ZHQ5oyUbd0FU7N33/vhGd3qmfg3Rb/Mil0tq/u9Z/XJJVte
	LP3H5Nu4n2s958Y/LkduCa5+Oe2dldDmRyUV8ba5uzpfLMzbxL9eXkpuj5cP5z4r/n1J+xYf
	5Hh6PXZ5PmNq1cUfG38/4utLKdbJeh12WYx9U6SeSUNywSMl/wuv3ih9n6nEUpyR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221113>

Function do_not_prune() was redundantly checking REF_ISSYMREF, which
was already tested at the top of pack_one_ref(), so remove that check.
And the rest was trivial, so inline the function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 471d71d..e1b8a56 100644
--- a/refs.c
+++ b/refs.c
@@ -1993,14 +1993,6 @@ struct pack_refs_cb_data {
 	FILE *refs_file;
 };
 
-static int do_not_prune(int flags)
-{
-	/* If it is already packed or if it is a symref,
-	 * do not prune it.
-	 */
-	return (flags & (REF_ISSYMREF|REF_ISPACKED));
-}
-
 static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
@@ -2028,7 +2020,8 @@ static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 				sha1_to_hex(o->sha1));
 	}
 
-	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(entry->flag)) {
+	/* If the ref was already packed, there is no need to prune it. */
+	if ((cb->flags & PACK_REFS_PRUNE) && !(entry->flag & REF_ISPACKED)) {
 		int namelen = strlen(entry->name) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
 		hashcpy(n->sha1, entry->u.value.sha1);
-- 
1.8.2.1
