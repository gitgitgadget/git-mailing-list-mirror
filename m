From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Out of memory on git log --simplify-by-decoration
 --first-parent
Date: Fri, 08 Jun 2012 15:01:55 -0700
Message-ID: <7vr4tpbgz0.fsf@alter.siamese.dyndns.org>
References: <4FD24330.2030805@lyx.org>
 <7vwr3hbm6x.fsf@alter.siamese.dyndns.org> <4FD25F34.1060400@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:02:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd7Ft-0000Bg-V4
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 00:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878Ab2FHWCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 18:02:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab2FHWB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 18:01:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C73B18180;
	Fri,  8 Jun 2012 18:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6dfJe4kP2irrv+oBp2uI2mQ8Lko=; b=c2Lepl
	Cn331q++5Gdj60nXZyTf+Vc1QA8uYc2q+uPiHC+8WdybQEhLjORY8AYT2qgOmC3p
	AhF7VAqRN3XHp65add8eTqUVDcQhJwJSNudvN/s48TXX/obkycEZ0OcUDypIvgQj
	HCDbBRQq94lr1/pWCO+ZRRMAQ1kxBFUwQGjjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DZL2rB3JFst6/PCnJX/LjJtNQZYYZThE
	A/GD7hN2SncwhmDuS3/NstBKeXDxmmgAIuNVhBDC5xyHcNQee/De/4/egQA3eP32
	/F5ytNCcTcQ7NBtmK56WQJ9fwKfLqbrsbYVfSCMNVkE9BUkXsfA/lXPI9hcJ/9Oe
	y64jCXvTc1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B792C817F;
	Fri,  8 Jun 2012 18:01:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0908F817D; Fri,  8 Jun 2012
 18:01:57 -0400 (EDT)
In-Reply-To: <4FD25F34.1060400@lyx.org> (Vincent van Ravesteijn's message of
 "Fri, 08 Jun 2012 22:23:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9129FCBC-B1B5-11E1-A89D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199535>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Op 8-6-2012 22:09, Junio C Hamano schreef:
>> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>>
>>> git dies after calling the following command on the git repo:
>>>
>>> $ git log f623ca1c...b9cfa4e9 --simplify-by-decoration --first-parent
> ...
>> What information were you trying to get out of the above command?
>
> I was using gitk and I tried to simplify the history a bit, just for
> visualization,... so I tried by checking "Limit to first parent" and
> "Simple history". Then, git errored out with an out-of-memory error.

I see.  I am not sure what it _means_ to simplify merges away in a
history that is showing first-parent-only ancestry, but in any case,
this patch may help.

-- >8 --
Subject: [PATCH] revision: cull side parents before running simplify-merges

The simplify_merges() function needs to look at all history chain to
find the closest ancestor that is relevant after the simplification,
but after --first-parent traversal, side parents haven't been marked
for relevance (they are irrelevant by definition due to the nature
of first-parent-only traversal) nor culled from the parents list of
resulting commits.

Remove these side parents from parents list before starting to
further simplifying the result.

---

 revision.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 935e7a7..acfdbac 100644
--- a/revision.c
+++ b/revision.c
@@ -1358,11 +1358,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->topo_order = 1;
 	} else if (!strcmp(arg, "--simplify-merges")) {
 		revs->simplify_merges = 1;
+		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
 		revs->simplify_history = 0;
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--simplify-by-decoration")) {
 		revs->simplify_merges = 1;
+		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
 		revs->simplify_history = 0;
 		revs->simplify_by_decoration = 1;
@@ -2013,25 +2015,31 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 
 static void simplify_merges(struct rev_info *revs)
 {
-	struct commit_list *list;
+	struct commit_list *list, *next;
 	struct commit_list *yet_to_do, **tail;
+	struct commit *commit;
 
-	if (!revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->lifo);
 	if (!revs->prune)
 		return;
 
 	/* feed the list reversed */
 	yet_to_do = NULL;
-	for (list = revs->commits; list; list = list->next)
-		commit_list_insert(list->item, &yet_to_do);
+	for (list = revs->commits; list; list = next) {
+		commit = list->item;
+		next = list->next;
+		free(list);
+		if (revs->first_parent_only &&
+		    commit->parents && commit->parents->next)
+			commit->parents->next = NULL;
+		commit_list_insert(commit, &yet_to_do);
+	}
 	while (yet_to_do) {
 		list = yet_to_do;
 		yet_to_do = NULL;
 		tail = &yet_to_do;
 		while (list) {
-			struct commit *commit = list->item;
-			struct commit_list *next = list->next;
+			commit = list->item;
+			next = list->next;
 			free(list);
 			list = next;
 			tail = simplify_one(revs, commit, tail);
@@ -2043,9 +2051,10 @@ static void simplify_merges(struct rev_info *revs)
 	revs->commits = NULL;
 	tail = &revs->commits;
 	while (list) {
-		struct commit *commit = list->item;
-		struct commit_list *next = list->next;
 		struct merge_simplify_state *st;
+
+		commit = list->item;
+		next = list->next;
 		free(list);
 		list = next;
 		st = locate_simplify_state(revs, commit);
