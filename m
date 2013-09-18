From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] connect: annotate refs with their symref information in get_remote_head()
Date: Tue, 17 Sep 2013 19:31:28 -0700
Message-ID: <1379471489-26280-6-git-send-email-gitster@pobox.com>
References: <20130906155608.GF12966@inner.h.apk.li>
 <1379471489-26280-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 04:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM7YZ-0006bw-0b
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 04:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab3IRCbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 22:31:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab3IRCbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 22:31:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9314839189;
	Wed, 18 Sep 2013 02:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gCKr
	nYydzB1o3RUmt9lhU4Xh9IM=; b=YSKIQ3+Q7kw8K8CPD+1GbixRsw/Mx7XUD3+v
	/SW9z/o5JuN6K8/7aWEXVzndorsAEz13GsIFBhRlcb+qKGKIHzsXxyWMWR/x5anE
	ceu07sB9RmaKwnQw9547O+L3Yr2TPd0giBDKXZ+owz0/cxBGfKA5GvShk0HUGstP
	SMANfQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Cy2AJfwCxM5mr5i5OFj1ccG0RI5KNlsu6SKVguWatFahzR70+h0rXwvef6WCzWWC
	L+u+wFZrpPSCH0liI7Zi/q536/tSqu2PjSrK5/Mz+tNZSCYSGbrfMUuaEwcpYXs+
	jgCk5s4RksKfLCp4SnLQ1dgbGq6yQZ5TJt8Wo6jrnR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8746939187;
	Wed, 18 Sep 2013 02:31:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF2F639186;
	Wed, 18 Sep 2013 02:31:41 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379471489-26280-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 740AB36E-200A-11E3-A5AF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234947>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/connect.c b/connect.c
index e4c7ae6..a53ef6d 100644
--- a/connect.c
+++ b/connect.c
@@ -6,6 +6,7 @@
 #include "run-command.h"
 #include "remote.h"
 #include "url.h"
+#include "string-list.h"
 
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
@@ -60,6 +61,61 @@ static void die_initial_contact(int got_at_least_one_head)
 		    "and the repository exists.");
 }
 
+static void parse_one_symref_info(struct string_list *symref, const char *val, int len)
+{
+	char *sym, *target;
+	struct string_list_item *item;
+
+	if (!len)
+		return; /* just "sym" */
+	/* e.g. "sym=HEAD:refs/heads/master" */
+	sym = xmalloc(len + 1);
+	memcpy(sym, val, len);
+	sym[len] = '\0';
+	target = strchr(sym, ':');
+	if (!target)
+		/* just "sym=something" */
+		goto reject;
+	*(target++) = '\0';
+	if (check_refname_format(sym, REFNAME_ALLOW_ONELEVEL) ||
+	    check_refname_format(target, REFNAME_ALLOW_ONELEVEL))
+		/* "sym=bogus:pair */
+		goto reject;
+	item = string_list_append(symref, sym);
+	item->util = target;
+	return;
+reject:
+	free(sym);
+	return;
+}
+
+static void annotate_refs_with_symref_info(struct ref *ref)
+{
+	struct string_list symref = STRING_LIST_INIT_DUP;
+	const char *feature_list = server_capabilities;
+
+	while (feature_list) {
+		int len;
+		const char *val;
+
+		val = parse_feature_value(feature_list, "sym", &len);
+		if (!val)
+			break;
+		parse_one_symref_info(&symref, val, len);
+		feature_list = val + 1;
+	}
+	sort_string_list(&symref);
+
+	for (; ref; ref = ref->next) {
+		struct string_list_item *item;
+		item = string_list_lookup(&symref, ref->name);
+		if (!item)
+			continue;
+		ref->symref = xstrdup((char *)item->util);
+	}
+	string_list_clear(&symref, 0);
+}
+
 /*
  * Read all the refs from the other end
  */
@@ -67,6 +123,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct ref **list, unsigned int flags,
 			      struct extra_have_objects *extra_have)
 {
+	struct ref **orig_list = list;
 	int got_at_least_one_head = 0;
 
 	*list = NULL;
@@ -114,6 +171,9 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		list = &ref->next;
 		got_at_least_one_head = 1;
 	}
+
+	annotate_refs_with_symref_info(*orig_list);
+
 	return list;
 }
 
-- 
1.8.4-585-g8d1dcaf
