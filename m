From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] name-rev --weight: cache the computed weight in notes
Date: Wed, 29 Aug 2012 20:50:27 -0700
Message-ID: <1346298629-13730-5-git-send-email-gitster@pobox.com>
References: <1346298629-13730-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 05:51:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vnD-0007zl-FP
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab2H3DvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:51:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab2H3Duk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:50:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 302A988B2
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qR7z
	T+G7C5NXNl+l1tcTzd2OdF4=; b=RZH+iTPAjpb6H2SL1bn2RykyofYnFyCEZPMP
	wnAIPkV1llrALADroA0K7dOWKipPyFAsBC05SFHmFqw+V/9twZkZqKmi8JqIk4+3
	+bMqjMeFZkBijKP+6Qh/B+1kzj2c+bnWSy8ii+8XsdigwyeJ53oavieGgEzfOV58
	na1leRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vPsxyE
	cR8l3LHI+X3Ezz6Gw17iQN+ZMjsJKvyTxmO3hG3TVVz+WnrwqfcmqICYXMfdMfo6
	8buCDWGjIZXBqZ+x85WoWZGJz7SzkTZ9gu2+jDqDL9Hup5X4/YLkWSyBioBPiRKz
	VPkJr098NtEtSiOiJbnDDZdkK3n41Wxw9EybY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E67688B1
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2812688B0 for
 <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.286.g9df01f7
In-Reply-To: <1346298629-13730-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DCFF93B4-F255-11E1-B4F0-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204515>

With the "weight" assigned to tip of each ref, we can give more
intuitive results from "name-rev" that is more suitable to answer
"what is the oldest tag that contains this commit?"  However, this
number is very expensive to compute.

Use the notes-cache mechanism to cache this value.  The result
becomes usable again.

    (priming the cache from scratch)
    $ rm .git/refs/notes/name-rev-weight
    $ /usr/bin/time git name-rev --weight --tags 0136db586c
    0136db586c tags/v3.5-rc1~83^2~81^2~76
    6.06user 0.46system 0:06.54elapsed 99%CPU (0avgtext+0avgdata 1861456maxresident)k
    8inputs+16outputs (0major+128576minor)pagefaults 0swaps

    (with cache already primed)
    $ /usr/bin/time git name-rev --weight --tags 0136db586c
    0136db586c tags/v3.5-rc1~83^2~81^2~76
    0.50user 0.22system 0:00.72elapsed 100%CPU (0avgtext+0avgdata 244224maxresident)k
    0inputs+0outputs (0major+16062minor)pagefaults 0swaps

    (the old "shortest path" version)
    $ /usr/bin/time git name-rev --tags 0136db586c
    0136db586c tags/v3.6-rc1~59^2~56^2~76
    0.31user 0.01system 0:00.32elapsed 100%CPU (0avgtext+0avgdata 243488maxresident)k
    0inputs+0outputs (0major+16000minor)pagefaults 0swaps

This version does not invalidate the cache in the presense of
modified grafts and object replacement, but in a later version we
can compute a hash of the grafts and replacement data and pass it as
the validity token to automatically invalidate the cache when these
data that affects the perceived topology change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 7cdb758..d78eedd 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
+#include "notes-cache.h"
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
@@ -32,10 +33,6 @@ struct rev_name {
  */
 static int use_weight;
 
-/*
- * NEEDSWORK: the result of this computation must be cached to
- * a dedicated notes tree, keyed by the commit object name.
- */
 static int compute_ref_weight(struct commit *commit)
 {
 	struct rev_info revs;
@@ -50,6 +47,32 @@ static int compute_ref_weight(struct commit *commit)
 	return weight;
 }
 
+static struct notes_cache weight_cache;
+static int weight_cache_updated;
+
+static int get_ref_weight(struct commit *commit)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t sz;
+	int weight;
+	char *note;
+
+	note = notes_cache_get(&weight_cache, commit->object.sha1, &sz);
+	if (note && !strtol_i(note, 10, &weight)) {
+		free(note);
+		return weight;
+	}
+	free(note);
+
+	weight = compute_ref_weight(commit);
+	strbuf_addf(&buf, "%d", weight);
+	notes_cache_put(&weight_cache, commit->object.sha1,
+			buf.buf, buf.len);
+	strbuf_release(&buf);
+	weight_cache_updated = 1;
+	return weight;
+}
+
 static int ref_weight(const char *refname, size_t reflen)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -69,7 +92,7 @@ static int ref_weight(const char *refname, size_t reflen)
 	if (!name)
 		die("Internal error: a tip without name '%s'", buf.buf);
 	if (!name->weight)
-		name->weight = compute_ref_weight(commit);
+		name->weight = get_ref_weight(commit);
 	return name->weight;
 }
 
@@ -323,6 +346,22 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 		fwrite(p_start, p - p_start, 1, stdout);
 }
 
+static const char *get_validity_token(void)
+{
+	/*
+	 * In future versions, we may want to automatically invalidate
+	 * the cached weight data whenever grafts and replacement
+	 * changes.  We could do so by (1) reading the contents of the
+	 * grafts file, (2) enumerating the replacement data (original
+	 * object name and replacement object name) and sorting the
+	 * result, and (3) concatenating (1) and (2) and hashing it,
+	 * to come up with "dynamic validity: [0-9a-f]{40}" or something.
+	 *
+	 * In this verison, we simply do not bother ;-).
+	 */
+	return "static validity token";
+}
+
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
@@ -353,6 +392,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	if (all || transform_stdin)
 		cutoff = 0;
 
+	if (use_weight)
+		notes_cache_init(&weight_cache, "name-rev-weight",
+				 get_validity_token());
+
 	for (; argc; argc--, argv++) {
 		unsigned char sha1[20];
 		struct object *o;
@@ -408,5 +451,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				  always, allow_undefined, data.name_only);
 	}
 
+	if (use_weight && weight_cache_updated)
+		notes_cache_write(&weight_cache);
+
 	return 0;
 }
-- 
1.7.12.286.g9df01f7
