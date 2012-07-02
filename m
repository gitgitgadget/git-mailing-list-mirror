From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/18] sha1_name.c: hide get_sha1_with_context_1()
 ugliness
Date: Mon,  2 Jul 2012 15:33:53 -0700
Message-ID: <1341268449-27801-3-git-send-email-gitster@pobox.com>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:36:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpDo-00052K-ID
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361Ab2GBWes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:34:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab2GBWeP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 416509068
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Z5y/
	v4KNxK6j0igCwb6KLxuGpNo=; b=RX34sHqU8wMusKolAmEkJK2NN01Vq66A3jsE
	H99NFP0ufQTqyddjsi+vDdWt5TG4OYC0aFMuSwUp7hzLFAGlQE4HA1xk/d2sDPc7
	Oxr2BMJIn7Sfsh+sTEF/icAOq8MKDbd4wqd6tewI/mfp7mfRRFalIfg+mVqS03j6
	IDeTIQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=aM1QSI
	IUKa+oYELDQrlbEWZrPW1fRjXLGmi8MOTrW9OLEWK3scVrqjCkHMn0i+de7ggzjj
	E/cokRGej0WPtlpnbY3dk47LlNAsT62fxVl4iTQvZ9hu8VCyuXAW9cwh1bskdOhs
	N1+Nc7ECx5MSBDVESjhPTNp33JxsX5/d2izXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E8199067
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8498D9066 for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0D533BA8-C496-11E1-8B36-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200886>

There is no outside caller that cares about the "only-to-die" ugliness.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |  6 +-----
 sha1_name.c | 31 ++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 10afd71..9ee470c 100644
--- a/cache.h
+++ b/cache.h
@@ -817,11 +817,7 @@ static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsig
 {
 	return get_sha1_with_mode_1(str, sha1, mode, 0, NULL);
 }
-extern int get_sha1_with_context_1(const char *name, unsigned char *sha1, struct object_context *orc, int only_to_die, const char *prefix);
-static inline int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc)
-{
-	return get_sha1_with_context_1(str, sha1, orc, 0, NULL);
-}
+extern int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc);
 
 /*
  * Try to read a SHA1 in hexadecimal format from the 40 characters
diff --git a/sha1_name.c b/sha1_name.c
index 5b0c845..10932bf 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -992,16 +992,6 @@ static void diagnose_invalid_index_path(int stage,
 }
 
 
-int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
-			 int only_to_die, const char *prefix)
-{
-	struct object_context oc;
-	int ret;
-	ret = get_sha1_with_context_1(name, sha1, &oc, only_to_die, prefix);
-	*mode = oc.mode;
-	return ret;
-}
-
 static char *resolve_relative_path(const char *rel)
 {
 	if (prefixcmp(rel, "./") && prefixcmp(rel, "../"))
@@ -1019,9 +1009,9 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
-int get_sha1_with_context_1(const char *name, unsigned char *sha1,
-			    struct object_context *oc,
-			    int only_to_die, const char *prefix)
+static int get_sha1_with_context_1(const char *name, unsigned char *sha1,
+				   struct object_context *oc,
+				   int only_to_die, const char *prefix)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
@@ -1134,3 +1124,18 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 	}
 	return ret;
 }
+
+int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
+			 int only_to_die, const char *prefix)
+{
+	struct object_context oc;
+	int ret;
+	ret = get_sha1_with_context_1(name, sha1, &oc, only_to_die, prefix);
+	*mode = oc.mode;
+	return ret;
+}
+
+int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc)
+{
+	return get_sha1_with_context_1(str, sha1, orc, 0, NULL);
+}
-- 
1.7.11.1.212.g52fe12e
