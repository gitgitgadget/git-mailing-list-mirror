From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Sun, 18 Oct 2009 01:01:07 -0700
Message-ID: <7vaazpxha4.fsf_-_@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 10:01:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzQhm-0006qo-MF
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 10:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbZJRIBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 04:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbZJRIBM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 04:01:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZJRIBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 04:01:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 309E15DC2C;
	Sun, 18 Oct 2009 04:01:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S14hpt5XotAGWIVsgl6CYMdHcLA=; b=oeZNb2
	LV0iWrTw86GFWsEHWAtbINYNx5Z1KHxU7znGVvMdx47QnW6kqmYAtTToloDqJHPb
	E/teh97WOc52u9mk5cq0acwLqEsN/yzbqRQAkBTAddSzum27Gkj7FxoFEG0ryVEd
	2L0XCIHw0q9v0Q01BfUB7jLvfXDo76oRA4jn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PKg7WPUgKWB036fILmmbGvGjSc8I0CD/
	D1LGc0rpCgjv9JXdzpemjJmT1BtC9sB3kBBlGhM1MEVt/XgM28x/J+2naYXPdZ9e
	+iqU/r0Luyn470nzJZFrXv8Fhl4woIssxXAWfvmt9DiEtge2vsaPs4XRNt6AcrFR
	/qV08CwM1X8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E945DC2B;
	Sun, 18 Oct 2009 04:01:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17E2C5DC29; Sun, 18 Oct
 2009 04:01:08 -0400 (EDT)
In-Reply-To: <7vzl7pyvzl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 18 Oct 2009 00\:58\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 675890DE-BBBC-11DE-8735-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130588>

When 'frotz' is not a valid object name nor a tracked filename,
we used to complain and failed this command.  When there is only
one remote that has 'frotz' as one of its tracking branches, we can
DWIM it as a request to create a local branch 'frotz' forking from
the matching remote tracking branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index d050c37..fb7e68a 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -572,6 +572,40 @@ static int interactive_checkout(const char *revision, const char **pathspec,
 	return run_add_interactive(revision, "--patch=checkout", pathspec);
 }
 
+struct tracking_name_data {
+	const char *name;
+	char *remote;
+	int unique;
+};
+
+static int check_tracking_name(const char *refname, const unsigned char *sha1,
+			       int flags, void *cb_data)
+{
+	struct tracking_name_data *cb = cb_data;
+	const char *slash;
+
+	if (prefixcmp(refname, "refs/remotes/"))
+		return 0;
+	slash = strchr(refname + 13, '/');
+	if (!slash || strcmp(slash + 1, cb->name))
+		return 0;
+	if (cb->remote) {
+		cb->unique = 0;
+		return 0;
+	}
+	cb->remote = xstrdup(refname);
+	return 0;
+}
+
+static const char *unique_tracking_name(const char *name)
+{
+	struct tracking_name_data cb_data = { name, NULL, 1 };
+	for_each_ref(check_tracking_name, &cb_data);
+	if (cb_data.unique)
+		return cb_data.remote;
+	free(cb_data.remote);
+	return NULL;
+}
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
@@ -630,8 +664,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.new_branch = argv0 + 1;
 	}
 
-	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
-		opts.track = git_branch_track;
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
@@ -655,6 +687,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 *   With no paths, if <something> is a commit, that is to
 	 *   switch to the branch or detach HEAD at it.
 	 *
+	 *   With no paths, if <something> is _not_ a commit, no -t nor -b
+	 *   was given, and there is a tracking branch whose name is
+	 *   <something> in one and only one remote, then this is a short-hand
+	 *   to fork local <something> from that remote tracking branch.
+	 *
 	 *   Otherwise <something> shall not be ambiguous.
 	 *   - If it's *only* a reference, treat it like case (1).
 	 *   - If it's only a path, treat it like case (2).
@@ -677,7 +714,20 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		if (get_sha1(arg, rev)) {
 			if (has_dash_dash)          /* case (1) */
 				die("invalid reference: %s", arg);
-			goto no_reference;          /* case (3 -> 2) */
+			if (!patch_mode &&
+			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
+			    !opts.new_branch &&
+			    !check_filename(NULL, arg) &&
+			    argc == 1) {
+				const char *remote = unique_tracking_name(arg);
+				if (!remote || get_sha1(remote, rev))
+					goto no_reference;
+				opts.new_branch = arg;
+				arg = remote;
+				/* DWIMmed to create local branch */
+			}
+			else
+				goto no_reference;
 		}
 
 		/* we can't end up being in (2) anymore, eat the argument */
@@ -715,6 +765,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	}
 
 no_reference:
+
+	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
+		opts.track = git_branch_track;
+
 	if (argc) {
 		const char **pathspec = get_pathspec(prefix, argv);
 
-- 
1.6.5.1.95.g09fbd
