From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/7] connect: annotate refs with their symref information in get_remote_head()
Date: Tue, 17 Sep 2013 22:14:22 -0700
Message-ID: <1379481263-29903-7-git-send-email-gitster@pobox.com>
References: <1379481263-29903-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 07:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMA6I-0006Dp-MB
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 07:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749Ab3IRFOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 01:14:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab3IRFOi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 01:14:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2552C3C958;
	Wed, 18 Sep 2013 05:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/yb+
	brZl89i1yNGc8mxkyGMkqTY=; b=r1oiExSSNRQeW3aDKlJb+o6G37dj9zSjpcag
	w1VGiSMML8gR+CzKwyMSzYBUypYG3pYq4G/E+McUGKzQpya/NThzP2TX82Z0Yil+
	TlbVvRYTYbhJNkgdyCFl2/NH9CMxzanVXGX8R+QKkhsY7RvG/N5Lg4V4REIMyjVj
	1xuKymw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	jqP+v7469DESE+xpKKK4cjKeC/De+nn8lGWZna/NTsLYXJPJgdeHHpA7HMC7gDI0
	06UdTnKMQ5r2S8iHNFj6bLobWR2KMZJypaZ6JMVM2EPg3jiXge00WlVMnYpzW0GV
	eE75ZfhITdqINq0QvmRd+JRtKXcoImPGpCsAvgxSyBk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A0F93C957;
	Wed, 18 Sep 2013 05:14:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 566F73C953;
	Wed, 18 Sep 2013 05:14:37 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379481263-29903-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 369EE204-2021-11E3-83DC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234955>

By doing this, clients of upload-pack can now reliably tell what ref
a symbolic ref points at; the updated test in t5505 used to expect
failure due to the ambiguity and made sure we give diagnostics, but
we no longer need to be so pessimistic. Make sure we correctly learn
which branch HEAD points at from the other side instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c         | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5505-remote.sh | 15 ++++----------
 2 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/connect.c b/connect.c
index e4c7ae6..553a80c 100644
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
+		return; /* just "symref" */
+	/* e.g. "symref=HEAD:refs/heads/master" */
+	sym = xmalloc(len + 1);
+	memcpy(sym, val, len);
+	sym[len] = '\0';
+	target = strchr(sym, ':');
+	if (!target)
+		/* just "symref=something" */
+		goto reject;
+	*(target++) = '\0';
+	if (check_refname_format(sym, REFNAME_ALLOW_ONELEVEL) ||
+	    check_refname_format(target, REFNAME_ALLOW_ONELEVEL))
+		/* "symref=bogus:pair */
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
+		val = parse_feature_value(feature_list, "symref", &len);
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
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 197d3f7..ac79dd9 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -160,9 +160,7 @@ cat >test/expect <<EOF
 * remote two
   Fetch URL: ../two
   Push  URL: ../three
-  HEAD branch (remote HEAD is ambiguous, may be one of the following):
-    another
-    master
+  HEAD branch: master
   Local refs configured for 'git push':
     ahead  forces to master  (fast-forwardable)
     master pushes to another (up to date)
@@ -262,17 +260,12 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
-cat >test/expect <<\EOF
-error: Multiple remote HEAD branches. Please choose one explicitly with:
-  git remote set-head two another
-  git remote set-head two master
-EOF
-
-test_expect_success 'set-head --auto fails w/multiple HEADs' '
+test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	(
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
-		test_must_fail git remote set-head --auto two >output 2>&1 &&
+		git remote set-head --auto two >output 2>&1 &&
+		echo "two/HEAD set to master" >expect &&
 		test_i18ncmp expect output
 	)
 '
-- 
1.8.4-585-g8d1dcaf
