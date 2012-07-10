From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 09/19] apply: move check_to_create_blob() closer to its
 sole caller
Date: Tue, 10 Jul 2012 00:04:02 -0700
Message-ID: <1341903852-4815-10-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUW4-0001Jz-H7
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab2GJHEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53199 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab2GJHEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD6FD7DE3
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=V/dH
	ZgbdD9XQO5bHNo3yDxk3Yi0=; b=JB0O6CrNzGU5oG4UNhdpHORmJ6mSoZlxz3/5
	1L07PjzgebEGwL0K+4oWpCNqjUKMIBGVkhUdYhU8WrX3DZqET5A8q+V5Cg/e/LpT
	I8X70ZbLSvk7vioI0oOL0zXGqXKljleNwlUKlGgEUiN0/eHnwyqhj3AE8lwEqIti
	CZ7fYNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=H07EDw
	wJ7oBm663DbuLy3k3DGn+BiaNqO4Gx53jygV+KQci2uAWvlD62eV2ZEsZClqCEt8
	arq3uZ+eCjPUBi3WU2dX5vxgE7l0oVeCHX222ZH68R7Wn8KsFrdxNduY0EJMXcNq
	hBvIBGpQZWEoz9XuPqa/oA353WikdZp8Zcq7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D49B67DE2
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 604B67DE1 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 853E3F24-CA5D-11E1-9E22-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201256>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ee1a960..cd25e63 100644
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
@@ -3272,6 +3249,29 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
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
1.7.11.1.294.g68a9409
