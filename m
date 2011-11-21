From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Mon, 21 Nov 2011 14:18:03 -0500
Message-ID: <CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Gerd Knops <gerti@bitart.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 20:18:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSZNb-0005pq-6a
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 20:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632Ab1KUTSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 14:18:05 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46108 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab1KUTSE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 14:18:04 -0500
Received: by ggnr5 with SMTP id r5so2696157ggn.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 11:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VVPFT91jZ65Fv2UNVqDwlf2eMehsDLwxdUGfXB2WeUs=;
        b=lW4RQyRXqZiNnx1IBPOKv1oPDnPAGugDJQbykZCoDgxDTXMosp4gpmT3bkjJgva1N7
         BIPsUkby9zYQZejvn+S7p8OfqV/hMe2FV0R9pu5h58Gt577+Tl7JPWi3q1OaRlqq4rK3
         EU9KMioVnVrPFEwNZl4864XMEH11WegSMl2T0=
Received: by 10.236.192.233 with SMTP id i69mr22417252yhn.60.1321903083357;
 Mon, 21 Nov 2011 11:18:03 -0800 (PST)
Received: by 10.146.1.15 with HTTP; Mon, 21 Nov 2011 11:18:03 -0800 (PST)
In-Reply-To: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185758>

On Sat, Nov 19, 2011 at 3:08 PM, Gerd Knops <gerti@bitart.com> wrote:
> On Mac OS X with a case-insensitive file system (not sure if that matters) git get's confused with branch names that differ only in case.

This is true. The branch code assumes a case-sensitive filesystem. I
started working on a fix, but it was more involved than I first
thought it would be. See my local WIP commit below, apologies if gmail
lines wraps it.

j.

commit dfa86073b7
Author: Jay Soffian <jaysoffian@gmail.com>
Date:   Thu Oct 6 14:51:15 2011 -0400

    Try not to confuse branch foo with branch Foo (WIP)

    This probably needs to canonicalize the branch name instead. Sigh.

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a41c818a7c..0e7362345d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -363,7 +363,7 @@ static void setup_branch_path(struct branch_info *branch)
 	struct strbuf buf = STRBUF_INIT;

 	strbuf_branchname(&buf, branch->name);
-	if (strcmp(buf.buf, branch->name))
+	if (strcmp_icase(buf.buf, branch->name))
 		branch->name = xstrdup(buf.buf);
 	strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
 	branch->path = strbuf_detach(&buf, NULL);
@@ -523,7 +523,7 @@ static void record_checkout(const char *name,
const char *new_work_tree)
 	} else { /* release name if we reserved it */
 		struct branch *branch = branch_get(name);
 		if (branch->work_tree &&
-		    !strcmp(branch->work_tree, get_git_work_tree()))
+		    !strcmp_icase(branch->work_tree, get_git_work_tree()))
 			git_config_set(key.buf, "");
 	}
 	strbuf_release(&key);
@@ -567,7 +567,7 @@ static void update_refs_for_switch(struct
checkout_opts *opts,
 	strbuf_addf(&msg, "checkout: moving from %s to %s",
 		    old_desc ? old_desc : "(invalid)", new->name);

-	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
+	if (!strcmp_icase(new->name, "HEAD") && !new->path && !opts->force_detach) {
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
 		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
@@ -582,7 +582,7 @@ static void update_refs_for_switch(struct
checkout_opts *opts,
 	} else if (new->path) {	/* Switch branches. */
 		create_symref("HEAD", new->path, msg.buf);
 		if (!opts->quiet) {
-			if (old->path && !strcmp(new->path, old->path)) {
+			if (old->path && !strcmp_icase(new->path, old->path)) {
 				fprintf(stderr, _("Already on '%s'\n"),
 					new->name);
 			} else if (opts->new_branch) {
@@ -612,7 +612,7 @@ static void update_refs_for_switch(struct
checkout_opts *opts,
 	remove_branch_state();
 	strbuf_release(&msg);
 	if (!opts->quiet &&
-	    (new->path || (!opts->force_detach && !strcmp(new->name, "HEAD"))))
+	    (new->path || (!opts->force_detach && !strcmp_icase(new->name, "HEAD"))))
 		report_tracking(new);
 }

@@ -719,7 +719,7 @@ static void check_if_checked_out(struct
checkout_opts *opts, const char *name)
 {
 	struct branch *branch = branch_get(name);
 	if (branch->work_tree && strlen(branch->work_tree) &&
-	    strcmp(branch->work_tree, get_git_work_tree())) {
+	    strcmp_icase(branch->work_tree, get_git_work_tree())) {
 		if (opts->force)
 			warning(_("branch '%s' is currently checked out"
 				  " in '%s'"), name, branch->work_tree);
diff --git a/remote.c b/remote.c
index 283b2121bd..1fba1c7fa3 100644
--- a/remote.c
+++ b/remote.c
@@ -166,9 +166,9 @@ static struct branch *make_branch(const char *name, int len)
 	char *refname;

 	for (i = 0; i < branches_nr; i++) {
-		if (len ? (!strncmp(name, branches[i]->name, len) &&
+		if (len ? (!strncmp_icase(name, branches[i]->name, len) &&
 			   !branches[i]->name[len]) :
-		    !strcmp(name, branches[i]->name))
+		    !strcmp_icase(name, branches[i]->name))
 			return branches[i];
 	}

@@ -829,7 +829,7 @@ static int query_refspecs(struct refspec *refs,
int ref_count, struct refspec *q
 				query->force = refspec->force;
 				return 0;
 			}
-		} else if (!strcmp(needle, key)) {
+		} else if (!strcmp_icase(needle, key)) {
 			*result = xstrdup(value);
 			query->force = refspec->force;
 			return 0;
