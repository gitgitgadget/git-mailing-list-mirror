From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 08/19] apply: further split load_preimage()
Date: Tue, 10 Jul 2012 00:04:01 -0700
Message-ID: <1341903852-4815-9-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUVX-0000bE-LC
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab2GJHEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096Ab2GJHEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 159EC7DE0
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/6/C
	INiSfeSNdjI8r3DcBtZEqP8=; b=hmFvFeKJo1PP1q5Sxg/Or0k4g3L81fAYYmC8
	G161qXuOjWOJdIVhA5Oqhl9sL75NtmejnOlAOKB8J+KjygToGY3irH/nw0vMZq/f
	aw5NXnUrPw2HNFF1AoO3TMQUauCESwWiAmiUWpMzyeeQ8H4TQ1E0FSKR0bG8NXoV
	NuzoMjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Huj7Uf
	EC88sc3tAVkMDHPCKVnK9tUWOXeTLio4kuPajcAjKtWB689C5WwHBro+nsErO2pf
	Ev/vtnfANF+nZjCEQ03J7k3IMPQUPyeA7cVvEKSN30BYcepSTsKF70wszVopWnt9
	f63nf40wn6dX8/viGnevPZ6/IBEx6ywXPkjUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CEB37DDF
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 759177DDE for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 841A4408-CA5D-11E1-AFBE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201246>

load_preimage() is very specific to grab the current contents for
the path given by patch->old_name.  Split the logic that grabs the
contents for a path out of it into a separate load_patch_target()
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 59 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5642433..ee1a960 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3067,6 +3067,31 @@ static struct patch *previous_patch(struct patch *patch, int *gone)
 	return previous;
 }
 
+#define SUBMODULE_PATCH_WITHOUT_INDEX 1
+
+static int load_patch_target(struct strbuf *buf,
+			     struct cache_entry *ce,
+			     struct stat *st,
+			     const char *name,
+			     unsigned expected_mode)
+{
+	if (cached) {
+		if (read_file_or_gitlink(ce, buf))
+			return error(_("read of %s failed"), name);
+	} else if (name) {
+		if (S_ISGITLINK(expected_mode)) {
+			if (ce)
+				return read_file_or_gitlink(ce, buf);
+			else
+				return SUBMODULE_PATCH_WITHOUT_INDEX;
+		} else {
+			if (read_old_data(st, name, buf))
+				return error(_("read of %s failed"), name);
+		}
+	}
+	return 0;
+}
+
 /*
  * We are about to apply "patch"; populate the "image" with the
  * current version we have, from the working tree or from the index,
@@ -3090,26 +3115,22 @@ static int load_preimage(struct image *image,
 	if (previous) {
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
-	} else if (cached) {
-		if (read_file_or_gitlink(ce, &buf))
+	} else {
+		status = load_patch_target(&buf, ce, st,
+					   patch->old_name, patch->old_mode);
+		if (status < 0)
+			return status;
+		else if (status == SUBMODULE_PATCH_WITHOUT_INDEX) {
+			/*
+			 * There is no way to apply subproject
+			 * patch without looking at the index.
+			 * NEEDSWORK: shouldn't this be flagged
+			 * as an error???
+			 */
+			free_fragment_list(patch->fragments);
+			patch->fragments = NULL;
+		} else if (status) {
 			return error(_("read of %s failed"), patch->old_name);
-	} else if (patch->old_name) {
-		if (S_ISGITLINK(patch->old_mode)) {
-			if (ce) {
-				read_file_or_gitlink(ce, &buf);
-			} else {
-				/*
-				 * There is no way to apply subproject
-				 * patch without looking at the index.
-				 * NEEDSWORK: shouldn't this be flagged
-				 * as an error???
-				 */
-				free_fragment_list(patch->fragments);
-				patch->fragments = NULL;
-			}
-		} else {
-			if (read_old_data(st, patch->old_name, &buf))
-				return error(_("read of %s failed"), patch->old_name);
 		}
 	}
 
-- 
1.7.11.1.294.g68a9409
