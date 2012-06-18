From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] sha1_name.c: teach find_short_packed_object() a
 commit-only option
Date: Mon, 18 Jun 2012 15:05:36 -0700
Message-ID: <1340057139-8311-8-git-send-email-gitster@pobox.com>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:06:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk5F-0000AS-Ew
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab2FRWF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:05:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982Ab2FRWFx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6882C97F7
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3b1X
	zxfr8IV84CnKm4iUK8qecFg=; b=gNP3m6HR82Im0jQ4dnYJYe/mk064qJpzKJZY
	1B58XUPS4bLnXwnAcGztJ+ZxCWfigl5u6E8VExDP7zlZQZom32+VBneQIWpQnlng
	8iDMR7b0//pn9lCyaORBm7hQPHgBAF2q1231/3jNQtGRUc3hCiSj5fJssplYeIgz
	uufq+TY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qzXdqA
	cbiz84AZK1mwYz0u/twhy/DN+MM6ADkeUXRR5Rqd8NGBot3qs01eC/FE4jCcGPij
	s2rjxeSDPiVmBUiaTUJIw4LNq1dMDEIH1nOPyJUWnGE2Iac4tam4AFrZJIfAFjE9
	3hfNIRTk0A/zvxv/GZhfUDelqL7h2LfeVXmIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60A6F97F6
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E719097F5 for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:52 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C54FF418-B991-11E1-8628-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200170>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index a283c85..262d7e1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -97,6 +97,7 @@ static int unique_in_pack(int len,
 			  const unsigned char *match,
 			  struct packed_git *p,
 			  const unsigned char **found_sha1,
+			  int commit_only,
 			  int seen_so_far)
 {
 	uint32_t num, last, i, first = 0;
@@ -134,6 +135,8 @@ static int unique_in_pack(int len,
 			break;
 
 		/* current matches */
+		if (commit_only && !is_commit_object(current))
+			continue;
 		if (!seen_so_far) {
 			*found_sha1 = current;
 			seen_so_far++;
@@ -146,7 +149,8 @@ static int unique_in_pack(int len,
 	return seen_so_far;
 }
 
-static int find_short_packed_object(int len, const unsigned char *match, unsigned char *sha1)
+static int find_short_packed_object(int len, const unsigned char *match,
+				    unsigned char *sha1, int commit_only)
 {
 	struct packed_git *p;
 	const unsigned char *found_sha1 = NULL;
@@ -154,7 +158,8 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 
 	prepare_packed_git();
 	for (p = packed_git; p && found < 2; p = p->next)
-		found = unique_in_pack(len, match, p, &found_sha1, found);
+		found = unique_in_pack(len, match, p, &found_sha1,
+				       commit_only, found);
 
 	if (found == 1)
 		hashcpy(sha1, found_sha1);
@@ -172,7 +177,7 @@ static int find_unique_short_object(int len, char *canonical,
 
 	prepare_alt_odb();
 	has_unpacked = find_short_object_filename(len, canonical, unpacked_sha1, 0);
-	has_packed = find_short_packed_object(len, res, packed_sha1);
+	has_packed = find_short_packed_object(len, res, packed_sha1, 0);
 	if (!has_unpacked && !has_packed)
 		return SHORT_NAME_NOT_FOUND;
 	if (1 < has_unpacked || 1 < has_packed)
-- 
1.7.11
