From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] name-rev: --weight option
Date: Wed, 29 Aug 2012 20:50:26 -0700
Message-ID: <1346298629-13730-4-git-send-email-gitster@pobox.com>
References: <1346298629-13730-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 05:51:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vnC-0007zl-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab2H3DvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:51:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481Ab2H3Dui (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:50:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CFE588AE
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4yQl
	Iz8K+CxS+E2dTC1WHigAeeE=; b=r2Z9XtBwmQzaTDagwcK5P9Gax8LxW1Jq6v/6
	kD4G5mRiqxvn3BEyGjjuui3GlgzqjPJrRZZRK6s5XcMB4txfp5vzpLhXdkA8h2kU
	CtOEO96YdpBHerwhJW7UxE4iuzDZMbuu47q6LAm7pY0asZE0x4s1iMn5dRFfWnMV
	50TASsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YHmdcz
	Eu05Jy2UWPd/IDP7BRSzGoxyyZO9UM4u2QWs07JOGYhuRiBtlcJ3TK/YYfBwydIv
	HcH1+6n971JwloSt8sCnJoKWXc9DXBUcgMwErX187MbgDOjRCmKJjQaCXOjPh0q5
	L7fLgfdXpxdwDOcTBoLBReHVMrcEoKJPeUnzg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D447788AD
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6CED88AB for
 <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.286.g9df01f7
In-Reply-To: <1346298629-13730-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DB990E42-F255-11E1-AB72-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204514>

Instead of naming a rev after a tip that is topologically closest,
use the tip that is the oldest one among those which contain the
rev.

The semantics "name-rev --weight" would give us is closer to what
people expect from "describe --contains".

Note that this is fairly expensive to compute; a later change in the
series will cache the weight value using notes-cache.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index ebbf541..7cdb758 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -4,6 +4,8 @@
 #include "tag.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "diff.h"
+#include "revision.h"
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
@@ -11,8 +13,85 @@ struct rev_name {
 	const char *tip_name;
 	int generation;
 	int distance;
+	int weight;
 };
 
+/*
+ * Historically, "name-rev" named a rev based on the tip that is
+ * topologically closest to it.
+ *
+ * It does not give a good answer to "what is the earliest tag that
+ * contains the commit?", however, because you can build a new commit
+ * on top of an ancient commit X, merge it to the tip and tag the
+ * result, which would make X reachable from the new tag in two hops,
+ * even though it appears in the part of the history that is contained
+ * in other ancient tags.
+ *
+ * In order to answer that question, "name-rev" can be told to name a
+ * rev based on the tip that has smallest number of commits behind it.
+ */
+static int use_weight;
+
+/*
+ * NEEDSWORK: the result of this computation must be cached to
+ * a dedicated notes tree, keyed by the commit object name.
+ */
+static int compute_ref_weight(struct commit *commit)
+{
+	struct rev_info revs;
+	int weight = 1; /* give root the weight of 1 */
+
+	reset_revision_walk();
+	init_revisions(&revs, NULL);
+	add_pending_object(&revs, (struct object *)commit, NULL);
+	prepare_revision_walk(&revs);
+	while (get_revision(&revs))
+		weight++;
+	return weight;
+}
+
+static int ref_weight(const char *refname, size_t reflen)
+{
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char sha1[20];
+	struct commit *commit;
+	struct rev_name *name;
+
+	strbuf_add(&buf, refname, reflen);
+	if (get_sha1(buf.buf, sha1))
+		die("Internal error: cannot parse tip '%s'", buf.buf);
+	strbuf_release(&buf);
+
+	commit = lookup_commit_reference_gently(sha1, 0);
+	if (!commit)
+		die("Internal error: cannot look up commit '%s'", buf.buf);
+	name = commit->util;
+	if (!name)
+		die("Internal error: a tip without name '%s'", buf.buf);
+	if (!name->weight)
+		name->weight = compute_ref_weight(commit);
+	return name->weight;
+}
+
+static int tip_weight_cmp(const char *a, const char *b)
+{
+	size_t reflen_a, reflen_b;
+	static const char traversal[] = "^~";
+
+	/*
+	 * A "tip" may look like <refname> followed by traversal
+	 * instruction (e.g. ^2~74).  We only are interested in
+	 * the weight of the ref part.
+	 */
+	reflen_a = strcspn(a, traversal);
+	reflen_b = strcspn(b, traversal);
+
+	if (reflen_a == reflen_b && !memcmp(a, b, reflen_a))
+		return 0;
+
+	return ref_weight(a, reflen_a) - ref_weight(b, reflen_b);
+}
+
 static long cutoff = LONG_MAX;
 
 /* How many generations are maximally preferred over _one_ merge traversal? */
@@ -49,8 +128,27 @@ static void name_rev(struct commit *commit,
 		use_this_tip = 1;
 	}
 
-	if (distance < name->distance)
-		use_this_tip = 1;
+	if (!use_weight) {
+		if (distance < name->distance)
+			use_this_tip = 1;
+	} else {
+		if (!name->tip_name)
+			use_this_tip = 1;
+		else {
+			/*
+			 * Pick a name based on the ref that is older,
+			 * i.e. having smaller number of commits
+			 * behind it.  Break the tie by picking the
+			 * path with smaller numer of steps to reach
+			 * that ref from the commit.
+			 */
+			int cmp = tip_weight_cmp(name->tip_name, tip_name);
+			if (0 < cmp)
+				use_this_tip = 1;
+			else if (!cmp && distance < name->distance)
+				use_this_tip = 1;
+		}
+	}
 
 	if (!use_this_tip)
 		return;
@@ -241,6 +339,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "undefined", &allow_undefined, "allow to print `undefined` names"),
 		OPT_BOOLEAN(0, "always",     &always,
 			   "show abbreviated commit object as fallback"),
+		OPT_BOOLEAN(0, "weight", &use_weight,
+			    "name revs based on the oldest tip that contain them"),
 		OPT_END(),
 	};
 
-- 
1.7.12.286.g9df01f7
