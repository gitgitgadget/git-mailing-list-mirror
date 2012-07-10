From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 10/19] apply: move "already exists" logic to
 check_to_create()
Date: Tue, 10 Jul 2012 00:04:03 -0700
Message-ID: <1341903852-4815-11-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUW5-0001Jz-21
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab2GJHF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:05:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754119Ab2GJHEo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D13647DE7
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dND3
	/vJqIikpmO9IIHdyu0ToWU0=; b=k+U1mQEF5cly5kiAmDctyH65GfBCRWo8n6pU
	4EOu8PCf7rUqQzLZQ3jywROED73fhMYZilKYJjrPhazKPB++OK0WFBqDVEwB459Z
	kVDR2e5M2CHi6+yy5xZAgQNIOBNPltHZqBAQKaV+PsRDOKjIa238ZGBAiKZ67OQS
	RDHFsds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=uuNIe7
	a0Oo/HCA4GRFZSnqT+mi3UcWvNTp1S55Bh6Mlcv5JBbWqvr+X5/OsodSfdyNa+OP
	UUfc4495ZGIMk1qDrXxfanVeYi8RiHtMBa2O/OQJuEe6XoVKx/RPctaRUUDuK4wv
	kWK7vT5sWnCR0qL3vzycPjalNkicL3i/+eQaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C87397DE6
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B3F87DE4 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 865847BA-CA5D-11E1-8993-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201257>

The check_to_create_blob() function used to check only the case
where we are applying to the working tree.  Rename the function to
check_to_create() and make it also responsible for checking the case
where we apply to the index.  Also make its caller responsible for
issuing an error message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index cd25e63..7379687 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3249,9 +3249,21 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	return 0;
 }
 
-static int check_to_create_blob(const char *new_name, int ok_if_exists)
+
+#define EXISTS_IN_INDEX 1
+#define EXISTS_IN_WORKTREE 2
+
+static int check_to_create(const char *new_name, int ok_if_exists)
 {
 	struct stat nst;
+
+	if (check_index &&
+	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
+	    !ok_if_exists)
+		return EXISTS_IN_INDEX;
+	if (cached)
+		return 0;
+
 	if (!lstat(new_name, &nst)) {
 		if (S_ISDIR(nst.st_mode) || ok_if_exists)
 			return 0;
@@ -3265,10 +3277,10 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 		if (has_symlink_leading_path(new_name, strlen(new_name)))
 			return 0;
 
-		return error(_("%s: already exists in working directory"), new_name);
-	}
-	else if ((errno != ENOENT) && (errno != ENOTDIR))
+		return EXISTS_IN_WORKTREE;
+	} else if ((errno != ENOENT) && (errno != ENOTDIR)) {
 		return error("%s: %s", new_name, strerror(errno));
+	}
 	return 0;
 }
 
@@ -3316,15 +3328,21 @@ static int check_patch(struct patch *patch)
 
 	if (new_name &&
 	    ((0 < patch->is_new) | (0 < patch->is_rename) | patch->is_copy)) {
-		if (check_index &&
-		    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
-		    !ok_if_exists)
+		int err = check_to_create(new_name, ok_if_exists);
+
+		switch (err) {
+		case 0:
+			break; /* happy */
+		case EXISTS_IN_INDEX:
 			return error(_("%s: already exists in index"), new_name);
-		if (!cached) {
-			int err = check_to_create_blob(new_name, ok_if_exists);
-			if (err)
-				return err;
+			break;
+		case EXISTS_IN_WORKTREE:
+			return error(_("%s: already exists in working directory"),
+				     new_name);
+		default:
+			return err;
 		}
+
 		if (!patch->new_mode) {
 			if (0 < patch->is_new)
 				patch->new_mode = S_IFREG | 0644;
-- 
1.7.11.1.294.g68a9409
