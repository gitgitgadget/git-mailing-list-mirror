From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] checkout to notice forks (Re: Minor annoyance with git push)
Date: Sat, 16 Feb 2008 17:08:22 -0800
Message-ID: <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
 <20080209030046.GA10470@coredump.intra.peff.net>
 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
 <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
 <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 02:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQY2H-00015I-7S
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 02:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYBQBIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 20:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbYBQBIs
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 20:08:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbYBQBIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 20:08:47 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E5735E7F;
	Sat, 16 Feb 2008 20:08:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 C0B115E7E; Sat, 16 Feb 2008 20:08:34 -0500 (EST)
In-Reply-To: <7vwspd5z1d.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 09 Feb 2008 18:24:30 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74088>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps making "git-checkout" to notice this and offer (or
> suggest) fast-forwarding at that point may be safer and make
> more sense.  You cannot grow your local branch unless you check
> them out, and your remote tracking will keep growing without the
> auto-ff you are suggesting, so it is not like people will lose
> anchoring point to compare between branches if we do not
> auto-ff.

So I did this.

When you are switching to a branch that is marked to merge from
somewhere else, e.g. when you have:

    [branch "next"]
            remote = upstream
            merge = refs/heads/next
    [remote "upstream"]
            url = ...
            fetch = refs/heads/*:refs/remotes/linus/*

and you say "git checkout next", then after we switch the branch
we check the upstream (in this case, refs/remotes/linus/next)
and our branch, and:

    (1) if they match, nothing happens;

    (2) if you are ahead (i.e. the upstream is a strict ancestor
        of you), one line message tells you so;

    (3) otherwise, you are either behind or you and the upstream
        have forked.  One line message will tell you which and
        then you will see a "log --pretty=oneline --left-right".

We could enhance this with an option that tells the command to
check if there is no local change, and automatically fast
forward when you are truly behind.  But I ripped out that change
because I was unsure what the right way should be to allow users
to control it (issues include that checkout should not become
automatically interactive).

This is hot off the press and I know it tends to be a bit too
loud.  It is based on Daniel's "git checkout in C" with Dscho's
lock_file fix.

---

 builtin-checkout.c |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 59a0ef4..9370ba0 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -12,6 +12,7 @@
 #include "branch.h"
 #include "diff.h"
 #include "revision.h"
+#include "remote.h"
 
 static const char * const checkout_usage[] = {
 	"git checkout [options] <branch>",
@@ -290,6 +291,139 @@ static int merge_working_tree(struct checkout_opts *opts,
 	return 0;
 }
 
+/*
+ * We really should allow cb_data... Yuck
+ */
+static const char *branch_name;
+static int branch_name_len;
+static char *found_remote;
+static char *found_merge;
+static int read_branch_config(const char *var, const char *value)
+{
+	const char *name;
+	if (prefixcmp(var, "branch."))
+		return 0; /* not ours */
+	name = var + strlen("branch.");
+	if (strncmp(name, branch_name, branch_name_len) ||
+	    name[branch_name_len] != '.')
+		return 0; /* not ours either */
+	if (!strcmp(name + branch_name_len, ".remote")) {
+		/*
+		 * Yeah, I know Christian's clean-up should
+		 * be used here, but the topic is based on an
+		 * older fork point.
+		 */
+		if (!value)
+			return error("'%s' not string", var);
+		found_remote = xstrdup(value);
+		return 0;
+	}
+	if (!strcmp(name + branch_name_len, ".merge")) {
+		if (!value)
+			return error("'%s' not string", var);
+		found_merge = xstrdup(value);
+		return 0;
+	}
+	return 0; /* not ours */
+}
+
+static int find_build_base(const char *ours, char **base)
+{
+	struct remote *remote;
+	struct refspec spec;
+
+	*base = NULL;
+
+	branch_name = ours + strlen("refs/heads/");
+	branch_name_len = strlen(branch_name);
+	found_remote = NULL;
+	found_merge = NULL;
+	git_config(read_branch_config);
+
+	if (!found_remote || !found_merge) {
+	cleanup:
+		free(found_remote);
+		free(found_merge);
+		return 0;
+	}
+
+	remote = remote_get(found_remote);
+	memset(&spec, 0, sizeof(spec));
+	spec.src = found_merge;
+	if (remote_find_tracking(remote, &spec))
+		goto cleanup;
+	*base = spec.dst;
+	return 1;
+}
+
+static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *opts)
+{
+	/*
+	 * We have switched to a new branch; is it building on
+	 * top of another branch, and if so does that other branch
+	 * have changes we do not have yet?
+	 */
+	char *base;
+	unsigned char sha1[20];
+	struct commit *ours, *theirs;
+	const char *msgfmt;
+	char symmetric[84];
+	int show_log;
+
+	if (!resolve_ref(new->path, sha1, 1, NULL))
+		return;
+	ours = lookup_commit(sha1);
+
+	if (!find_build_base(new->path, &base))
+		return;
+
+	sprintf(symmetric, "%s", sha1_to_hex(sha1));
+
+	/*
+	 * Ok, it is tracking base; is it ahead of us?
+	 */
+	if (!resolve_ref(base, sha1, 1, NULL))
+		return;
+	theirs = lookup_commit(sha1);
+
+	sprintf(symmetric + 40, "...%s", sha1_to_hex(sha1));
+
+	if (!hashcmp(sha1, ours->object.sha1))
+		return; /* we are the same */
+
+	show_log = 1;
+	if (in_merge_bases(theirs, &ours, 1)) {
+		msgfmt = "You are ahead of the tracked branch '%s'\n";
+		show_log = 0;
+	}
+	else if (in_merge_bases(ours, &theirs, 1))
+		msgfmt = "Your branch can be fast-forwarded to the tracked branch '%s'\n";
+	else
+		msgfmt = "Both your branch and the tracked branch '%s' have own changes, you would eventually need to merge\n";
+
+	if (!prefixcmp(base, "refs/remotes/"))
+		base += strlen("refs/remotes/");
+	fprintf(stderr, msgfmt, base);
+
+	if (show_log) {
+		const char *args[32];
+		int ac;
+
+		ac = 0;
+		args[ac++] = "log";
+		args[ac++] = "--pretty=oneline";
+		args[ac++] = "--abbrev-commit";
+		args[ac++] = "--left-right";
+		args[ac++] = "--boundary";
+		args[ac++] = symmetric;
+		args[ac++] = "--";
+		args[ac] = NULL;
+
+		run_command_v_opt(args, RUN_GIT_CMD);
+	}
+}
+
+
 static void update_refs_for_switch(struct checkout_opts *opts,
 				   struct branch_info *old,
 				   struct branch_info *new)
@@ -332,6 +466,8 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	}
 	remove_branch_state();
 	strbuf_release(&msg);
+	if (new->path)
+		adjust_to_tracking(new, opts);
 }
 
 static int switch_branches(struct checkout_opts *opts,
