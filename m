From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] log-tree: show mergetag in log --show-signature output
Date: Wed,  4 Jan 2012 14:10:58 -0800
Message-ID: <1325715058-11984-4-git-send-email-gitster@pobox.com>
References: <1325715058-11984-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 23:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiZ3K-0000WP-Jx
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 23:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab2ADWLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 17:11:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114Ab2ADWLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 17:11:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9D0C679B
	for <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AgFZ
	stIp20xuzBnXG7W9oT0rmS4=; b=jd6tl/xUZgrxSdtb27pWAK/mpsvIqeakTHV4
	6XxaV3WKnjvlsw799k9ySfYjSxM0knyth1rIcQ0pwT/gYyyHAzDZs5JWYKi0hgvn
	eCE48VQ6Q4Qbz7osClzCA598qW0+SnWYiMV3LV0Tj3piiPPJps060W4YLqCIEuag
	NJ2Lycc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=GA19Ot
	e5cHpQ5greyCNzVRcLURRm1VqqP7qXCvEeTR59qQ12PwgyfKxt3qEvKATQoBBYq7
	RixG6j+lbMCjtLajDc9SHLZ+EFBUFE9eAfr2/LH24WJs9bB+XbtNb7NjA1mbVxdz
	mj14y5r+aOewV5ZfvpA6efLdMQPjF1yXzHbG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD789679A
	for <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2090F6799 for
 <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:05 -0500 (EST)
X-Mailer: git-send-email 1.7.8.2.340.gd18f0f
In-Reply-To: <1325715058-11984-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FED11FD0-3720-11E1-8431-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187948>

A commit object that merges a signed tag records the "mergetag" extended
header. Check the validity of the GPG signature on it, and show it in a
way similar to how "gpgsig" extended header is shown.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 005c5a5..b87dd53 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -443,6 +443,78 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	strbuf_release(&signature);
 }
 
+static int which_parent(const unsigned char *sha1, const struct commit *commit)
+{
+	int nth;
+	const struct commit_list *parent;
+
+	for (nth = 0, parent = commit->parents; parent; parent = parent->next) {
+		if (!hashcmp(parent->item->object.sha1, sha1))
+			return nth;
+		nth++;
+	}
+	return -1;
+}
+
+static void show_one_mergetag(struct rev_info *opt,
+			      struct commit_extra_header *extra,
+			      struct commit *commit)
+{
+	unsigned char sha1[20];
+	struct tag *tag;
+	struct strbuf verify_message;
+	int status, nth;
+	size_t payload_size, gpg_message_offset;
+
+	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), sha1);
+	tag = lookup_tag(sha1);
+	if (!tag)
+		return; /* error message already given */
+
+	strbuf_init(&verify_message, 256);
+	if (parse_tag_buffer(tag, extra->value, extra->len))
+		strbuf_addstr(&verify_message, "malformed mergetag\n");
+	else if ((nth = which_parent(tag->tagged->sha1, commit)) < 0)
+		strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
+				    tag->tag, tag->tagged->sha1);
+	else
+		strbuf_addf(&verify_message,
+			    "parent #%d, tagged '%s'\n", nth + 1, tag->tag);
+	gpg_message_offset = verify_message.len;
+
+	payload_size = parse_signature(extra->value, extra->len);
+	if ((extra->len <= payload_size) ||
+	    (verify_signed_buffer(extra->value, payload_size,
+				  extra->value + payload_size,
+				  extra->len - payload_size,
+				  &verify_message) &&
+	     verify_message.len <= gpg_message_offset)) {
+		strbuf_addstr(&verify_message, "No signature\n");
+		status = -1;
+	}
+	else if (strstr(verify_message.buf + gpg_message_offset,
+			": Good signature from "))
+		status = 0;
+	else
+		status = -1;
+
+	show_sig_lines(opt, status, verify_message.buf);
+	strbuf_release(&verify_message);
+}
+
+static void show_mergetag(struct rev_info *opt, struct commit *commit)
+{
+	struct commit_extra_header *extra, *to_free;
+
+	to_free = read_commit_extra_headers(commit);
+	for (extra = to_free; extra; extra = extra->next) {
+		if (strcmp(extra->key, "mergetag"))
+			continue; /* not a merge tag */
+		show_one_mergetag(opt, extra, commit);
+	}
+	free_commit_extra_headers(to_free);
+}
+
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
@@ -554,8 +626,10 @@ void show_log(struct rev_info *opt)
 		}
 	}
 
-	if (opt->show_signature)
+	if (opt->show_signature) {
 		show_signature(opt, commit);
+		show_mergetag(opt, commit);
+	}
 
 	if (!commit->buffer)
 		return;
-- 
1.7.8.2.340.gd18f0f
