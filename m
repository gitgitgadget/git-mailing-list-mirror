From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Mon, 05 Mar 2012 13:34:38 -0800
Message-ID: <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 22:34:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4fYP-0004fM-Rs
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 22:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab2CEVeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 16:34:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab2CEVen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 16:34:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8B60626C;
	Mon,  5 Mar 2012 16:34:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mv7spRUZQABUvnp+wU6Qf3FDgHg=; b=vJgsnE
	MqoJ9LA/LjjUueOHVkdqzVWXsvl61dk1f5XzCIVU07v0mTGzSAcMiSxwjUSbq+0S
	dd0p/W1N73ZtHCsJaLbbJgt52c4kRluKB1l/Bvipwc/nAgarQ94+5rNH/L+x8MRw
	DnPTuy+z5oCfI3vwcMJI3QGoMeK8PBIbxGGDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VFPxTsAi5FpC+isMcAsU7gv3aphWbj5i
	4Ul7wDl72LBRdaz9PmzBKT8CnVaW/Oxh7nQ8d1R1+N9HdB7JAIGk8+e6oYYTZWmm
	L+kUd1nRnnWdvFe8q0oVI5hGGm+L8hSYgpEtvgTumtWJ2yN27rTnm/eRO2hNvlWV
	GAC5T28f1EA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B011D626B;
	Mon,  5 Mar 2012 16:34:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 177476268; Mon,  5 Mar 2012
 16:34:40 -0500 (EST)
In-Reply-To: <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 5 Mar 2012 12:33:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 043A6854-670B-11E1-BC61-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192274>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Of course, since you do it in branches that you maintain, to you
> committer information is pointless. But I pull from submaintainers,
> and then it really is the committer part that is way more relevant.

Fair enough.

I do not think a simple population count on the committer field is a
good heuristics.  For example, I suspect that you would want to see
a lot more weight given to names of committers near the tip of the
history you are pulling from, iow, if your lieutenant pulled 100
commit series by a leaf contributor, you still want to see the name
of the lieutenant, not the leaf contributor, even the latter may
have far more commits.

This patch punts the deep thinking part and just picks the tip
committer and counts only merges in the history you are pulling in.
It may not be a very good heuristics, but the code structure should
be a good place to start.

Changes to the test vector in t6200 illustrate how the output should
look like.

-- >8 --
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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fmt-merge-msg.c         |  101 +++++++++++++++++++++++++++++++++++++--
 t/t6200-fmt-merge-msg.sh        |   32 +++++++++++--
 t/t7600-merge.sh                |    1 +
 t/t7604-merge-custom-message.sh |    1 +
 4 files changed, 128 insertions(+), 7 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index c81a7fe..b2465b4 100644
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
@@ -180,6 +182,89 @@ static void add_branch_desc(struct strbuf *out, const char *name)
 	strbuf_release(&desc);
 }
 
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
+		elem->util = (void *) 0;
+	}
+	elem->util = (void*)(((intptr_t)elem->util) + 1);
+}
+
+#define util_as_int(elem) ((intptr_t)((elem)->util))
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
+			    (int)util_as_int(&people->items[0]),
+			    people->items[1].string,
+			    (int)util_as_int(&people->items[1]));
+	else if (people->nr)
+		strbuf_addf(out, "%s (%d) and others",
+			    people->items[0].string,
+			    (int)util_as_int(&people->items[0]));
+}
+
+static int committer_is_me(const char *name)
+{
+	int namelen = strlen(name);
+	const char *me = git_committer_info(IDENT_NO_DATE);
+	return (me && !memcmp(me, name, namelen) &&
+		!memcmp(me + namelen, " <", 2));
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
+	strbuf_addstr(out, "\nBy ");
+	add_people_count(out, authors);
+	if (committers->nr == 1 &&
+	    committer_is_me(committers->items->string))
+		return;
+	strbuf_addstr(out, "\nvia ");
+	add_people_count(out, committers);
+}
+
 static void shortlog(const char *name,
 		     struct origin_data *origin_data,
 		     struct commit *head,
@@ -190,6 +275,8 @@ static void shortlog(const char *name,
 	struct commit *commit;
 	struct object *branch;
 	struct string_list subjects = STRING_LIST_INIT_DUP;
+	struct string_list authors = STRING_LIST_INIT_DUP;
+	struct string_list committers = STRING_LIST_INIT_DUP;
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 	struct strbuf sb = STRBUF_INIT;
 	const unsigned char *sha1 = origin_data->sha1;
@@ -199,7 +286,6 @@ static void shortlog(const char *name,
 		return;
 
 	setup_revisions(0, NULL, rev, NULL);
-	rev->ignore_merges = 1;
 	add_pending_object(rev, branch, name);
 	add_pending_object(rev, &head->object, "^HEAD");
 	head->object.flags |= UNINTERESTING;
@@ -208,10 +294,15 @@ static void shortlog(const char *name,
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
@@ -226,6 +317,7 @@ static void shortlog(const char *name,
 			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
 
+	add_people_info(out, &authors, &committers);
 	if (count > limit)
 		strbuf_addf(out, "\n* %s: (%d commits)\n", name, count);
 	else
@@ -246,6 +338,7 @@ static void shortlog(const char *name,
 	rev->commits = NULL;
 	rev->pending.nr = 0;
 
+	string_list_clear(&authors, 0);
 	string_list_clear(&subjects, 0);
 }
 
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 9a16806..b90015d 100755
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
@@ -263,6 +280,7 @@ test_expect_success 'setup: expected shortlog for two branches' '
 	  Common #2
 	  Common #1
 
+	By A U Thor
 	* right:
 	  Right #5
 	  Right #4
@@ -353,6 +371,7 @@ test_expect_success 'merge-msg tag' '
 	cat >expected <<-EOF &&
 	Merge tag ${apos}tag-r3${apos}
 
+	By A U Thor
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
 	  Common #2
@@ -374,11 +393,14 @@ test_expect_success 'merge-msg two tags' '
 	cat >expected <<-EOF &&
 	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos}
 
+	By A U Thor
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
 	  Common #2
 	  Common #1
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* tag ${apos}tag-l5${apos}:
 	  Left #5
 	  Left #4
@@ -402,11 +424,14 @@ test_expect_success 'merge-msg tag and branch' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos}
 
+	By A U Thor
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
 	  Common #2
 	  Common #1
 
+	By Another Author (3) and A U Thor (2)
+	via Another Committer
 	* left:
 	  Left #5
 	  Left #4
@@ -431,6 +456,7 @@ test_expect_success 'merge-msg lots of commits' '
 		cat <<-EOF &&
 		Merge branch ${apos}long${apos}
 
+		By A U Thor
 		* long: (35 commits)
 		EOF
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9e27bbf..e09b932 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -58,6 +58,7 @@ create_merge_msgs () {
 	} >squash.1-5-9 &&
 	echo >msg.nolog &&
 	{
+		echo "By A U Thor" &&
 		echo "* tag 'c3':" &&
 		echo "  commit 3" &&
 		echo
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 89619cf..b84cea3 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -11,6 +11,7 @@ create_merge_msgs() {
 
 	cp exp.subject exp.log &&
 	echo >>exp.log "" &&
+	echo >>exp.log "By A U Thor" &&
 	echo >>exp.log "* tag 'c2':" &&
 	echo >>exp.log "  c2"
 }
-- 
1.7.9.2.413.ge58a8e
