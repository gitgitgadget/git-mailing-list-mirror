From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge --no-edit: do not add comments meant for "--edit" mode
Date: Mon, 31 Dec 2012 10:33:12 -0800
Message-ID: <7vehi6dqc7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 19:33:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpkB5-0008Ew-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 19:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab2LaSdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 13:33:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab2LaSdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 13:33:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B065B8E3;
	Mon, 31 Dec 2012 13:33:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=X
	lP1IkSM+euB9YJhgxLkX/jMUa4=; b=Rk505lXPcTENOirEpNAhoa/Fx6JHLRUgL
	ImVLVqSJ2tDrZOgqoV5VZhLhKC4+EPcJrbKHQWZxQ/x2xsd/n2e1+buceT+tQvp7
	ixQDpbJpFF6nfKo1XgjbwmSypJci/aCYYF+t80NPPdiDbpWERAhEeST7VMnlkPa9
	Zd107I6PjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=jQc
	GGno0fUIYiBtbNGCAqohuoLRYoZKwQbdiyBTktaAsFCyR1D837qW+ZjJmnXNkmPu
	JSMrlgAystZfNJLjQYQ1eteouU2R8yv8/EDsbdvgQNzwjQlrDxi9ckMfeXFDZQKU
	hKtwCNxOXBdzUrvjvDgswVA/gSJVhb0FB41mFNkY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C931B8E2;
	Mon, 31 Dec 2012 13:33:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F2DEB8DF; Mon, 31 Dec 2012
 13:33:14 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 898B12A6-5378-11E2-A269-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212359>

The credit lines "By" and "Via" to credit authors and committers for
their contributions on the side branch are meant as a hint to the
integrator to decide whom to mention in the log message text.  After
the integrator saves the message in the editor, they are meant to go
away and that is why they are commented out.

When a merge is recorded without editing the generated message,
however, its contents do not go through the normal stripspace()
and these lines are left in the merge.

Stop producing them when we know the merge is going to be recorded
without editing, i.e. when --no-edit is given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin.h               |  3 ++-
 builtin/fmt-merge-msg.c | 21 ++++++++++++++-------
 builtin/merge.c         |  1 +
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin.h b/builtin.h
index dffb34e..3ad8d19 100644
--- a/builtin.h
+++ b/builtin.h
@@ -16,7 +16,8 @@ extern const char git_more_info_string[];
 extern void prune_packed_objects(int);
 
 struct fmt_merge_msg_opts {
-	unsigned add_title:1;
+	unsigned add_title:1,
+		credit_people:1;
 	int shortlog_len;
 };
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 2c4d435..dd1f363 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -232,8 +232,9 @@ static void record_person(int which, struct string_list *people,
 {
 	char *name_buf, *name, *name_end;
 	struct string_list_item *elem;
-	const char *field = (which == 'a') ? "\nauthor " : "\ncommitter ";
+	const char *field;
 
+	field = (which == 'a') ? "\nauthor " : "\ncommitter ";
 	name = strstr(commit->buffer, field);
 	if (!name)
 		return;
@@ -323,7 +324,8 @@ static void add_people_info(struct strbuf *out,
 static void shortlog(const char *name,
 		     struct origin_data *origin_data,
 		     struct commit *head,
-		     struct rev_info *rev, int limit,
+		     struct rev_info *rev,
+		     struct fmt_merge_msg_opts *opts,
 		     struct strbuf *out)
 {
 	int i, count = 0;
@@ -335,6 +337,7 @@ static void shortlog(const char *name,
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 	struct strbuf sb = STRBUF_INIT;
 	const unsigned char *sha1 = origin_data->sha1;
+	int limit = opts->shortlog_len;
 
 	branch = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);
 	if (!branch || branch->type != OBJ_COMMIT)
@@ -351,13 +354,15 @@ static void shortlog(const char *name,
 
 		if (commit->parents && commit->parents->next) {
 			/* do not list a merge but count committer */
-			record_person('c', &committers, commit);
+			if (opts->credit_people)
+				record_person('c', &committers, commit);
 			continue;
 		}
-		if (!count)
+		if (!count && opts->credit_people)
 			/* the 'tip' committer */
 			record_person('c', &committers, commit);
-		record_person('a', &authors, commit);
+		if (opts->credit_people)
+			record_person('a', &authors, commit);
 		count++;
 		if (subjects.nr > limit)
 			continue;
@@ -372,7 +377,8 @@ static void shortlog(const char *name,
 			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
 
-	add_people_info(out, &authors, &committers);
+	if (opts->credit_people)
+		add_people_info(out, &authors, &committers);
 	if (count > limit)
 		strbuf_addf(out, "\n* %s: (%d commits)\n", name, count);
 	else
@@ -635,7 +641,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.items[i].string,
 				 origins.items[i].util,
-				 head, &rev, opts->shortlog_len, out);
+				 head, &rev, opts, out);
 	}
 
 	strbuf_complete_line(out);
@@ -690,6 +696,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.add_title = !message;
+	opts.credit_people = 1;
 	opts.shortlog_len = shortlog_len;
 
 	ret = fmt_merge_msg(&input, &output, &opts);
diff --git a/builtin/merge.c b/builtin/merge.c
index e81fde6..c5d3551 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1324,6 +1324,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			memset(&opts, 0, sizeof(opts));
 			opts.add_title = !have_message;
 			opts.shortlog_len = shortlog_len;
+			opts.credit_people = (0 < option_edit);
 
 			fmt_merge_msg(&merge_names, &merge_msg, &opts);
 			if (merge_msg.len)
-- 
1.8.1.rc3.236.g505e3af
