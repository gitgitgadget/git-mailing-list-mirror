From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 10/18] sha1_name.c: allow get_short_sha1() to take other
 flags
Date: Mon,  2 Jul 2012 15:34:01 -0700
Message-ID: <1341268449-27801-11-git-send-email-gitster@pobox.com>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:35:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpD1-0003YV-OV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933146Ab2GBWez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:34:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756332Ab2GBWec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 308B29086
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oMkX
	OR1Ay3eYZqiAnAQ8ZA9WWDc=; b=Rh1fEgcThz69trFfrAIwcJLlGOTjXQQvF3rf
	+f60/eYOtTjdb8gchLEnXiXVrt+O6tcslV79J0NwyMA8VdVajmh5DR8HK/oLJ9hc
	alwaSxrPYaPdtxwKT3gIB12I5PRul6faYiyYBA8NmvVewYnCbSPiCCsmd1Yy3IzO
	O5i03hI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=uxxbsj
	3isYSE5sMqi99lkPnCxgR0Fn+KNbesoYdc0/bCOA61bd8Oi5E4ob3h6/qaxxGo+Z
	Ei8lpsB3fk2eG47LHIBWkCn8g9X4JZB41rSyMz+vhrBzpaR/zqhpwx7v+C8I6i4x
	PtTYga5QCEXLgA7Zpc9VVL6TL3R9alQBHKMvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2873F9085
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A51A19084 for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 17898532-C496-11E1-A733-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200872>

Instead of a separate "int quietly" argument, make it take "unsigned
flags" so that we can pass other options to it.

The bit assignment of this flag word is exposed in cache.h because
the mechanism will be exposed to callers of the higher layer in
later commits in this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     | 2 ++
 sha1_name.c | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 3066b03..fd5b7f6 100644
--- a/cache.h
+++ b/cache.h
@@ -811,6 +811,8 @@ struct object_context {
 	unsigned mode;
 };
 
+#define GET_SHA1_QUIETLY 01
+
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern void die_on_misspelt_object_name(const char *name, const char *prefix);
 extern int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc);
diff --git a/sha1_name.c b/sha1_name.c
index 6c585e3..01cce9f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -219,12 +219,13 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 }
 
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
-			  int quietly)
+			  unsigned flags)
 {
 	int i, status;
 	char hex_pfx[40];
 	unsigned char bin_pfx[20];
 	struct disambiguate_state ds;
+	int quietly = !!(flags & GET_SHA1_QUIETLY);
 
 	if (len < MINIMUM_ABBREV || len > 40)
 		return -1;
@@ -272,7 +273,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
-		status = get_short_sha1(hex, len, sha1_ret, 1);
+		status = get_short_sha1(hex, len, sha1_ret, GET_SHA1_QUIETLY);
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
@@ -603,7 +604,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_sha1(cp, len, sha1, 1);
+				return get_short_sha1(cp, len, sha1, GET_SHA1_QUIETLY);
 			}
 		}
 	}
-- 
1.7.11.1.212.g52fe12e
