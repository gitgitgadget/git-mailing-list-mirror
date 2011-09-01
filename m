From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] fetch: verify we have everything we need before updating
 our ref
Date: Thu,  1 Sep 2011 15:43:35 -0700
Message-ID: <1314917015-3587-4-git-send-email-gitster@pobox.com>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
 <1314917015-3587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 00:43:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzFzI-0000h6-23
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 00:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578Ab1IAWnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 18:43:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932574Ab1IAWnn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 18:43:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A843B5248
	for <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UXFV
	e+Gn5SRWNEEJbYQHsecqWKM=; b=vqHKXapENJ2z5n2ah6LnZJUxVuEgCvvz7wo9
	jAc74QkpINWO1w/rHm5msZFVHJ6RiVQOTyAgyqoaArxfm6pq7f7xKvxPG+pVPxIE
	iNOUjasqXwuKi8VBoFaJ+r26hlydC7iLY74luH0dIJyEiGONgyj4WlB3T+tGELc7
	f4QX7Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=cQQzRq
	vTOVkcN1S24elXYJn9wUkYx0aGPaIChu78vD+Kdet0VJRcAFgmA0MIENoRdNDh5B
	Mt0ipGoyHbnFBWIyp3Kw6mmLzbVSUIbtmFRFgPieY4WJlezg+8fCJ110W7k+9fVo
	VK63VVXrNGJTo1F6ViWW8Bo+2ZmEPkcqhAAXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A04E35247
	for <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB3A15246 for
 <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.72.g4b5ea
In-Reply-To: <1314917015-3587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D78B0D74-D4EB-11E0-800E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180581>

The "git fetch" command works in two phases. The remote side tells us what
objects are at the tip of the refs we are fetching from, and transfers the
objects missing from our side. After storing the objects in our repository,
we update our remote tracking branches to point at the updated tips of the
refs.

A broken or malicious remote side could send a perfectly well-formed pack
data during the object transfer phase, but there is no guarantee that the
given data actually fill the gap between the objects we originally had and
the refs we are updating to.

Although this kind of breakage can be caught by running fsck after a
fetch, it is much cheaper to verify that everything that is reachable from
the tips of the refs we fetched are indeed fully connected to the tips of
our current set of refs before we update them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c |  119 +++++++++++++++++++++++++++++--------------------------
 1 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f9c41da..bdb03ff 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -345,6 +345,64 @@ static int update_local_ref(struct ref *ref,
 	}
 }
 
+/*
+ * The ref_map records the tips of the refs we are fetching. If
+ *
+ *  $ git rev-list --verify-objects --stdin --not --all
+ *
+ * (feeding all the refs in ref_map on its standard input) does not
+ * error out, that means everything reachable from these updated refs
+ * locally exists and is connected to some of our existing refs.
+ *
+ * Returns 0 if everything is connected, non-zero otherwise.
+ */
+static int check_everything_connected(struct ref *ref_map, int quiet)
+{
+	struct child_process rev_list;
+	const char *argv[] = {"rev-list", "--verify-objects",
+			      "--stdin", "--not", "--all", NULL, NULL};
+	char commit[41];
+	struct ref *ref;
+	int err = 0;
+
+	if (!ref_map)
+		return 0;
+
+	if (quiet)
+		argv[5] = "--quiet";
+
+	memset(&rev_list, 0, sizeof(rev_list));
+	rev_list.argv = argv;
+	rev_list.git_cmd = 1;
+	rev_list.in = -1;
+	rev_list.no_stdout = 1;
+	rev_list.no_stderr = quiet;
+	if (start_command(&rev_list))
+		return error(_("Could not run 'git rev-list'"));
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	memcpy(commit + 40, "\n", 2);
+	for (ref = ref_map; ref; ref = ref->next) {
+		memcpy(commit, sha1_to_hex(ref->old_sha1), 40);
+		if (write_in_full(rev_list.in, commit, 41) < 0) {
+			if (errno != EPIPE && errno != EINVAL)
+				error(_("failed write to rev-list: %s"),
+				      strerror(errno));
+			err = -1;
+			break;
+		}
+	}
+	if (close(rev_list.in)) {
+		error(_("failed to close rev-list's stdin: %s"), strerror(errno));
+		err = -1;
+	}
+
+	sigchain_pop(SIGPIPE);
+
+	return finish_command(&rev_list) || err;
+}
+
 static int store_updated_refs(const char *raw_url, const char *remote_name,
 		struct ref *ref_map)
 {
@@ -364,6 +422,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url = transport_anonymize_url(raw_url);
 	else
 		url = xstrdup("foreign");
+
+	if (check_everything_connected(ref_map, 0))
+		return error(_("%s did not send all necessary objects\n"), url);
+
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
 
@@ -457,24 +519,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
  * We would want to bypass the object transfer altogether if
  * everything we are going to fetch already exists and is connected
  * locally.
- *
- * The refs we are going to fetch are in ref_map.  If running
- *
- *  $ git rev-list --objects --stdin --not --all
- *
- * (feeding all the refs in ref_map on its standard input)
- * does not error out, that means everything reachable from the
- * refs we are going to fetch exists and is connected to some of
- * our existing refs.
  */
 static int quickfetch(struct ref *ref_map)
 {
-	struct child_process revlist;
-	struct ref *ref;
-	int err;
-	const char *argv[] = {"rev-list",
-		"--quiet", "--objects", "--stdin", "--not", "--all", NULL};
-
 	/*
 	 * If we are deepening a shallow clone we already have these
 	 * objects reachable.  Running rev-list here will return with
@@ -484,47 +531,7 @@ static int quickfetch(struct ref *ref_map)
 	 */
 	if (depth)
 		return -1;
-
-	if (!ref_map)
-		return 0;
-
-	memset(&revlist, 0, sizeof(revlist));
-	revlist.argv = argv;
-	revlist.git_cmd = 1;
-	revlist.no_stdout = 1;
-	revlist.no_stderr = 1;
-	revlist.in = -1;
-
-	err = start_command(&revlist);
-	if (err) {
-		error(_("could not run rev-list"));
-		return err;
-	}
-
-	/*
-	 * If rev-list --stdin encounters an unknown commit, it terminates,
-	 * which will cause SIGPIPE in the write loop below.
-	 */
-	sigchain_push(SIGPIPE, SIG_IGN);
-
-	for (ref = ref_map; ref; ref = ref->next) {
-		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
-		    write_str_in_full(revlist.in, "\n") < 0) {
-			if (errno != EPIPE && errno != EINVAL)
-				error(_("failed write to rev-list: %s"), strerror(errno));
-			err = -1;
-			break;
-		}
-	}
-
-	if (close(revlist.in)) {
-		error(_("failed to close rev-list's stdin: %s"), strerror(errno));
-		err = -1;
-	}
-
-	sigchain_pop(SIGPIPE);
-
-	return finish_command(&revlist) || err;
+	return check_everything_connected(ref_map, 1);
 }
 
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
-- 
1.7.7.rc0.72.g4b5ea
