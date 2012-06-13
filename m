From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/19] apply: move "already exists" logic to
 check_to_create()
Date: Wed, 13 Jun 2012 12:32:51 -0700
Message-ID: <1339615980-19727-11-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetJu-0008OY-9v
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab2FMTdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2FMTdW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C06C98717
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=SyPz
	m6+HmS6nGHLJD5FFeo8Bozs=; b=eD0gOlGoAAScBSAzXjtaxY2Dv4LsymhTu+Pd
	KR2fq7rNu8X/HVgPrWvhr0Ldc7QnrpoTTupt05pDMA7iGCvpxfF4oGAg14OfcGmM
	xffDyuTeaMcvtUHrP/m+d7zdn+ofa6pCKoSe6Qt+qxmMS+tnp/KvGFE2GyRpTcuN
	YNAFqac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TbFy+8
	Mcf4zlr5yK0iYj+nhjdJur3/Y8fAHAxHlEs7jRHMUId4CrPCw9+iESyZwEAdpNP7
	ZbGzSf8QaIl56kE4COX7uy90VZWbN5Zrhy2tpafPNlGLIdl0Xg4WEsDE53j8fug4
	5jXada4Hh2aFiINXfaUD4bILravx3Fq6/NOgU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8A7A8716
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 300F58715 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A260D17C-B58E-11E1-8118-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199925>

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
index 6431178..c4166b3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3243,9 +3243,21 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
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
@@ -3259,10 +3271,10 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
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
 
@@ -3310,15 +3322,21 @@ static int check_patch(struct patch *patch)
 
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
1.7.11.rc3.30.g3bdace2
