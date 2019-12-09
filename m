Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4970C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B114206D3
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S/ItFEXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLISv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:51:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62810 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLISv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 13:51:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD0709EAB8;
        Mon,  9 Dec 2019 13:51:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3vpbCpaZtFFStS78dlZDSg1zkok=; b=S/ItFE
        XVHzw+LSqVXLjNjdEgovj8sjEvKAfJj/LH5GpNTRaf0ze42T+EYtE2Hgl8+akrvT
        GcoPr6pnFW92Z1F5BlHs7Qp2Jfo/tqF0HXGT7cI+ikkueVrosDFw4BwaEKMfXB7F
        k8DoWiMQOIXH+alaGoIIMc0GWW2wvTxFOSIeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J6JtR0EVJyUONTAI5GXlP/9TqfNtC+vO
        ASJneFvff1euf9gYitvsE3K09sKxx3M5Or8v9ZYfiO6Rfic92nLI4BshICoxHuRY
        E0FbJrtaoTMgm26PAQngCUVl07CdYgpjenAor9uHGMnSwTnFG/7eBFesbUVoMXD9
        RucMC0/bttg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2CE39EAB6;
        Mon,  9 Dec 2019 13:51:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDED29EAB5;
        Mon,  9 Dec 2019 13:51:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Torok <alext9@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] rebase: fix --fork-point with short refname
References: <20191205235704.31385-1-alext9@gmail.com>
        <20191209145312.3251-1-alext9@gmail.com>
        <20191209145312.3251-2-alext9@gmail.com>
Date:   Mon, 09 Dec 2019 10:51:47 -0800
In-Reply-To: <20191209145312.3251-2-alext9@gmail.com> (Alex Torok's message of
        "Mon, 9 Dec 2019 09:53:12 -0500")
Message-ID: <xmqq36dtwcvw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5496988-1AB4-11EA-9BA5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Torok <alext9@gmail.com> writes:

> We were directly passing in the user-provided upstream_name into
> get_fork_point(), but get_fork_point() was expecting a fully qualified
> ref name. This resulted in `--fork-point` not working as expected.
> Without the full ref name, get_fork_point could not find the fork point,
> and rebase behaved as if no `--fork-point` flag was passed in.
>
> Pull logic for getting the full dwim ref name out of merge-base.c
> handle_fork_point into get_fork_point. This allows both of the locations

"handle_fork_point() into get_fork_point()" to match the second line
of the first paragraph, perhaps (similarly for "get_fork_point()"
on the next line)?

> that call get_fork_point to not need to handle doing the dwim ref lookup
> before trying to get the fork point.
>
> Duplicate all of the rebase tests with a short refname to ensure that
> they work with short and long refnames.
>
> Signed-off-by: Alex Torok <alext9@gmail.com>
> ---
>
> One thing that I'm not super sure about is the error messaging that gets
> printed when a short refname is given to rebase. In the ambigous refname
> test that I added, the command output is:
>
> warning: refname 'one' is ambiguous.
> error: ambiguous refname: 'one'
> fatal: could not get fork point
>
> Which seems a bit odd ot have a warning, error, fatal stacked on top of
> each other.

Yes, it does look strange.

I think that the new "dwim_unique_ref()" helper is misdesigned as a
generic helper function.  It makes it hard for the callers to handle
errors on their own for this function to return error().

A helper at the right level for this kind of thing would have been a
function that does DWIM ref and returns the number of candidate refs
the given short name would expand to, and do all that silently.  The
caller would then react to the returned number and say "no such" if
there is no candidate, or "ambigous" if there are more than one.

Which is exactly what dwim_ref() is.  In other words, dwim_unique_ref()
helper, unless it is useful by multiple callers who want it to die()
itself, is not all that useful as an abstraction.

If I were doing this, probably I would not add dwim_unique_ref() at
all, and then I'd invent an extra variant of get_fork_point(), that
the caller can choose to make it die or just silently return an error.

This caller would want it to die() without giving control back to
it, but there may be some other callers that would want a finer
control.

On the other hand, if the other caller(s) all want get_fork_point()
to die, then that would also be fine.  A quick glance tells me that
the only other caller is in builtin/rebase.c and does this:

	if (fork_point > 0) {
		struct commit *head =
			lookup_commit_reference(the_repository,
						&options.orig_head);
		options.restrict_revision =
			get_fork_point(options.upstream_name, head);
	}

and there are other calls to die(_("...")) in the caller everywhere,
so I'd say you are over-engineering a simple bugfix.

Wouldn't it be sufficient for this fix to be more like this?

-- >8 --

Subject: rebase: --fork-point regression fix

"git rebase --fork-point master" used to work OK, as it internally
called "git merge-base --fork-point" that knew how to handle short
refname and dwim it to the full refname before calling the
underlying get_fork_point() function.

This is no longer true after the command was rewritten in C, as its
internall call made directly to get_fork_point() does not dwim a
short ref.

Move the "dwim the refname argument to the full refname" logic that
is used in "git merge-base" to the underlying get_fork_point()
function, so that the other caller of the function in the
implementation of "git rebase" behaves the same way to fix this
regression.

---
 builtin/merge-base.c         | 12 +-----------
 commit.c                     | 15 +++++++++++++--
 t/t3431-rebase-fork-point.sh | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e3f8da13b6..6719ac198d 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -114,26 +114,16 @@ static int handle_is_ancestor(int argc, const char **argv)
 static int handle_fork_point(int argc, const char **argv)
 {
 	struct object_id oid;
-	char *refname;
 	struct commit *derived, *fork_point;
 	const char *commitname;
 
-	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
-	case 0:
-		die("No such ref: '%s'", argv[0]);
-	case 1:
-		break; /* good */
-	default:
-		die("Ambiguous refname: '%s'", argv[0]);
-	}
-
 	commitname = (argc == 2) ? argv[1] : "HEAD";
 	if (get_oid(commitname, &oid))
 		die("Not a valid object name: '%s'", commitname);
 
 	derived = lookup_commit_reference(the_repository, &oid);
 
-	fork_point = get_fork_point(refname, derived);
+	fork_point = get_fork_point(argv[0], derived);
 
 	if (!fork_point)
 		return 1;
diff --git a/commit.c b/commit.c
index 40890ae7ce..016f14fe95 100644
--- a/commit.c
+++ b/commit.c
@@ -903,12 +903,22 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	struct commit_list *bases;
 	int i;
 	struct commit *ret = NULL;
+	char *full_refname;
+
+	switch (dwim_ref(refname, strlen(refname), &oid, &full_refname)) {
+	case 0:
+		die("No such ref: '%s'", refname);
+	case 1:
+		break; /* good */
+	default:
+		die("Ambiguous refname: '%s'", refname);
+	}
 
 	memset(&revs, 0, sizeof(revs));
 	revs.initial = 1;
-	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
+	for_each_reflog_ent(full_refname, collect_one_reflog_ent, &revs);
 
-	if (!revs.nr && !get_oid(refname, &oid))
+	if (!revs.nr)
 		add_one_commit(&oid, &revs);
 
 	for (i = 0; i < revs.nr; i++)
@@ -934,6 +944,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 
 cleanup_return:
 	free_commit_list(bases);
+	free(full_refname);
 	return ret;
 }
 
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 78851b9a2a..5b09aecd13 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -47,11 +47,31 @@ test_rebase 'G F B A' --keep-base
 test_rebase 'G F C E D B A' --no-fork-point
 test_rebase 'G F C D B A' --no-fork-point --onto D
 test_rebase 'G F C B A' --no-fork-point --keep-base
+
 test_rebase 'G F E D B A' --fork-point refs/heads/master
+test_rebase 'G F E D B A' --fork-point master
+
 test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F D B A' --fork-point --onto D master
+
 test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
+test_rebase 'G F B A' --fork-point --keep-base master
+
 test_rebase 'G F C E D B A' refs/heads/master
+test_rebase 'G F C E D B A' master
+
 test_rebase 'G F C D B A' --onto D refs/heads/master
+test_rebase 'G F C D B A' --onto D master
+
 test_rebase 'G F C B A' --keep-base refs/heads/master
+test_rebase 'G F C B A' --keep-base master
+
+test_expect_success "git rebase --fork-point with ambigous refname" "
+	git checkout master &&
+	git checkout -b one &&
+	git checkout side &&
+	git tag one &&
+	test_must_fail git rebase --fork-point --onto D one
+"
 
 test_done
