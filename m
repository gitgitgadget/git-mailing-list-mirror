From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/3] teaching log's --glob=<glob> and friends to git
 shortlog
Date: Thu, 21 Apr 2011 16:16:53 -0500
Message-ID: <20110421211613.GA18418@elie>
References: <20110421102241.GA16185@elie>
 <7vtydry038.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:17:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD1FN-00034u-6y
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 23:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab1DUVRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 17:17:04 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56035 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab1DUVRB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 17:17:01 -0400
Received: by iyb14 with SMTP id 14so96165iyb.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/1P+N+V6sfN6QmJ3m2hjTM2EE2UFZd40ys8/7/cmbRI=;
        b=ekYPAUcLEa6m49RmP9ha0uJMcZKD1QqAE3ncuImxmtJgFazkzIy2Ya8q97ysPzH+q/
         HlkTo8YgAE/b4a1PSuCkIz2Q+7b4pvs0VWL1iRqKXzI/VjTH6uylA+aRTrNDGcXBoJAs
         PDVKUKPgWau0AjvuB1bM4SCm3JcWpsMJRnZrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hjbZOIthgNb1kWL/MOWfAygxHjqGcvU1yx77jzRDBMcVC9+dTLT0XvHe9vjjRWHwEJ
         NwEUNLXf2ckQ0nQBTCcxsnlVsgVE5lDTA11Oz0tthSJqgDnU5jXyBP+whSgMB1sRnw1/
         kNGWKU9TdP3znxrvBUOTrVnhdDBm/tPqNMVoU=
Received: by 10.42.149.200 with SMTP id x8mr533330icv.195.1303420620126;
        Thu, 21 Apr 2011 14:17:00 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id g16sm887168ibb.54.2011.04.21.14.16.57
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 14:16:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtydry038.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171919>

Hi,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> 	git rev-list ^HEAD --no-walk commit1 commit2 ...
>
> That should be "git rev-list --no-walk ^HEAD commit1 commit2 ..." from the
> syntactical point of view to begin with, but more importantly, what does
> it mean to ask excluding commits reachable from HEAD without walking?

This framing of the question is based on --no-walk being a global
flag.  It is possible to imagine it instead being a positional
argument like --not, without invasive changes to the code structure,
as in the patch below.

> As ^HEAD is inherently about walking the history to paint the part of DAG
> that are not interesting because the nodes in there are reachable from
> there, the request that command line tries to make does not make much
> sense.

A separate question is whether paying attention to the position of
--no-walk in the command line was a good idea.  Let's see what it
would take to reconcile my belief that "no, it isn't" with current
practice.

The idea would be to introduce a new option --behave-like-show with
the following semantics:

. "git log --behave-like-show foo..bar" is a synonym for "git log foo..bar"
. "git log --behave-like-show -5 foo" is a synonym for "git log -5 foo"
. "git log --behave-like-show --do-walk foo" is a synonym for "git log foo"
. "git log --behave-like-show foo" is a synonym for "git log --no-walk foo"

Then we could remove the existing magic that turns "git log --no-walk foo..bar"
to "git log foo..bar" and error out since the operator has requested
something undoable ("--no-walk is incompatible with negative revisions").

More precisely, it could work like so:

 - --no-walk/--do-walk becomes a tristate (walk, don't walk, default)
 - --behave-like-show state is another tristate (seen ^foo or -5,
   using --behave-like-show but not seen ^foo or -5, neither)

The rules:

 - if we saw --no-walk (and it was not cancelled by a later --do-walk)
   along with ^foo, error out.
 - otherwise, if we saw --do-walk (and it was not cancelled by a later
   --no-walk), walk.
 - otherwise, if we saw --no-walk, don't walk.  If we saw ^foo, walk.
 - by default, walk if and only if we didn't see --behave-like-show.

So the usual "git show" usage patterns would work, and the position of
--no-walk (except in that it can be cancelled by --do-walk) wouldn't
matter.

> As I said in
>
>  http://thread.gmane.org/gmane.comp.version-control.git/170457/focus=170629
>
> the "--no-walk" hack happens to work by accident, and we would need to
> rethink the way it operates and revamp it.

Yes, [1] is interesting (though a bit broader in scope).

The promised nonsense patch implementing a NO_WALK commit flag (i.e.,
the approach the patch upthread was meant to clarify we are not using)
follows.

[1] http://thread.gmane.org/gmane.comp.version-control.git/170457/focus=170839

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Please feel free to play around with it but do not consider
it for inclusion. :)
---
 revision.c |   37 ++++++++++++++++++++++++++++---------
 revision.h |    4 +++-
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 0f38364..dae16da 100644
--- a/revision.c
+++ b/revision.c
@@ -133,8 +133,10 @@ void mark_parents_uninteresting(struct commit *commit)
 
 static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
 {
-	if (revs->no_walk && (obj->flags & UNINTERESTING))
+	if (obj->flags & UNINTERESTING) {
+		obj->flags &= ~NO_WALK;
 		revs->no_walk = 0;
+	}
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
 		int len = interpret_branch_name(name, &buf);
@@ -166,6 +168,10 @@ void add_head_to_pending(struct rev_info *revs)
 	obj = parse_object(sha1);
 	if (!obj)
 		return;
+	if (revs->no_walk)
+		obj->flags |= NO_WALK;
+	else
+		obj->flags &= ~NO_WALK;
 	add_pending_object(revs, obj, "HEAD");
 }
 
@@ -506,7 +512,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 	 */
 	try_to_simplify_commit(revs, commit);
 
-	if (revs->no_walk)
+	if ((commit->object.flags & NO_WALK) && !revs->force_walk)
 		return 0;
 
 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
@@ -1062,6 +1068,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			} else
 				a->object.flags |= flags_exclude;
 			b->object.flags |= flags;
+			b->object.flags &= ~NO_WALK;
 			add_pending_object(revs, &a->object, this);
 			add_pending_object(revs, &b->object, next);
 			return 0;
@@ -1128,6 +1135,7 @@ static void read_revisions_from_stdin(struct rev_info *revs, const char ***prune
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
+	int flags = 0;
 
 	strbuf_init(&sb, 1000);
 	while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
@@ -1143,7 +1151,11 @@ static void read_revisions_from_stdin(struct rev_info *revs, const char ***prune
 			}
 			die("options not supported in --stdin mode");
 		}
-		if (handle_revision_arg(sb.buf, revs, 0, 1))
+		if (revs->no_walk)
+			flags |= NO_WALK;
+		else
+			flags &= ~NO_WALK;
+		if (handle_revision_arg(sb.buf, revs, flags, 1))
 			die("bad revision '%s'", sb.buf);
 	}
 	if (seen_dashdash)
@@ -1186,7 +1198,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 
 	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
 		revs->max_count = atoi(optarg);
-		revs->no_walk = 0;
+		revs->force_walk = 1;
 		return argcount;
 	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
 		revs->skip_count = atoi(optarg);
@@ -1194,16 +1206,16 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((*arg == '-') && isdigit(arg[1])) {
 	/* accept -<digit>, like traditional "head" */
 		revs->max_count = atoi(arg + 1);
-		revs->no_walk = 0;
+		revs->force_walk = 1;
 	} else if (!strcmp(arg, "-n")) {
 		if (argc <= 1)
 			return error("-n requires an argument");
 		revs->max_count = atoi(argv[1]);
-		revs->no_walk = 0;
+		revs->force_walk = 1;
 		return 2;
 	} else if (!prefixcmp(arg, "-n")) {
 		revs->max_count = atoi(arg + 2);
-		revs->no_walk = 0;
+		revs->force_walk = 1;
 	} else if ((argcount = parse_long_opt("max-age", argv, &optarg))) {
 		revs->max_age = atoi(optarg);
 		return argcount;
@@ -1563,6 +1575,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+		if (revs->no_walk)
+			flags |= NO_WALK;
+		else
+			flags &= ~NO_WALK;
+
 		if (*arg == '-') {
 			int opts;
 
@@ -1688,6 +1705,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		if (get_sha1_with_mode(revs->def, sha1, &mode))
 			die("bad default revision '%s'", revs->def);
 		object = get_reference(revs, revs->def, sha1, 0);
+		if (revs->no_walk)
+			object->flags |= NO_WALK;
+		else
+			object->flags &= ~NO_WALK;
 		add_pending_object_with_mode(revs, object, revs->def, mode);
 	}
 
@@ -1951,8 +1972,6 @@ int prepare_revision_walk(struct rev_info *revs)
 	}
 	free(list);
 
-	if (revs->no_walk)
-		return 0;
 	if (revs->limited)
 		if (limit_list(revs) < 0)
 			return -1;
diff --git a/revision.h b/revision.h
index 9fd8f30..60f00ff 100644
--- a/revision.h
+++ b/revision.h
@@ -15,7 +15,8 @@
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
-#define ALL_REV_FLAGS	((1u<<10)-1)
+#define NO_WALK		(1u<<10)
+#define ALL_REV_FLAGS	((1u<<11)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -42,6 +43,7 @@ struct rev_info {
 	unsigned int	dense:1,
 			prune:1,
 			no_walk:1,
+			force_walk:1,
 			show_all:1,
 			remove_empty_trees:1,
 			simplify_history:1,
-- 
1.7.5.rc3
