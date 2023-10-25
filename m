Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCEF2D602
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC54116
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 01:44:34 -0700 (PDT)
Received: (qmail 7975 invoked by uid 109); 25 Oct 2023 08:44:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Oct 2023 08:44:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 960 invoked by uid 111); 25 Oct 2023 08:44:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Oct 2023 04:44:38 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Oct 2023 04:44:32 -0400
From: Jeff King <peff@peff.net>
To: Michael McClimon <michael@mcclimon.org>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] pretty: add %I formatting for patch-id
Message-ID: <20231025084432.GC2145145@coredump.intra.peff.net>
References: <20231022022800.69219-1-michael@mcclimon.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231022022800.69219-1-michael@mcclimon.org>

On Sat, Oct 21, 2023 at 10:27:58PM -0400, Michael McClimon wrote:

> I would like to have a single-command way to get the patch id for a
> commit: the thing you'd see in a pipeline like
>     git diff-tree --patch-with-raw HEAD | git patch-id

So I actually don't think this is the worst thing in the world. You are
using two plumbing commands as intended. And if you want to get N
patch-ids, you can do it with a constant number of processes like:

  git rev-list HEAD | git diff-tree --stdin -p | git patch-id

Alternatively, I wonder if patch-id could generate the ids internally
(which we certainly have code for; that's how git-cherry, etc, work).
Would it make sense to teach patch-id:

  1. To accept just commit id's on stdin to produce the patches for
     those commit id's against their parents, without receiving the
     patch text itself on stdin. I guess --commits-only or something.

  2. To accept commit-ishes on the command line, overriding the need to
     read from stdin.

Which would let your single-patch case become just:

  git patch-id --commits-only HEAD

But let's read on...

> My initial thought was to add a --patch-id flag to git diff-tree, but
> then I thought that maybe better would be to add a pretty specifier to
> do so, so that (for instance) you could generate patch-ids for
> everything in a branch by saying something like
>     git log --pretty='%I %H' start..

I can see how "%I" would be convenient, especially from a scripting
standpoint, since you can control how it appears in the output. But it
does feel a little funny to me as a commit pretty-printing item.
Computing it requires calculating the diff, which we'll of course want
to do separately for the diff portion of many invocations. E.g., I
didn't check, but I'd guess that:

  git log --pretty="%I %H" -p

would compute each diff twice. Would it make more sense as a
diff-format alongside --raw, --name-status, and so on?

I have a more subtle reason to think this might be a good idea, which
I'll discuss below.

> The thing that is perplexing to me is that it _does_ appear to work on
> some commits, for example (where 8b3aa36f is a recent-ish commit from
> master, chosen at random):
> [...]
> But for other commits, like the one in the test here, it does not.

Hmm. When I run the failing test in a debugger, I see that going into
commit_patch_id(), there is already an entry in diff_queued_diff (which
is a global that stores the result of the last diff). So I think there
is already a diff there from the call to diff_tree_oid() in
log_tree_diff(). And then you diff _again_ and end up with duplicates
when computing the patch-id.

(This causes another bug, too; at the end of diff_flush_patch_id we
clear the queue, so the actual diff is not showed by "git show" anymore;
the use of "-s" in the test obscures that).

The thing that most surprises me is that it ever works at all. ;) But I
think what happens is this:

  - in the code in your patch, you fail to set up the diff_options
    correctly. In particular, you do not set the "recursive" flag.

  - so in the case of 8b3aa36f, which touches only a file in
    Documentation/, the call from log_tree_diff() queues the correct
    file modification entry. The second call from commit_patch_id()
    mistakenly queues only the parent tree "Documentation"

  - a patch-id is defined on the textual patch changes, so it ignores
    non-file changes that are queued (and in Git you wouldn't normally
    see these anyway unless you use a non-recursive diff or a special
    option like "-t").

And hence any patch which consists of changes to files only in subtrees
will "work", and other ones fail. To "fix" your patch, you could set
diffopt.flags.recursive, as we do in format-patch's prepare_bases()
call. But of course because of the duplicate diff, that just means we'll
consistently get the wrong answer now. ;)

So I'd expect something like this to work:

diff --git a/pretty.c b/pretty.c
index 47e2e6e99a..5a473c7941 100644
--- a/pretty.c
+++ b/pretty.c
@@ -20,6 +20,7 @@
 #include "run-command.h"
 #include "object-name.h"
 #include "patch-ids.h"
+#include "diffcore.h"
 
 /*
  * The limit for formatting directives, which enable the caller to append
@@ -1576,10 +1577,28 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		{
 			struct diff_options diffopt;
 			struct object_id patch_id;
+
+			/*
+			 * save the existing diff queue, as it may be
+			 * populated, e.g. by log_tree_diff(). Of course
+			 * it would be nice to use its results, but:
+			 *
+			 *   1. We can't count on it (we might be formatting a
+			 *      via some other code path).
+			 *   2. We have no clue which diff options were used.
+			 */
+			struct diff_queue_struct old_queue = diff_queued_diff;
+			DIFF_QUEUE_CLEAR(&diff_queued_diff);
+
 			repo_diff_setup(the_repository, &diffopt);
+			diffopt.flags.recursive = 1;
+			diff_setup_done(&diffopt);
+
 			if (commit_patch_id(commit, &diffopt, &patch_id, 0))
 				die(_("cannot get patch id"));
 			strbuf_addstr(sb, oid_to_hex(&patch_id));
+
+			diff_queued_diff = old_queue;
 			return 1;
 		}
 	case 'm':		/* left/right/bottom */

but it doesn't quite fix your test. There I think the issue is that
the patch-id code is a bit wonky for the special case of the creation of
an empty file (even before your patch). The internal patch-id generator
adds fake:

  --- /dev/null
  +++ b/whatever

lines that would normally appear in the patch for a newly created file.
But for an empty file, the "--patch" format does not emit those lines at
all! So we need this hackery on top:

diff --git a/diff.c b/diff.c
index 2c602df10a..9370e585f1 100644
--- a/diff.c
+++ b/diff.c
@@ -6431,15 +6431,15 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->two->oid),
 					the_hash_algo->hexsz);
 		} else {
-			if (p->one->mode == 0) {
+			if (p->one->mode == 0 && p->two->size) {
 				patch_id_add_string(&ctx, "---/dev/null");
 				patch_id_add_string(&ctx, "+++b/");
 				the_hash_algo->update_fn(&ctx, p->two->path, len2);
-			} else if (p->two->mode == 0) {
+			} else if (p->two->mode == 0 && p->one->size) {
 				patch_id_add_string(&ctx, "---a/");
 				the_hash_algo->update_fn(&ctx, p->one->path, len1);
 				patch_id_add_string(&ctx, "+++/dev/null");
-			} else {
+			} else if (p->one->size || p->two->size) {
 				patch_id_add_string(&ctx, "---a/");
 				the_hash_algo->update_fn(&ctx, p->one->path, len1);
 				patch_id_add_string(&ctx, "+++b/");

And with that, your new test succeeds.

> have done a bit of investigation, but I would not really call myself a C
> programmer and I'm not super familiar with the codebase, so I'm a bit
> stuck. I thought maybe at first I wasn't initializing the diff_options
> correctly, but I suspect the problem is actually more fundamental than
> that.

So as you can see, the diff options do matter. And that is a more
fundamental issue.  In many cases patch-id will be pretty stable and
independent of options, but I suspect it would get confused by things
like rename detection.

If we run "git log --format=%I", which diff options should be used for
the patch-id? A stable set (like we do for "format-patch --base")? Or
ones that match the diff we are otherwise generating? I could see
arguments both ways.

One nice thing about "diff-tree | patch-id" is that you are in control
of the options that diff-tree uses. But I'd think in most cases you just
want a stable patch-id, so the "git patch-id HEAD" I suggested earlier
would presumably use some very basic set of diff options.

I dunno. I do not use patch-id much (aside from internal use via things
like "git cherry", etc). So there may be use cases or corner cases I'm
not thinking about. But I do think there's a bit of complexity to think
about here.

-Peff
