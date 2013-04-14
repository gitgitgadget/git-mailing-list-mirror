From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/33] repack_without_ref(): silence errors for dangling packed refs
Date: Sun, 14 Apr 2013 14:54:32 +0200
Message-ID: <1365944088-10588-18-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:55:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTH-0004NM-BM
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab3DNMzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:46 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:65523 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751981Ab3DNMzn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:43 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-c3-516aa74e463a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.52.02295.E47AA615; Sun, 14 Apr 2013 08:55:42 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkE007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:41 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqOu3PCvQ4Pg9dYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M6Y3tHHVnBRpOLltpVsDYyHBLoYOTkkBEwkjrUeZoOwxSQu3FsPZHNxCAlcZpRYvqSJ
	EcI5yyRx780ORpAqNgFdiUU9zUxdjBwcIgLZErvXyoOEmQUcJDZ/bgQrERYIkdi3cAIriM0i
	oCqxqmsR2AJeAVeJwzt62CGWKUgc374NrJ4TKD79+TGwuJCAi8SszbNZJzDyLmBkWMUol5hT
	mqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokRElI8Oxi/rZM5xCjAwajEw/uCMStQiDWx
	rLgy9xCjJAeTkijvyWVAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8jq1AOd6UxMqq1KJ8mJQ0
	B4uSOK/qEnU/IYH0xJLU7NTUgtQimKwMB4eSBO9FkKGCRanpqRVpmTklCGkmDk4QwQWygQdo
	w12QQt7igsTc4sx0iKJTjIpS4rxnQRICIImM0jy4AbDof8UoDvSPMEQVDzBxwHW/AhrMBDTY
	Z286yOCSRISUVAMj7+HiqNnXjywStFjbtNN5+oxYrT193lvLTzD5Glx4m8Y647AVd86hhZUp
	ZlkLBQ77nrDetUXD70c618yCafNMPvodMtCU2TmhbDd7+XQfF5NZp69veMwZxfBVTLngd+2H
	8vwNfeFrshx8oz/6rLYV3lN49o7tppUGpheaPXj8upfMmrL6YXeaEktxRqKhFnNR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221106>

Stop emitting an error message for dangling packed references found
when deleting another packed reference.  See the previous commit for a
longer explanation of the issue.

Change repack_without_ref_fn() to silently ignore dangling packed
references.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 17 ++++++++++-------
 t/t3210-pack-refs.sh |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 51f68d3..eadbc2a 100644
--- a/refs.c
+++ b/refs.c
@@ -531,15 +531,17 @@ static void sort_ref_dir(struct ref_dir *dir)
 
 /*
  * Return true iff the reference described by entry can be resolved to
- * an object in the database.  Emit a warning if the referred-to
- * object does not exist.
+ * an object in the database.  If report_errors is true, emit a
+ * warning if the referred-to object does not exist.
  */
-static int ref_resolves_to_object(struct ref_entry *entry)
+static int ref_resolves_to_object(struct ref_entry *entry, int report_errors)
 {
 	if (entry->flag & REF_ISBROKEN)
 		return 0;
 	if (!has_sha1_file(entry->u.value.sha1)) {
-		error("%s does not point to a valid object!", entry->name);
+		if (report_errors)
+			error("%s does not point to a valid object!",
+			      entry->name);
 		return 0;
 	}
 	return 1;
@@ -578,7 +580,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 		return 0;
 
 	if (!((data->flags & DO_FOR_EACH_INCLUDE_BROKEN) ||
-	      ref_resolves_to_object(entry)))
+	      ref_resolves_to_object(entry, 1)))
 		return 0;
 
 	current_ref = entry;
@@ -1897,8 +1899,9 @@ static int repack_without_ref_fn(struct ref_entry *entry, void *cb_data)
 
 	if (!strcmp(data->refname, entry->name))
 		return 0;
-	if (!ref_resolves_to_object(entry))
-		return 0; /* Skip broken refs */
+	/* Silently skip broken refs: */
+	if (!ref_resolves_to_object(entry, 0))
+		return 0;
 	len = snprintf(line, sizeof(line), "%s %s\n",
 		       sha1_to_hex(entry->u.value.sha1), entry->name);
 	/* this should not happen but just being defensive */
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index c032d88..559f602 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -142,7 +142,7 @@ test_expect_success 'delete ref with dangling packed version' '
 	test_cmp /dev/null result
 '
 
-test_expect_failure 'delete ref while another dangling packed ref' '
+test_expect_success 'delete ref while another dangling packed ref' '
 	git branch lamb &&
 	git commit --allow-empty -m "future garbage" &&
 	git pack-refs --all &&
-- 
1.8.2.1
