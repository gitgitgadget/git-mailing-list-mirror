Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZkUqYyo1"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB8D191
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 21:58:51 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 59F171C4DD1;
	Thu, 23 Nov 2023 00:58:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MF7QGpMx71g0vinSCrCOcYOeRP0Xyx/rAwyrrW
	5uOyU=; b=ZkUqYyo1Ral3/VAVSys/JsuN8wWynIEasuwPI+udZMVxyv8zghYJsg
	Nsj0o/+35ZpVmtvZLfqIFcQpqbPBYGjM2EKPMzV8g0QghwKcw7HnnmkWB0rC5aq8
	ekwQX9B6OcRXHzSYxPaqd/9nB96nvq4orKEcgqlj3UHp3jLJ704Pc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51C541C4DCF;
	Thu, 23 Nov 2023 00:58:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B099C1C4DCE;
	Thu, 23 Nov 2023 00:58:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Willem Verstraeten <willem.verstraeten@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git checkout -B <branch> lets you checkout a branch that is
 already checked out in another worktree Inbox
In-Reply-To: <xmqqjzq9cl70.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	23 Nov 2023 10:28:19 +0900")
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
	<xmqqjzq9cl70.fsf@gitster.g>
Date: Thu, 23 Nov 2023 14:58:48 +0900
Message-ID: <xmqqv89tau3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5F6A9318-89C5-11EE-8603-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I guess we could change the behaviour so that
>
>     git checkout -B <branch> [<start-point>]
>
> fails when <branch> is an existing branch that is in use in another
> worktree, and allow "-f" to be used to override the safety, i.e.,
>
>     git checkout -f -B <branch> [<start-point>]
>
> would allow the <branch> to be repointed to <start-point> (or HEAD)
> even when it is used elsewhere.

It turns out that for some reason "-f" is not how we decided to
override this one---there is "--ignore-other-worktrees" option.

I'll attach the first step (preparatory refactoring) to this message
below, and follow it up with the second step to implement and test
the change.

--- >8 ---
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 23 Nov 2023 14:11:41 +0900
Subject: [PATCH 1/2] checkout: refactor die_if_checked_out() caller

There is a bit dense logic to make a call to "die_if_checked_out()"
while trying to check out a branch.  Extract it into a helper
function and give it a bit of comment to describe what is going on.

The most important part of the refactoring is the separation of the
guarding logic before making the call to die_if_checked_out() into
the caller specific part (e.g., the logic that decides that the
caller is trying to check out an existing branch) and the bypass due
to the "--ignore-other-worktrees" option.  The latter will be common
no matter how the current or future callers decides they need this
protection.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f02434bc15..b4ab972c5a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1516,6 +1516,26 @@ static void die_if_some_operation_in_progress(void)
 	wt_status_state_free_buffers(&state);
 }
 
+/*
+ * die if attempting to checkout an existing branch that is in use
+ * in another worktree, unless ignore-other-wortrees option is given.
+ * The check is bypassed when the branch is already the current one,
+ * as it will not make things any worse.
+ */
+static void die_if_switching_to_a_branch_in_use(struct checkout_opts *opts,
+						const char *full_ref)
+{
+	int flags;
+	char *head_ref;
+
+	if (opts->ignore_other_worktrees)
+		return;
+	head_ref = resolve_refdup("HEAD", 0, NULL, &flags);
+	if (head_ref && (!(flags & REF_ISSYMREF) || strcmp(head_ref, full_ref)))
+		die_if_checked_out(full_ref, 1);
+	free(head_ref);
+}
+
 static int checkout_branch(struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
@@ -1576,15 +1596,9 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (!opts->can_switch_when_in_progress)
 		die_if_some_operation_in_progress();
 
-	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
-	    !opts->ignore_other_worktrees) {
-		int flag;
-		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
-		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
-			die_if_checked_out(new_branch_info->path, 1);
-		free(head_ref);
-	}
+	/* "git checkout <branch>" */
+	if (new_branch_info->path && !opts->force_detach && !opts->new_branch)
+		die_if_switching_to_a_branch_in_use(opts, new_branch_info->path);
 
 	if (!new_branch_info->commit && opts->new_branch) {
 		struct object_id rev;
-- 
2.43.0

