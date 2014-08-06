From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] apply: hoist use_patch() helper for path exclusion up
Date: Wed,  6 Aug 2014 15:58:04 -0700
Message-ID: <1407365885-1628-3-git-send-email-gitster@pobox.com>
References: <xmqq8un1ml7e.fsf@gitster.dls.corp.google.com>
 <1407365885-1628-1-git-send-email-gitster@pobox.com>
Cc: Peyton Randolph <prandolph@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 00:58:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFAAG-0001tc-5s
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 00:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbaHFW6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 18:58:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58185 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715AbaHFW6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 18:58:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D0403077D;
	Wed,  6 Aug 2014 18:58:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pvev
	CJ5zR6DfyOBMxLafZQgFsBY=; b=B58B3DNTr1RHPzdy1rLoNmZOZjbOlQT+DXE/
	6tKowKkh64F+s0E0+pVZnQD2mqC7AUJzy1lrVit13ujOfFBEVAQ/iyfUtRp2BRRh
	QcJPJHVhckE2S2P4jtEBl+DGTJ2MSl5MkOvJ4jG+RGChoWzjKzI9ba52F+a1T3Nn
	bH/1GFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	USi8Fu4s26zxg7c+6gQJtjSQHZlUhAnozEMHD3sBo5t+DUPtWy8BK7k3MJTgdYJh
	638fqEHTIvb/oY86SQsSGJylriWfRL7lMR/kWFl/9tcleboDh8YxYl62IyG6OtwN
	1OG0D3RWhA/3GJptUXJHnM7GhwLY0+f24e921ANLs0s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 447A63077C;
	Wed,  6 Aug 2014 18:58:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9598530777;
	Wed,  6 Aug 2014 18:58:24 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-rc1-209-g4e1b551
In-Reply-To: <1407365885-1628-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2BA52454-1DBD-11E4-850B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254911>

We will be adding a caller to the function a bit earlier in this
file in a later patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 81 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4270cde..bf075cc 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1938,6 +1938,49 @@ static void prefix_patch(struct patch *p)
 }
 
 /*
+ * include/exclude
+ */
+
+static struct string_list limit_by_name;
+static int has_include;
+static void add_name_limit(const char *name, int exclude)
+{
+	struct string_list_item *it;
+
+	it = string_list_append(&limit_by_name, name);
+	it->util = exclude ? NULL : (void *) 1;
+}
+
+static int use_patch(struct patch *p)
+{
+	const char *pathname = p->new_name ? p->new_name : p->old_name;
+	int i;
+
+	/* Paths outside are not touched regardless of "--include" */
+	if (0 < prefix_length) {
+		int pathlen = strlen(pathname);
+		if (pathlen <= prefix_length ||
+		    memcmp(prefix, pathname, prefix_length))
+			return 0;
+	}
+
+	/* See if it matches any of exclude/include rule */
+	for (i = 0; i < limit_by_name.nr; i++) {
+		struct string_list_item *it = &limit_by_name.items[i];
+		if (!fnmatch(it->string, pathname, 0))
+			return (it->util != NULL);
+	}
+
+	/*
+	 * If we had any include, a path that does not match any rule is
+	 * not used.  Otherwise, we saw bunch of exclude rules (or none)
+	 * and such a path is used.
+	 */
+	return !has_include;
+}
+
+
+/*
  * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file).
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
@@ -4145,44 +4188,6 @@ static int write_out_results(struct patch *list)
 
 static struct lock_file lock_file;
 
-static struct string_list limit_by_name;
-static int has_include;
-static void add_name_limit(const char *name, int exclude)
-{
-	struct string_list_item *it;
-
-	it = string_list_append(&limit_by_name, name);
-	it->util = exclude ? NULL : (void *) 1;
-}
-
-static int use_patch(struct patch *p)
-{
-	const char *pathname = p->new_name ? p->new_name : p->old_name;
-	int i;
-
-	/* Paths outside are not touched regardless of "--include" */
-	if (0 < prefix_length) {
-		int pathlen = strlen(pathname);
-		if (pathlen <= prefix_length ||
-		    memcmp(prefix, pathname, prefix_length))
-			return 0;
-	}
-
-	/* See if it matches any of exclude/include rule */
-	for (i = 0; i < limit_by_name.nr; i++) {
-		struct string_list_item *it = &limit_by_name.items[i];
-		if (!fnmatch(it->string, pathname, 0))
-			return (it->util != NULL);
-	}
-
-	/*
-	 * If we had any include, a path that does not match any rule is
-	 * not used.  Otherwise, we saw bunch of exclude rules (or none)
-	 * and such a path is used.
-	 */
-	return !has_include;
-}
-
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
-- 
2.1.0-rc1-209-g4e1b551
