From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/7] upload-pack: send symbolic ref information as capability
Date: Tue, 17 Sep 2013 22:14:19 -0700
Message-ID: <1379481263-29903-4-git-send-email-gitster@pobox.com>
References: <1379481263-29903-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 07:14:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMA6K-0006Dp-UN
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 07:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab3IRFOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 01:14:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586Ab3IRFOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 01:14:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0A783C942;
	Wed, 18 Sep 2013 05:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9DGQ
	wC3z3YEIm3th5G1fCGpeIWk=; b=d7X+CH0c85KL+PXpf4I8JMlg+9ligU4Hnzgt
	2jPfwxws9yFbZL03+cFmwVqKn9QWLikAuvBkVzGgVeeQnQliWxelglCX52g6ldHq
	v/Do+QQ6+lbLHlRWuLCiFT0HMeDcyfDvTBx1xNXDnPahNSf3SHXeZaI5Wo+TTAHw
	htAYcNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	I8K8xg/MceBiF7aIRTrtH9gZl378IoKS/FIfg/B9Ps8Y9BFpW7xG3yvjHaJgq8F2
	iVJMzXdi2CqIUd3Mrxv2SXqWtxNBGCHkRzKADvFgTW2H9aPGglnjhylTnPhcc3R3
	MaHu++X+8XlnhORmu/WIo6MlmtbYUCb13oJmd3RFYy0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96C083C941;
	Wed, 18 Sep 2013 05:14:32 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 097313C93D;
	Wed, 18 Sep 2013 05:14:30 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379481263-29903-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 32DAE082-2021-11E3-8A3A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234956>

One long-standing flaw in the pack transfer protocol was that there
was no way to tell the other end which branch "HEAD" points at.
With a capability "symref=HEAD:refs/heads/master", let the sender to
tell the receiver what symbolic ref points at what ref.

This capability can be repeated more than once to represent symbolic
refs other than HEAD, such as "refs/remotes/origin/HEAD").

Add an infrastructure to collect symbolic refs, format them as extra
capabilities and put it on the wire.  For now, just send information
on the "HEAD" and nothing else.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index a6e107f..979fc8e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -734,6 +734,16 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag
 	return 0;
 }
 
+static void format_symref_info(struct strbuf *buf, struct string_list *symref)
+{
+	struct string_list_item *item;
+
+	if (!symref->nr)
+		return;
+	for_each_string_list_item(item, symref)
+		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
+}
+
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
@@ -745,32 +755,60 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (mark_our_ref(refname, sha1, flag, NULL))
 		return 0;
 
-	if (capabilities)
-		packet_write(1, "%s %s%c%s%s%s agent=%s\n",
+	if (capabilities) {
+		struct strbuf symref_info = STRBUF_INIT;
+
+		format_symref_info(&symref_info, cb_data);
+		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
 			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
+			     symref_info.buf,
 			     git_user_agent_sanitized());
-	else
+		strbuf_release(&symref_info);
+	} else {
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
+	}
 	capabilities = NULL;
 	if (!peel_ref(refname, peeled))
 		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
 	return 0;
 }
 
+static int find_symref(const char *refname, const unsigned char *sha1, int flag,
+		       void *cb_data)
+{
+	const char *symref_target;
+	struct string_list_item *item;
+	unsigned char unused[20];
+
+	if ((flag & REF_ISSYMREF) == 0)
+		return 0;
+	symref_target = resolve_ref_unsafe(refname, unused, 0, &flag);
+	if (!symref_target || (flag & REF_ISSYMREF) == 0)
+		die("'%s' is a symref but it is not?", refname);
+	item = string_list_append(cb_data, refname);
+	item->util = xstrdup(symref_target);
+	return 0;
+}
+
 static void upload_pack(void)
 {
+	struct string_list symref = STRING_LIST_INIT_DUP;
+
+	head_ref_namespaced(find_symref, &symref);
+
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
-		head_ref_namespaced(send_ref, NULL);
-		for_each_namespaced_ref(send_ref, NULL);
+		head_ref_namespaced(send_ref, &symref);
+		for_each_namespaced_ref(send_ref, &symref);
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(mark_our_ref, NULL);
 		for_each_namespaced_ref(mark_our_ref, NULL);
 	}
+	string_list_clear(&symref, 1);
 	if (advertise_refs)
 		return;
 
-- 
1.8.4-585-g8d1dcaf
