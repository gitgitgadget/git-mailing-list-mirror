From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/19] apply: further split load_preimage()
Date: Wed, 13 Jun 2012 12:32:49 -0700
Message-ID: <1339615980-19727-9-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetJt-0008OY-Pc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab2FMTdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2FMTdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 172728711
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ey7g
	J8TP5fIubmeogWWLI+0GSns=; b=Hcx4OyVnCRBjpdi2UGpcYTG+XrdcGYSzhfbE
	VrFZRmGu+UaGo1etgkw1gmU+eSUEduZy1tr2NXWzBn3Ss3aoYLIJhlCrjhoNfkSp
	laXQfL513qwv04VTA8/+wXzlfdJmftVwPGIzLiGFBbV0QP6BHcG1wQ1hTIj3ifn4
	ag/UDp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gF8bL2
	5SEgz4atjbF/w7BtHykYJRN1jjVgMCiS2EVBPIq//n9qxz/tjIRJTsA/B/dMfsJQ
	Ie4CXVFMcAiXDSxfTeQyFzBOOqgvbsB8zXJWqDhrPsoOOY97So9vZOLet7MHT5Lv
	dVyOy1TXg1mxpvy2ae3FifZqQmLG64l4Sywwo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EF51870F
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C9B5870E for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A02E4FA6-B58E-11E1-ADA5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199926>

load_preimage() is very specific to grab the current contents for
the path given by patch->old_name.  Split the logic that grabs the
contents for a path out of it into a separate load_patch_target()
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 59 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 78dc1a8..35e9a9c 100644
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
1.7.11.rc3.30.g3bdace2
