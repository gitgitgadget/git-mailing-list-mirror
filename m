From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/9] sha1_name.c: allow get_short_sha1() to take other
 flags
Date: Sat, 23 Jun 2012 17:11:29 -0700
Message-ID: <1340496691-12258-8-git-send-email-gitster@pobox.com>
References: <1340496691-12258-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 02:12:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiaRV-0001fP-GN
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 02:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730Ab2FXAMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 20:12:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756601Ab2FXALr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 20:11:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A25A8F34
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=A7oM
	xjPDAL4P2pC3mlgaAQ4mgRs=; b=Wj9fGr/Hn8LK4b3LTOjDQc9EXpzdUa/OKveC
	JLkB/YToxe26COCs1ylZKWytzcdu9DatMDP7Uwf7TGBjRRPvveB0jEA6ifOoB7sC
	nJZRQRLAhZdEOg8dUOt/OI4HnfUvw9/hx4okLcmpF2cSf7f95+umhpF6fwNWRlUE
	1g870eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Ai3JPY
	oKYCX3QmBhabp6AHJ6diQE1AMjuDdrLqaIQ7zZKmHBBUkx3Q1avN0tbJoS1SfatC
	ef9tf+szuZ1Xl7bYawfe8/CXLHhpeLTZNH4yvHH1c8lkv3ibXoG5ADy3HR5K5JOX
	uHPBXJojX08mIAfg/g4Mdzl1BkBqGw+vZ2gcQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D2738F33
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5FA68F31 for
 <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
In-Reply-To: <1340496691-12258-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2FCAC3BA-BD91-11E1-BE2D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200511>

Instead of a separate "int quietly" argument, make it take "unsigned flags"
so that we can pass other options to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 852d5c2..7cca7d9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -218,13 +218,16 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
+#define GET_SHORT_QUIETLY 01
+
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
-			  int quietly)
+			  unsigned flags)
 {
 	int i, status;
 	char hex_pfx[40];
 	unsigned char bin_pfx[20];
 	struct disambiguate_state ds;
+	int quietly = !!(flags & GET_SHORT_QUIETLY);
 
 	if (len < MINIMUM_ABBREV || len > 40)
 		return -1;
@@ -272,7 +275,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
-		status = get_short_sha1(hex, len, sha1_ret, 1);
+		status = get_short_sha1(hex, len, sha1_ret, GET_SHORT_QUIETLY);
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
@@ -603,7 +606,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_sha1(cp, len, sha1, 1);
+				return get_short_sha1(cp, len, sha1, GET_SHORT_QUIETLY);
 			}
 		}
 	}
-- 
1.7.11.1.29.gf71be5c
