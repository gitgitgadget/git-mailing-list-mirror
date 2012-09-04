From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3.5/6] name-rev --weight: trivial optimization
Date: Tue, 04 Sep 2012 15:29:39 -0700
Message-ID: <7va9x58lrg.fsf_-_@alter.siamese.dyndns.org>
References: <1346298629-13730-1-git-send-email-gitster@pobox.com>
 <1346298629-13730-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 00:29:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T91d5-00088r-BW
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 00:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830Ab2IDW3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 18:29:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932695Ab2IDW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 18:29:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B05B29A00;
	Tue,  4 Sep 2012 18:29:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lJXhe7Yb3/YhX54ttXeqTiTNSnM=; b=jdCeko
	jnGNxeBTlGamaa3GyF5RbSA7pA7hD1EAdsDyoaHDQ1NVEE7at90Nn8YDTX+BQPYu
	RnTTO/+ee/YH4W9Hfk2ROPFX/HGVRNH3EfEPHK99PhAMmtecruqzOiCor8K8N3QS
	FF3BRGHLIQW96Ur1+lzvDK6ymEL/wdbWAM5jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T0Wxbs6Ca/WeW203TmG/6AuArLj2XUyP
	Y70vU2FEYflG1nTBPpfdU+J5GxufGpkBG+AbrNcBS2iw/R8IC9pB7gqN/gf0hHFB
	lWRaqtmZyv0j0pxugtfxMHBJRXkjUc7iCdxrYwpQTbcNVcVkFJQQebDArUihq/qt
	2AZvHX5H63s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CAFB99FF;
	Tue,  4 Sep 2012 18:29:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDB0899FE; Tue,  4 Sep 2012
 18:29:40 -0400 (EDT)
In-Reply-To: <1346298629-13730-4-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed, 29 Aug 2012 20:50:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 049591B0-F6E0-11E1-9D48-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204788>

Junio C Hamano <gitster@pobox.com> writes:

> Instead of naming a rev after a tip that is topologically closest,
> use the tip that is the oldest one among those which contain the
> rev.
>
> The semantics "name-rev --weight" would give us is closer to what
> people expect from "describe --contains".
>
> Note that this is fairly expensive to compute; a later change in the
> series will cache the weight value using notes-cache.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Here is a trivial optimization on top of the one from the other day.

-- >8 --
It often happens that immediately after traversing from v1.2.3 to
find out its weight, we are asked to see if another commit v1.2.0
is heavier than that.

Because the commits that are reachable from v1.2.3 are painted with
the SHOWN flag until the next "rev-list" traversal, we can notice
that the new commit v1.2.0 is reachable from v1.2.3 without doing
any traversal.  We cannot learn exactly how much it weighs, but we
can tell it must weigh less than v1.2.3, and that is all that the
caller wants to know.

In the kernel history, "git name-rev --tags 0136db586c" which
started this topic needs 26k calls to tip_weight_cmp().  13k of them
are comparisons between tips based on the same ref and answered
without computing any weight.  Among the remaining 13k, 1.8k
comparisons are answered with this trivial "fast-forward"
optimization.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 7cdb758..809553b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -32,6 +32,9 @@ struct rev_name {
  */
 static int use_weight;
 
+/* To optimize revision traversal */
+static struct commit *painted_commit;
+
 /*
  * NEEDSWORK: the result of this computation must be cached to
  * a dedicated notes tree, keyed by the commit object name.
@@ -47,15 +50,15 @@ static int compute_ref_weight(struct commit *commit)
 	prepare_revision_walk(&revs);
 	while (get_revision(&revs))
 		weight++;
+	painted_commit = commit;
 	return weight;
 }
 
-static int ref_weight(const char *refname, size_t reflen)
+static struct commit *ref_commit(const char *refname, size_t reflen)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
 	struct commit *commit;
-	struct rev_name *name;
 
 	strbuf_add(&buf, refname, reflen);
 	if (get_sha1(buf.buf, sha1))
@@ -65,9 +68,16 @@ static int ref_weight(const char *refname, size_t reflen)
 	commit = lookup_commit_reference_gently(sha1, 0);
 	if (!commit)
 		die("Internal error: cannot look up commit '%s'", buf.buf);
+	return commit;
+}
+
+static int ref_weight(struct commit *commit, const char *refname, size_t reflen)
+{
+	struct rev_name *name;
+
 	name = commit->util;
 	if (!name)
-		die("Internal error: a tip without name '%s'", buf.buf);
+		die("Internal error: a tip without name '%.*s'", (int) reflen, refname);
 	if (!name->weight)
 		name->weight = compute_ref_weight(commit);
 	return name->weight;
@@ -76,6 +86,7 @@ static int ref_weight(const char *refname, size_t reflen)
 static int tip_weight_cmp(const char *a, const char *b)
 {
 	size_t reflen_a, reflen_b;
+	struct commit *commit_a, *commit_b;
 	static const char traversal[] = "^~";
 
 	/*
@@ -89,7 +100,25 @@ static int tip_weight_cmp(const char *a, const char *b)
 	if (reflen_a == reflen_b && !memcmp(a, b, reflen_a))
 		return 0;
 
-	return ref_weight(a, reflen_a) - ref_weight(b, reflen_b);
+	commit_a = ref_commit(a, reflen_a);
+	commit_b = ref_commit(b, reflen_b);
+
+	/* Have we painted either one of these recently? */
+	if (commit_a == painted_commit &&
+	    (commit_b->object.flags & SHOWN)) {
+		/*
+		 * We know b can be reached from a, so b must be older
+		 * (lighter, as it has fewer commits behind it) than
+		 * a.
+		 */
+		return 1;
+	} else if (commit_b == painted_commit &&
+		   (commit_a->object.flags & SHOWN)) {
+		/* Likewise */
+		return -1;
+	}
+
+	return ref_weight(commit_a, a, reflen_a) - ref_weight(commit_b, b, reflen_b);
 }
 
 static long cutoff = LONG_MAX;
-- 
1.7.12.321.g60f00e5
