Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C44C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 09:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCIJBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 04:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCIJAu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 04:00:50 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B263FDDF23
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 00:58:22 -0800 (PST)
Received: (qmail 7635 invoked by uid 109); 9 Mar 2023 08:58:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 08:58:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29195 invoked by uid 111); 9 Mar 2023 08:58:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 03:58:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 03:58:16 -0500
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] add-patch: handle "* Unmerged path" lines
Message-ID: <ZAmfqC9WMl3XeyEr@coredump.intra.peff.net>
References: <xmqqy1o8wdgi.fsf@gitster.g>
 <bff58f23-6188-9b1e-b23a-fc3d94e9f72f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bff58f23-6188-9b1e-b23a-fc3d94e9f72f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2023 at 03:51:31PM -0500, Philippe Blain wrote:

> >  * Finally retire the scripted "git add -p/-i" implementation and have
> >    everybody use the one reimplemented in C.
> 
> I just hit a 'BUG' in the builtin add -p, I'll try to write a reproducer later but
> wanted to send a heads up now in case you can reproduced easily on your own with the below info.
> Note that this is not new in 2.40-rc2, I'm still on 2.39.1.
> 
> Basically I have an unmerged path from a conflicted 'git checkout $branch -m'. I resolved
> the conflict, but did not run 'git add'. And then I ran (in the 'doc' directory of the repository)
> 'git restore -S -p ../doc/path/to/file' and got:

Thanks, a fix is below. While the escape-hatch of the perl version is
going away in v2.40, people have been exposed to the bug since we
flipped the default in v2.37.0. There's still an escape hatch in the
form of "git reset -p :^conflicted-path", though I guess that is
probably a bit much to expect most users to realize. In practice I'd
expect people to just fall back to non-interactive commands for a
moment.

So I don't consider it urgent for v2.40, but the patch is small enough
that it might be OK to squeeze in.

-- >8 --
Subject: [PATCH] add-patch: handle "* Unmerged path" lines

When we generate a diff with --cached, unmerged entries have no oid for
their index entry:

  $ git diff-index --abbrev --cached HEAD
  :100644 000000 f719efd 0000000 U	my-conflict

So when we are asked to produce a patch, since we only have one side, we
just emit a special message:

  $ git diff-index --cached -p HEAD
  * Unmerged path my-conflict

This confuses interactive-patch modes that look at cached diffs. For
example:

  $ git reset -p
  BUG: add-patch.c:498: diff starts with unexpected line:
  * Unmerged path my-conflict

Making things even more confusing, you'll get that error only if the
unmerged entry is alphabetically the first changed file. Otherwise, we
simply stick the unrecognized line to the end of the previous hunk.
There it's mostly harmless, as it eventually gets fed back to "git
apply", which happily ignores it. But it's still shown to the user
attached to the hunk, which is wrong.

So let's handle these lines as a noop. There's not really anything
useful to do with a conflicted merge in this case, and that's what we do
for other cases like "add -p". There we get a "diff --cc" line, which we
accept as starting a new file, but we refuse to use any of its hunks
(their headers start with "@@@" and not "@@ ", so we silently ignore
them).

It seems like simply recognizing the line and continuing in our parsing
loop would work. But we actually need to run the rest of the loop body
to handle matching up our colored/filtered output. But that code assumes
that we have some active file_diff we're working on. So instead, we'll
just insert a dummy entry into our array. This ends up the same as if we
saw a "diff --cc" line (a file with no hunks).

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This patch just fixes the immediate bug. There's some possible future
work:

  - we could print a warning that the path is ignored. We don't do that
    for "diff --cc" entries, either, though often those involve an index
    refresh that will print "my-conflict: needs merge" or similar.

    Doing so would require parsing the path name from the line. We don't
    seem to quote it in any way, though. So a name like "foo\nbar" would
    probably produce confusing output (though this patch would do the
    right thing; we'd have a dummy entry for "foo", and then just
    tack the useless "bar" line onto it). We should decide what the diff
    side should produce before we start trying to parse it here.

  - arguably we could shrink the list to only non-conflicted entries
    beforehand. That's what the "patch" menu item does if you run a full
    add--interactive. But it would be slower (you have to run an extra
    diff now). On the other hand, that is what the perl version did (and
    it consistently printed "ignoring unmerged: foo", and then said "No
    changes".

  - it's a little weird that the interactive-patch parser will complain
    if the first line of the diff is garbage, but not if it sees garbage
    later on. If we were more strict, that would have triggered the BUG()
    rather than tacking the unknown line to the hunk (and we _should_ be
    able to recognize arbitrary hunk lines by their "[-+ ]" prefixes).

    But there may be corner cases I'm not thinking of, so I left it for
    now.

 add-patch.c                |  3 ++-
 t/t3701-add-interactive.sh | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index a86a92e1646..d7fc4f4cd21 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -483,7 +483,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		if (!eol)
 			eol = pend;
 
-		if (starts_with(p, "diff ")) {
+		if (starts_with(p, "diff ") ||
+		    starts_with(p, "* Unmerged path ")) {
 			complete_file(marker, hunk);
 			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
 				   file_diff_alloc);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3a99837d9b1..e80e2b377c1 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1075,4 +1075,25 @@ test_expect_success 'show help from add--helper' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reset -p with unmerged files' '
+	test_when_finished "git checkout --force main" &&
+	test_commit one conflict &&
+	git checkout -B side HEAD^ &&
+	test_commit two conflict &&
+	test_must_fail git merge one &&
+
+	# this is a noop with only an unmerged entry
+	git reset -p &&
+
+	# add files that sort before and after unmerged entry
+	echo a >a &&
+	echo z >z &&
+	git add a z &&
+
+	# confirm that we can reset those files
+	printf "%s\n" y y | git reset -p &&
+	git diff-index --cached --diff-filter=u HEAD >staged &&
+	test_must_be_empty staged
+'
+
 test_done
-- 
2.40.0.rc2.537.g928a61c97db

