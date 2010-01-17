From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/8] rerere: honor conflict-marker-size attribute
Date: Sun, 17 Jan 2010 01:39:04 -0800
Message-ID: <1263721144-18605-9-git-send-email-gitster@pobox.com>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:39:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRbw-0003v2-0L
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab0AQJjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753687Ab0AQJj0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:39:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab0AQJjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:39:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DCF4491432
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=WW2G
	m4/YaQbM1dY320Yik/3pRII=; b=Qe25vrYUEbfxfys2qepcfQZ+ZLa+zD+ErXnD
	ekC/nraKSOsUzjYR9HbzOCkV/oDPLUsMX+0doDYFuM63x4lryaWm+jYOZ2Nkx/W9
	cse/IWgoaVhJp2IudfZKU178XXbQ7p/GRxr3wYh2jywpOg5oOMLCu+nDa3XbCypI
	dJxNHZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fe9XdL
	EyNfcCBxLXs4FWwT4AUXxaukMkZDHiMO9z00VtnHojPbJsX04DEV0Q6fo0DwrA88
	to3zngQgZhzbyeLp7NqW63xh7SoWXcXSZ9Me2/akNjvGplswf/aYTpJL3A9opJrd
	CWehAhAsl7bdkh6U5V43YA+d3ZV26XA31oV2s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D90F291431
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55B6B9142F for
 <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:23 -0500 (EST)
X-Mailer: git-send-email 1.6.6.405.g80ed6.dirty
In-Reply-To: <1263721144-18605-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 322C687C-034C-11DF-906B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137285>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ll-merge.c |   15 +++++++++++++++
 ll-merge.h |    2 ++
 rerere.c   |    5 +++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index d682071..0dcaae0 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -380,3 +380,18 @@ int ll_merge(mmbuffer_t *result_buf,
 			  ours, our_label, theirs, their_label,
 			  virtual_ancestor, marker_size);
 }
+
+int ll_merge_marker_size(const char *path)
+{
+	static struct git_attr_check check;
+	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
+
+	if (!check.attr)
+		check.attr = git_attr("conflict-marker-size");
+	if (!git_checkattr(path, 1, &check) && check.value) {
+		marker_size = atoi(check.value);
+		if (marker_size <= 0)
+			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
+	}
+	return marker_size;
+}
diff --git a/ll-merge.h b/ll-merge.h
index 5388422..ff5d84a 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -12,4 +12,6 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *theirs, const char *their_label,
 	     int virtual_ancestor);
 
+int ll_merge_marker_size(const char *path);
+
 #endif
diff --git a/rerere.c b/rerere.c
index d4d1507..2a2bd23 100644
--- a/rerere.c
+++ b/rerere.c
@@ -5,6 +5,7 @@
 #include "dir.h"
 #include "resolve-undo.h"
 #include "ll-merge.h"
+#include "attr.h"
 
 /* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
 static int rerere_enabled = -1;
@@ -218,7 +219,7 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 {
 	int hunk_no = 0;
 	struct rerere_io_file io;
-	int marker_size = 7;
+	int marker_size = ll_merge_marker_size(path);
 
 	memset(&io, 0, sizeof(io));
 	io.io.getline = rerere_file_getline;
@@ -285,7 +286,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	struct cache_entry *ce;
 	int pos, len, i, hunk_no;
 	struct rerere_io_mem io;
-	int marker_size = 7;
+	int marker_size = ll_merge_marker_size(path);
 
 	/*
 	 * Reproduce the conflicted merge in-core
-- 
1.6.6.405.g80ed6.dirty
