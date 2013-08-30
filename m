From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Fri, 30 Aug 2013 16:55:29 -0700
Message-ID: <xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
	<CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
	<CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
	<xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 31 01:55:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFYXS-0007V5-6e
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 01:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894Ab3H3Xze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 19:55:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754340Ab3H3Xzd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 19:55:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF47C3D3BE;
	Fri, 30 Aug 2013 23:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EcF8qMM3cT2ruFcmxcvasmyViDs=; b=jbsrCW
	vViH8HPywlrNULwoHMzc4WeC0lC5G12iWse+a2Li2IZYCwGY+MZNoTaehy/qtWA3
	V6KqoI0mu0VRpd/G5uXyFWTf+QzGg8sKFWxz+vXtwB2fcASriMxyG2KM81B2umD7
	hDWAcpqG0vktAEgOG+Qh/mfHhDcy6y1lS01UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WKtd7jNCkP7+j1RATuMftrp0X+zAsmjp
	Hcoyh6LSWIVHDcuZBsS8aZNHXlmGuA46l7bJhcb51mDglGbbG7+NcK+cJWUNg5ka
	2+RAiTn17OS3uHQpJQK4n4+uBufie2m086903S/ez24w7KTMoErVDkXBkAmQuKj0
	isP0iaw0ucw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3E573D3BD;
	Fri, 30 Aug 2013 23:55:31 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27B7F3D3BB;
	Fri, 30 Aug 2013 23:55:31 +0000 (UTC)
In-Reply-To: <xmqqeh9b15x6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 30 Aug 2013 09:48:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A72A5FD6-11CF-11E3-9E01-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233484>

People often find "git log --branches" etc. that includes _all_
branches is cumbersome to use when they want to grab most but except
some.  The same applies to --tags, --all and --glob.

Teach the revision machinery to remember patterns, and then upon the
next such a globbing option, exclude those that match the pattern.

With this, I can view only my integration branches (e.g. maint,
master, etc.) without topic branches, which are named after two
letters from primary authors' names, slash and topic name.

    git rev-list --no-walk --exclude=??/* --branches |
    git name-rev --refs refs/heads/* --stdin

This one shows things reachable from local and remote branches that
have not been merged to the integration branches.

    git log --remotes --branches --not --exclude=??/* --branches

It may be a bit rough around the edges, in that the pattern to give
the exclude option depends on what globbing option follows.  In
these examples, the pattern "??/*" is used, not "refs/heads/??/*",
because the globbing option that follows the -"-exclude=<pattern>"
is "--branches".  As each use of globbing option resets previously
set "--exclude", this may not be such a bad thing, though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > It may be a good idea to step back a bit and think of this topic as
 > a way to enhance the --branches option and its friends with only the
 > inclusive wildcard semantics.  It lets us include those that match
 > the pattern with "--branches=wip/*", but there is no way to say "oh
 > by the way, I do not want those that match this pattern included
 > when you expand this short-hand".  We have --branches=pattern that
 > is inclusive; perhaps it can be prefixed with --branches=!pattern to
 > pre-declare "whatever the next --branches expands to, do not include
 > those that match this pattern", or something, which would make the
 > earlier "wip" example to be:
 >
 > 	--all --not --branches='!wip/*' --branches

 So here is a quick attempt at that approach, which does not look
 too intrusive. 

 revision.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 revision.h |  3 +++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 84ccc05..3e82874 100644
--- a/revision.c
+++ b/revision.c
@@ -1180,11 +1180,28 @@ struct all_refs_cb {
 	const char *name_for_errormsg;
 };
 
+static int ref_excluded(struct rev_info *revs, const char *path)
+{
+	struct string_list_item *item;
+
+	if (!revs->ref_excludes)
+		return 0;
+	for_each_string_list_item(item, revs->ref_excludes) {
+		if (!fnmatch(item->string, path, 0))
+			return 1;
+	}
+	return 0;
+}
+
 static int handle_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
-	struct object *object = get_reference(cb->all_revs, path, sha1,
-					      cb->all_flags);
+	struct object *object;
+
+	if (ref_excluded(cb->all_revs, path))
+	    return 0;
+
+	object = get_reference(cb->all_revs, path, sha1, cb->all_flags);
 	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
 	add_pending_sha1(cb->all_revs, path, sha1, cb->all_flags);
 	return 0;
@@ -1197,6 +1214,24 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 	cb->all_flags = flags;
 }
 
+static void clear_ref_exclusion(struct rev_info *revs)
+{
+	if (revs->ref_excludes) {
+		string_list_clear(revs->ref_excludes, 0);
+		free(revs->ref_excludes);
+	}
+	revs->ref_excludes = NULL;
+}
+
+static void add_ref_exclusion(struct rev_info *revs, const char *exclude)
+{
+	if (!revs->ref_excludes) {
+		revs->ref_excludes = xcalloc(1, sizeof(*revs->ref_excludes));
+		revs->ref_excludes->strdup_strings = 1;
+	}
+	string_list_append(revs->ref_excludes, exclude);
+}
+
 static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
 		int (*for_each)(const char *, each_ref_fn, void *))
 {
@@ -1953,33 +1988,44 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (!strcmp(arg, "--all")) {
 		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
 		handle_refs(submodule, revs, *flags, head_ref_submodule);
+		clear_ref_exclusion(revs);
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
+		clear_ref_exclusion(revs);
 	} else if (!strcmp(arg, "--bisect")) {
 		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
 		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
 	} else if (!strcmp(arg, "--tags")) {
 		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
+		clear_ref_exclusion(revs);
 	} else if (!strcmp(arg, "--remotes")) {
 		handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
+		clear_ref_exclusion(revs);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref(handle_one_ref, optarg, &cb);
+		clear_ref_exclusion(revs);
+		return argcount;
+	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
+		add_ref_exclusion(revs, optarg);
 		return argcount;
 	} else if (!prefixcmp(arg, "--branches=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+		clear_ref_exclusion(revs);
 	} else if (!prefixcmp(arg, "--tags=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+		clear_ref_exclusion(revs);
 	} else if (!prefixcmp(arg, "--remotes=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
+		clear_ref_exclusion(revs);
 	} else if (!strcmp(arg, "--reflog")) {
 		handle_reflog(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
diff --git a/revision.h b/revision.h
index 95859ba..b4dc56c 100644
--- a/revision.h
+++ b/revision.h
@@ -59,6 +59,9 @@ struct rev_info {
 	/* The end-points specified by the end user */
 	struct rev_cmdline_info cmdline;
 
+	/* excluding from --branches, --refs, etc. expansion */
+	struct string_list *ref_excludes;
+
 	/* Basic information */
 	const char *prefix;
 	const char *def;
-- 
1.8.4-358-g02cbb92
