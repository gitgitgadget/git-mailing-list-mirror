From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/3] show: --ignore-missing
Date: Wed, 18 May 2011 19:03:34 -0700
Message-ID: <7vliy3a1l5.fsf@alter.siamese.dyndns.org>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 04:03:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMsaX-0004lS-MN
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 04:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab1ESCDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 22:03:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab1ESCDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 22:03:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D9EA5901;
	Wed, 18 May 2011 22:05:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H2HPwgLLNj3prbvGVhySXXzfMkc=; b=Gegwnn
	V7m5vQkGisMC1IxdJsKuvEZKfgSTRuS9tcXcVS8xtIhz2zqVlr9iod4HbeocpFG7
	M03DP05lrG3+MInzmGmBfIx1sqaEKn5gkpjjP3COSQLJHaF2wVdujOFRvgWsSHfv
	wDmOHouqjwladJle1r97pLfi27T6aLs/7jduQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hzdc/fhubNST6iuw/Yqd1qGHjrWbt40G
	FwQ7nsK31fO6+Q6pFhP7SKWfsP5SELVnNBu9YIvMTNMbLXNFQjTMIq71aN2mYVGf
	98kQMF40YpVDeEMMtzuIFz14CHTkgajeLdt/DqtgREdm6CAaRBRs1poCndpGqoHR
	lVA7B7fU5OE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A5005900;
	Wed, 18 May 2011 22:05:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6EF7858FF; Wed, 18 May 2011
 22:05:44 -0400 (EDT)
In-Reply-To: <1305764061-21303-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed, 18 May 2011 17:14:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82677C1A-81BC-11E0-8945-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173926>

Instead of barfing, simply ignore bad object names seen in the
input. This is useful when reading from "git notes list" output
that may refer to objects that have already been garbage collected.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This would let me do something like

	git notes list |
        sed -e 's/. *//' | # strip note-blob
	git show --format='%ci %H ...' --ignore-missing --stdin |
        ... perhaps sort by commit date, filter, etc... |
        git notes remove --stdin --ignore-missing

   Perhaps "git notes list --target-only" can be added to remove the
   need for the second "sed" in the pipeline.

 Documentation/git-rev-list.txt     |    1 +
 Documentation/rev-list-options.txt |    4 ++++
 builtin/rev-parse.c                |    1 +
 revision.c                         |   15 +++++++++++++--
 revision.h                         |    3 ++-
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 415f4f0..38fafca 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -29,6 +29,7 @@ SYNOPSIS
 	     [ \--tags[=<pattern>] ]
 	     [ \--remotes[=<pattern>] ]
 	     [ \--glob=<glob-pattern> ]
+	     [ \--ignore-missing ]
 	     [ \--stdin ]
 	     [ \--quiet ]
 	     [ \--topo-order ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 52bae31..7e7ba68 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -139,6 +139,10 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	is automatically prepended if missing. If pattern lacks '?', '*',
 	or '[', '/*' at the end is implied.
 
+--ignore-missing::
+
+	Upon seeing an invalid object name in the input, pretend as if
+	the bad input was not given.
 
 ifndef::git-rev-list[]
 --bisect::
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index adb1cae..4c19f84 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -44,6 +44,7 @@ static int is_rev_argument(const char *arg)
 		"--branches=",
 		"--branches",
 		"--header",
+		"--ignore-missing",
 		"--max-age=",
 		"--max-count=",
 		"--min-age=",
diff --git a/revision.c b/revision.c
index a7cf79b..5cb3a75 100644
--- a/revision.c
+++ b/revision.c
@@ -133,6 +133,8 @@ void mark_parents_uninteresting(struct commit *commit)
 
 static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
 {
+	if (!obj)
+		return;
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
 		revs->no_walk = 0;
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
@@ -174,8 +176,11 @@ static struct object *get_reference(struct rev_info *revs, const char *name, con
 	struct object *object;
 
 	object = parse_object(sha1);
-	if (!object)
+	if (!object) {
+		if (revs->ignore_missing)
+			return object;
 		die("bad object %s", name);
+	}
 	object->flags |= flags;
 	return object;
 }
@@ -906,6 +911,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
 		return 0;
 	while (1) {
 		it = get_reference(revs, arg, sha1, 0);
+		if (!it && revs->ignore_missing)
+			return 0;
 		if (it->type != OBJ_TAG)
 			break;
 		if (!((struct tag*)it)->tagged)
@@ -1044,6 +1051,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			a = lookup_commit_reference(from_sha1);
 			b = lookup_commit_reference(sha1);
 			if (!a || !b) {
+				if (revs->ignore_missing)
+					return 0;
 				die(symmetric ?
 				    "Invalid symmetric difference expression %s...%s" :
 				    "Invalid revision range %s..%s",
@@ -1090,7 +1099,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		arg++;
 	}
 	if (get_sha1_with_mode(arg, sha1, &mode))
-		return -1;
+		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
@@ -1475,6 +1484,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--children")) {
 		revs->children.name = "children";
 		revs->limited = 1;
+	} else if (!strcmp(arg, "--ignore-missing")) {
+		revs->ignore_missing = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc);
 		if (!opts)
diff --git a/revision.h b/revision.h
index bca9947..93f338d 100644
--- a/revision.h
+++ b/revision.h
@@ -36,7 +36,8 @@ struct rev_info {
 	const char *prefix;
 	const char *def;
 	struct pathspec prune_data;
-	unsigned int early_output;
+	unsigned int	early_output:1,
+			ignore_missing:1;
 
 	/* Traversal flags */
 	unsigned int	dense:1,
-- 
1.7.5.1.414.gb4910
