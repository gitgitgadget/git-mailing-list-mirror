Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF3D201B0
	for <e@80x24.org>; Sun, 19 Feb 2017 02:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdBSCI2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 21:08:28 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:54520 "EHLO
        homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751289AbdBSCI0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Feb 2017 21:08:26 -0500
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 04D14348070
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 18:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        in-reply-to:references:from:date:subject:to
        :content-transfer-encoding:message-id:mime-version; s=
        mattmccutchen.net; bh=cg5CbljFk2EEM3rEbhc0z9NsEBg=; b=ZC0AoIQcyG
        4e6vxIuE9r6pVR+Bv2yLa4twvLQ29IG666KADd39ainVwM1baOYRJR4IIwm/Fc6C
        Xy74zaO4BQRXFDOBZNF+vnk2oEkZ18TJpZzA8JsHHNGIpC7hYS5yFFT7klSGqjjF
        uZp1EDhNcSOMs2MizOPtNWyHq9///NTQc=
Received: from main (c-174-63-86-113.hsd1.ma.comcast.net [174.63.86.113])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id A69D4348062
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 18:08:01 -0800 (PST)
In-Reply-To: <xmqq60kfezr9.fsf@gitster.mtv.corp.google.com>
References: <xmqq60kfezr9.fsf@gitster.mtv.corp.google.com>
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Sat, 18 Feb 2017 20:55:08 -0500
Subject: [PATCH] fetch: print an error when declining to request an
 unadvertised object
To:     git@vger.kernel.org
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Content-Transfer-Encoding: 7bit
Message-ID: <1487470080.3570.8.camel@mattmccutchen.net>
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently "git fetch REMOTE SHA1" silently exits 1 if the server doesn't
allow requests for unadvertised objects by sha1.  The more common case
of requesting a nonexistent ref normally triggers a die() in
get_fetch_map, so "git fetch" wasn't bothering to check after the fetch
that it got all the refs it sought, like "git fetch-pack" does near the
end of cmd_fetch_pack.

Move the code from cmd_fetch_pack to a new function,
report_unmatched_refs, that is called by fetch_refs_via_pack as part of
"git fetch".  Also, change filter_refs (which checks whether a request
for an unadvertised object should be sent to the server) to set a new
match status on the "struct ref" when the request is not allowed, and
have report_unmatched_refs check for this status and print a special
error message, "Server does not allow request for unadvertised object".

Finally, add a simple test case for "git fetch REMOTE SHA1".

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 builtin/fetch-pack.c  |  7 +------
 fetch-pack.c          | 51 ++++++++++++++++++++++++++++++++++++++-------------
 fetch-pack.h          |  9 +++++++++
 remote.h              |  9 +++++++--
 t/t5516-fetch-push.sh |  3 ++-
 transport.c           | 14 +++++++++-----
 6 files changed, 66 insertions(+), 27 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cfe9e44..2a1c1c2 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -219,12 +219,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	 * remote no-such-ref' would silently succeed without issuing
 	 * an error.
 	 */
-	for (i = 0; i < nr_sought; i++) {
-		if (!sought[i] || sought[i]->matched)
-			continue;
-		error("no such remote ref %s", sought[i]->name);
-		ret = 1;
-	}
+	ret |= report_unmatched_refs(sought, nr_sought);
 
 	while (ref) {
 		printf("%s %s\n",
diff --git a/fetch-pack.c b/fetch-pack.c
index 601f077..f12bfcd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -578,7 +578,7 @@ static void filter_refs(struct fetch_pack_args *args,
 					break; /* definitely do not have it */
 				else if (cmp == 0) {
 					keep = 1; /* definitely have it */
-					sought[i]->matched = 1;
+					sought[i]->match_status = REF_MATCHED;
 				}
 				i++;
 			}
@@ -598,22 +598,24 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 
 	/* Append unmatched requests to the list */
-	if ((allow_unadvertised_object_request &
-	    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
-		for (i = 0; i < nr_sought; i++) {
-			unsigned char sha1[20];
+	for (i = 0; i < nr_sought; i++) {
+		unsigned char sha1[20];
 
-			ref = sought[i];
-			if (ref->matched)
-				continue;
-			if (get_sha1_hex(ref->name, sha1) ||
-			    ref->name[40] != '\0' ||
-			    hashcmp(sha1, ref->old_oid.hash))
-				continue;
+		ref = sought[i];
+		if (ref->match_status != REF_NOT_MATCHED)
+			continue;
+		if (get_sha1_hex(ref->name, sha1) ||
+		    ref->name[40] != '\0' ||
+		    hashcmp(sha1, ref->old_oid.hash))
+			continue;
 
-			ref->matched = 1;
+		if ((allow_unadvertised_object_request &
+		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
+		} else {
+			ref->match_status = REF_UNADVERTISED_NOT_ALLOWED;
 		}
 	}
 	*refs = newlist;
@@ -1094,3 +1096,26 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	clear_shallow_info(&si);
 	return ref_cpy;
 }
+
+int report_unmatched_refs(struct ref **sought, int nr_sought)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < nr_sought; i++) {
+		if (!sought[i])
+			continue;
+		switch (sought[i]->match_status) {
+		case REF_MATCHED:
+			continue;
+		case REF_NOT_MATCHED:
+			error(_("no such remote ref %s"), sought[i]->name);
+			break;
+		case REF_UNADVERTISED_NOT_ALLOWED:
+			error(_("Server does not allow request for unadvertised object %s"),
+			      sought[i]->name);
+			break;
+		}
+		ret = 1;
+	}
+	return ret;
+}
diff --git a/fetch-pack.h b/fetch-pack.h
index c912e3d..fd4d80e 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -45,4 +45,13 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct sha1_array *shallow,
 		       char **pack_lockfile);
 
+/*
+ * Print an appropriate error message for each sought ref that wasn't
+ * matched.  Return 0 if all sought refs were matched, otherwise 1.
+ *
+ * The type of "sought" should be "const struct ref *const *" but for
+ * http://stackoverflow.com/questions/5055655/double-pointer-const-correctness-warnings-in-c .
+ */
+int report_unmatched_refs(struct ref **sought, int nr_sought);
+
 #endif
diff --git a/remote.h b/remote.h
index 9248811..0b9d8c4 100644
--- a/remote.h
+++ b/remote.h
@@ -89,8 +89,13 @@ struct ref {
 		force:1,
 		forced_update:1,
 		expect_old_sha1:1,
-		deletion:1,
-		matched:1;
+		deletion:1;
+
+	enum {
+		REF_NOT_MATCHED = 0, /* initial value */
+		REF_MATCHED,
+		REF_UNADVERTISED_NOT_ALLOWED
+	} match_status;
 
 	/*
 	 * Order is important here, as we write to FETCH_HEAD
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 26b2caf..78f3b8e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1098,7 +1098,8 @@ test_expect_success 'fetch exact SHA1' '
 		test_must_fail git cat-file -t $the_commit &&
 
 		# fetching the hidden object should fail by default
-		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy &&
+		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
+		test_i18ngrep "Server does not allow request for unadvertised object" err &&
 		test_must_fail git rev-parse --verify refs/heads/copy &&
 
 		# the server side can allow it to succeed
diff --git a/transport.c b/transport.c
index 04e5d66..c377907 100644
--- a/transport.c
+++ b/transport.c
@@ -204,6 +204,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
+	int ret = 0;
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
 	char *dest = xstrdup(transport->url);
@@ -241,19 +242,22 @@ static int fetch_refs_via_pack(struct transport *transport,
 			  &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
-	if (finish_connect(data->conn)) {
-		free_refs(refs);
-		refs = NULL;
-	}
+	if (finish_connect(data->conn))
+		ret = -1;
 	data->conn = NULL;
 	data->got_remote_heads = 0;
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
 
+	if (refs == NULL)
+		ret = -1;
+	if (report_unmatched_refs(to_fetch, nr_heads))
+		ret = -1;
+
 	free_refs(refs_tmp);
 	free_refs(refs);
 	free(dest);
-	return (refs ? 0 : -1);
+	return ret;
 }
 
 static int push_had_errors(struct ref *ref)
-- 
2.9.3


