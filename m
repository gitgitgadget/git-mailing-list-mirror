From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 03/18] sha1_name.c: get rid of ugly get_sha1_with_mode_1()
Date: Mon,  2 Jul 2012 15:33:54 -0700
Message-ID: <1341268449-27801-4-git-send-email-gitster@pobox.com>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:36:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpDp-00052K-2Q
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab2GBWet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:34:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756061Ab2GBWeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 718F1906F
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=45Hr
	NvrEqeIg0tZ7TrQYmCdnZOU=; b=W9RTXogWQDOas9ruFzKGokw7UWR99WPOS1WO
	OxB7Yvgo5475LBhdiyo2c441Y3OngxnBHsiSzQHSAAo7P52SLN75WqS0wbRHbpld
	Jp5rN6sftz5THkA+STPtVkQO9dXHsTC2zAwRkcjfZbVEyNotJJpNq+vqQYzK4vMz
	1ZFbxp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FnrDne
	oIUeEhivAuZioY4eE3m2rEV2KpXNZ8DJaEF7ITsifMUnIxSrDzAl1hAZqVsgWBIF
	jtrua2Dh76Tm3cH8YixkUG2T6Hw5QBE+33YPmH9E9VHo8QM+3JURoyPnerrU3lPq
	4ELPOipkHc6j8DplGqSeXxfhgd/MPMvcdoO/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65F24906E
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 794D1906B for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0E7D69E0-C496-11E1-9FDA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200885>

The only external caller is setup.c that tries to give a nicer error
message when an object name is misspelt (e.g. "HEAD:cashe.h").
Retire it and give the caller a dedicated and more intuitive API
function die_on_misspelt_object_name().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |  7 ++-----
 setup.c     |  8 ++------
 sha1_name.c | 20 ++++++++++++++++----
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 9ee470c..2200110 100644
--- a/cache.h
+++ b/cache.h
@@ -812,11 +812,8 @@ struct object_context {
 };
 
 extern int get_sha1(const char *str, unsigned char *sha1);
-extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int only_to_die, const char *prefix);
-static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
-{
-	return get_sha1_with_mode_1(str, sha1, mode, 0, NULL);
-}
+extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
+extern void die_on_misspelt_object_name(const char *name, const char *prefix);
 extern int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc);
 
 /*
diff --git a/setup.c b/setup.c
index 61c22e6..979a26b 100644
--- a/setup.c
+++ b/setup.c
@@ -55,18 +55,14 @@ int check_filename(const char *prefix, const char *arg)
 
 static void NORETURN die_verify_filename(const char *prefix, const char *arg)
 {
-	unsigned char sha1[20];
-	unsigned mode;
-
 	/*
 	 * Saying "'(icase)foo' does not exist in the index" when the
 	 * user gave us ":(icase)foo" is just stupid.  A magic pathspec
 	 * begins with a colon and is followed by a non-alnum; do not
-	 * let get_sha1_with_mode_1(only_to_die=1) to even trigger.
+	 * let die_on_misspelt_object_name() even trigger.
 	 */
 	if (!(arg[0] == ':' && !isalnum(arg[1])))
-		/* try a detailed diagnostic ... */
-		get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
+		die_on_misspelt_object_name(arg, prefix);
 
 	/* ... or fall back the most general message. */
 	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
diff --git a/sha1_name.c b/sha1_name.c
index 10932bf..01ed48b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1125,12 +1125,24 @@ static int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 	return ret;
 }
 
-int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
-			 int only_to_die, const char *prefix)
+/*
+ * Call this function when you know "name" given by the end user must
+ * name an object but it doesn't; the function _may_ die with a better
+ * diagnostic message than "no such object 'name'", e.g. "Path 'doc' does not
+ * exist in 'HEAD'" when given "HEAD:doc", or it may return in which case
+ * you have a chance to diagnose the error further.
+ */
+void die_on_misspelt_object_name(const char *name, const char *prefix)
 {
 	struct object_context oc;
-	int ret;
-	ret = get_sha1_with_context_1(name, sha1, &oc, only_to_die, prefix);
+	unsigned char sha1[20];
+	get_sha1_with_context_1(name, sha1, &oc, 1, prefix);
+}
+
+int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
+{
+	struct object_context oc;
+	int ret = get_sha1_with_context_1(str, sha1, &oc, 0, NULL);
 	*mode = oc.mode;
 	return ret;
 }
-- 
1.7.11.1.212.g52fe12e
