From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/14] merge: extract prepare_merge_message() logic out
Date: Sat, 25 Apr 2015 22:26:03 -0700
Message-ID: <1430025967-24479-11-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5T-0002kU-JP
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbbDZF0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751194AbbDZF0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E05C46700;
	Sun, 26 Apr 2015 01:26:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RMO2
	e8Eh0Zrnx8/YtCTolPOKXDo=; b=DMohT44kNPKNG/VyJPeUQciCE+NAl9DL2g2d
	CuBSqQoEXD9eAkhc2K8RFeto0/+3o6Tu0IwVZIOlOD0v9mB7WCdrebFAOBZbYhDK
	69dfDKM15EACcNqOoZeMqk5HW69lPyL3PHBkJTJjdXwXwlev8FyasK6LzkqO68eo
	D1Fzuvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=iKXEuz
	SCiT6vJaIljK6Hr21KOyeDKdXSlvPpt39rKgrRm1E2vpYN7VM+XwkgtDzgWBN4Y8
	NEKoXHLT4TGV2jyph8cOzlQOShgF1VM3rLyaC0KJl5kT+YIzysjtGz8WtADTWAQU
	aaFJfKzYI/7bCsncYEJzR1iNwVjub+9RgBi7k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0728B466FF;
	Sun, 26 Apr 2015 01:26:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B15B466FC;
	Sun, 26 Apr 2015 01:26:22 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C694D442-EBD4-11E4-99E1-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267814>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d853c9d..a972ed6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1076,6 +1076,20 @@ static struct commit_list *reduce_parents(struct commit *head_commit,
 	return remoteheads;
 }
 
+static void prepare_merge_message(struct strbuf *merge_names, struct strbuf *merge_msg)
+{
+	struct fmt_merge_msg_opts opts;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.add_title = !have_message;
+	opts.shortlog_len = shortlog_len;
+	opts.credit_people = (0 < option_edit);
+
+	fmt_merge_msg(merge_names, merge_msg, &opts);
+	if (merge_msg->len)
+		strbuf_setlen(merge_msg, merge_msg->len - 1);
+}
+
 static struct commit_list *collect_parents(struct commit *head_commit,
 					   int *head_subsumed,
 					   int argc, const char **argv)
@@ -1248,20 +1262,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		if (!have_message || shortlog_len) {
 			struct strbuf merge_names = STRBUF_INIT;
-			struct fmt_merge_msg_opts opts;
 
 			for (p = remoteheads; p; p = p->next)
 				merge_name(merge_remote_util(p->item)->name, &merge_names);
-
-			memset(&opts, 0, sizeof(opts));
-			opts.add_title = !have_message;
-			opts.shortlog_len = shortlog_len;
-			opts.credit_people = (0 < option_edit);
-
-			fmt_merge_msg(&merge_names, &merge_msg, &opts);
-			if (merge_msg.len)
-				strbuf_setlen(&merge_msg, merge_msg.len - 1);
-
+			prepare_merge_message(&merge_names, &merge_msg);
 			strbuf_release(&merge_names);
 		}
 	}
-- 
2.4.0-rc3-238-g36f5934
