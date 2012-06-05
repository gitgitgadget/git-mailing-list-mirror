From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] merge: separte the logic to check for a signed tag
Date: Tue,  5 Jun 2012 12:58:31 -0700
Message-ID: <1338926312-4239-2-git-send-email-gitster@pobox.com>
References: <1338926312-4239-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 21:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbztp-0001V9-D1
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 21:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab2FET6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 15:58:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56848 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab2FET6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 15:58:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C47F9FCD
	for <git@vger.kernel.org>; Tue,  5 Jun 2012 15:58:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xSzZ
	ryyBBIl9t6ufRJq7zKWXxJM=; b=tbfEKejOj51pka08h67/AqLJCy50z+4EKY/+
	iZzzkNJrv2eeva3lq4h2M9O4/HDqefBOH/Z7Ly/xTLwP4oLS9kn5u7qo0cjmoN1F
	jDgYvuBAAetnm1KsVkRLQTL65ERABnycZDBRrAS+8YAi2nhaARuvmSR7UkSz1xuc
	etYnsCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=r/yf0/
	SPLKNtfaOyT8YPqKt3Ib++cmbkpXq+al9BSiFGioPY3rm/2z2nugWtJyFXRMmB/B
	UDO0/8vtr08eiBVpzCFZRVDvb85sHU1U1I/Z3aX4NcyYn5tzOplGzr7AksupZZfM
	Ru9v9c0LLjFfs2JHr2S3CbIGr8sb6FNeHB6C4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24A4E9FCC
	for <git@vger.kernel.org>; Tue,  5 Jun 2012 15:58:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC7D29FCB for
 <git@vger.kernel.org>; Tue,  5 Jun 2012 15:58:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
In-Reply-To: <1338926312-4239-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D5CA90F8-AF48-11E1-94FA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199283>

We drop allow_fast_forward when merging a signed tag, because we
always need to create a new commit to have a place to record the
signed tag payload.

Move the logic to determine if the object given to merge is a signed
tag into a separate helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f385b8a..23389f2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1099,6 +1099,15 @@ static void write_merge_state(void)
 	close(fd);
 }
 
+static int merging_signed_tag(struct commit *parent)
+{
+	struct merge_remote_desc *desc = merge_remote_util(parent);
+
+	if (!desc || !desc->obj || desc->obj->type != OBJ_TAG)
+		return 0;
+	return 1;
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -1283,10 +1292,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    sha1_to_hex(commit->object.sha1));
 		setenv(buf.buf, argv[i], 1);
 		strbuf_reset(&buf);
-		if (!fast_forward_only &&
-		    merge_remote_util(commit) &&
-		    merge_remote_util(commit)->obj &&
-		    merge_remote_util(commit)->obj->type == OBJ_TAG) {
+		if (!fast_forward_only && merging_signed_tag(commit)) {
 			if (option_edit < 0)
 				option_edit = 1;
 			allow_fast_forward = 0;
-- 
1.7.11.rc1.37.g09843ac
