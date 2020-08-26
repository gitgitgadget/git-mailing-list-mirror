Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF78C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC722078D
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHZUNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:13:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:41792 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgHZUNH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 16:13:07 -0400
Received: (qmail 10423 invoked by uid 109); 26 Aug 2020 20:13:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Aug 2020 20:13:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17495 invoked by uid 111); 26 Aug 2020 20:13:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Aug 2020 16:13:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Aug 2020 16:13:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: [PATCH] revision: set rev_input_given in handle_revision_arg()
Message-ID: <20200826201305.GA1595824@coredump.intra.peff.net>
References: <CAGyf7-G_ciVpgvvOiH1Fq9kNuWunCpM1fhv3ao_RMXBB0K=HMA@mail.gmail.com>
 <xmqq8se21pl1.fsf@gitster.c.googlers.com>
 <20200825194619.GB1419759@coredump.intra.peff.net>
 <xmqq4koq1p28.fsf@gitster.c.googlers.com>
 <20200825195511.GD1419759@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825195511.GD1419759@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 03:55:11PM -0400, Jeff King wrote:

> > You beat me to it while I was wondering what to do between the local
> > got_rev_arg variable and the revs->rev_input_given field.
> 
> That makes me wonder why we need got_rev_arg at all if we have
> revs->rev_input_given. But I suspect an answer can be found by digging
> into git-blame. I probably won't do that immediately, so if you want to,
> you can do so without worrying that we're duplicating work. :)

This is all my fault, naturally. :) I added rev_input_given a while ago
but didn't go far enough. Here's what I think we should do:

-- >8 --
Subject: [PATCH] revision: set rev_input_given in handle_revision_arg()

Commit 7ba826290a (revision: add rev_input_given flag, 2017-08-02) added
a flag to rev_info to tell whether we got any revision arguments. As
explained there, this is necessary because some revision arguments may
not produce any pending traversal objects, but should still inhibit
default behaviors (e.g., a glob that matches nothing).

However, it only set the flag in the globbing code, but not for
revisions we get on the command-line or via stdin. This leads to two
problems:

  - the command-line code keeps its own separate got_rev_arg flag; this
    isn't wrong, but it's confusing and an extra maintenance burden

  - even specifically-named rev arguments might end up not adding any
    pending objects: if --ignore-missing is set, then specifying a
    missing object is a noop rather than an error.

And that leads to some user-visible bugs:

  - when deciding whether a default rev like "HEAD" should kick in, we
    check both got_rev_arg and rev_input_given. That means that
    "--ignore-missing $ZERO_OID" works on the command-line (where we set
    got_rev_arg) but not on --stdin (where we don't)

  - when rev-list decides whether it should complain that it wasn't
    given a starting point, it relies on rev_input_given. So it can't
    even get the command-line "--ignore-missing $ZERO_OID" right

Let's consistently set the flag if we got any revision argument. That
lets us clean up the redundant got_rev_arg, and fixes both of those bugs
(but note there are three new tests: we'll confirm the already working
git-log command-line case).

A few implementation notes:

  - conceptually we want to set the flag whenever handle_revision_arg()
    finds an actual revision arg ("handles" it, you might say). But it
    covers a ton of cases with early returns. Rather than annotating
    each one, we just wrap it and use its success exit-code to set the
    flag in one spot.

  - the new rev-list test is in t6018, which is titled to cover globs.
    This isn't exactly a glob, but it made sense to stick it with the
    other tests that handle the "even though we got a rev, we have no
    pending objects" case, which are globs.

  - the tests check for the oid of a missing object, which it's pretty
    clear --ignore-missing should ignore. You can see the same behavior
    with "--ignore-missing a-ref-that-does-not-exist", because
    --ignore-missing treats them both the same. That's perhaps less
    clearly correct, and we may want to change that in the future. But
    the way the code and tests here are written, we'd continue to do the
    right thing even if it does.

Reported-by: Bryan Turner <bturner@atlassian.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c               | 16 +++++++++++-----
 t/t4202-log.sh           | 10 ++++++++++
 t/t6018-rev-list-glob.sh |  5 +++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 96630e3186..08c2ad23af 100644
--- a/revision.c
+++ b/revision.c
@@ -2017,7 +2017,7 @@ static int handle_dotdot(const char *arg,
 	return ret;
 }
 
-int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsigned revarg_opt)
+static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int flags, unsigned revarg_opt)
 {
 	struct object_context oc;
 	char *mark;
@@ -2092,6 +2092,14 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	return 0;
 }
 
+int handle_revision_arg(const char *arg, struct rev_info *revs, int flags, unsigned revarg_opt)
+{
+	int ret = handle_revision_arg_1(arg, revs, flags, revarg_opt);
+	if (!ret)
+		revs->rev_input_given = 1;
+	return ret;
+}
+
 static void read_pathspec_from_stdin(struct strbuf *sb,
 				     struct strvec *prune)
 {
@@ -2703,7 +2711,7 @@ static void NORETURN diagnose_missing_default(const char *def)
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
-	int i, flags, left, seen_dashdash, got_rev_arg = 0, revarg_opt;
+	int i, flags, left, seen_dashdash, revarg_opt;
 	struct strvec prune_data = STRVEC_INIT;
 	const char *submodule = NULL;
 	int seen_end_of_options = 0;
@@ -2792,8 +2800,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			strvec_pushv(&prune_data, argv + i);
 			break;
 		}
-		else
-			got_rev_arg = 1;
 	}
 
 	if (prune_data.nr) {
@@ -2822,7 +2828,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		opt->tweak(revs, opt);
 	if (revs->show_merge)
 		prepare_show_merge(revs);
-	if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
+	if (revs->def && !revs->pending.nr && !revs->rev_input_given) {
 		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index a0930599aa..56d34ed465 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1850,6 +1850,16 @@ test_expect_success 'log does not default to HEAD when rev input is given' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'do not default to HEAD with ignored object on cmdline' '
+	git log --ignore-missing $ZERO_OID >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'do not default to HEAD with ignored object on stdin' '
+	echo $ZERO_OID | git log --ignore-missing --stdin >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'set up --source tests' '
 	git checkout --orphan source-a &&
 	test_commit one &&
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index bb5aeac07f..b31ff7eeec 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -345,6 +345,11 @@ test_expect_success 'rev-list should succeed with empty output with empty glob'
 	test_must_be_empty actual
 '
 
+test_expect_success 'rev-list should succeed with empty output when ignoring missing' '
+	git rev-list --ignore-missing $ZERO_OID >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
 
 	compare shortlog "subspace/one subspace/two" --branches=subspace &&
-- 
2.28.0.749.gf1242ce4bd

