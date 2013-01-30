From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/8] fetch: fetch objects by their exact SHA-1 object
 names
Date: Wed, 30 Jan 2013 10:45:41 -0800
Message-ID: <1359571542-19852-8-git-send-email-gitster@pobox.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cg5-0004fU-Up
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694Ab3A3SqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:46:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756650Ab3A3Sp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:45:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 414F9C414;
	Wed, 30 Jan 2013 13:45:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RcA6
	petF+NPmVw/8et/hyphc6yQ=; b=DL9iApL/0sRokPpAfbhRHcpo5FFXLUtLlF1y
	02yOgdVGSNv9nYR2nmrfo0APxlPgdJpIl66hj/YXHVEMuyicA22/zn7gWpvui7ml
	PsEQFVw2R//hZ+WMxEkeftS2AJufbKm6TVyvqnQAtnEEGoPxUpmQmLh/k/AiDqgH
	5T7kG6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	d15WoKgwt//T2+GxBuBPZlbuIL1ROhiwuDM19c+aOFIy5Zb+CidbZpjqoPSNea6e
	8gN2FUwo0kSKRcQnrZvJncr8IjEteJ12W+rjBt/LjShtcqjbSzVjFkt8wCoYaiR3
	Z05JuG2usKHHNQGss6WT3FIIi34GrRXd31Xe7EhTAGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36707C413;
	Wed, 30 Jan 2013 13:45:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CDFEC411; Wed, 30 Jan 2013
 13:45:58 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.589.ga9b91ac
In-Reply-To: <1359571542-19852-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 494F57A4-6B0D-11E2-BBF5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215055>

Teach "git fetch" to accept an exact SHA-1 object name the user may
obtain out of band on the LHS of a pathspec, and send it on a "want"
message when the server side advertises the allow-tip-sha1-in-want
capability.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fetch-pack.c          | 22 +++++++++++++++++++++-
 remote.c              | 12 +++++++++++-
 remote.h              |  1 +
 t/t5516-fetch-push.sh | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 915c0b7..70db646 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -36,7 +36,7 @@ static int marked;
 #define MAX_IN_VAIN 256
 
 static struct commit_list *rev_list;
-static int non_common_revs, multi_ack, use_sideband;
+static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -563,6 +563,21 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 	}
 
+	/* Append unmatched requests to the list */
+	if (allow_tip_sha1_in_want) {
+		for (i = 0; i < nr_sought; i++) {
+			ref = sought[i];
+			if (ref->matched)
+				continue;
+			if (get_sha1_hex(ref->name, ref->old_sha1))
+				continue;
+
+			ref->matched = 1;
+			*newtail = ref;
+			ref->next = NULL;
+			newtail = &ref->next;
+		}
+	}
 	*refs = newlist;
 }
 
@@ -803,6 +818,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband = 1;
 	}
+	if (server_supports("allow-tip-sha1-in-want")) {
+		if (args->verbose)
+			fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
+		allow_tip_sha1_in_want = 1;
+	}
 	if (!server_supports("thin-pack"))
 		args->use_thin_pack = 0;
 	if (!server_supports("no-progress"))
diff --git a/remote.c b/remote.c
index 1b7828d..1118d05 100644
--- a/remote.c
+++ b/remote.c
@@ -15,6 +15,7 @@ static struct refspec s_tag_refspec = {
 	0,
 	1,
 	0,
+	0,
 	"refs/tags/*",
 	"refs/tags/*"
 };
@@ -565,9 +566,13 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
 
 		if (fetch) {
+			unsigned char unused[40];
+
 			/* LHS */
 			if (!*rs[i].src)
 				; /* empty is ok; it means "HEAD" */
+			else if (llen == 40 && !get_sha1_hex(rs[i].src, unused))
+				rs[i].exact_sha1 = 1; /* ok */
 			else if (!check_refname_format(rs[i].src, flags))
 				; /* valid looking ref is ok */
 			else
@@ -1495,7 +1500,12 @@ int get_fetch_map(const struct ref *remote_refs,
 	} else {
 		const char *name = refspec->src[0] ? refspec->src : "HEAD";
 
-		ref_map = get_remote_ref(remote_refs, name);
+		if (refspec->exact_sha1) {
+			ref_map = alloc_ref(name);
+			get_sha1_hex(name, ref_map->old_sha1);
+		} else {
+			ref_map = get_remote_ref(remote_refs, name);
+		}
 		if (!missing_ok && !ref_map)
 			die("Couldn't find remote ref %s", name);
 		if (ref_map) {
diff --git a/remote.h b/remote.h
index 251d8fd..f7b08f1 100644
--- a/remote.h
+++ b/remote.h
@@ -62,6 +62,7 @@ struct refspec {
 	unsigned force : 1;
 	unsigned pattern : 1;
 	unsigned matching : 1;
+	unsigned exact_sha1 : 1;
 
 	char *src;
 	char *dst;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 852efb6..522056f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1037,6 +1037,40 @@ test_expect_success 'push --prune refspec' '
 	! check_push_result $the_first_commit tmp/foo tmp/bar
 '
 
+test_expect_success 'fetch exact SHA1' '
+	mk_test heads/master hidden/one &&
+	git push testrepo master:refs/hidden/one &&
+	(
+		cd testrepo &&
+		git config transfer.hiderefs refs/hidden
+	) &&
+	check_push_result $the_commit hidden/one &&
+
+	mk_child child &&
+	(
+		cd child &&
+
+		# make sure $the_commit does not exist here
+		git repack -a -d &&
+		git prune &&
+		test_must_fail git cat-file -t $the_commit &&
+
+		# fetching the hidden object should fail by default
+		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy &&
+		test_must_fail git rev-parse --verify refs/heads/copy &&
+
+		# the server side can allow it to succeed
+		(
+			cd ../testrepo &&
+			git config uploadpack.allowtipsha1inwant true
+		) &&
+
+		git fetch -v ../testrepo $the_commit:refs/heads/copy &&
+		result=$(git rev-parse --verify refs/heads/copy) &&
+		test "$the_commit" = "$result"
+	)
+'
+
 test_expect_success 'push to update a hidden ref' '
 	mk_test heads/master hidden/one hidden/two hidden/three &&
 	(
-- 
1.8.1.2.589.ga9b91ac
