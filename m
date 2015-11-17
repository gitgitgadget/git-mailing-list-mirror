From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Tue, 17 Nov 2015 18:22:37 -0500
Message-ID: <20151117232237.GA29014@sigill.intra.peff.net>
References: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
 <CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
 <20151117224809.GE27862@sigill.intra.peff.net>
 <CAPig+cQcmtZJmm_FGMNL4OCTgdFZGyLjVrwbfCCp+0kwBeFuRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:22:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZypaG-0004aV-LZ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 00:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbbKQXWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 18:22:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:59033 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751882AbbKQXWj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 18:22:39 -0500
Received: (qmail 17819 invoked by uid 102); 17 Nov 2015 23:22:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 17:22:39 -0600
Received: (qmail 31461 invoked by uid 107); 17 Nov 2015 23:23:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 18:23:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Nov 2015 18:22:37 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQcmtZJmm_FGMNL4OCTgdFZGyLjVrwbfCCp+0kwBeFuRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281429>

On Tue, Nov 17, 2015 at 06:01:25PM -0500, Eric Sunshine wrote:

> On Tue, Nov 17, 2015 at 5:48 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Nov 17, 2015 at 12:11:25AM -0500, Eric Sunshine wrote:
> >> > blame content even if the path provided does match an existing
> >> > blob on said revision.
> >>
> >> git-blame documentation does not advertise "blame <file> <rev>" as a
> >> valid invocation. It does advertise "blame <rev> -- <file>", and this
> >> case already works correctly even when <file> does not exist in the
> >> worktree.
> >
> > Hmm. Out of curiosity I tried:
> >
> >   git blame v2.4.0 -- t/t6031-merge-recursive.sh
> >
> > and it segfaults. This bisects to Max's recent 1b0d400 (blame: extract
> > find_single_final, 2015-10-30), but I do not see anything obviously
> > wrong with it from a quick glance.
> 
> In the original code, sb->final received was assigned value of obj,
> which may have gone through deref_tag(), however, after 1b0d400,
> sb->final is unconditionally assigned the original value of obj, not
> the (potentially) deref'd value.

Good eye. I fed it a tag, find_single_final knows that points to a
commit, then prepare_final casts the tag object to a commit. Whoops.

The patch below fixes it for me. It probably needs a test, but I have to
run for the moment.

-- >8 --
Subject: [PATCH] blame: fix object casting regression

Commit 1b0d400 refactored the prepare_final() function so
that it could be reused in multiple places. Originally, the
loop had two outputs: a commit to stuff into sb->final, and
the name of the commit from the rev->pending array.

After the refactor, that loop is put in its own function
with a single return value: the object_array_entry from the
rev->pending array. This contains both the name and the object,
but with one important difference: the object is the
_original_ object found by the revision parser, not the
dereferenced commit. If one feeds a tag to "git blame", we
end up casting the tag object to a "struct commit", which
causes a segfault.

Instead, let's return the commit (properly casted) directly
from the function, and take the "name" as an optional
out-parameter. This does the right thing, and actually
simplifies the callers, who no longer need to cast or
dereference the object_array_entry themselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index ac36738..2184e39 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2403,10 +2403,12 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	return commit;
 }
 
-static struct object_array_entry *find_single_final(struct rev_info *revs)
+static struct commit *find_single_final(struct rev_info *revs,
+					const char **name_p)
 {
 	int i;
-	struct object_array_entry *found = NULL;
+	struct commit *found = NULL;
+	const char *name = NULL;
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *obj = revs->pending.objects[i].item;
@@ -2418,22 +2420,20 @@ static struct object_array_entry *find_single_final(struct rev_info *revs)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
 			die("More than one commit to dig from %s and %s?",
-			    revs->pending.objects[i].name,
-			    found->name);
-		found = &(revs->pending.objects[i]);
+			    revs->pending.objects[i].name, name);
+		found = (struct commit *)obj;
+		name = revs->pending.objects[i].name;
 	}
+	if (name_p)
+		*name_p = name;
 	return found;
 }
 
 static char *prepare_final(struct scoreboard *sb)
 {
-	struct object_array_entry *found = find_single_final(sb->revs);
-	if (found) {
-		sb->final = (struct commit *) found->item;
-		return xstrdup(found->name);
-	} else {
-		return NULL;
-	}
+	const char *name;
+	sb->final = find_single_final(sb->revs, &name);
+	return xstrdup_or_null(name);
 }
 
 static char *prepare_initial(struct scoreboard *sb)
@@ -2721,11 +2721,9 @@ parse_done:
 		die("Cannot use --contents with final commit object name");
 
 	if (reverse && revs.first_parent_only) {
-		struct object_array_entry *entry = find_single_final(sb.revs);
-		if (!entry)
+		final_commit = find_single_final(sb.revs, NULL);
+		if (!final_commit)
 			die("--reverse and --first-parent together require specified latest commit");
-		else
-			final_commit = (struct commit*) entry->item;
 	}
 
 	/*
-- 
2.6.3.636.g1460207
