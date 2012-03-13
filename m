From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/1] fmt-merge-msg: show those involved in a merged series
Date: Tue, 13 Mar 2012 11:28:50 -0700
Message-ID: <7vzkbkuzh9.fsf_-_@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <4F5EF6EC.20008@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 19:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7WSx-00089S-3y
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 19:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab2CMS2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 14:28:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635Ab2CMS2w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 14:28:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51F3969E1;
	Tue, 13 Mar 2012 14:28:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hGKAnXdpQNkkFJ1vBmd9Pum1i6U=; b=Gd9wuM
	B7Cq/ngwgTNHOfRgsZK/9LbDKYEad8VIn9L2HwFwEtZRPrbKtZIFQnsX8D8TSZu2
	rxqRM2eIcHTwruVQ2ZEjm84gzmZzLsH049x3mcThq+lsqvfPjXFxuFu1DRv5egsN
	a8eE85tygdkZLkiCtJSY3PmJ0llJyWyglOofM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BzWWjbPUBIx9ro6IKCaoG3ztAooFQu0g
	PM4xLqYW1xN4fN13BF9AfT6ii4U+CRhjGKEM74WaNVhbkbRjWljnfeDCxbkx1xNe
	6miaEAhZ1XiFQbQTjbL4jeXyEukimeIpgxj91mnTwMQp6zRE6Z+qntxSkpyMZd3c
	5ZWCTfxles8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 495FE69E0;
	Tue, 13 Mar 2012 14:28:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7127469D6; Tue, 13 Mar 2012
 14:28:51 -0400 (EDT)
In-Reply-To: <4F5EF6EC.20008@viscovery.net> (Johannes Sixt's message of "Tue,
 13 Mar 2012 08:27:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61D59D64-6D3A-11E1-832E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193054>

As we already walk the history of the branch that gets merged to
come up with a short log, let's label it with names of the primary
authors, so that the user who summarizes the merge can easily give
credit to them in the log message.

Also infer the names of "lieutents" to help integrators at higher
level of the food-chain to give credit to them, by counting:

 * The committer of the 'tip' commit that is merged
 * The committer of merge commits that are merged

Often the first one gives the owner of the history being pulled, but
his last pull from his sublieutenants may have been a fast-forward,
in which case the first one would not be.  The latter rule will
count the integrator of the history, so together it might be a
reasonable heuristics.

There are two special cases:

 - The "author" credit is omitted when the series is written solely
   by the same author who is making the merge. The name can be seen
   on the "Author" line of the "git log" output to view the log
   message anyway.

 - The "lieutenant" credit is omitted when there is only one key
   committer in the merged branch and it is the committer who is
   making the merge. Typically this applies to the case where the
   developer merges his own branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a fresh re-roll without all those "oops, this does not compile
   on a compiler that warns about casting between a pointer and intptr_t
   while being happy to see it further casted down to int" fix-up patches.

   A major difference can be seen by the lack of changes to existing
   tests. The tests earlier series touched are all about single developer
   case, and there is no need to update the test vectors for this change.

 builtin/fmt-merge-msg.c  |  114 ++++++++++++++++++++++++++++++++++++++++++++--
 t/t6200-fmt-merge-msg.sh |   27 +++++++++--
 2 files changed, 134 insertions(+), 7 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index c81a7fe..4e7196a 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -27,6 +27,8 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 			merge_log_config = DEFAULT_MERGE_LOG_LEN;
 	} else if (!strcmp(key, "merge.branchdesc")) {
 		use_branch_desc = git_config_bool(key, value);
+	} else {
+		return git_default_config(key, value, cb);
 	}
 	return 0;
 }
@@ -180,6 +182,101 @@ static void add_branch_desc(struct strbuf *out, const char *name)
 	strbuf_release(&desc);
 }
 
+#define util_as_int(elem) ((int)(intptr_t)((elem)->util))
+
+static void record_person(int which, struct string_list *people,
+			  struct commit *commit)
+{
+	char name_buf[MAX_GITNAME], *name, *name_end;
+	struct string_list_item *elem;
+	const char *field = (which == 'a') ? "\nauthor " : "\ncommitter ";
+
+	name = strstr(commit->buffer, field);
+	if (!name)
+		return;
+	name += strlen(field);
+	name_end = strchrnul(name, '<');
+	if (*name_end)
+		name_end--;
+	while (isspace(*name_end) && name <= name_end)
+		name_end--;
+	if (name_end < name || name + MAX_GITNAME <= name_end)
+		return;
+	memcpy(name_buf, name, name_end - name + 1);
+	name_buf[name_end - name + 1] = '\0';
+
+	elem = string_list_lookup(people, name_buf);
+	if (!elem) {
+		elem = string_list_insert(people, name_buf);
+		elem->util = (void *)0;
+	}
+	elem->util = (void*)((intptr_t)(util_as_int(elem) + 1));
+}
+
+static int cmp_string_list_util_as_int(const void *a_, const void *b_)
+{
+	const struct string_list_item *a = a_, *b = b_;
+	return util_as_int(b) - util_as_int(a);
+}
+
+static void add_people_count(struct strbuf *out, struct string_list *people)
+{
+	if (people->nr == 1)
+		strbuf_addf(out, "%s", people->items[0].string);
+	else if (people->nr == 2)
+		strbuf_addf(out, "%s (%d) and %s (%d)",
+			    people->items[0].string,
+			    util_as_int(&people->items[0]),
+			    people->items[1].string,
+			    util_as_int(&people->items[1]));
+	else if (people->nr)
+		strbuf_addf(out, "%s (%d) and others",
+			    people->items[0].string,
+			    util_as_int(&people->items[0]));
+}
+
+static void credit_people(struct strbuf *out,
+			  struct string_list *them,
+			  int kind)
+{
+	const char *label;
+	const char *me;
+
+	if (kind == 'a') {
+		label = "\nBy ";
+		me = git_author_info(IDENT_NO_DATE);
+	} else {
+		label = "\nvia ";
+		me = git_committer_info(IDENT_NO_DATE);
+	}
+
+	if (!them->nr ||
+	    (them->nr == 1 &&
+	     me &&
+	     (me = skip_prefix(me, them->items->string)) != NULL &&
+	     skip_prefix(me, " <")))
+		return;
+	strbuf_addstr(out, label);
+	add_people_count(out, them);
+}
+
+static void add_people_info(struct strbuf *out,
+			    struct string_list *authors,
+			    struct string_list *committers)
+{
+	if (authors->nr)
+		qsort(authors->items,
+		      authors->nr, sizeof(authors->items[0]),
+		      cmp_string_list_util_as_int);
+	if (committers->nr)
+		qsort(committers->items,
+		      committers->nr, sizeof(committers->items[0]),
+		      cmp_string_list_util_as_int);
+
+	credit_people(out, authors, 'a');
+	credit_people(out, committers, 'c');
+}
+
 static void shortlog(const char *name,
 		     struct origin_data *origin_data,
 		     struct commit *head,
@@ -190,6 +287,8 @@ static void shortlog(const char *name,
 	struct commit *commit;
 	struct object *branch;
 	struct string_list subjects = STRING_LIST_INIT_DUP;
+	struct string_list authors = STRING_LIST_INIT_DUP;
+	struct string_list committers = STRING_LIST_INIT_DUP;
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 	struct strbuf sb = STRBUF_INIT;
 	const unsigned char *sha1 = origin_data->sha1;
@@ -199,7 +298,6 @@ static void shortlog(const char *name,
 		return;
 
 	setup_revisions(0, NULL, rev, NULL);
-	rev->ignore_merges = 1;
 	add_pending_object(rev, branch, name);
 	add_pending_object(rev, &head->object, "^HEAD");
 	head->object.flags |= UNINTERESTING;
@@ -208,10 +306,15 @@ static void shortlog(const char *name,
 	while ((commit = get_revision(rev)) != NULL) {
 		struct pretty_print_context ctx = {0};
 
-		/* ignore merges */
-		if (commit->parents && commit->parents->next)
+		if (commit->parents && commit->parents->next) {
+			/* do not list a merge but count committer */
+			record_person('c', &committers, commit);
 			continue;
-
+		}
+		if (!count)
+			/* the 'tip' committer */
+			record_person('c', &committers, commit);
+		record_person('a', &authors, commit);
 		count++;
 		if (subjects.nr > limit)
 			continue;
@@ -226,6 +329,7 @@ static void shortlog(const char *name,
 			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
 
+	add_people_info(out, &authors, &committers);
 	if (count > limit)
 		strbuf_addf(out, "\n* %s: (%d commits)\n", name, count);
 	else
@@ -246,6 +350,8 @@ static void shortlog(const char *name,
 	rev->commits = NULL;
 	rev->pending.nr = 0;
 
+	string_list_clear(&authors, 0);
+	string_list_clear(&committers, 0);
 	string_list_clear(&subjects, 0);
 }
 
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 9a16806..9b50f54 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -35,15 +35,18 @@ test_expect_success setup '
 
 	echo "l3" >two &&
 	test_tick &&
-	git commit -a -m "Left #3" &&
+	GIT_COMMITTER_NAME="Another Committer" \
+	GIT_AUTHOR_NAME="Another Author" git commit -a -m "Left #3" &&
 
 	echo "l4" >two &&
 	test_tick &&
-	git commit -a -m "Left #4" &&
+	GIT_COMMITTER_NAME="Another Committer" \
+	GIT_AUTHOR_NAME="Another Author" git commit -a -m "Left #4" &&
 
 	echo "l5" >two &&
 	test_tick &&
-	git commit -a -m "Left #5" &&
+	GIT_COMMITTER_NAME="Another Committer" \
+	GIT_AUTHOR_NAME="Another Author" git commit -a -m "Left #5" &&
 	git tag tag-l5 &&
 
 	git checkout right &&
@@ -99,6 +102,8 @@ test_expect_success '[merge] summary/log configuration' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* left:
 	  Left #5
 	  Left #4
@@ -144,6 +149,8 @@ test_expect_success 'merge.log=3 limits shortlog length' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* left: (5 commits)
 	  Left #5
 	  Left #4
@@ -159,6 +166,8 @@ test_expect_success 'merge.log=5 shows all 5 commits' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* left:
 	  Left #5
 	  Left #4
@@ -181,6 +190,8 @@ test_expect_success '--log=3 limits shortlog length' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* left: (5 commits)
 	  Left #5
 	  Left #4
@@ -196,6 +207,8 @@ test_expect_success '--log=5 shows all 5 commits' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* left:
 	  Left #5
 	  Left #4
@@ -225,6 +238,8 @@ test_expect_success 'fmt-merge-msg -m' '
 	cat >expected.log <<-EOF &&
 	Sync with left
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* ${apos}left${apos} of $(pwd):
 	  Left #5
 	  Left #4
@@ -256,6 +271,8 @@ test_expect_success 'setup: expected shortlog for two branches' '
 	cat >expected <<-EOF
 	Merge branches ${apos}left${apos} and ${apos}right${apos}
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* left:
 	  Left #5
 	  Left #4
@@ -379,6 +396,8 @@ test_expect_success 'merge-msg two tags' '
 	  Common #2
 	  Common #1
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* tag ${apos}tag-l5${apos}:
 	  Left #5
 	  Left #4
@@ -407,6 +426,8 @@ test_expect_success 'merge-msg tag and branch' '
 	  Common #2
 	  Common #1
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* left:
 	  Left #5
 	  Left #4
-- 
1.7.10.rc0.65.g3445e
