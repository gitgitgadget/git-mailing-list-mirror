From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] diffcore-pickaxe: optimize by trimming common initial
 and trailing parts
Date: Wed, 25 Feb 2009 22:52:06 -0800
Message-ID: <30c0d4d9b64924679c9af00796f7e0b562020ddf.1235629933.git.gitster@pobox.com>
References: <cover.1235629933.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 07:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lca85-0006C2-CX
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 07:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbZBZGw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 01:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbZBZGwY
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 01:52:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbZBZGwX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 01:52:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D8BD71267
	for <git@vger.kernel.org>; Fri, 27 Feb 2009 01:52:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 33BFD1266 for
 <git@vger.kernel.org>; Fri, 27 Feb 2009 01:52:20 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.91.gf9a36
In-Reply-To: <cover.1235629933.git.gitster@pobox.com>
X-Pobox-Relay-ID: 2E2C4284-049B-11DE-BB43-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111530>

We can optimize the pickaxe search by removing the lines at the beginning
and at the end that are common between the preimage and the postimage, and
counting the occurrences of the "needle" in the haystack that is now made
smaller.

One thing that we need to be careful about is that we should not remove
the common part in full.  We need to keep at least the same length as the
"needle" from the common part, so that we can detect the differences in a
case like this:

  preimage: common part then needle appears in this file
 postimage: common part then needlX appears in this file

If we literally remove the common leading part up to "needl" and start
counting from the byte after that, we will miss that preimage has an
occurrence of "needle" but postimage does not.

With this optimization in place, the following query in the Linux kernel
repository on my machine becomes about 40% faster:

$ STRING='Ensure that the real time constraints are schedulable.'
$ git log -S"$STRING" HEAD -- kernel/sched.c >/dev/null

(Before the patch, best of 5 runs)
5.59user 0.15system 0:05.74elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+39956minor)pagefaults 0swaps

(After the patch, best of 5 runs)
3.04user 0.17system 0:03.23elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+49697minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 4a0dca1..b447d75 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -68,9 +68,59 @@ static int has_different_matches(struct diff_filepair *p,
 				 const char *needle, unsigned long len,
 				 regex_t *regexp)
 {
-	return (count_match(0, p->one, needle, len, regexp)
-		!= count_match(0, p->two, needle, len, regexp));
+	const char *one, *two;
+	unsigned long one_size, two_size, common, trim;
+	int differs;
 
+	if (regexp)
+		return (count_match(0, p->one, needle, len, regexp)
+			!= count_match(0, p->two, needle, len, regexp));
+	if (diff_populate_filespec(p->one, 0) ||
+	    diff_populate_filespec(p->two, 0))
+		return 0;
+
+	one = p->one->data;
+	two = p->two->data;
+	one_size = p->one->size;
+	two_size = p->two->size;
+	common = (one_size < two_size) ? one_size : two_size;
+
+	/* Skip the initial common part */
+	for (trim = 0;
+	     trim < common && one[trim] == two[trim];
+	     trim++)
+		;
+
+	/* Start comparing at (len-1) bytes before the first difference */
+	if (len <= trim) {
+		trim -= len;
+		one += trim;
+		two += trim;
+		common -= trim;
+		one_size -= trim;
+		two_size -= trim;
+	}
+
+	/* Trim the common part at the end */
+	for (trim = 0;
+	     trim < common && one[one_size - trim - 1] == two[two_size - trim - 1];
+	     trim++)
+		;
+
+	/* Leave (len-1) bytes */
+	if (len <= trim) {
+		trim -= len;
+		one_size -= trim;
+		two_size -= trim;
+	}
+
+	differs = (count_match_internal(0, one, one_size, needle, len, regexp) !=
+		   count_match_internal(0, two, two_size, needle, len, regexp));
+
+	diff_free_filespec_data(p->one);
+	diff_free_filespec_data(p->two);
+
+	return differs;
 }
 
 static int pickaxe_match_one(struct diff_filepair *p,
-- 
1.6.2.rc2.91.gf9a36
