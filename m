From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] ls-files -i: micro-optimize path_excluded()
Date: Tue,  5 Jun 2012 22:45:15 -0700
Message-ID: <1338961519-30970-3-git-send-email-gitster@pobox.com>
References: <1338961519-30970-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 07:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc94M-0002JF-NN
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 07:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab2FFFpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 01:45:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897Ab2FFFpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 01:45:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0550B5FFC
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=p6+H
	6RK5AD6NwCl0IR5gaNo6XSQ=; b=Q7jDS61o8yAcPstd6X4H7nqdLkeXKOBi+dmA
	6VAVZraZlLn5ZjRRMYvR8uswlxoCATlElGHrhvu3G+OZDfOeUJVC23BS9j1AZ4in
	bqbTbgA0yhvGanjd/H4ol6sBlXBgxlHr8hDiXdhzvWHuLF3LpBVvp6SHQPP7GCKz
	fEao9Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=lDdO2Y
	pCQuVfBskeXfvzjFslLRbTkMFLV5S7Booie3xXNQa83NWOQjH9sj+orZ+g+HcV3h
	KsSYvstki0co7hXnQ1Moy5M8AQYp6g6GFDTh9thd/4vJqAE/b1WPa+OlyuqHxtUz
	5yZ8QCKYw8fQgBqpqxEI6HIUJ9y2aZ0+AHShQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F19765FFB
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8057C5FFA for
 <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
In-Reply-To: <1338961519-30970-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CFE216FA-AF9A-11E1-91CA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199300>

As we know a caller that does not recurse is calling us in the index
order, we can remember the last directory we found to be excluded
and see if the path we are looking at is still inside it, in which
case we can just answer that it is excluded.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/dir.c b/dir.c
index c3f0884..839bc9f 100644
--- a/dir.c
+++ b/dir.c
@@ -592,11 +592,25 @@ void path_exclude_check_clear(struct path_exclude_check *check)
 	strbuf_release(&check->path);
 }
 
+/*
+ * Is the ce->name excluded?  This is for a caller like show_files() that
+ * do not honor directory hierarchy and iterate through paths that are
+ * possibly in an ignored directory.
+ *
+ * A path to a directory known to be excluded is left in check->path to
+ * optimize for repeated checks for files in the same excluded directory.
+ */
 int path_excluded(struct path_exclude_check *check, struct cache_entry *ce)
 {
 	int i, dtype;
 	struct strbuf *path = &check->path;
 
+	if (path->len &&
+	    path->len <= ce_namelen(ce) &&
+	    !memcmp(ce->name, path->buf, path->len) &&
+	    (!ce->name[path->len] || ce->name[path->len] == '/'))
+		return 1;
+
 	strbuf_setlen(path, 0);
 	for (i = 0; ce->name[i]; i++) {
 		int ch = ce->name[i];
@@ -608,6 +622,10 @@ int path_excluded(struct path_exclude_check *check, struct cache_entry *ce)
 		}
 		strbuf_addch(path, ch);
 	}
+
+	/* An entry in the index; cannot be a directory with subentries */
+	strbuf_setlen(path, 0);
+
 	dtype = ce_to_dtype(ce);
 	return excluded(check->dir, ce->name, &dtype);
 }
-- 
1.7.11.rc1.37.g09843ac
