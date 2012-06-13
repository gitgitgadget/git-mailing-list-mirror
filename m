From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/19] apply: move check_to_create_blob() closer to its
 sole caller
Date: Wed, 13 Jun 2012 12:32:50 -0700
Message-ID: <1339615980-19727-10-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:34:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetKU-0001oS-8C
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab2FMTeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:34:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773Ab2FMTdU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCE058714
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GfGC
	XUyilUmkMYvX7Gf0yXld4hw=; b=tbFL1J+uaDGIeGDA3fRFZVHaT/WuQQkcM5Z9
	eSldV6oM0S6G14zDOowJJGYvYiaVnb22iUIEFTZM/gfR24dldd+HSBKkQcFhKc9u
	B65o7CL3hyLhXTTAPuBfwbn23o5vJPPgzzGsYSltJnm6NA6UL3aXSaIVAwxIB4Xk
	rfsRE+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=nQT9jt
	f+DRwVzK7i+UjIH3Z5uFCiu9S0btW4lJltDtqV012WzAS5hcVjoOCHWZnSntffBt
	P5yONvIe0glqWa8MclV22qgf0pd2ohnCzzkQ31kEeyS7ZUicBGYqVTSg145uEppt
	0JD5vJVdMylyomRR1SaXsUo/CLBYySUjC0fsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3FAA8713
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6153A8712 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A14E648E-B58E-11E1-9EB7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199935>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 35e9a9c..6431178 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3159,29 +3159,6 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	return 0;
 }
 
-static int check_to_create_blob(const char *new_name, int ok_if_exists)
-{
-	struct stat nst;
-	if (!lstat(new_name, &nst)) {
-		if (S_ISDIR(nst.st_mode) || ok_if_exists)
-			return 0;
-		/*
-		 * A leading component of new_name might be a symlink
-		 * that is going to be removed with this patch, but
-		 * still pointing at somewhere that has the path.
-		 * In such a case, path "new_name" does not exist as
-		 * far as git is concerned.
-		 */
-		if (has_symlink_leading_path(new_name, strlen(new_name)))
-			return 0;
-
-		return error(_("%s: already exists in working directory"), new_name);
-	}
-	else if ((errno != ENOENT) && (errno != ENOTDIR))
-		return error("%s: %s", new_name, strerror(errno));
-	return 0;
-}
-
 static int verify_index_match(struct cache_entry *ce, struct stat *st)
 {
 	if (S_ISGITLINK(ce->ce_mode)) {
@@ -3266,6 +3243,29 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	return 0;
 }
 
+static int check_to_create_blob(const char *new_name, int ok_if_exists)
+{
+	struct stat nst;
+	if (!lstat(new_name, &nst)) {
+		if (S_ISDIR(nst.st_mode) || ok_if_exists)
+			return 0;
+		/*
+		 * A leading component of new_name might be a symlink
+		 * that is going to be removed with this patch, but
+		 * still pointing at somewhere that has the path.
+		 * In such a case, path "new_name" does not exist as
+		 * far as git is concerned.
+		 */
+		if (has_symlink_leading_path(new_name, strlen(new_name)))
+			return 0;
+
+		return error(_("%s: already exists in working directory"), new_name);
+	}
+	else if ((errno != ENOENT) && (errno != ENOTDIR))
+		return error("%s: %s", new_name, strerror(errno));
+	return 0;
+}
+
 /*
  * Check and apply the patch in-core; leave the result in patch->result
  * for the caller to write it out to the final destination.
-- 
1.7.11.rc3.30.g3bdace2
