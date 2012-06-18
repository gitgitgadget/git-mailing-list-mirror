From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] sha1_name.c: allow get_short_sha1() to take other flags
Date: Mon, 18 Jun 2012 15:05:37 -0700
Message-ID: <1340057139-8311-9-git-send-email-gitster@pobox.com>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:07:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk6z-00042y-N3
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab2FRWGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:06:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283Ab2FRWF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A970F97FB
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dLU0
	nMzVWeyyBhMM5/pNDx2jx3c=; b=dZ+1jl9Op+vd8V27eo4yvlH/SdgaFvKsiGP7
	yD9S3iNGT1iEhHXl6JnhLRWb1gp+XRgHIWCm4OU2DBpZ8oANwpZmxg1XOdb2gNuB
	2ci97LA1JnDHeYK5qIIWj3CmaI4x5VOO0pERNeuPsTM2InJttms/s7+SN4HcadPk
	BfXJ5jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hhr+tf
	QZZZdmu6wU8Riqh3yMdHtY7TBKfnpPmF6LpvbCd25L/F/EPCDgoSTConZDbFqsRI
	+aA3VfvgJ3LZ339JMxE18Nq9kcfx0toPbAberAsqb36iGw4qPo8T1MjLylqjcPzq
	Jcjl/m6y99aQbuC+NBwYmCg+24qZEAbZuj/1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A24E997FA
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A705E97F9 for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C658E28E-B991-11E1-A7A4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200172>

Instead of a separate "int quietly" argument, make it take "unsigned flags"
so that we can pass other options to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 262d7e1..df11ded 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -193,12 +193,15 @@ static int find_unique_short_object(int len, char *canonical,
 	return 0;
 }
 
+#define GET_SHORT_QUIETLY 01
+
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
-			  int quietly)
+			  unsigned flags)
 {
 	int i, status;
 	char canonical[40];
 	unsigned char res[20];
+	int quietly = !!(flags & GET_SHORT_QUIETLY);
 
 	if (len < MINIMUM_ABBREV || len > 40)
 		return -1;
@@ -240,7 +243,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
-		status = get_short_sha1(hex, len, sha1_ret, 1);
+		status = get_short_sha1(hex, len, sha1_ret, GET_SHORT_QUIETLY);
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
@@ -571,7 +574,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_sha1(cp, len, sha1, 1);
+				return get_short_sha1(cp, len, sha1, GET_SHORT_QUIETLY);
 			}
 		}
 	}
-- 
1.7.11
