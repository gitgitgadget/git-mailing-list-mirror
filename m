From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 11/25] sha1_name.c: allow get_short_sha1() to take other
 flags
Date: Tue,  3 Jul 2012 14:37:01 -0700
Message-ID: <1341351435-31011-12-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:39:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAoQ-0006e0-3a
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab2GCViP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756526Ab2GCVhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EEB78658
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JZH2
	Ftt6XIWQ1S6ynF5JhLxFR5k=; b=QivtrYIpf1gSxBiM5EL+dkK5vIszbB60jKC7
	Vwxc6uWoVhtUCnZ7UFDL6UOGJYq8xF6WdQFgD7MtuNIcjYUrryEOgN5I6cUGIau0
	T/Ng9jElLlMpiTw7MzjoPOnAPVItAYfVW3aUJrHKsIkTAUu2PLI6LcEu8UmJFY87
	OglKXGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FSdfc5
	EvckpU5jQ42Es6lT4+/v8fMIw5YttzlSYQJjzJb44gG/36zdOTqIJ3Vld/SrlnE5
	9WUnULcrn1GMcO7SVVfbH7Qwx+9BEEMagSARFY2cd+l1pjb+k1X+udWe0XJx+qlN
	b6kVwPu4bkF3euFFUbHJgwlOmW60O6j85ujPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E8D8657
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 082768656 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4FDB5A98-C557-11E1-BCB4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200964>

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
index 2aa9fb6..1bafa45 100644
--- a/cache.h
+++ b/cache.h
@@ -811,6 +811,8 @@ struct object_context {
 	unsigned mode;
 };
 
+#define GET_SHA1_QUIETLY 01
+
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
 extern int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc);
diff --git a/sha1_name.c b/sha1_name.c
index c824bdd..793d80c 100644
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
1.7.11.1.229.g706c98f
