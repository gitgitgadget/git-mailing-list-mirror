From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/15] merge: extract prepare_merge_message() logic out
Date: Wed, 29 Apr 2015 14:29:29 -0700
Message-ID: <1430342973-30344-12-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:30:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYR-0006XY-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbbD2V37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750940AbbD2V3x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 331CD4DAD3;
	Wed, 29 Apr 2015 17:29:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=s6RA
	xig3xS2PhNrzcBg8pST4jT8=; b=V4a2XZlemQx5RAm7aZCw8yueEthpgz4IkAgR
	giRER/DMVPuLElAk4m9m8qwZllDKXxZJea/4SSQyl20Bw0HPJt+s7be116GhqdXH
	Hrc1YpEKIP43Fh+anwInM5nB0KrEaMFhRLLv6IFy+uMtFRmKelChc+00TsFWhGQf
	ULtUHWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ejLIxD
	0ZfaAaxK0bBbggoIrp4PL4LHmJG8Txw6JLtSEctoX+Wk2mw6tSNS3bQQJIalOb8W
	pXiiC3NpHnDF4NJxmtTjPDvwqvi98sMW+Iq/EEjm9l+C6MCROjbi1HVijQOK5yh4
	elM+BUAwJFCvt2fexDMFTw8jGfITcd0xurpUg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B0034DAD2;
	Wed, 29 Apr 2015 17:29:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A362F4DACF;
	Wed, 29 Apr 2015 17:29:52 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DF5C9F7A-EEB6-11E4-B3E9-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268015>

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
2.4.0-rc3-300-g052d062
