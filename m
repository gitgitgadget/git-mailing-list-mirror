From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-remote SEGV on t5505 test.
Date: Thu, 17 Jul 2008 21:25:32 -0700
Message-ID: <7vsku7es3n.fsf@gitster.siamese.dyndns.org>
References: <g5osl6$4g3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: SungHyun Nam <namsh@posdata.co.kr>
X-From: git-owner@vger.kernel.org Fri Jul 18 06:26:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJhYJ-0004SU-78
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 06:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYGREZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 00:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbYGREZm
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 00:25:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbYGREZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 00:25:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 98D0230024;
	Fri, 18 Jul 2008 00:25:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C481530022; Fri, 18 Jul 2008 00:25:34 -0400 (EDT)
In-Reply-To: <g5osl6$4g3$1@ger.gmane.org> (SungHyun Nam's message of "Fri, 18
 Jul 2008 10:46:02 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93AA3D48-5481-11DD-BDB5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88981>

SungHyun Nam <namsh@posdata.co.kr> writes:

> And the 'skip_prefix()' returns NULL in this case.
> (The old skip_prefix() never returns NULL).

Thanks.  Something like this?

 builtin-remote.c |   51 +++++++++++++++++++--------------------------------
 1 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 1491354..db12668 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -147,6 +147,15 @@ struct branch_info {
 
 static struct path_list branch_list;
 
+static const char *abbrev_ref(const char *name, const char *prefix)
+{
+	const char *abbrev = skip_prefix(name, prefix);
+	if (abbrev)
+		return abbrev;
+	return name;
+}
+#define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
+
 static int config_read_branches(const char *key, const char *value, void *cb)
 {
 	if (!prefixcmp(key, "branch.")) {
@@ -176,18 +185,12 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			info->remote = xstrdup(value);
 		} else {
 			char *space = strchr(value, ' ');
-			const char *ptr = skip_prefix(value, "refs/heads/");
-			if (ptr)
-				value = ptr;
+			value = abbrev_branch(value);
 			while (space) {
 				char *merge;
 				merge = xstrndup(value, space - value);
 				path_list_append(merge, &info->merge);
-				ptr = skip_prefix(space + 1, "refs/heads/");
-				if (ptr)
-					value = ptr;
-				else
-					value = space + 1;
+				value = abbrev_branch(space + 1);
 				space = strchr(value, ' ');
 			}
 			path_list_append(xstrdup(value), &info->merge);
@@ -219,12 +222,7 @@ static int handle_one_branch(const char *refname,
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec)) {
 		struct path_list_item *item;
-		const char *name, *ptr;
-		ptr = skip_prefix(refspec.src, "refs/heads/");
-		if (ptr)
-			name = ptr;
-		else
-			name = refspec.src;
+		const char *name = abbrev_branch(refspec.src);
 		/* symbolic refs pointing nowhere were handled already */
 		if ((flags & REF_ISSYMREF) ||
 				unsorted_path_list_has_path(&states->tracked,
@@ -253,7 +251,6 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 		struct path_list *target = &states->tracked;
 		unsigned char sha1[20];
 		void *util = NULL;
-		const char *ptr;
 
 		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
 			target = &states->new;
@@ -262,10 +259,7 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 			if (hashcmp(sha1, ref->new_sha1))
 				util = &states;
 		}
-		ptr = skip_prefix(ref->name, "refs/heads/");
-		if (!ptr)
-			ptr = ref->name;
-		path_list_append(ptr, target)->util = util;
+		path_list_append(abbrev_branch(ref->name), target)->util = util;
 	}
 	free_refs(fetch_map);
 
@@ -460,10 +454,8 @@ static int append_ref_to_tracked_list(const char *refname,
 
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
-	if (!remote_find_tracking(states->remote, &refspec)) {
-		path_list_append(skip_prefix(refspec.src, "refs/heads/"),
-			&states->tracked);
-	}
+	if (!remote_find_tracking(states->remote, &refspec))
+		path_list_append(abbrev_branch(refspec.src), &states->tracked);
 
 	return 0;
 }
@@ -530,15 +522,10 @@ static int show(int argc, const char **argv)
 					"es" : "");
 			for (i = 0; i < states.remote->push_refspec_nr; i++) {
 				struct refspec *spec = states.remote->push + i;
-				const char *p = "", *q = "";
-				if (spec->src)
-					p = skip_prefix(spec->src, "refs/heads/");
-				if (spec->dst)
-					q = skip_prefix(spec->dst, "refs/heads/");
 				printf(" %s%s%s%s", spec->force ? "+" : "",
-					p ? p : spec->src,
-					spec->dst ? ":" : "",
-					q ? q : spec->dst);
+				       abbrev_branch(spec->src),
+				       spec->dst ? ":" : "",
+				       spec->dst ? abbrev_branch(spec->dst) : "");
 			}
 			printf("\n");
 		}
@@ -588,7 +575,7 @@ static int prune(int argc, const char **argv)
 				result |= delete_ref(refname, NULL);
 
 			printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
-			       skip_prefix(refname, "refs/remotes/"));
+			       abbrev_ref(refname, "refs/remotes/"));
 		}
 
 		/* NEEDSWORK: free remote */
