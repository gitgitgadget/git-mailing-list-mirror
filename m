From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/15] merge: narrow scope of merge_names
Date: Wed, 29 Apr 2015 14:29:28 -0700
Message-ID: <1430342973-30344-11-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:30:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYR-0006XY-0j
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbbD2V34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751195AbbD2V3w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C86544DAC9;
	Wed, 29 Apr 2015 17:29:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4j3l
	NEhyJXM7PaK2nP61sHTXYTE=; b=wN1pkwK3w9GvyA79xNrszsSTXNAcsaIjTdNe
	3zIskhw6TZORHTnVyDnpgydzIXeOOnXfdIWQ8vlt8pNOnUXtjYN3pA38hMNwdmgO
	ejbfJNvMo9T3tct/Ap1I+H2gyV1x9zSYj9wyHaOwu4FgDaxwRgktVMzzQv0RWZGZ
	aIEHkIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FqcXTA
	89XJ4iFKfOV2ywjRv6y5JXx3rTaMOO3Fh71e29qDKGVJI7ND8aRbawCvKaS2FryD
	rTewmWnIswoeY2GWdQku6GBbfz1DypqvIWPNXaQDeMdG3OanTya7O3n6chlOezRG
	slyNOECR4cDSTtmzTJbCo+XhB8xSx7xmaBraA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C0ADC4DAC8;
	Wed, 29 Apr 2015 17:29:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49B8A4DAC5;
	Wed, 29 Apr 2015 17:29:51 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DE8C38EE-EEB6-11E4-B5C2-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268019>

In order to pass the list of parents to fmt_merge_msg(), cmd_merge()
uses this strbuf to create something that look like FETCH_HEAD that
describes commits that are being merged.  This is necessary only
when we are creating the merge commit message ourselves, but was
done unconditionally.

Move the variable and the logic to populate it to confine them in a
block that needs them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 054f052..d853c9d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1236,8 +1236,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		argc -= 2;
 		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
 	} else {
-		struct strbuf merge_names = STRBUF_INIT;
-
 		/* We are invoked directly as the first-class UI. */
 		head_arg = "HEAD";
 
@@ -1247,11 +1245,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * to the given message.
 		 */
 		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
-		for (p = remoteheads; p; p = p->next)
-			merge_name(merge_remote_util(p->item)->name, &merge_names);
 
 		if (!have_message || shortlog_len) {
+			struct strbuf merge_names = STRBUF_INIT;
 			struct fmt_merge_msg_opts opts;
+
+			for (p = remoteheads; p; p = p->next)
+				merge_name(merge_remote_util(p->item)->name, &merge_names);
+
 			memset(&opts, 0, sizeof(opts));
 			opts.add_title = !have_message;
 			opts.shortlog_len = shortlog_len;
@@ -1260,6 +1261,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			fmt_merge_msg(&merge_names, &merge_msg, &opts);
 			if (merge_msg.len)
 				strbuf_setlen(&merge_msg, merge_msg.len - 1);
+
+			strbuf_release(&merge_names);
 		}
 	}
 
-- 
2.4.0-rc3-300-g052d062
